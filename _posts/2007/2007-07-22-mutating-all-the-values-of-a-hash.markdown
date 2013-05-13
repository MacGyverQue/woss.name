---
layout: post
status: publish
published: true
title: Mutating all the values of a hash
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
wordpress_id: 454
wordpress_url: http://woss.name/2007/07/22/mutating-all-the-values-of-a-hash/
date: 2007-07-22 14:49:14.000000000 +01:00
categories:
- Geekery
- Ruby and Rails
tags:
- Geekery
- Ruby and Rails
comments:
- id: 916
  author: josh
  author_email: josh@hasmanythrough.com
  author_url: http://blog.hasmanythrough.com
  date: !binary |-
    MjAwNy0wNy0yMiAxNjoxMzozMCArMDEwMA==
  date_gmt: !binary |-
    MjAwNy0wNy0yMiAxNToxMzozMCArMDEwMA==
  content: ! '<p>Ah yes, this old chestnut. Caught between wanting collect&#47;map
    to consistently return an Array, and wanting to do a hash map that returns a hash.  I
    usually just use inject, like so:<&#47;p>


    <p>new_hash = old_hash.inject({}) {|h,(k,v)| h[k] = mutate(v); h }<&#47;p>


    <p>But I''ve often wanted a map_hash method too.<&#47;p>'
---
It's not the first time I've found myself writing something akin to the following:

    BandPages = YAML::load(IO.read("#{RAILS_ROOT}&#47;test&#47;fixtures&#47;myspace_band_pages.yml"))
    BandDoms = Hash[*BandPages.map do |k, v|
      [
        k,
        Hpricot.parse(v)
      ]
    end.flatten]

OK, so what I'm actually doing in this case is loading a bunch of HTML pages I've cached as a YAML file (for testing) and parsing their HTML dom using [Hpricot](http:&#47;&#47;code.whytheluckystiff.net&#47;hpricot&#47;).  (Don't ask!)  But what I'm doing in the general case is:

    new_hash = Hash[*old_hash.map do |k, v|
      [
        k,
        mutate_value(v)
      ]
    end.flatten]

Wouldn't it be a lot clearer if I did something along the lines of:

    new_hash = old_hash.mutate_values do |v|
      mutate_value(v)
    end

instead?  So that it feels just like using map on an array?  Well, that's what I've done. :-)  You can pick up the extension in my [rubaidh_platform](http:&#47;&#47;svn.rubaidh.com&#47;plugins&#47;trunk&#47;rubaidh_platform) plugin along with another pile of random things.

Or did I miss something that already does this a little more elegantly?  I think it should be a core part of Ruby -- maybe that's even how map should behave on hashes?