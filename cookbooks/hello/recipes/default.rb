rightscale_marker

cookbook_file "/etc/yum.repos.d/rpmforge.repo" do
  source "rpmforge.repo"
  owner "root"
  group "root"
  mode 0644
end

log "Installing php"

node[:app][:packages].each do |p|
    package p do
      action :install
    end
end 


