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
    nodejs_module mod do
      if node['nodejs']['module_global']
        is_global   true
      else
        is_global   false
      end
    end
end
