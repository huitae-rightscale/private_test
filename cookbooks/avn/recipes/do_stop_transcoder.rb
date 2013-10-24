#
# Cookbook Name:: avn
# Recipe:: do_start_cloudtv
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

log "Stopping transcoder components..."

service "lighttd" do
  action :stop
end

service "riak" do
  action :stop
end

