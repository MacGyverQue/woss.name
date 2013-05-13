---
layout: post
status: publish
published: true
title: ! 'Solaris: Upgrading to Sun Studio 12'
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
wordpress_id: 444
wordpress_url: http://woss.name/2007/06/24/solaris-upgrading-to-sun-studio-12/
date: 2007-06-24 16:57:12.000000000 +01:00
categories:
- Geekery
- Solaris
tags:
- Geekery
- Solaris
comments:
- id: 892
  author: toha
  author_email: tomi.hakala@pobox.fi
  author_url: ''
  date: !binary |-
    MjAwNy0wNy0wOCAxMDoyMDo1MCArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNy0wOCAwOToyMDo1MCArMDEwMA==
  content: <p>Thanks!<&#47;p>
---
I should probably be ashamed that it's taken me this long to notice: I don't have a compiler installed in my zones!  I discovered this afternoon while I was trying to build mongrel for an app I was about to deploy!  I had assumed that Sun Studio 11, which is installed in the global zone would be automatically available to the other zones.

Apparently not.  I don't know if it's a quirk of my installation, or whether I've screwed something up, but Sun Studio doesn't appear to be managed by the packaging system.  `pkginfo|grep SUNWspro` doesn't show up anything.  Well, I suppose that'll explain why it's not being copied across to the zones as it should...  So, let's get it installed properly, and let's upgrade to Sun Studio 12 while we're at it.

First of all, let's go grab the new packages from here: [Sun Studio downloads](http:&#47;&#47;developers.sun.com&#47;sunstudio&#47;downloads&#47;index.jsp).  Follow through the usual rigmarole for downloading packages for Sun, logging, accepting license agreements, that kind of thing.  I did discover that I can copy the URL from the download page and pass it to `wget` on the server, which saved me some time.  And got [download speeds of ~1.5MB&#47;s](http:&#47;&#47;belowzero.biz&#47;). :-)

While that's in progress, let's uninstall Sun Studio 11, which is required before we can install 12.  Approximately following the instructions from [Uninstalling the Sun Studio 11 software](http:&#47;&#47;docs.sun.com&#47;source&#47;819-3052&#47;remove.html#56314) we do the following in the global zone:

    mathie@kilchoman:~$ cd &#47;var&#47;sadm&#47;prod&#47;com.sun.studio_11&#47;
    mathie@kilchoman:com.sun.studio_11$ pfexec .&#47;batch_uninstall_all

It chunters away for a few minutes, uninstalling the various components of Studio 11.

Once the previous steps are complete, we're free to install Sun Studio 12.  First of all, create a directory and unpack the download into it:

    mathie@kilchoman:~$ mkdir SunStudio12
    mathie@kilchoman:~$ cd SunStudio12&#47;
    mathie@kilchoman:SunStudio12$ gtar jxf ~&#47;SunStudio12-solaris-x86-200705-pkg.tar.bz2

Now we follow the steps outlined in [Installing on a Solaris 10 1&#47;06 OS Server With Zones](http:&#47;&#47;docs.sun.com&#47;app&#47;docs&#47;doc&#47;820-0273&#47;6nc1a9djl?a=view) by running the following in the global zone:

    mathie@kilchoman:SunStudio12$ pfexec .&#47;prepare_system -s patches
    mathie@kilchoman:SunStudio12$ pfexec .&#47;batch_installer --accept-sla --zone=all

The first command didn't appear to do much in my case; then again I've updated patches on the system quite recently.  The batch installer sits there for a while, then almost silently, finishes.  You can verify that the install has worked in the global zone by running `version`.  It should report the various Sun Studio 12 tools as being installed.

But the real proof of the pudding?  In a zone:

    mathie@cardhu:~$ version
    [ snip ]
    The following components are installed on your system:

    Sun Studio 12
            Sun Studio 12 C Compiler
            Sun Studio 12 C++ Compiler

Score!