---
layout: post
title: ! 'Thumper: Getting hardware sensor readings'
date: 2007-06-03 14:37:19 +01:00
categories:
- Geekery
- Solaris
tags:
- Geekery
- Solaris
---
I've been busy all week on other projects, so I haven't had as much time to
devote to the Thumper. However, in the background, I've been plotting how to
monitor the physical sensors.

I like to capture information and track it over time -- while it's not hugely
useful to know that the fan's RPM is 8000, it becomes useful to track it
because when you see it starting to trend down over a period of time, you've a
fair idea it's going to fail.

It might not be useful to graph that I have 17TB of disk space free on the ZFS
pool, but take that graph over 6 months, or a year, and you'll start to be
able to project forward and predict when you're going to run out of space.

So anyway, I thought to myself, "well, we're looking to grab sensor data, SNMP
is the obvious solution!" To gratuitously misquote (apparently) Steve Haflich,
"When your hammer is SNMP, everything begins to look like a thumb." I've spent
the past couple of sessions trying to make SNMP work, first on the ILOM
processor, then on the host machine, in the hopes that I could retrieve data
from the various hardware sensors on the X4500.

I failed miserably. In short, I couldn't actually get the ILOM to reliably
respond to SNMP requests with any version of the protocol and with any
authentication mechanism. I've no idea what I was doing wrong -- basically
it's just ignoring me:

    mathie@bowmore:mathie$ snmpwalk -v1 -c public 192.168.0.251
    Timeout: No Response from 192.168.0.251

although it did respond to that very incantation a while ago and I'm not aware
of what I've changed since! As for the host SNMP daemon(s), I couldn't see
anything that snmpwalk found that corresponded to temperatures or fan speeds.
In fact 1.3.6.1.4.1.42 (or `enterprises.sun`, Sun's own part of the OID tree)
was surprisingly sparse.

Then I found a far simpler solution. `ipmitool` is a command line program
which talks the Intelligent Platform Management Interface (IPMI). And so does
the ILOM. So we can use that to query parts of the ILOM system from the host
machine.  The most useful command I've found so far is:

    mathie@kilchoman:~$ ipmitool sdr list full
    proc.p0.t_core   | 52 degrees C      | ok
    proc.p1.t_core   | 50 degrees C      | ok
    dbp.t_amb        | 27 degrees C      | ok
    io.front.t_amb   | 42 degrees C      | ok
    io.rear.t_amb    | 39 degrees C      | ok
    proc.front.t_amb | 32 degrees C      | ok
    proc.rear.t_amb  | 36 degrees C      | ok
    ft0.f0.speed     | 8000 RPM          | ok
    ft0.f1.speed     | 8000 RPM          | ok
    ft1.f0.speed     | 7700 RPM          | ok
    ft1.f1.speed     | 7700 RPM          | ok
    ft2.f0.speed     | 8000 RPM          | ok
    ft2.f1.speed     | 8000 RPM          | ok
    ft3.f0.speed     | 7700 RPM          | ok
    ft3.f1.speed     | 8000 RPM          | ok
    ft4.f0.speed     | 7800 RPM          | ok
    ft4.f1.speed     | 8000 RPM          | ok
    io.v_+1v5        | 1.54 Volts        | ok
    io.v_+2v5        | 2.54 Volts        | ok
    io.v_+5v_disk    | 5.04 Volts        | ok
    io.v_-12v        | -12.20 Volts      | ok
    proc.p0.v_+1v25  | 1.27 Volts        | ok
    proc.p0.v_+1v5   | 1.42 Volts        | ok
    proc.p0.v_+2v5   | 2.58 Volts        | ok
    proc.p1.v_+1v25  | 1.27 Volts        | ok
    proc.p1.v_+1v5   | 1.40 Volts        | ok
    proc.p1.v_+2v5   | 2.58 Volts        | ok
    proc.v_+1v8      | 1.84 Volts        | ok
    sys.v_+12v       | 12.03 Volts       | ok
    sys.v_+1v2       | 1.23 Volts        | ok
    sys.v_+3v3       | 3.36 Volts        | ok
    sys.v_+3v3stby   | 3.29 Volts        | ok
    sys.v_+5v        | 4.99 Volts        | ok
    sys.v_bat        | 3.17 Volts        | ok

which gives me a list of all the information I might want to graph. It'll also
conveniently take a `-c` flag which dumps the information out in CSV format so
we can more easily parse it with another application.

Long term, SNMP might be a more consistent way to grab lots of different stats
about the system in a more portable manner, but for now this is good enough to
throw together a quick app that polls every few minutes and stores historical
readings. And then something to graph it all. Of course, Ruby (& Rails) is my
hammer... :-)

**Update** Hrm.  Unfortunately, I can't immediately figure out how access `ipmitool` from inside a container, rather than the global zone.  When it's working locally, it appears to try and get access to the IPMI through `/dev/bmc` which is not available in the zone I just created.  I wonder how I can make that happen, or whether the data collection part of the system is going to have to run in the global zone?
