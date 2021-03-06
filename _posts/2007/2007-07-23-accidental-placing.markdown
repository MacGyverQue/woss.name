---
layout: post
title: Accidental Placing
date: 2007-07-23 12:11:09 +01:00
categories:
- Geekery
- Ruby and Rails
tags:
- Geekery
- Ruby and Rails
---
It's weird when you're reading through your RSS feeds and come across your own name in a screenshot.  Apparently I'm one of the top ten contributors to Rails this month: [Working with Rails July Hackfest](http://www.workingwithrails.com/hackfest/13-monthly-july-2-7) (currently at no. 7).  Not quite sure how I managed that, it's just been pure coincidence that I've been hacking on edge with a new project lately. :-)  So, what do you reckon I could do to get [#8830](http://dev.rubyonrails.org/ticket/8830), [#8831](http://dev.rubyonrails.org/ticket/8831), [#8832](http://dev.rubyonrails.org/ticket/8832), [#9051](http://dev.rubyonrails.org/ticket/9051) or [#9056](http://dev.rubyonrails.org/ticket/9056) accepted before the end of the month?

In other news, I learned something interesting this morning.  I was doing something that boiled down to:

    irb(main):001:0> a = Array.new(3, [])
    => [[], [], []]
    irb(main):002:0> a[0] << 3
    => [3]
    irb(main):003:0> a
    => [[3], [3], [3]]

and wondering what on earth was going on!  Turns out that when creating a new array in this way, it creates each new item in the array using a reference to what was passed in, rather than duplicating it.  So all three items in the new array are in fact references to the same array passed in.  This is actually well documented in the Pickaxe, but I just assumed different behaviour and got confused.  What I actually wanted to do was:

    irb(main):004:0> a = Array.new(3) { [] }
    => [[], [], []]
    irb(main):005:0> a[0] << 3
    => [3]
    irb(main):006:0> a
    => [[3], [], []]

which got me the desired behaviour.  Of course, all this was deep inside some other code (implementing `Enumerable#unzip` to provide the reverse of `zip`) so it took me a good while this morning to track down what was going on.

**Update** Add [#9085](http://dev.rubyonrails.org/ticket/9085) and [#9097](http://dev.rubyonrails.org/ticket/9097) to that list. :-)
