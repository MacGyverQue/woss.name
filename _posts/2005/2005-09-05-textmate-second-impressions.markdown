---
layout: post
status: publish
published: true
title: ! 'Textmate: Second Impressions'
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
wordpress_id: 53
wordpress_url: http://woss.name/?p=53
date: 2005-09-05 13:58:04.000000000 +01:00
categories:
- Geekery
- Work
tags: []
comments: []
---
Well, I finally got around to registering <a href="http:&#47;&#47;macromates.com&#47;">TextMate<&#47;a> (by conning my work into registering me a copy, no less!) so I'm sticking with it for the long term.  It has finally ousted <a href="http:&#47;&#47;www.xemacs.org&#47;">XEmacs<&#47;a> from my main toolset, and has even pushed <a href="http:&#47;&#47;vim.org&#47;" title="Vi IMproved!">vim<&#47;a> from being <code>$EDITOR<&#47;code> and <code>$VISUAL<&#47;code> on the command line!

It's taking time for my fingers to get the hang of new shortcuts -- they've been prefixing most commands with <code>C-x<&#47;code> or <code>C-c<&#47;code> for the best part of 10 years now, so I guess that's understandable.  I'm taking the tack of writing all the keyboard shortcuts I should be using on the whiteboard above my desk.

Folding is new to me.  OK, I think it does exist in XEmacs, but I never found it.  Being able to hide a pile of HTML in the current file that you're not currently working on so that it doesn't get in the way is really useful.  Particularly when it's a 30-odd KB ZPT you're trying to edit that basically contains 5 complete HTML pages.  Projects are really useful -- being able to have all the files in your project as a clickable list in a drawer is much quicker than having to flick through an open dialog every time you want to edit a new file.  Syntax highlighting Just Works&trade; for every file type I've thrown at it (since I grabbed the latest bundles from svn), though in the case of DTML files, that's just because I've told TextMate they're either SQL (in the case of zsql methods) or CSS (the only other dtml file in MailManager).

On the downside, the command line tool <code>tm<&#47;code> has gotten me into a spot of bother.  It's <em>way<&#47;em> too close to <code>rm<&#47;code>, which has resulted in, more than once, me deleting a file instead of opening it in TextMate!  Argh!  I've since aliased it to <code>textmate<&#47;code> in my shell and try to use that to launch instead.

I think I'd like to try my hand at implementing a bundle that supports CVS, in the same way as there's one for Subversion, Darcs and SVK already.  Despite not particularly liking it, I'm stuck with using CVS for some projects, at least for the medium term, so I'd like to have some of the same support as the folks that use these new fangled revision control systems.  It shouldn't be too hard to port the existing Subversion bundle across, I reckon.  Something for the weekend, perhaps.

All in all, a wonderful editor, and I think I'm going to be spending a lot of my time with it from now on.