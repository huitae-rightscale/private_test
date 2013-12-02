define :nodejs_module, :enable => true do

    log "parametes are : #{params[:name]}"

#    execute "install npm module" do
#      command "npm -g install #{params[:name]"
#    end

#    bash "install_npm_module" do
#      code <<-EOM
#        npm install #{params[:mod]}
#        mkdir /usr/local/jboss
#      EOM
#    end
end
