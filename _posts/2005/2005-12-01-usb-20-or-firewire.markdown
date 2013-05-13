---
layout: post
status: publish
published: true
title: USB 2.0 or Firewire?
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
wordpress_id: 200
wordpress_url: http://woss.name/?p=200
date: 2005-12-01 23:54:12.000000000 +00:00
categories:
- Geekery
tags: []
comments: []
---
OK, this is a totally unscientific test, but I decided to see whether I was better using the USB 2.0 interface between my PowerBook laptop and an external hard disc, or the Firewire interface.  For the purposes of the test, I was using <a href="http:&#47;&#47;www.seagate.com&#47;products&#47;retail&#47;external&#47;usbfirewire">300GB Seagate<&#47;a> external drive I borrowed from work (for doing a backup of my laptop!) and my <a href="http:&#47;&#47;www.apple.com&#47;support&#47;powerbook&#47;">Apple PowerBook G4<&#47;a>.  In each case, the devices were the only things on that bus, with a cable direct from one to the other.  I used <a href="http:&#47;&#47;sourceforge.net&#47;projects&#47;bonnie&#47;">Bonnie++<&#47;a> to perform the tests.

So, the results for USB 2.0:

[code]Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K&#47;sec %CP K&#47;sec %CP K&#47;sec %CP K&#47;sec %CP K&#47;sec %CP  &#47;sec %CP
Tandoori.local 300M 17787  90 18301  11 18297   8 21720  96 454209 95  2108   5
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP
                 16  3014  49 +++++ +++  2994  46   227   8 +++++ +++   112   5[&#47;code]

and the results for Firewire:

[code]Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K&#47;sec %CP K&#47;sec %CP K&#47;sec %CP K&#47;sec %CP K&#47;sec %CP  &#47;sec %CP
Tandoori.local 300M 16843  87 33608  19 33613  15 21676  96 439173 91  3094   8
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP
                 16  4409  70 +++++ +++  4629  70   269   8 +++++ +++   127   5[&#47;code]

So, what does that mean?  Broadly, Firewire is faster, particularly for block reads and file create&#47;read&#47;delete operations.  I find this slightly surprising, because for some bizarre reason USB 2.0 <em>feels<&#47;em> faster.  But that's probably some weird perception thing that will change now that I've seen hard data. :-)

Just for comparison, these are the results for the laptop's internal hard disc:

[code]Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K&#47;sec %CP K&#47;sec %CP K&#47;sec %CP K&#47;sec %CP K&#47;sec %CP  &#47;sec %CP
Tandoori.local 300M 18459  95 32805  18 32294  15 21102  95 439976 90  2174   5
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP  &#47;sec %CP
                 16  3289  68 +++++ +++  3796  58   169   5 +++++ +++    84   3[&#47;code]

So using the external hard disc with firewire is even faster than the internal disc, particularly for seeking operations (which you'd expect, since the internal disc has a slower rotational speed -- 4200rpm rather than 7200rpm).