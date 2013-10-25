maintainer        ""
maintainer_email  ""
license           ""
description       "Install & configure avn application"
version           "0.1.1"

depends "rightscale"

recipe "avn::default"           , "default recipe"
#recipe "avn::install_cloudtv"   , "Install & configure cloudtv app"
#recipe "avn::install_transcoder", "Install & configure transcoder"

attribute 'avn/tier',
    :display_name   => "tier",
    :description    => "Server Role",
    :type           => "string",
    :required       => "required",
    :choice         => [ "cloudtv", "transcoder" ],
    :recipes        => [ "avn::default" ]

attribute 'avn/transcoder_ip',
    :display_name   => "transcoder_ip",
    :description    => "IP of transcoder server",
    :type           => "string",
    :required       => "optional",
    :recipes        => [ "avn::default" ]

attribute 'avn/transcoder_master',
    :display_name   => "cluster_master",
    :description    => "Select master of transcoder master",
    :type           => "string",
    :required       => "optional",
    :choice         => [ "master", "slave" ],
    :recipes        => [ "avn::default" ]

attribute 'avn/cluster_master_ip',
    :display_name   => "transcoder_cluster",
    :description    => "IP or FQDN of transcoder master",
    :type           => "string",
    :required       => "optional",
    :recipes        => [ "avn::default" ]

attribute "avn/port",
  :display_name => "Application Listen Port",
  :description =>
    "The port that the application service is listening on. Example: 80",
  :default => "80",
  :recipes => [ "avn::default" ],
  :required => "optional"

attribute "avn/backend_ip_type",
  :display_name => "Application IP Type Given to Load Balancer",
  :description =>
    "Specify the IP type where the application server is listening." +
    " Example: private",
  :choice => ["public", "private"],
  :default => "private",
  :recipes => ["avn::default"],
  :required => "optional"

