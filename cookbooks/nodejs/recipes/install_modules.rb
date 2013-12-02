#
# Cookbook Name:: nodejs
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

module_list = node['nodejs']['module_list']

module_list.each do |mod|
    nodejs_module mod
end

#bash "install_npm_module" do
#  code <<-EOM
#    npm install socket.io 
#    mkdir /usr/local/jboss
#    tar zxf jboss.tar.gz --strip=1 -C /usr/local/jboss
#    chown -R jboss:jboss /usr/local/jboss
#    chmod 0755 /usr/local/jboss
#    rm -f /usr/local/jboss/bin/*.bat
#    rm -f /usr/local/jboss/standalone/configuration/*.xml
#  EOM
#  not_if { ::File.exists?("/usr/local/jboss/bin") }
#end
