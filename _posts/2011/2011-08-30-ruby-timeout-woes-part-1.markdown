---
layout: post
title: Ruby Timeout Woes, Part 1
excerpt: in which I discover that the behaviour of Ruby's built in timeout mechanism
  has changed slightly between Ruby 1.8.x and Ruby 1.9.
date: 2011-08-30 13:21:43 +01:00
categories:
- Geekery
- Ruby and Rails
tags:
- ruby
- ruby 1.8
- ruby 1.9
- timeout
- exceptions
---
I seem to be having a bad day with the built in `Timeout` class in Ruby. There are two problems; one is pretty innocuous, the other ... not so much.

When you're using `Timeout`, you'll typically wrap the block of code you're wanting to guard like this:

{% highlight ruby %}
require 'timeout'

begin
  Timeout.timeout(10) do
    # Block of code
  end
rescue Timeout::Error => e
  puts "Execution expired"
end
{% endhighlight %}

Your block of code will run for up to (approximately) 10 seconds and, if it hasn't completed in that time, will raise the `Timeout::Error` exception. Pretty straightforward.

The innocuous issue is just one trying to make me mistrust my memory. In Ruby 1.8.x, `Timeout::Error` inherits from `Interrupt`, so it's inheritance from `Exception` goes along the lines of:

{% highlight ruby %}
Timeout::Error < Interrupt < SignalException < Exception
{% endhighlight %}

The key thing to note here is that it *doesn't* inherit directly from `StandardError` and so a blank rescue block won't catch it:

{% highlight ruby %}
begin
  Timeout.timeout(10) { sleep 20 }
rescue
  puts "On Ruby 1.8.x I won't catch the timeout exception."
end
{% endhighlight %}

However, on Ruby 1.9.2, `Timeout::Error` inherits from `RuntimeError`, so in the above code example, the rescue block *will* get called. That's annoying, but it's not like it's the only incompatible change between Ruby 1.8.x and Ruby 1.9, so I'm OK with that. Plus, non-specific `rescue` blocks like that are a bad smell anyway.

The slightly more insidious problem needs further explanation. Come back again later on and I'll tell you all about it.
