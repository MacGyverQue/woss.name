---
layout: post
title: Migrating hosts
date: 2006-03-31 09:12:55 +01:00
categories:
- Geekery
- Work
---
Well, yesterday was fun.  After all the kind comments I received, I decided to go shopping for a VPS to host my applications.  And, from [Paul](http://www.oobaloo.co.uk/)'s recommendation, decided to give [Rimuhosting](http://rimuhosting.com/) a shot.  The host was set up within a couple of hours of my application, along with a personal, friendly email introducing me to the service.  (Good customer service!  +1!)

So I spent the full day re-familiarising myself with [Debian](http://www.debian.org/) (well, [Ubuntu](http://www.ubuntu.com/) really, but their nice and similar, only Ubuntu has a release schedule that better suits me!).  I wound up upgrading to [Dapper Drake](https://wiki.ubuntu.com/DapperDrake), the current 'testing' release which is scheduled to be released in June.  It seems to work nicely, has MySQL 4.1 (which, IIRC from working with [MailManager](http://www.logicalware.org/), has almost useful Unicode support) [Ruby 1.8.4](http://www.ruby-lang.org/) and [lighttpd](http://www.lighttpd.net/) already packaged.

I made the decision *not* to use dpkg as a source for any of the Ruby modules.  It provides me with the base Ruby installation, and everything else is provided by Rubygems.  That allows me to stay on the bleeding edge a bit better, if necessary, giving me finer control over which Ruby packages I use.  Everything else is provided by the base system.

My previous experience of lighttpd was it magically being used when I run `script/server`, so I spent a while figuring out how to get that working, first of all having it spawn the fcgi processes directly, then moving on to using the Rails spinners.  (Note to self:  I still need to setup an init script to run `/home/vhosts/*/current/script/spin` so that things start up correctly after a reboot!)

But now I have my two 'production' applications running on the new host.  There was an unfortunate period of downtime while I switched the DNS across (though now I have control of the http daemon, that should never happen again, because I can fiddle in some proxying to the new host for the next scale-up).

All in all, I'm quite pleased with myself.  I managed to set up and deploy a Rails-based hosting service in less than a day, figuring large amounts of it from scratch.  This bodes well for any future deployments.  Next time I should document it step-by-step.  And after that, automate it.
