---
layout: post
title: Zope Page Template weirdness
date: 2005-10-14 15:20:59 +01:00
categories:
- Geekery
- Python
- Work
---
So we were having a 'discussion' on the work mailing list about a change I'd made to the UI code for [MailManager](http://www.logicalware.com/).  Given the following page template:

{% highlight xml %}
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
                      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en" i18n:attributes="lang language; xml:lang language"
  xmlns:tal="http://xml.zope.org/namespaces/tal"
  xmlns:metal="http://xml.zope.org/namespaces/metal"
  xmlns:i18n="http://xml.zope.org/namespaces/i18n">
  <head>
    <title tal:content="template/title">The title</title>
  </head>
  <body>
    <p>
      <option tal:attributes="selected python:1==1">xxx</option>
      <option tal:attributes="selected python:1==0">yyy</option>
    </p>
  </body>
</html>
{% endhighlight %}

both Andy and Kev asserted that it would render to:

{% highlight xml %}
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
                      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en"
      xml:lang="en">
  <head>
    <title></title>
  </head>
  <body>
    <p>
      <option selected="selected">xxx</option>

      <option>yyy</option>
    </p>
  </body>
</html>
{% endhighlight %}

while I was asserting that it rendered to:

{% highlight xml %}
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
                      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en"
      xml:lang="en">
  <head>
    <title></title>
  </head>
  <body>
    <p>
      <option selected="True">xxx</option>
      <option selected="False">yyy</option>

    </p>
  </body>
</html>
{% endhighlight %}

(note the difference in the rendering of the 'selected' attribute of the <code>&lt;option&gt;</code> tag.)

I had distilled mine down from the MailManager code, as a test instance, whereas both Kev &amp; Andy had created a fresh template in the ZMI.  And both of us appeared to be right.  We wondered if it was a difference in platform -- I'm working on my laptop, with python 2.4 &amp; Zope 2.7.7.  But no.  The difference is that I'm rendering the files as content-type text/xml (which Zope kindly defaults to if it encounters a file starting <code>&lt;?xml ...</code> whereas they were forcing the content-type to text/html (the default if you create a template through the ZMI).  If you force the content-type to text/xml in the ZMI you'll see the same results as I get.

So it turns out that exactly the same Zope Page Templates will render slightly differently, depending on whether or not they are marked as being HTML or XML.  Cool.

(I can understand why they are pulled apart by different parsers, since it's so much nicer to use a proper XML parser if you're expecting valid XML -- and leave the grotty excuses for HTML that one sometimes finds to another lame, hacky thing -- but to not mangle them into the same AST and use a unified generator at the other end?)

When I've got more time, I should go file bugs.  But I've got an alpha of MailManager 2.1 to release this afternoon, so I'd better get on with that or there'll be no getting to go to the pub for me!
