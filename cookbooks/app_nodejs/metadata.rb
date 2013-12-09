maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Cookbook provides an Apache + Passenger implementation of the" +
                 " 'app' Lightweight Resource Provider (LWRP). Installs and" +
                 " configures an Apache + Passenger application server."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "13.5.0"

supports "centos"
supports "redhat"
supports "ubuntu"

depends "app"
depends "repo"
depends "rightscale"
depends "web_apache"
depends "logrotate"

recipe "app_nodejs::setup_server", "Setup Node.js installation"
recipe "app_nodejs::install_modules", "Installs Node.js module"

#recipe "app_passenger::setup_server_3_0",
#  "Sets provider-specific attributes for rails-passenger"
#
#recipe "app_passenger::install_custom_gems",
#  "Installs custom gems."
#
#recipe "app_passenger::install_required_app_gems",
#  "Installs bundler gems. Gemfile must be present in app directory."
#
#recipe "app_passenger::run_custom_rails_commands",
#  "Runs specific user defined commands. Commands will be executed in" +
#  " the app directory."

attribute "app_nodejs/version",
  :description    => "Node.js version to be installed.",
  :recipes        => ["app_nodejs::setup_server"],
  :type           => "string",
  :display_name   => "nodejs_version",
  :required       => "recommended",
  :default        => "0.10.22"

attribute "app_nodejs/module_list",
  :description    => "Modules to be installed by npm." +
                     " seperated by blank" +
                     " example : module1 module2 ",
  :recipes        => ["app_nodejs::setup_server", "app_nodejs::install_modules"],
  :type           => "string",
  :display_name   => "module_list",
  :default        => "express forever",
  :required       => "optional"

attribute "app_nodejs/module_global",
  :description    => "Install modules with global environment.",
  :recipes        => ["app_nodejs::install_modules"],
  :choice         => ["true", "false"],
  :type           => "string",
  :display_name   => "module_global",
  :required       => "recommended",
  :default        => "true"

#attribute "app_passenger/rails_spawn_method",
#  :display_name => "Rails spawn method",
#  :description =>
#    "The spawn method that Phusion Passenger will use. The choices are:" +
#    " smart, smart-lv2, and conservative. Example: conservative",
#  :choice => ["conservative", "smart-lv2", "smart"],
#  :required => "recommended",
#  :default => "conservative",
#  :recipes => ["app_passenger::setup_server_3_0"]
#
#attribute "app_passenger/project/environment",
#  :display_name => "Rails Environment",
#  :description =>
#    "Creates a Rails RAILS ENV environment variable. Example: development",
#  :choice => ["development", "production", "test"],
#  :required => "optional",
#  :default => "development",
#  :recipes => ["app_passenger::setup_server_3_0"]
#
#attribute "app_passenger/apache/serve_local_files",
#  :display_name => "Apache serve local Files",
#  :description =>
#    "This option tells Apache whether it should serve the (static) content" +
#    " itself. Currently, it will omit dynamic content, such as *.php," +
#    " *.action, *.jsp, and *.do. Example: true",
#  :choice => ["true", "false"],
#  :required => "optional",
#  :default => "true",
#  :recipes => ["app_passenger::setup_server_3_0"]
#
#attribute "app_passenger/project/gem_list",
#  :display_name => "Custom gems list",
#  :description =>
#    "A space-separated list of optional gem(s)." +
#    " Format: ruby-Gem1:version ruby-Gem2:version ruby-Gem3." +
#    " Example: mygem:1.0, yourgem:2.0",
#  :required => "optional",
#  :default => "",
#  :recipes => ["app_passenger::install_custom_gems"]

#attribute "app_passenger/project/custom_cmd",
#  :display_name => "Custom rails/bin/ command",
#  :description =>
#    "A comma-separated list of optional commands which will be executed" +
#    " in the app directory." +
#    " Example: rake gems:install, rake db:create, rake get_common",
#  :required => "optional",
#  :default => "",
#  :recipes => ["app_passenger::run_custom_rails_commands"]
