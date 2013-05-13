---
layout: post
status: publish
published: true
title: Duplicate suppression in procmail
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
wordpress_id: 329
wordpress_url: http://woss.name/2003/10/13/duplicate-suppression-in-procmail/
date: 2003-10-13 09:26:40.000000000 +01:00
categories:
- Geekery
tags:
- Geekery
comments: []
---
<p>I had previously discarded using duplicate suppression in procmail because a number of lists I was on at the time (notably the FreeBSD lists) are regularly cross-posted amongst.  Mail that was cross-posted to two or more lists I was subscribed to would wind up in one of the mailboxes, depending on which mail arrived first.  This was irritating because it made reading a thread more difficult.  Of course, this is only a problem because I filter each mailing lists into a separate mailbox.<&#47;p>

<p>Thinking about it this morning, I figured a possible solution.  From my <code>~&#47;.procmailrc<&#47;code>:<&#47;p>

<pre># Duplicate detection
:0Whc: $MAILDIR&#47;.msgid$LOCKEXT
| formail -D 16384 $MAILDIR&#47;msgid.cache

:0afw
| formail -A 'X-Duplicate: YES'<&#47;pre>

<p>This is near the top of my procmail configuration.  It uses formail to keep a cache of Message IDs and, if it detects a duplicate, inserts the header 'X-Duplicate: YES'.  Then my procmail configuration goes on to deal with mailing lists (incidentally, as much as possible using the (X-)?List-Id header).  Before the final delivery recipe which dumps stuff into various particular inboxes, I then have:<&#47;p>

<pre># Dump duplicates after mailing lists are dealt with
:0
* ^X-Duplicate: YES
.Junk.Duplicates&#47;<&#47;pre>

<p>which will put the duplicate into a separate mailbox.  Of course, this isn't going to detect many duplicates - only mail which is sent CC'd to several of my accounts or list mail which is CC'd to me <em>and the mail from the list itself arrives first<&#47;em>.  But it's better than nothing at all, I guess.<&#47;p>

<p>While I'm at it, here is another procmai recipe I threw together this morning:<&#47;p>

<pre>:0 Whf
| formail -z -R 'X-Original-To:' 'Original-To:'<&#47;pre>

<p>This takes the X-Original-To header (which Postfix appears to insert) and removes the X- prefix, which means that it will then match the ^TO_ shortcut expression you can use in your procmail script.<&#47;p>