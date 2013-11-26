maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "This cookbook provides a set of nodejs recipes used by" +
                 " the RightScale Node.JS ServerTemplates. This" +
                 " cookbook contains  generic recipes that use the " +
                 " Lightweight Resource Provider (LWRP) interface."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

supports "centos"
supports "redhat"
supports "ubuntu"

depends "rightscale"

recipe "nodejs", "Installs Node.JS based on the default installation method"
recipe "nodejs::install_server", "Installs Node.JS from packages"
recipe "nodejs::install_modules", "Installs Node.JS from packages"

attribute "nodejs/version",
    :description    => "Node.js version to be installed.",
    :recipes        => ["nodejs::default", "nodejs::install_server"],
    :type           => "string",
    :display_name   => "nodejs_version",
    :required       => "recommended",
    :default        => "0.10.22"

attribute "nodejs/module_list",
    :description    => "Modules to be installed by npm.",
    :recipes        => ["nodejs::default", "nodejs::install_server", "nodejs::install_modules"],
    :type           => "array",
    :display_name   => "module_list",
    :required       => "optional"
