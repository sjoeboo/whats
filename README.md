whats
-----

A script to query puppetdb and tell you what something is.

* Takes hostname/fqdn as an argument.
* Can provide yaml/json output as well as human readable.
* Has configurable default fact list
* has configurable domain completion/searches

Basically, `whats` is a wrapper around the puppetdb api, and will return facts you find interesting.

Installation
------------
```
gem install puppet-whats
```

Config Example
--------------

```
---
puppetdb_server: 'puppetdb.some.domain.com'
puppetdb_port: '8080'
domains:
  - some.domain.com
  - domain.com
basic_info:
  - hostname
  - uptime
```

Usage
-----

```
whats --help
Usage: whats [options] <hostname>
    -j, --json                       JSON output
    -y, --yaml                       YAML output
    -p, --pp                         Pretty Print output
    -a, --all                        Use all facts
    -c, --config CONFIG              Config file to use
    -v, --verbose                    Be verbose
    -q, --quiet                      Be extra quiet, only shown
```
Default output is a human readble table, thanks to [terminal-table](https://github.com/tj/terminal-table)

Options are pretty obvious, however:

`-j --json` will output json formatted facts

`-y --yaml` will output yaml formatted facts

`-p --pp` will pretty-print format the facts

`-a --all` will just output all the facts, with whatever output you pick

`-v --verbose` will give you a little more info as to whats going on

`-q --quiet` will suppress everything except the fact output, for scripting

`-c --config` lets you specify a config (yaml) other than the default locations of `['~/.whats.yaml','/etc/whats.yaml']`

Example:
--------
Normal:
```
╰─ ./whats puppetca
Searching for puppetca...
Searching for puppetca.test.domain
+------------------------+--------------------------------------------------------+
| Fact                   | Value                                                  |
+------------------------+--------------------------------------------------------+
| hostname               | puppetca                                               |
| manufacturer           | VMware, Inc.                                           |
| productname            | VMware Virtual Platform                                |
| serialnumber           | VMware-42 20 6d 93 d4 97 c0 b8-01 dc 5d 46 e9 c7 69 a8 |
| operatingsystem        | CentOS                                                 |
| operatingsystemrelease | 7.2.1511                                               |
| architecture           | x86_64                                                 |
| processor0             | Intel(R) Xeon(R) CPU E5-2698 v3 @ 2.30GHz              |
| processorcount         | 4                                                      |
| memorysize             | 3.70 GiB                                               |
| kernelrelease          | 3.10.0-327.10.1.el7.x86_64                             |
| ipaddress              | 10.120.6.8                                             |
| macaddress             | 00:50:56:a0:71:0b                                      |
| virtual                | vmware                                                 |
| uptime                 | 10 days                                                |
+------------------------+--------------------------------------------------------+
```

Todo
----

[ ] Add SSL support
[ ] Make rubygem?
