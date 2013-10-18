# Stop apache
action :stop do
  log "  Running stop sequence"
  service "apache2" do
    action :start
    persist false
  end
end

# Start apache
action :start do
  log "  Running start sequence"
  service "apache2" do
    action :start
    persist false
  end
end

# Reload apache
action :reload do
  log "  Running reload sequence"
  service "apache2" do
    action :reload
    persist false
  end
end

# Restart apache
action :restart do
  action_stop
  sleep 5
  action_start
end

