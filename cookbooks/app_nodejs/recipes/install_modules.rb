#
# Cookbook Name:: app_nodejs
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

log "  Installing nodejs modules:"

module_list = node['app_nodejs']['module_list']

module_list.each do |mod|
    nodejs_module mod do
      if node['app_nodejs']['module_global']
        is_global   true
      else
        is_global   false
      end
    end
end

# Install specified gems

# Variable node[:app_passenger][:opt_gems_list] contains space separated list of Gems along
# with their versions in the format:
#
#   ruby-Gem1:version  ruby-Gem2:version ruby-Gem3:version
#
#log "  Installing user specified gems:"
#ruby_block "Install custom gems" do
#  block do
#
#    gem_list = node[:app_passenger][:project][:gem_list]
#
#    # Split gem_list into an array
#    gem_list = gem_list.split
#    # Installing gems
#    gem_list.each do |gem_name|
#      begin
#        if gem_name =~ /(.+):([\d\.]{2,})/
#          name = "#{$1} --version #{$2}"
#        else
#          name = gem_name
#        end
#      end
#      Chef::Log.info("  Installing custom gem: #{name}")
#      raise "Error installing gems!" unless system("#{node[:app_passenger][:gem_bin].chomp} install #{name} --no-ri --no-rdoc --no-update-sources")
#    end
#
#  end
  only_if { node[:app_passenger][:project][:gem_list] != "" }
end
