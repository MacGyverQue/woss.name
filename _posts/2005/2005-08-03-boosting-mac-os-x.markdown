---
layout: post
status: publish
published: true
title: Boosting Mac OS X
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
excerpt: ! 'I''ve been mucking around with <a href="http:&#47;&#47;www.boost.org&#47;"
  title="Boost C++ Library">Boost<&#47;a> over the past couple of evenings to see
  if I can get it setup on my laptop and get back into a bit of C++ development.  I''ve
  succeeded, but it wasn''t as simple as I''d thought.  Well, I suppose it could have
  been, but I also decided to figure out <a href="http:&#47;&#47;www.boost.org&#47;tools&#47;build&#47;v2&#47;index.html"
  title="Boost Build System v2">Boost.Build<&#47;a>.  BTW, a prerequisite for all
  the following is that the Apple <a href="http:&#47;&#47;developer.apple.com&#47;"
  title="Apple Developer Tools">Developer Tools<&#47;a> installed.


'
wordpress_id: 22
wordpress_url: http://woss.name/?p=22
date: 2005-08-03 20:30:50.000000000 +01:00
categories:
- Geekery
tags: []
comments:
- id: 14
  author: Lally
  author_email: lally@vt.edu
  author_url: ''
  date: !binary |-
    MjAwNS0wOC0yMCAxMzozMToxNSArMDEwMA==
  date_gmt: !binary |-
    MjAwNS0wOC0yMCAxMjozMToxNSArMDEwMA==
  content: Gotta warn you, Qt's pretty assesque on OS X, even Qt 4.  They draw it
    all themselves using their own drawing code, and the difference is pretty obvious.  After
    using it for a while, I'm going Objective-C++.
- id: 15
  author: Jason K.
  author_email: jkankiewicz@advpubtech.com
  author_url: ''
  date: !binary |-
    MjAwNS0xMC0wNCAxODoxODo1NiArMDEwMA==
  date_gmt: !binary |-
    MjAwNS0xMC0wNCAxNzoxODo1NiArMDEwMA==
  content: Why not use wxWidgets instead? It's cross-platform like QT but uses the
    native GUI toolkit to render its controls so you'll get the native look and feel
    in your GUI.
---
I've been mucking around with <a href="http:&#47;&#47;www.boost.org&#47;" title="Boost C++ Library">Boost<&#47;a> over the past couple of evenings to see if I can get it setup on my laptop and get back into a bit of C++ development.  I've succeeded, but it wasn't as simple as I'd thought.  Well, I suppose it could have been, but I also decided to figure out <a href="http:&#47;&#47;www.boost.org&#47;tools&#47;build&#47;v2&#47;index.html" title="Boost Build System v2">Boost.Build<&#47;a>.  BTW, a prerequisite for all the following is that the Apple <a href="http:&#47;&#47;developer.apple.com&#47;" title="Apple Developer Tools">Developer Tools<&#47;a> installed.

<a id="more"></a><a id="more-22"></a>

Part of the trouble is that the released version of Boost doesn't support Mac OS X 10.4 out the box.  The new version of gcc it ships with (4.0) no longer has the <code>-fcoalesce-templates<&#47;code> flag, which the Boost build system automatically passes in.  It wasn't <em>that<&#47;em> difficult to figure out how to modify the Darwin toolset to fiddle the flags, but I decided to grab the CVS version anyway:

[code]mathie@Tandoori:tmp$ cvs -d :pserver:anonymous@cvs.sourceforge.net:&#47;cvsroot&#47;boost login
Logging in to :pserver:anonymous@cvs.sourceforge.net:2401&#47;cvsroot&#47;boost
CVS password:
mathie@Tandoori:tmp$ cvs -z3 -Q -d :pserver:anonymous@cvs.sourceforge.net:&#47;cvsroot&#47;boost co boost
mathie@Tandoori:tmp$ export BOOST_ROOT=`pwd`&#47;boost
mathie@Tandoori:tmp$ export BOOST_BUILD_PATH=${BOOST_ROOT}&#47;tools&#47;build&#47;v2[&#47;code]

which builds nice and cleanly.  (Setting <code>$BOOST_ROOT<&#47;code> is just handy at this point so I can give you 'working' commands next up.  It's needed later anyway, as is <code>$BOOST_BUILD_PATH<&#47;code>.)  Next up is to build the Boost version of jam and stick it in <code>&#47;usr&#47;local&#47;bin<&#47;code>:

[code]mathie@Tandoori:tmp$ cd ${BOOST_ROOT}&#47;tools&#47;build&#47;jam_src&#47;
mathie@Tandoori:jam_src$ .&#47;build.sh
[ ... build output ... ]
mathie@Tandoori:jam_src$ sudo cp bin.macosxppc&#47;bjam &#47;usr&#47;local&#47;bin&#47;bjam[&#47;code]

Now we have the basic build tools required and it's time to build Boost itself.  This is where what I've done diverges from the instructions I'm about to write.  I've got my own installation of Python 2.4, where the default Python on Mac OS X 10.3 and 10.4 is 2.3.x.  So, if you see a mention of 2.4, it's a typo. :-)  So, do the following (which, on my Powerbook 1.67GHz running on batteries, took about an hour or so):

[code]mathie@Tandoori:jam_src$ cd $BOOST_ROOT
mathie@Tandoori:boost$ PYTHON_VERSION=2.3 bjam -sTOOLS=darwin \
  --with-python-root=&#47;System&#47;Library&#47;Frameworks&#47;Python.framework&#47;Versions&#47;Current&#47; \
  stage
Building Boost.Regex with the optional Unicode&#47;ICU support disabled.
Please refer to the Boost.Regex documentation for more information
(and if you don't know what ICU is then you probably don't need it).
...patience...
[ ... more build output ... ][&#47;code]

Unless ICU is an Intensive Care Unit, I'm not too worried about it, so I ignored that warning.  This will have the built libraries sitting in <code>${BOOST_ROOT}&#47;stage&#47;lib<&#47;code>, and that's where they'll stay for now.  Now, before we try building our own projects, there are a couple of bits of configuration needed.  First up is to edit <code>${BOOST_BUILD_PATH}&#47;user-config.jam<&#47;code> and add the following to somewhere near the top:

[code]using darwin ;[&#47;code]

I've created an extra file for Boost.build v2 so that using Boost is easier.  I'm not a Jam expert, so it's probably very wrong, but it does <em>appear<&#47;em> to work.  Take <a href="&#47;dist&#47;boost.jam" title="Using Boost.build for applications with Boost">boost.jam<&#47;a> and place it in <code>${BOOST_BUILD_PATH}&#47;tools&#47;boost.jam<&#47;code>.  Now let's create ourselves a very quick project to demo it works.  Create a directory to put the project in, change to that directory and create an empty file to tell Jam this is the project root:

[code]mathie@Tandoori:tmp$ mkdir boostdemo
mathie@Tandoori:tmp$ cd boostdemo
mathie@Tandoori:boostdemo$ touch project-root.jam[&#47;code]

Now create a very simple C++ program, <code>boostdemo.cc<&#47;code>, using the Boost unit test library (just to show that we can successfully link to shared libraries too!):

[code lang="cpp"]#include <boost&#47;test&#47;unit_test.hpp>

using boost::unit_test::test_suite;

void free_test_function()
{
  BOOST_CHECK(2 == 1);
}

test_suite*
init_unit_test_suite(int, char *[])
{
  test_suite *test = BOOST_TEST_SUITE("Unit test example 1");

  test->add(BOOST_TEST_CASE(&free_test_function), 1);
  return test;
}[&#47;code]

And create a file called <code>Jamfile<&#47;code> containing the following:

[code]using boost ;
exe boostdemo : boostdemo.cc &#47;boost&#47;&#47;unit_test_framework ;[&#47;code]

I should warn you that spaces are quite significant in Jam files.  For instance, the ':' and ';' must be surrounded by whitespace, or you'll get odd errors about something being 'gristed'...  But, if you've followed these instructions carefully, and with a spot of luck, you should be able to build and run the demo:

[code]mathie@Tandoori:boostdemo$ bjam
...patience...
...found 300 targets...
...updating 5 targets...
MkDir1 bin
MkDir1 bin&#47;darwin
MkDir1 bin&#47;darwin&#47;debug
darwin.compile.c++ bin&#47;darwin&#47;debug&#47;boostdemo.o
darwin.link bin&#47;darwin&#47;debug&#47;boostdemo
...updated 5 targets...
mathie@Tandoori:boostdemo$ bin&#47;darwin&#47;debug&#47;boostdemo
Running 1 test case...
boostdemo.cc(8): error in "free_test_function": check 2 == 1 failed

*** No errors detected[&#47;code]

I have no idea how accurate these instructions are, nor how they'll cope with building production applications for distribution, but so far they're working for me, and it's been an interesting learning experience figuring out how Jam works.  I think I'd like to persevere with it.

Next up?  Figuring out how to build <a href="http:&#47;&#47;www.trolltech.com&#47;products&#47;qt&#47;index.html" title="Trolltech's Qt 4">Qt<&#47;a> version 4, which, I'm hoping will provide me with a decent C++ GUI framework...