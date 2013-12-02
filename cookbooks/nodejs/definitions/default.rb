define :nodejs_module, :enable => true, :is_global => false do

    log "installing nodejs module : #{params[:name]}"

    if params[:is_global] == "true"
        global = "-g"
    else
        global = " "
    end

    execute "install npm module" do
      command "npm #{global} install #{params[:name]}"
    end

    log "installation is done : #{params[:name]}"
end
