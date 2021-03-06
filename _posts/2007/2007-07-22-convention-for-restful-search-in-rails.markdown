---
layout: post
title: Convention for RESTful search in Rails?
date: 2007-07-22 18:12:22 +01:00
categories:
- Geekery
- Ruby and Rails
- RailsConf Europe
tags:
- Geekery
- RailsConf Europe
- Ruby and Rails
---
Back in RailsConf Europe last year, at [David's Keynote](http://woss.name/2006/09/30/railsconf-europe-2006-first-plenary-dhh/), it was said that:

> There are unresolved decisions with respect to the restful controllers. In particular, what should the convention be for searching? A separate action? Or parameters passed to the index action?

I don't suppose a convention has been adopted for this yet?  I'm just about to implement search in an application I'm working on and I'd rather go with the 2.0 convention now, rather than fight against it with my wrong decision later. :-)

**Update** Judging by the implementation of `ActiveResource#find` it's parameters passed to index, isn't it?

**Update 2** OK, so what's the elegant, reusable implementation for `FooController#index`, turning `params` into `find(:all, :conditions => ...)`?

**Update 3** I've started codifying what I'm doing into a plugin: [resource_search](http://svn.rubaidh.com/plugins/trunk/resource_search). It's still in its infancy.
