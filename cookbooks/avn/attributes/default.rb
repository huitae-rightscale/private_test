default[:avn][:private_ip] = node[:cloud][:private_ips][0]
default[:avn][:public_ip] = node[:cloud][:public_ips][0]
default[:avn][:provider] = "app"
# By default listen on the first private IP
default[:avn][:ip] = node[:cloud][:private_ips][0]
# IP addrs of loadbalancer requesting firewall ports to be opened to it
default[:avn][:lb_private_ip] = ""
default[:avn][:lb_public_ip] = ""
default[:avn][:port] = "80"
default[:avn][:backend_ip_type] = "private"

