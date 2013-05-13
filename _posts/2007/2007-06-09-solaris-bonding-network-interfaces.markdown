---
layout: post
status: publish
published: true
title: ! 'Solaris: Bonding network interfaces'
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
wordpress_id: 436
wordpress_url: http://woss.name/2007/06/09/solaris-bonding-network-interfaces/
date: 2007-06-09 13:54:37.000000000 +01:00
categories:
- Geekery
- Solaris
tags:
- Geekery
- Solaris
comments:
- id: 862
  author: Dick Davies
  author_email: rasputnik@gmail.com
  author_url: http://number9.hellooperator.net
  date: !binary |-
    MjAwNy0wNi0wOSAxNzo1OTo0MCArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNi0wOSAxNjo1OTo0MCArMDEwMA==
  content: ! '<p>No, what happens is:<&#47;p>


    <p>the host name in &#47;etc&#47;hostname.aggr1 is looked up (probably in &#47;etc&#47;hosts)
    to get the ip address.<&#47;p>


    <p>The netmask is picked up from &#47;etc&#47;inet&#47;networks - if you didn''t
    specify it, you''ll get a &#47;24 (which happens to be what you wanted).<&#47;p>'
- id: 863
  author: Graeme Mathieson
  author_email: mathie@rubaidh.com
  author_url: http://woss.name/
  date: !binary |-
    MjAwNy0wNi0xMCAwNzo0NDo0MCArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNi0xMCAwNjo0NDo0MCArMDEwMA==
  content: ! '<p>Dick: Ah, my bad.  I had considered that <code>&#47;etc&#47;hosts<&#47;code>
    was involved in changing the name from <code>&#47;etc&#47;hostname.<interface><&#47;code>
    to an IP address (with <code>&#47;etc&#47;inet&#47;netmasks<&#47;code> offering
    some assistance in lieu of guessing the netmask).  But my limited testing showed
    this not to happen -- I changed the entry in <code>&#47;etc&#47;hosts<&#47;code>
    to another IP on the local network, rebooted and it didn''t change IP.  When I
    changed it with <code>ifconfig<&#47;code>, however, the changes did persist, which
    is how I came to my conclusion.<&#47;p>


    <p>Unfortunately, the server in question is now sitting in the back of the car,
    so it''ll have to wait ''til this afternoon before I can do some more testing.  Everything
    else Solaris around here is using DHCP anyway.<&#47;p>


    <p>I''ve gotten kinda lost reading through <code>&#47;lib&#47;svc&#47;methods&#47;net-physical<&#47;code>...<&#47;p>'
- id: 864
  author: Dick Davies
  author_email: rasputnik@gmail.com
  author_url: http://number9.hellooperator.net
  date: !binary |-
    MjAwNy0wNi0xMSAyMDo1NTo1NyArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNi0xMSAxOTo1NTo1NyArMDEwMA==
  content: ! '<p>Hey Graham. You''re right - it''s &#47;etc&#47;inet&#47;netmasks
    (not networks as I said).<&#47;p>


    <p>The closest ref would be :<&#47;p>


    <p>http:&#47;&#47;docs.sun.com&#47;app&#47;docs&#47;doc&#47;816-4554&#47;6maoq01n9?a=view<&#47;p>


    <p>Looks like you can get away with just an IP in there too.<&#47;p>


    <p>It''s supposed to support CIDR notation (which would be a lot simpler than
    buggering about with 3 files) - personally I''d wait to be on the console for
    that though :)<&#47;p>'
- id: 865
  author: Graeme Mathieson
  author_email: mathie@rubaidh.com
  author_url: http://woss.name/
  date: !binary |-
    MjAwNy0wNi0xMiAxMDo1MjoyOSArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNi0xMiAwOTo1MjoyOSArMDEwMA==
  content: ! '<p>Dick, you''re absolutely right.  I shall update the article shortly
    so that at least it''s accurate in posterity...<&#47;p>


    <p>re working on the console, isn''t the ILOM lovely? :-)<&#47;p>'
- id: 866
  author: Paul Armstrong
  author_email: psarmstr@gmail.com
  author_url: http://gometric.us
  date: !binary |-
    MjAwNy0wNi0xNiAwNjoyMDo0OSArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNi0xNiAwNToyMDo0OSArMDEwMA==
  content: ! '<p>If you want resiliency, you probably want IPMP instead.<&#47;p>


    <p>http:&#47;&#47;docs.sun.com&#47;app&#47;docs&#47;doc&#47;816-4554&#47;6maoq027g?q=IPMP&amp;a=view<&#47;p>


    <p>Protects against failure anywhere between your NIC and the router (inclusive)
    unlike aggregation (and on aggregation across multiple switches is only kind of
    supported in many cases anyway).<&#47;p>


    <p>You can get throughput and redundancy by using aggregation and IPMP across
    all 4 interfaces on an X4500 :)<&#47;p>'
- id: 867
  author: Nekau
  author_email: steve.burton@crc.net
  author_url: http://www.crc.net
  date: !binary |-
    MjAwNy0wNi0xOSAxODoyMDozNyArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNi0xOSAxNzoyMDozNyArMDEwMA==
  content: ! '<p>How can I create this type of 2 redundancy in versions of Solaris
    before 10?<&#47;p>


    <p>I have many servers running 7&#47;8&#47;9, and I want an active&#47;standby
    layer 2 config.<&#47;p>


    <p>I don''t want to IPMP.<&#47;p>'
- id: 868
  author: Paul Armstrong
  author_email: psarmstr@gmail.com
  author_url: http://gometric.us
  date: !binary |-
    MjAwNy0wNi0yMCAwODo1NTozNCArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNi0yMCAwNzo1NTozNCArMDEwMA==
  content: ! '<p>Nekau:<&#47;p>


    <p>If you want redundancy at layer 2, you need IPMP as a link level detector won''t
    see the failed switch port between your distribution and aggregation switches.<&#47;p>


    <p>For aggregation prior to Solaris 10 you need http:&#47;&#47;www.sun.com&#47;products&#47;networking&#47;ethernet&#47;suntrunking&#47;<&#47;p>


    <p>Paul<&#47;p>'
- id: 869
  author: Graeme Mathieson
  author_email: mathie@rubaidh.com
  author_url: http://woss.name/
  date: !binary |-
    MjAwNy0wNi0yMCAwOToxMjo1MSArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNi0yMCAwODoxMjo1MSArMDEwMA==
  content: ! '<p>Paul: I''m glad you fielded that question because I didn''t know
    the answer. :-)  Thanks!<&#47;p>


    <p>I''ll take a look at IPMP for providing redundancy in addition to the aggregation.  I
    had assumed that aggregation would notice the link state of the interface and
    act accordingly.  As it is, in the current configuration, the router itself is
    a SPOF anyway.<&#47;p>'
- id: 870
  author: Paul Armstrong
  author_email: psarmstr@gmail.com
  author_url: http://gometric.us
  date: !binary |-
    MjAwNy0wNi0yMSAwMTozMDo1OSArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNi0yMSAwMDozMDo1OSArMDEwMA==
  content: ! "<p>Aggregation will notice if any of the following occur:\n* the cable
    between the server and the switch it's directly plugged into fails\n* the NIC
    fails\n* the switchport the interface is plugged into fails.<&#47;p>\n\n<p>It
    won't catch:\n* router failure\n* any uplink from the switch to further switching
    or routers<&#47;p>\n\n<p>So IPMP allows you to plug each interface into a different
    switch and create fully redundant paths without having to cross link everything
    and potentially ending up with layer 2 loops.<&#47;p>\n\n<p>For instance, you
    can do:\nrouter    router\n  |         |\nswitch    switch\n   \\        &#47;\n
    \   \\      &#47;\n     server<&#47;p>\n\n<p>Paul<&#47;p>"
- id: 871
  author: Mark Seabourne
  author_email: m.seabourne@ncrl.co.uk
  author_url: ''
  date: !binary |-
    MjAwNy0xMS0xMiAxNDo0MTowNiArMDAwMA==
  date_gmt: !binary |-
    MjAwNy0xMS0xMiAxMzo0MTowNiArMDAwMA==
  content: ! '<p>Hi,<&#47;p>


    <p>I''ve followed the procedures described above, but on a SunFire V245 system
    connected to an unmanaged 3com switch I''m getting the following message on the
    console:<&#47;p>


    <p>[kern.warning] WARNING: IP: Hardware address ''00.xx.xx.xx.xx.1a'' trying to
    be our address 192.168.001.095!<&#47;p>


    <p>1a is the ip address of the bge0 interface that was configured before I attempted
    the dladm configuration.<&#47;p>


    <p>Any suggestions welcome.<&#47;p>'
---
I've managed to find a new home for the Thumper.  The noise it's making is driving me absolutely batty, and I have to switch it off at night.  I'm also worried about it overheating as the weather starts to improve.  So I've managed to secure a deal with [Below Zero](http:&#47;&#47;belowzero.biz&#47;), an ISP based in Edinburgh with an amazing world-class network.  We're going to shift it into the new place tomorrow, so I'm preparing by changing IP addresses before it moves.

So anyway, one of the things I'd been wanting to do was figure out how to bond two network interfaces to give me some resilience on the net connection.  Turns out it's pretty easy, though I did have one mental stumbling block, which we'll come to in a moment. The instructions here are correct for a server with at least two e1000 interfaces, where the first one was configured during the install as the network interface.  You'll also want to do this from the console, because the first thing we're going to do is take down the network interface:

    mathie@kilchoman:~$ pfexec ifconfig e1000g0 unplumb

Now let's use `dladm` to bond the two network interfaces together and bring the bonded interface back up:

    mathie@kilchoman:~$ pfexec dladm create-aggr -d e1000g0 -d e1000g1 1
    mathie@kilchoman:~$ pfexec ifconfig aggr1 plumb

Now we give it an IP address:

    mathie@kilchoman:~$ pfexec ifconfig aggr1 192.168.0.253 netmask 255.255.255.0 up

There's one last thing you'll want to do:

    mathie@kilchoman:~$ pfexec mv &#47;etc&#47;hostname.{e1000g0,aggr1}

Now here's the thing that confused me: that's it!  The information you give to `dladm` automatically persists and you've already associated the IP address with the interface by shifting `&#47;etc&#47;hostname.<interface>`.  You don't need to go putting the information in `&#47;etc&#47;network&#47;interfaces` or some file in `&#47;etc&#47;sysconfig`.  That makes life a lot easier. :-)

**Update** I incorrectly said that the changes made with `ifconfig` automatically persist.  It turns out they don't, it uses a combination of `&#47;etc&#47;hostname.<interface>`, `&#47;etc&#47;hosts` and `&#47;etc&#47;inet&#47;netmasks` to infer the IP address of the interface.  Thanks to [Dick Davies](http:&#47;&#47;number9.hellooperator.net&#47;) for correcting me. :-)