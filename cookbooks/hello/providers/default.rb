#
# Cookbook Name:: hello
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

action :install do

  cookbook_file "/etc/yum.repo.d/rpmforge.repo" do
    source "rpmforge.repo"
    owner "root"
    group "root"
    mode 0644
  end

  packages = new_resource.packages

  unless packages.nil?
    log "Packages to be installed are #{packages}"

    packages.each do |p|
      package p
    end
  end
end

