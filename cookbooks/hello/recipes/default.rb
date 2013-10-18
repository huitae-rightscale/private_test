rightscale_marker

cookbook_file "/etc/yum.repo.d/rpmforge.repo" do
  source "rpmforge.repo"
  owner "root"
  group "root"
  mode 0644
end

log "Installing php"

package "php" do
    action :install
end


