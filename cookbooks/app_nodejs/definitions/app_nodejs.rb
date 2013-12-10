#
# Cookbook Name:: app_nodejs
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

# This is an adaptation of Opscode "deploy" resource to be used with RightScale repository LWRPs:
# cookbooks/repo, cookbooks/repo_git, cookbooks/repo_ros, cookbooks/repo_svn

define :app_nodejs, :options => "", :mod_name => nil, :path => nil, :g_option => false do

  log "Create path to install in #{params[:path]} if not exists...."

  directory "#{params[:path]}" do
    ower nodejs
    group nodejs
    mode 0755 
    recursive true
    action :create
    only_if { params[:path]!=nil }
    not_if { ::File.directory?("#{params[:path]}") }
  end

  log "installing nodejs module : #{params[:mod_name]}"

  if (params[:g_option] == "true" && !params[:path].nil?)
      option = "-g --prefix #{params[:path]} "
  end

  execute "install npm module" do
    command "npm #{option} install #{params[:mod_name]}"
  end

  log "installation is done : #{params[:mod_name]}"

end

