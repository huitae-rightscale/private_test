#
# Cookbook Name:: nodejs
# Attributes:: nodejs
#
# Copyright 2010-2012, Promet Solutions
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

case node['platform']
  when "ubuntu"
    default['nodejs']['install_method'] = 'package'
  when "centos"
    default['nodejs']['install_method'] = 'binary'
end

default['nodejs']['version'] = '0.10.22'
default['nodejs']['checksum_linux_x64'] = '3739f75bbb85c920a237ceb1c34cb872409d61f7'
default['nodejs']['dir'] = '/opt/'
#default['nodejs']['npm'] = '1.3.5'
default['nodejs']['src_url'] = "http://nodejs.org/dist"
default['nodejs']['make_threads'] = node['cpu'] ? node['cpu']['total'].to_i : 2
default['nodejs']['check_sha'] = true

# Set this to true to install the legacy packages (0.8.x) from ubuntu/debian repositories; default is false (using the latest stable 0.10.x)
#default['nodejs']['legacy_packages'] = false
