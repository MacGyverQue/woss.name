---
layout: post
status: publish
published: true
title: Installing DBI::mysql on Solaris 10
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
wordpress_id: 274
wordpress_url: http://woss.name/2006/05/21/installing-dbimysql-on-solaris-10/
date: 2006-05-21 12:24:20.000000000 +01:00
categories:
- Geekery
- Solaris
- Work
tags: []
comments:
- id: 464
  author: Peter Tribble
  author_email: peter.tribble@gmail.com
  author_url: http://ptribble.blogspot.com/
  date: !binary |-
    MjAwNi0wNS0yMSAxNTo1OToxOCArMDEwMA==
  date_gmt: !binary |-
    MjAwNi0wNS0yMSAxNDo1OToxOCArMDEwMA==
  content: ! '<p>Something''s slightly confused here.<&#47;p>


    <p>Are you using a 32 or 64-bit mysql distribution? Your mention of -xarch=v9
    implies 64-bit; you can''t combine 32 and 64-bit files whatever. In that case
    I''m very surprised it will even build. If you''re going to link it against perl,
    you''ll have to use the 32-bit version.<&#47;p>


    <p>I don''t see any benefit on the client side to using a 64-bit mysql; I''m not
    sure there''s much of a benefit on the server (for SPARC) unless you actually
    want to access a database that big in memory. (The situation is slightly different
    on x64, where you usually do get a win from going to 64-bit, but this is largely
    due to the 64-bit ABI being different from the 32-bit ABI rather than due simply
    to the number of bits.)<&#47;p>


    <p>I''ve never had a problem with getting DBD&#47;DBI&#47;mysql to work with the
    binary mysql downloaded from mysql.com. The binary downloads do have their problems
    - not supplying shared libraries can cause problems with other applications (PHP,
    for example) that want to link against them.<&#47;p>'
- id: 465
  author: mathie
  author_email: mathie@woss.name
  author_url: http://woss.name/
  date: !binary |-
    MjAwNi0wNS0yMSAxNzoxMDo0MyArMDEwMA==
  date_gmt: !binary |-
    MjAwNi0wNS0yMSAxNjoxMDo0MyArMDEwMA==
  content: ! '<p>peter: It''s the 64-bit version of 5.0.21 for Solaris 10, from the
    MySQL web site.  Good point, I should just grab the 32-bit version and be done
    with it.  I can worry about scaling if I ever actually need to scale beyond that!<&#47;p>


    <p>As it is, I''ve remembered somebody in the past recommending <a href="http:&#47;&#47;www.blastwave.org&#47;"
    rel="nofollow">Blastwave<&#47;a> and I''m just installing all my packages from
    there for the moment.  That''s working a whole lot better. :)<&#47;p>


    <p>Thanks for the advice.<&#47;p>'
- id: 466
  author: Rakesh Saini
  author_email: rakeshsaini@yahoo.com
  author_url: ''
  date: !binary |-
    MjAwOC0wNi0yNyAxMTowNzoyMiArMDEwMA==
  date_gmt: !binary |-
    MjAwOC0wNi0yNyAxMDowNzoyMiArMDEwMA==
  content: ! '<p>Done successful compilation with following flags

    perl Makefile.PL --cflags="-I&#47;opt&#47;mysql&#47;mysql&#47;include -D_FORTEC_"
    --libs="-L&#47;opt&#47;mysql&#47;mysql&#47;lib -lmysqlclient -lz -lposix4 -lresolv
    -lgen -lsocket -lnsl -lm"<&#47;p>'
- id: 467
  author: Gerardo Diaz
  author_email: jcomp@hotmail.com
  author_url: ''
  date: !binary |-
    MjAwOC0wOC0yOCAxMzo0OTozNyArMDEwMA==
  date_gmt: !binary |-
    MjAwOC0wOC0yOCAxMjo0OTozNyArMDEwMA==
  content: ! '<p>Hi Rakesh,<&#47;p>


    <p>What version of perl and mysql did you use? Aso was it 64 or 32bit?<&#47;p>


    <p>Thanks<&#47;p>'
---
OK, mostly this is a check to see if I'm actually thinking correctly or not.  The default `perl` on Solaris 10 appears to be compiled with `-xarch=v8`.  The binary build of [MySQL](http:&#47;&#47;www.mysql.com) 5.0.12 from the web site is built with `-xarch=v9`.  The fact that both are built for different architectures means that you *cannot* actually build `DBI::mysql` on this platform since it needs to link to libraries from both packages which have incompatible architectures.

Is that correct?  It's certainly the case that simply doing:

    -bash-3.00# perl -MCPAN -eshell
    CPAN: File::HomeDir loaded ok

    cpan shell -- CPAN exploration and modules installation (v1.87)
    ReadLine support enabled

    cpan> install DBD::mysql

doesn't work, since it tries to build the Perl module with `-xarch=v8` (inheriting from the perl installation) and link with the `libmysqlclient.a` which is built with `-xarch=v9`.  It appears to configure and build OK, but all the tests fail with:

`install_driver(mysql) failed: Can't load '[...]&#47;blib&#47;arch&#47;auto&#47;DBD&#47;mysql&#47;mysql.so' for module DBD::mysql: ld.so.1: perl: fatal: relocation error: file [...]&#47;blib&#47;arch&#47;auto&#47;DBD&#47;mysql&#47;mysql.so: symbol mysql_real_escape_string: referenced symbol not found at &#47;usr&#47;perl5&#47;5.8.4&#47;lib&#47;sun4-solaris-64int&#47;DynaLoader.pm line 230.`

Bugger.  So much for being lazy and trying to use prebuilt binaries of stuff.