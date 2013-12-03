#
# Cookbook Name:: nodejs
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

default[:nodejs][:version]      = "0.10.22"
default[:nodejs][:bin_baseurl]  = "http://nodejs.org/dist/v#{node[:nodejs][:version]}"
default[:nodejs][:tar]          = "node-v#{node[:nodejs][:version]}-linux-x64.tar.gz"
default[:nodejs][:source]       = "http://nodejs.org/dist/v#{node[:nodejs][:version]}/#{node[:nodejs][:tar]}"
default[:nodejs][:bin_path]     = "/usr/local/nodejs"
default[:nodejs][:checksum_linux_x64] = "3739f75bbb85c920a237ceb1c34cb872409d61f7"
default[:nodejs][:module_list]  = []
