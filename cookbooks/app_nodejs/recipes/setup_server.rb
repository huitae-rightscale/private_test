#
# Cookbook Name:: app_nodejs
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

log "  Setting provider specific settings for nodejs."
version = "#{node[:app_nodejs][:version]}"
node[:app][:provider] = "app_nodejs"
node[:app][:version] = version

case node[:platform]
when "ubuntu"
  node[:app][:packages] = [ "nodejs" ]
  node[:app][:user] = "nodejs"
  node[:app][:group] = "nodejs"
when "centos", "redhat"
  node[:app][:packages] = [
  ]
  node[:app][:user] = "nodejs"
  node[:app][:group] = "nodejs"
else
  raise "Unrecognized distro #{node[:platform]}, exiting "
end

