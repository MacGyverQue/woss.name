---
layout: post
status: publish
published: true
title: Memory mismanagement
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
wordpress_id: 330
wordpress_url: http://woss.name/2003/11/19/memory-mismanagement/
date: 2003-11-19 15:50:08.000000000 +00:00
categories:
- Geekery
tags:
- Geekery
comments: []
---
<p>Cocoa (and, I think, Objective-C in general) has a slightly unusual memory management architecture.  There's the equivalent of <code>new<&#47;code> and <code>delete<&#47;code> &acirc;&euro;&rdquo; <code>[<em>class<&#47;em> alloc]<&#47;code> and <code>[<em>object<&#47;em> release]<&#47;code> &acirc;&euro;&rdquo; with the notable difference that <code>alloc<&#47;code> doesn't call any constructor, so you'll most often see the idiom <code>[[<em>class<&#47;em> alloc] init]<&#47;code>.  Strictly speaking, <code>release<&#47;code> is part of a reference counting system.  <code>alloc<&#47;code> bumps the reference count to 1 and you can do <code>[<em>object<&#47;em> retain]<&#47;code> to increment it yourself.  <code>release<&#47;code> decrements the reference count and, when it reaches 0, frees the object.  Familiar territory so far, more or less.<&#47;p>

<p>In addition to <code>release<&#47;code>, there's <code>autorelease<&#47;code> which will release the object at some point in the future, but guarantees it will stick around for the current scope.  (Actually, it gets released properly if the reference count is still 0 when the next auto-release pool gets released, so objects can hang around for the entire life of the application, or in the case of an AppKit GUI, at least 'til the next time the run loop goes round.)  This in itself is not a problem and is quite useful in practice.  Think of a temporary object in a function.  Instead of just allocating it near the start of the function and having to remember to free it again at the end:<&#47;p>

<pre>void fn()
{
    Foo *a = [[Foo alloc] init];
    if([a bar]) {
        [a release];
        return;
    }
    &#47;* Do some other stuff *&#47;
    [a release];
    return;
}<&#47;pre>

<p>we can <code>autorelease<&#47;code> it at the top, know it's still valid through the function, but not have to worry about correctly deleting it before the referencing variable goes out of scope:<&#47;p>

<pre>void fn()
{
    Foo *a = [[[Foo alloc] init] autorelease];
    if([a bar]) {
        return;
    }
    &#47;* Do some other stuff *&#47;
    return;
}<&#47;pre>

<p>In addition to this, there is a common idiom in Apple's API where a class will provide particular functions which return temporary objects (ie objects which have already been autoreleased to save you the trouble).  For example, the following <code>[[[NSString alloc] initWithString:@"hello world"] autorelease]<&#47;code> is neatly packaged up into <code>[NSString stringWithString:@"hello world"]<&#47;code>. <&#47;p>

<p>The tricky part comes next:  who can tell me if the <code>NSArray<&#47;code> returned by <code>[aString componentsSeparatedByString:@":"]<&#47;code> (the moral equivalent of Perl's <code>split<&#47;code>) is a temporary object or not?  Not the documentation, that's for sure.  The malloc library complains about double-frees if I try to release it, so I'm guessing it is.  Perhaps I just missed the tech note documenting these nuances in detail...<&#47;p>

<p><strong>Update<&#47;strong>: I forgot to summarise:  I just spent the past hour picking through my code to figure out what I was doing wrong.  At least now I think I have a better understanding of the memory management system <em>and<&#47;em> the test suite stuff I was wittering about earlier has proved its worth.<&#47;p>