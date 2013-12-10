#
# Cookbook Name:: app_passenger
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

default[:app_nodejs][:version]      = "0.10.22"
default[:app_nodejs][:bin_baseurl]  = "http://nodejs.org/dist/v#{node[:app_nodejs][:version]}"
default[:app_nodejs][:tar]          = "node-v#{node[:app_nodejs][:version]}-linux-x64.tar.gz"
default[:app_nodejs][:source]       = "http://nodejs.org/dist/v#{node[:app_nodejs][:version]}/#{node[:app_nodejs][:tar]}"
default[:app_nodejs][:bin_path]     = "/usr/local/nodejs"
default[:app_nodejs][:checksum_linux_x64] = "3739f75bbb85c920a237ceb1c34cb872409d61f7"
default[:app_nodejs][:module_list]  = []
default[:app_nodejs][:path_to_install]  = nil

