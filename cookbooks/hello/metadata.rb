maintainer        "Hello World"
maintainer_email  ""
license           ""
description       "Just print hello world"
version           "0.1"

depends "rightscale"

recipe "hello::default", "Just say Hello!"

attribute 'hello/messages',
:display_name => "Hello Message",
:description => "Input messages to say",
:type => "string",
:required => "optional",
:recipes => [ "hello::default" ],
:default => "Hi There! This is a Test Message!"

attribute 'app/packages',
:display_name => "Install packages",
:description => "Install packages",
:type => "array",
:required => "optional",
:recipes => [ "hello::default" ]
