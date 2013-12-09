#
# Cookbook Name:: app_passenger
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

# @resource app

# Stops apache/passenger
action :stop do
  log "  Running stop sequence"
  service "apache2" do
    action :stop
    persist false
  end
end

# Starts apache/passenger
action :start do
  log "  Running start sequence"
  service "apache2" do
    action :start
    persist false
  end
end

# Reloads apache/passenger
action :reload do
  log "  Running reload sequence"
  service "apache2" do
    action :reload
    persist false
  end
end

# Restarts apache/passenger
action :restart do
  log "  Running restart sequence"
  # Calls the :stop action.
  action_stop
  sleep 5
  # Calls the :start action.
  action_start
end

# Installs required packages to system
action :install do

  # Installing some apache development headers required for rubyEE
  packages = new_resource.packages
  log "  Packages which will be installed: #{packages}"

  case node["platform"]
   when "ubuntu"
     repo = "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
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
           :nodejs_install_path    => node[:nodejs][:bin_path]
       })
     end
  end
end


# Sets up apache/passenger virtual host
action :setup_vhost do
  raise 'Will do nothing because node.js will act as a webserver itself'
end


# Sets up Passenger database connection
action :setup_db_connection do
  #raise 'DB connection will be handled by node.js module'
  log "DB connection will be handled by node.js module"
end


# Downloads/Updates application repository
action :code_update do

  deploy_dir = new_resource.destination

  log "  Starting code update sequence"
  log "  Current project doc root is set to #{deploy_dir}"
  log "  Downloading project repo"

  # Calling "repo" LWRP to download remote project repository
  # See cookbooks/repo/resources/default.rb for the "repo" resource.
  repo "default" do
    destination deploy_dir
    action node[:repo][:default][:perform_action].to_sym
    app_user node[:app][:user]
    repository node[:repo][:default][:repository]
    persist false
  end

end

# Sets up monitoring tools for passenger
action :setup_monitoring do
  log "  Monitoring resource is not implemented in php framework yet. Use apache monitoring instead."

#  plugin_path = "#{node[:rightscale][:collectd_lib]}/plugins/passenger"
#
#  service "collectd" do
#    action :enable
#  end
#
#  directory "#{node[:rightscale][:collectd_lib]}/plugins/" do
#    recursive true
#    not_if { ::File.exists?("#{node[:rightscale][:collectd_lib]}/plugins/") }
#  end
#
#  # Installing collectd plugin for passenger monitoring
#  template "#{plugin_path}" do
#    source "collectd_passenger.erb"
#    mode "0755"
#    backup false
#    cookbook "app_passenger"
#    variables(
#      :apache_binary => node[:apache][:binary],
#      :passenger_memory_stats => "#{node[:app_passenger][:passenger_bin_dir]}/passenger-memory-stats",
#      :passenger_status => "#{node[:app_passenger][:passenger_bin_dir]}/passenger-status"
#    )
#    notifies :restart, resources(:service => "collectd")
#  end
#
#  # Removing previous passenger.conf in case of stop-start
#  file "#{node[:rightscale][:collectd_plugin_dir]}/passenger.conf" do
#    backup false
#    action :delete
#  end
#
#  # Installing collectd config for passenger plugin
#  template "#{node[:rightscale][:collectd_plugin_dir]}/passenger.conf" do
#    cookbook "app_passenger"
#    source "collectd_passenger.conf.erb"
#    variables(
#      :apache_executable => node[:web_apache][:config_subdir],
#      :apache_user => node[:app][:user],
#      :plugin_path => plugin_path
#    )
#    notifies :restart, resources(:service => "collectd")
#  end
#
  # Collectd exec cannot run scripts under root user, so we need to give ability to use sudo to "apache" user
  # passenger monitoring resources have strict restrictions, only for root can gather full stat info
  # we gave permissions to apache user to access passenger monitoring resources
#  ruby_block "sudo setup" do
#    block { ::File.open('/etc/sudoers', 'a') { |file| file.puts "#includedir /etc/sudoers.d\n" } }
#    not_if { ::File.readlines("/etc/sudoers").grep(/^\s*#includedir\s+\/etc\/sudoers.d/).any? }
#  end
#
#  directory "/etc/sudoers.d/" do
#    recursive true
#  end
#
#  template "/etc/sudoers.d/passenger-status" do
#    cookbook "app_passenger"
#    source "passenger-status.erb"
#    mode "0440"
#    variables(
#      :user => node[:app][:user],
#      :passenger_bin_dir => node[:app_passenger][:passenger_bin_dir]
#    )
#    not_if { ::File.exists?("/etc/sudoers.d/passenger-status") }
#    notifies :restart, resources(:service => "collectd")
#  end

end
