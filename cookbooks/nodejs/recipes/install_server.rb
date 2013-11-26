#
# Cookbook Name:: nodejs
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

case node["platform"]
  when "ubuntu"
    repo = "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
    packages = ["nodejs"]
    apt_repository "node.js" do
      uri repo
      distribution node["lsb"]["codename"]
      components ["main"]
      keyserver "keyserver.ubuntu.com"
      key "C7917B12"
      action :add
    end
  when "centos"
    packages = ["nodejs", "nodejs-devel", "npm"]
  else
    log "There are no nodejs packages for this platform; please use the source or binary method to install node"
end

packages.each do |p|
  package p
end

#include_recipe "nodejs::install_from_#{node['nodejs']['install_method']}"

