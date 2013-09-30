describe "precomputing rollups" do
end

describe "administration" do
  it "creates a database"
  it "adds a write key to a database"
  it "adds a read key to a database"
  it "deletes a database"
end

describe "POSTing" do
  it "posts points to a series" do
    t = Time.now.to_i
    response = post("/db/#{@db}/points", [
      {
        "series": "users.events",
        "extra_columns": ["email", "type"]
        "points": [
          [t, "paul@errplane.com", "click"],
          [t, "todd@errplane.com", "click"]
        ]
      }
    ])
  end

  it "can post points to a series without the extra column names"
end

describe "GETing" do
  before :all do
    @db = "some_db"
  end

  it "returns a time series with a start and end time with a default order of newest first" do
    response = get("/db/#{@db}/series?q=select value from=cpu.idle where time>now()-1d")
    response_body_without_ids(response).should == [
      {
        "series": "cpu.idle",
        "columns": ["value", "time"],
        "datapoints": [
          [6.0, 1311836012],
          [5.0, 1311836011],
          [3.0, 1311836010],
          [2.0, 1311836009],
          [1.0, 1311836008]
        ]
      }
    ]
  end

  it "returns multiple time series with a start and end time" do
    response = get("/db/#{@db}/series?q=select value from cpu.* where time>now()-7d and time<now()-6d")
  end

  it "splits unique column values into multiple time series" do
    write_points(@db, "users.events", [
      {email: "paul@errplane.com", type: "click", target: "/foo/bar/something"},
      {email: "todd@errplane.com", type: "click", target: "/asdf"},
      {email: "paul@errplane.com", type: "click", target: "/jkl", time: 2.days.ago.to_i}
    ])
    response = get("/db/#{@db}/series?q=select count(*) from users.events group_by user_email,time(1h) where time>now()-7d")
    response_body_without_ids(response).should == [
      {
        "series": "users.events",
        "columns": ["count", "time", "email"],
        "datapoints": [
          [1, 1311836012, "paul@errplane.com"],
          [1, 1311836012, "todd@errplane.com"],
          [1, 1311836008, "paul@errplane.com"]
        ]
      }
    ]    
  end

  it "returns the top n time series by a given function" do
    response = get("/db/#{@db}/series?q=select top(10, count(*)) from=users.events group_by user_email,time(1h) where time>now()-7d")
    # response has 10 time series in it
  end

  it "returns multiple time series by taking a regex in the from clause with a limit on the number of points with newest first (last point from every series)" do
    response = get("/db/#{@db}/series?q=select last(value) from .* limit=1")
    response_body_without_ids(response).should == [
      {
        "series": "users.events",
        "columns": ["value", "time", "email"],
        "datapoints": [
          [1, 1311836012]
        ]
      },
      {
        "series": "cpu.idle",
        "columns": ["value", "time"]
        "datapoints": [
          [6.0, 1311836012]
        ]
      }
    ]    
  end

  it "has a default where of time=now()-1h"
  it "has a default limit of 1000"

  it "can merge two time series into one" do
    response = get("/db/#{@db}/series?q=select count(*) from merge(newsletter.signups,user.signups) group_by time(1h) where time>now()-1d")
  end

  it "returns a time series that is the result of a diff of one series against another" do
    response = get("/db/#{@db}/series?q=select diff(t1.value, t2.value) from inner_join(memory.total, t1, memory.used, t2) group_by time(1m) where time>now()-6h")
  end

  it "returns a time series with the function applied to a time series and a scalar"


  it "returns a time series with counted unique values" do
    response = get("/db/#{@db}/series?q=select count(distinct(email)) from user.events where time>now()-1d group_by time(15m)")
  end

  it "returns a time series with calculated percentiles" do
    response = get("/db/#{@db}/series?q=select percentile(95, value) from response_times group_by time(10m) where time>now()-6h")
  end

  it "returns a single time series with the unique dimension values for dimension a for a given dimension=<some value>" do
    series_name = "events"
    write_points(@db, events, {email: "paul@errplane.com", type: "login"})
    response = get("/db/#{@db}/series?q=select count(*) from events where type='login'")
  end

  it "runs a continuous query with server sent events"

  it "can redirect a continuous query into a new time series" do
    response = get("/db/#{@db}/series?q=select count(*) from user.events where time<forever group_by time(1d) into=user.events.count.per_day")
  end

  it "can redirect a continuous query of multiple series into a many new time series" do
    response = get("/db/#{@db}/series?q=select percentile(95,value) from stats.* where time<forever group_by time(1d) into :series_name.percentiles.95")
  end

  it "has an index of the running continuous queries"
  it "can stop a continuous query"
end

describe "DELETEing" do
  it "deletes a range of data from start to end time from a time series"
  it "deletes a range of data from start to end time for any time series matching a regex"
end
