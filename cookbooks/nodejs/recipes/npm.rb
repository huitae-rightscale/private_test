#--
# Copyright (c) 2013 RightScale, Inc, All Rights Reserved Worldwide.
#
# THIS PROGRAM IS CONFIDENTIAL AND PROPRIETARY TO RIGHTSCALE
# AND CONSTITUTES A VALUABLE TRADE SECRET.  Any unauthorized use,
# reproduction, modification, or disclosure of this program is
# strictly prohibited.  Any use of this program by an authorized
# licensee is strictly subject to the terms and conditions,
# including confidentiality obligations, set forth in the applicable
# License Agreement between RightScale, Inc. and
# the licensee.
#++

include_recipe "nodejs"

package "curl"

npm_src_url = "http://registry.npmjs.org/npm/-/npm-#{node['nodejs']['npm']}.tgz"

bash "install npm - package manager for node" do
  cwd "/usr/local/src"
  user "root"
  code <<-EOH
    mkdir -p npm-v#{node['nodejs']['npm']} && \
    cd npm-v#{node['nodejs']['npm']}
    curl -L #{npm_src_url} | tar xzf - --strip-components=1 && \
    make uninstall dev
  EOH
  not_if "#{node['nodejs']['dir']}/bin/npm -v 2>&1 | grep '#{node['nodejs']['npm']}'"
end

