maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "This cookbook provides a set of database recipes used by" +
                 " the RightScale Database Manager ServerTemplates. This" +
                 " cookbook does not contain a specific database implementation," +
                 " but generic recipes that use the Lightweight Resource" +
                 " Provider (LWRP) interface."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

supports "centos"
supports "redhat"
supports "ubuntu"

depends "rightscale"

recipe "nodejs", "Installs Node.JS based on the default installation method"
#recipe "nodejs::install_from_source", "Installs Node.JS from source"
#recipe "nodejs::install_from_binary", "Installs Node.JS from official binaries"
recipe "nodejs::install_from_package", "Installs Node.JS from packages"

attribute "nodejs/version",
    :description    => "Node.js version to be installed.",
    :recipes        => ["nodejs::default", "nodejs::install_from_package"],
    :type           => "string",
    :display_name   => "nodejs_version",
    :required       => "recommended",
    :default        => "0.10.22"

attribute "nodejs/modules",
    :description    => "Modules to be installed by npm.",
    :recipes        => ["nodejs::default", "nodejs::install_from_package"],
    :type           => "array",
    :display_name   => "modules",
    :required       => "optional"

attribute "nodejs/install_path",
    :description    => "Path to install nodejs.",
    :recipes        => ["nodejs::default", "nodejs::install_from_package"],
    :type           => "string",
    :display_name   => "install_path",
    :required       => "optional",
    :default        => "/opt/nodejs"
