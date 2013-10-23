maintainer        ""
maintainer_email  ""
license           ""
description       "Install & configure avn application"
version           "0.1"

depends "rightscale"

recipe "avn::default"           , "default recipe"
recipe "avn::install_cloudtv"   , "Install & configure cloudtv app"
recipe "avn::install_transcoder", "Install & configure transcoder"

attribute 'avn/tier',
    :display_name   => "tier",
    :description    => "Server Role",
    :type           => "string",
    :required       => "required",
    :choice         => [ "cloudtv", "transcoder" ],
    :recipes        => [ 
       "avn::default" 
    ]

attribute 'avn/transcoder_ip',
    :display_name   => "transcoder_ip",
    :description    => "IP of transcoder server",
    :type           => "string",
    :required       => "required",
    :recipes        => [ 
       "avn::install_cloudtv", 
       "avn::install_transcoder" 
    ]

