# Cookbook Name:: rs_utils
#
# Copyright (c) 2011 RightScale Inc
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

default[:rs_utils][:short_hostname]        = 'localhost'
default[:rs_utils][:domain_name]           = 'localdomain'
default[:rs_utils][:search_suffix]         = ''

default[:rs_utils][:timezone] = nil
#default[:rs_utils][:timezone] = "UTC"
    
default[:rs_utils][:process_list] = ""
default[:rs_utils][:process_match_list] = ""   
default[:rs_utils][:private_ssh_key] = ""
default[:rs_utils][:collectd_share] = "/usr/share/collectd"
default[:rs_utils][:mysql_binary_backup_file] = "/var/run/mysql-binary-backup"

default[:rs_utils][:plugin_list] = ""
default[:rs_utils][:plugin_list_ary] = [
  "cpu",
  "df",
  "disk",
  "load",
  "memory",
  "processes",
  "swap",
  "users",
]

default[:rs_utils][:process_list] = ""
default[:rs_utils][:process_list_ary] = [ "init" ]

#
# Setup Distro dependent variables
#
case platform
when "redhat","centos","fedora","suse"
  rs_utils[:logrotate_config] = "/etc/logrotate.d/syslog"
  rs_utils[:collectd_config] = "/etc/collectd.conf"
  rs_utils[:collectd_plugin_dir] = "/etc/collectd.d"
when "debian","ubuntu"
  rs_utils[:logrotate_config] = "/etc/logrotate.d/syslog-ng"
  rs_utils[:collectd_config] = "/etc/collectd/collectd.conf"
  rs_utils[:collectd_plugin_dir] = "/etc/collectd/conf"
end

case node[:kernel][:machine]
when "i386", "i686"
  rs_utils[:collectd_lib] = "/usr/lib/collectd"
when "x86_64"
  rs_utils[:collectd_lib] = "/usr/lib64/collectd"
end

#
# Cloud specific attributes
#
rs_utils[:enable_remote_logging] = false

if node.has_key?('cloud')
  case cloud[:provider]
  when "ec2"
    rs_utils[:enable_remote_logging] = true
  end
end