---
layout: post
title: Timestamps that can behave like booleans
date: 2008-04-10 17:25:09 +01:00
categories:
- Geekery
- Ruby and Rails
tags:
- active_record
- booleans
- named_scope
- plugin
- rails
- ruby
---
I often come across this particular use case and it's probably easiest to
explain with an example. Take an ActiveRecord model called `Book` which
represents a book in Amazon's catalogue. In addition to books which are
already published, we collect information about books which are going to be
released at some point in the future. We store the publication date in the
field `published_at`.

More often than not, though, we don't really want to know *when* a book was
(or will be) published, we just want to know whether it has been published or
not.  So I wind up defining a couple of extra methods:

    class Book < ActiveRecord::Base
      def published?
        !published_at.blank?
      end

      def published=(value)
        # Note the automatic time zone conversion magic in edge rails!
        self.published_at = value ? Time.now : nil
      end
    end

All well and good, but I wind up doing that quite a few times across all the
projects I have. Time for an extraction! And what's good about this
extraction? Well, it expresses what I am actually trying to do without boring
you with the details of how I do it.  So how about:

    class Book < ActiveRecord::Base
      timestamped_boolean :published_at
    end

Now we get the two methods defined automatically. And, as I say, we have a
declarative way of saying what we're providing without having to have extra
documentation.

I've pulled this abstraction into a tiny wee plugin which is now up on GitHub.
It's called
[`timestamped_booleans`](http://github.com/rubaidh/timestamped_booleans). Feel
free to grab it, fork it, play around. I've got a couple of changes I should
do and push in the next few hours. The first you'll already have noticed if
you're reading carefully; what if the date it is `published_at` is in the
future? It's not published then, is it? So I'll need to modify the question
method to also check that the attribute's date is not in the future.

Next up after that is to automatically declare associated named scopes for
edge Rails because I also wind up doing the equivalent as class methods a lot:

    class Book < ActiveRecord::Base
      def self.find_published(*args)
        with_published do
          find(*args)
        end
      end

      private
      def with_published
        with_scope :find => :conditions => { ['published_at IS NOT ?'], nil} do
          yield
        end
      end
    end

which it wouldn't hurt to tidy up a bit.
