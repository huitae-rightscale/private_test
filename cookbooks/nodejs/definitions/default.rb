define :nodejs_module, :enable => true do

    log "installing nodejs module : #{params[:name]}"

#    execute "install npm module" do
#      command "npm -g install #{params[:name]}"
#    end

    bash "install_npm_module" do
      code <<-EOM
        npm -g install #{params[:mod]}
      EOM
    end

    log "installation is done : #{params[:name]}"
end
