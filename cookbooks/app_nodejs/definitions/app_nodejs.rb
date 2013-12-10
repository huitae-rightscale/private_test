#
# Cookbook Name:: app_nodejs
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

# This is an adaptation of Opscode "deploy" resource to be used with RightScale repository LWRPs:
# cookbooks/repo, cookbooks/repo_git, cookbooks/repo_ros, cookbooks/repo_svn

define :app_nodejs, :mod_name => "", :g_option => "" do

  modules = params[:mod_name]
  is_global = params[:g_option]

  log "installing nodejs module : #{modules}"

  if is_global == "true"
      global = "-g"
  else
      global = " "
  end

  execute "install npm module" do
    command "npm #{global} install #{modules}"
  end

  log "installation is done : #{modules}"

end

