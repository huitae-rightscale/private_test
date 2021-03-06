#
# Cookbook Name:: avn
# Recipe:: default
#
# Copyright 2013, RightScale Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
# Cookbook Name:: avn
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker

log " Setting tier specific settings for avn application server."

case node[:avn][:tier]
when "cloudtv"
    node[:avn][:packages] = [
        "cloudtv",
        "settopdata"
    ]
when "transcoder"
    node[:avn][:packages] = [
        "transcoder",
        "riak"
    ]
end

cookbook_file "/etc/yum.repos.d/activevideo-H5.repo" do
  source "activevideo-H5.repo"
  owner "root"
  group "root"
  mode "0644"
end

package "jdk" do
    action :remove
end

node[:avn][:packages].each do |p|
    package p do
      action :install
    end
end 

if node[:avn][:tier] == "cloudtv"

  template "/etc/opt/usm.xml" do
    source "usm.xml.erb"
    owner "rendercast"
    group "ctvadmin"
    mode "0664"
    variables({
      :cloudtv_public_ip    => node[:avn][:public_ip],
      :cloudtv_private_ip   => node[:avn][:private_ip]
    })
  end

  template "/etc/opt/devices.xml" do
    source "devices.xml.erb"
    owner "rendercast"
    group "ctvadmin"
    mode "0664"
  end

  template "/etc/opt/programs.xml" do
    source "programs.xml.erb"
    owner "rendercast"
    group "ctvadmin"
    mode "0664"
  end

  template "/etc/opt/compositor.xml" do
    source "compositor.xml.erb"
    owner "rendercast"
    group "ctvadmin"
    mode "0664"
    variables({
      :transcoder_ip    => node[:avn][:transcoder_ip],
    })
  end

  service "compositor" do
    supports :reload => true, :restart => true
    action :restart
  end

  service "usm" do
    supports :reload => true, :restart => true
    action :restart
  end

  service "lighttpd" do
    supports :reload => true, :restart => true
    action :restart
  end

elsif node[:avn][:tier] == "transcoder"

  if node[:avn][:transcoder_master] == "master" 
    master_ip = node[:avn][:private_ip]
  elsif node[:avn][:transcoder_master]== "slave"
    master_ip = node[:avn][:cluster_master_ip]
  end

  template "/etc/opt/transcoder_config.pl" do
    source "transcoder_config.pl.erb"
    owner "rendercast"
    group "ctvadmin"
    mode "0664"
    variables({
      :riak_master_ip   => master_ip
    })
  end

  template "/etc/lighttpd/lighttpd.conf" do
    source "lighttpd.conf.trans.erb"
    owner "rendercast"
    group "ctvadmin"
    mode "0664"
  end

  service "riak" do
    action :start
  end

  service "lighttpd" do
    supports :reload => true, :restart => true
    action :restart
  end

end
 
