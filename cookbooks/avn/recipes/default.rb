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
when "trasncoder"
    node[:avn][:packages] = [
        "transcoder",
        "riak"
    ]
end

cookbook_file "/etc/yum.repos.d/activevideo-H5.repo" do
  source "activevideo-H5.repo"
  owner "root"
  group "root"
  mode 0644
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
elsif node[:avn][:tier] == "trasncoder"
end
 
rightscale_marker :end
