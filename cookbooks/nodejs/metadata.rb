maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "This cookbook provides a set of nodejs recipes based on" +
                 " cookbook published by Chef cummunity. This" +
                 " cookbook contains recipes for installation and configuration with" +
                 " implementation, but generic recipes that use the LWRP interface."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1"

supports "centos"
supports "redhat"
supports "ubuntu"

depends "rightscale"

recipe "nodejs", "Installs Node.JS based on the default installation method"
recipe "nodejs::install_from_source", "Installs Node.JS from source"
recipe "nodejs::install_from_binary", "Installs Node.JS from official binaries"
recipe "nodejs::install_from_package", "Installs Node.JS from packages"
recipe "nodejs::npm", "Installs npm from source - a package manager for node"

