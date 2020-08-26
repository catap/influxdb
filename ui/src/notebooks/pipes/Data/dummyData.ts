import {Schema} from 'src/types'

export const results: Schema = {
  cpu: {
    fields: [
      'usage_guest',
      'usage_guest_nice',
      'usage_idle',
      'usage_iowait',
      'usage_irq',
      'usage_nice',
      'usage_softirq',
      'usage_steal',
      'usage_system',
      'usage_user',
    ],
    tags: {
      host: ['MBP15.lan1'],
      cpu: [
        'cpu-total',
        'cpu0',
        'cpu1',
        'cpu10',
        'cpu11',
        'cpu2',
        'cpu3',
        'cpu4',
        'cpu5',
        'cpu6',
        'cpu7',
        'cpu8',
        'cpu9',
      ],
    },
  },
  disk: {
    fields: [
      'free',
      'inodes_free',
      'inodes_total',
      'inodes_used',
      'total',
      'used',
      'used_percent',
    ],
    tags: {
      fstype: ['apfs'],
      device: ['disk1s1', 'disk1s4', 'disk1s5', 'disk2s1'],
    },
  },
  diskio: {
    fields: [
      'io_time',
      'iops_in_progress',
      'read_bytes',
      'read_time',
      'reads',
      'weighted_io_time',
      'write_bytes',
      'write_time',
      'writes',
    ],
    tags: {
      name: ['disk0', 'disk2'],
      host: ['ip-192-168-1-206.ec2.internal'],
    },
  },
  mem: {
    fields: [
      'active',
      'available',
      'available_percent',
      'buffered',
      'cached',
      'commit_limit',
      'committed_as',
      'dirty',
      'free',
      'high_free',
      'high_total',
      'huge_page_size',
      'huge_pages_free',
      'huge_pages_total',
      'inactive',
      'low_free',
      'low_total',
      'mapped',
      'page_tables',
      'shared',
      'slab',
      'swap_cached',
      'swap_free',
      'swap_total',
      'total',
      'used',
      'used_percent',
      'vmalloc_chunk',
      'vmalloc_total',
      'vmalloc_used',
      'wired',
      'write_back',
      'write_back_tmp',
    ],
    tags: {
      host: ['ip-192-168-1-206.ec2.internal'],
    },
  },
  net: {
    fields: [
      'bytes_recv',
      'bytes_sent',
      'drop_in',
      'drop_out',
      'err_in',
      'err_out',
      'packets_recv',
      'packets_sent',
    ],
    tags: {
      host: ['ip-192-168-1-206.ec2.internal'],
      interface: [
        'awd10',
        'en0',
        'en1',
        'en2',
        'en3',
        'en4',
        'en5',
        'llw0',
        'p2p0',
        'utun0',
        'utun1',
        'utun2',
      ],
    },
  },
  processes: {
    fields: [
      'blocked',
      'idle',
      'running',
      'sleeping',
      'stopped',
      'total',
      'unknown',
    ],
    tags: {
      host: ['ip-192-168-1-206.ec2.internal'],
    },
  },
  swap: {
    fields: ['free', 'in', 'out', 'total', 'used', 'used_percent'],
    tags: {
      host: ['ip-192-168-1-206.ec2.internal'],
    },
  },
  system: {
    fields: [
      'load1',
      'load15',
      'load5',
      'n_cpus',
      'n_users',
      'uptime',
      'uptime_format',
    ],
    tags: {
      host: ['ip-192-168-1-206.ec2.internal'],
    },
  },
}