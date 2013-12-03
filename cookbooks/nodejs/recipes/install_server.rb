#
# Cookbook Name:: nodejs
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

user "nodejs" do
  home "/usr/local/nodejs"
  group "nodejs"
end

case node["platform"]
  when "ubuntu"
    repo = "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
    packages = ["nodejs"]
    apt_repository "node.js" do
      uri repo
      distribution node["lsb"]["codename"]
      components ["main"]
      keyserver "keyserver.ubuntu.com"
      key "C7917B12"
      action :add
    end

    packages.each do |p|
      package p
    end

  when "centos"
    remote_file "/tmp/#{node[:nodejs][:tar]}" do
      owner "root"
      group "root"
      mode "0644"
      source "#{node[:nodejs][:source]}"
      checksum "#{node[:nodejs][:checksum_linux_x64]}"
    end

    bash "unpack_nodejs" do
      cwd "/tmp"
      code <<-EOM
        tar zxf #{node[:nodejs][:tar]} --strip=1 -C /usr/local/nodejs
        chown -R nodejs:nodejs /usr/local/nodejs
        chmod 0755 /usr/local/nodejs
      EOM
      not_if { ::File.exists?("/usr/local/nodejs/bin") }
    end

    template "/etc/profile.d/nodejs.sh" do
        source "nodejs.sh.erb"
        owner "root"
        group "root"
        cookbook "nodejs"
        variables({
            :nodejs_install_path    => "#{[:nodejs][:bin_path]"
        })
    end
  else
    log "There are no nodejs packages for this platform; please use the source or binary method to install node"
end

log "Node.js is installed successfully!!"
