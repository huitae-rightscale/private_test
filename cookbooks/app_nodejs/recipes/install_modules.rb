#
# Cookbook Name:: app_nodejs
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

log "  Installing nodejs modules: #{node[:app_nodejs][:module_list]}"
log "  with options : #{node[:app_nodejs][:module_global]}"

app_nodejs "default" do
    mod_name node[:app_nodejs][:module_list]
    g_option node[:app_nodejs][:module_global]
end
