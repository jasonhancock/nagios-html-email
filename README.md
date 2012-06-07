nagios-html-email
=================

A script to send html email notifications from Nagios.

![example-notification](https://github.com/jasonhancock/nagios-html-email/raw/master/example-images/example-notification.png)

License: MIT
------------
Copyright (c) 2012 Jason Hancock <jsnbyh@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Installation
------------

Copy the notify-html-email script from the plugins directory and drop it into 
Nagios' plugins directory (this is usually /usr/lib64/nagios/plugins on a 
64-bit RHEL/CentOS box). Then configure Nagios.

Nagios Configuration
--------------------

Create the command object:

```
define command {
    command_name   notify-by-html-email
    command_line   /usr/bin/perl $USER1$/notify-html-email https://nagios.example.com/nagios
}

```

Notice a couple of things with the command object. First, I had to specify the
path to the perl binary. This was because Nagios will use the embedded perl
interpreter and I didn't want that to happen. Second, I'm passing the url
of my nagios instance to the script. The url is only used to build links
that get put into the body of the email. This is so you can click on the
links directly from the email and get taken to your Nagios installation.

Now that the command object has been configured, you must tell your contacts to
use this new command. I have a generic-contact template that all of my individual
contacts inherit from, thus I only have to update the template to use the new
command:

```
define contact{
    name                            generic-contact 
    register                        0
    ...
    service_notification_commands   notify-by-html-email
    host_notification_commands      notify-by-html-email
}

```

Restart Nagios to pick up the changes.
