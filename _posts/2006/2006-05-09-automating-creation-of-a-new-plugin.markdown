---
layout: post
title: Automating creation of a new plugin
date: 2006-05-09 12:15:57 +01:00
categories:
- Geekery
- Work
---
Recently I've been finding that I want to create a few plugins to share functionality across rails applications.  Simple things, like form builders using my 'house style', but once I've written it out in two applications and it comes to a third, it's time to factor things out into a plugin.

However, running `script/generate plugin foo` just dumps the plugin in my current application, whereas I keep a separate repository of plugins to share amongst all my applications.  For the second time today, I went about generating the new plugin then importing it into the repository and adding an `svn:externals` line to the application.  So I automated it.  Now we have: [rails_new_plugin.sh](/dist/rails_new_plugin.sh)  It will need customised for anybody else's use -- to educate it about your shared plugin repository location and layout -- but it works nicely for me and I thought I might share it.

Let me know if you have any suggestions for improvements/changes.
