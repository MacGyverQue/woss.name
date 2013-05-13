---
layout: post
status: publish
published: true
title: Using git submodules to track vendor&#47;rails
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
wordpress_id: 479
wordpress_url: http://woss.name/?p=479
date: 2008-04-11 11:57:40.000000000 +01:00
categories:
- Geekery
- Ruby and Rails
tags: []
comments:
- id: 997
  author: George Anderson
  author_email: george@benevolentcode.com
  author_url: ''
  date: !binary |-
    MjAwOC0wNC0xNSAyMDozODowNCArMDEwMA==
  date_gmt: !binary |-
    MjAwOC0wNC0xNSAxOTozODowNCArMDEwMA==
  content: ! '<p>Thanks for your "git" series of posts; they''re helpful.<&#47;p>


    <p>&#47;g<&#47;p>'
- id: 998
  author: Helder
  author_email: helder@gmail.com
  author_url: http://obvio171.wordpress.com
  date: !binary |-
    MjAwOC0wNS0xMCAyMzozNTo1NCArMDEwMA==
  date_gmt: !binary |-
    MjAwOC0wNS0xMCAyMjozNTo1NCArMDEwMA==
  content: ! '<p>Thanks for the post, it was really helpful! One question:<&#47;p>


    <p>I''m starting to use Vlad the Deployer with git, but AFAIK it makes a whole
    clone of the repository everytime you deploy. I can live with that if it''s cloning
    locally from my own repository, but it''d probably be bad if it also cloned entire
    submodule repositories every time. Do you know if that''s what happens? Or if
    vlad even works with git submodules at all?<&#47;p>


    <p>Thanks a lot!<&#47;p>


    <p>Cheers,<&#47;p>


    <p>Helder<&#47;p>'
- id: 999
  author: Cynthia Kiser
  author_email: cnk@caltech.edu
  author_url: ''
  date: !binary |-
    MjAwOC0wNy0wOSAwMToyMjoyMyArMDEwMA==
  date_gmt: !binary |-
    MjAwOC0wNy0wOSAwMDoyMjoyMyArMDEwMA==
  content: <p>Very useful post. Would you mind adding a section on how to quit using
    vendor&#47;rails at all (i.e. getting off edge and just using gems). Looks  like
    deleting your vendor&#47;rails directory and removing the references to that directory
    from your .git&#47;config and .gitmodules files then committing those changes
    does the trick.<&#47;p>
- id: 1000
  author: Steve Yen
  author_email: steve.yen@trimpath.com
  author_url: http://trimpath.com
  date: !binary |-
    MjAwOC0xMS0wNCAwMDowMTowMSArMDAwMA==
  date_gmt: !binary |-
    MjAwOC0xMS0wMyAyMzowMTowMSArMDAwMA==
  content: <p>Great post - just what I needed to know to submodule my plugins.<&#47;p>
---
In a previous post, [Using git submodules to track plugins](http:&#47;&#47;woss.name&#47;2008&#47;04&#47;09&#47;using-git-submodules-to-track-vendorrails&#47;)
I introduced the idea of using git submodules as part of your workflow in
developing Rails applications. At the time, Rails itself wasn't using git, but
that has finally happened. You can find the official Ruby on Rails source code
repository at <http:&#47;&#47;github.com&#47;rails&#47;rails>. So, how to we track Rails with
git submodules?

Let's start from our books application of the [previous post](http:&#47;&#47;woss.name&#47;2008&#47;04&#47;09&#47;using-git-submodules-to-track-vendorrails&#47;).
And we'll add in the submodule for Rails:

    mathie@tullibardine:books$ git submodule add git:&#47;&#47;github.com&#47;rails&#47;rails.git vendor&#47;rails
    Initialized empty Git repository in &#47;Users&#47;mathie&#47;tmp&#47;src&#47;books&#47;vendor&#47;rails&#47;.git&#47;
    remote: Generating pack...
    remote: Done counting 67937 objects.
    remote: Deltifying 67937 objects...
    remote:  100% (67937&#47;67937) done
    remote: Total 67937 (delta 52081), reused 67937 (delta 52081)
    Receiving objects: 100% (67937&#47;67937), 9.88 MiB | 20 KiB&#47;s, done.
    Resolving deltas: 100% (52081&#47;52081), done.

and let's see what that's done:

    mathie@tullibardine:books$ git stat
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #	modified:   .gitmodules
    #	new file:   vendor&#47;rails
    #
    mathie@tullibardine:books$ git diff --cached
    diff --git a&#47;.gitmodules b&#47;.gitmodules
    index 228959d..64ce630 100644
    --- a&#47;.gitmodules
    +++ b&#47;.gitmodules
    @@ -4,3 +4,6 @@
     [submodule "vendor&#47;plugins&#47;timestamped_booleans"]
            path = vendor&#47;plugins&#47;timestamped_booleans
            url = git:&#47;&#47;github.com&#47;rubaidh&#47;timestamped_booleans
    +[submodule "vendor&#47;rails"]
    +       path = vendor&#47;rails
    +       url = git:&#47;&#47;github.com&#47;rails&#47;rails.git
    diff --git a&#47;vendor&#47;rails b&#47;vendor&#47;rails
    new file mode 160000
    index 0000000..f46fd6f
    --- &#47;dev&#47;null
    +++ b&#47;vendor&#47;rails
    @@ -0,0 +1 @@
    +Subproject commit f46fd6f2fceb22f00669f066fc98f92a18e5875f

So we've successfully added in a new submodule for Rails, for the current
HEAD. Let's commit that and push it upstream:

    mathie@tullibardine:books$ git commit -m "Use git submodules to track HEAD of rails repository."
    Created commit 4bb82c9: Use git submodules to track HEAD of rails repository.
     2 files changed, 4 insertions(+), 0 deletions(-)
     create mode 160000 vendor&#47;rails
    mathie@tullibardine:books$ git push
    [ ... ]

That's all well and good, but we don't always want to track edge Rails.
Sometimes we want to track the stable branch or pin ourselves to a particular
version. Let's first of all pin to version 2.0.2:

    mathie@tullibardine:books$ cd vendor&#47;rails&#47;
    mathie@tullibardine:rails$ git tag
    [ ... ]
    v2.0.2
    [ ... ]
    mathie@tullibardine:rails$ git co v2.0.2
    Note: moving to "v2.0.2" which isn't a local branch
    [ ... ]
    HEAD is now at c8da518... Tagged Rails 2.0.2
    mathie@tullibardine:rails$ cd ..&#47;..
    mathie@tullibardine:books$ git status
    # On branch master
    # Changed but not updated:
    #   (use "git add <file>..." to update what will be committed)
    #
    #	modified:   vendor&#47;rails
    #
    no changes added to commit (use "git add" and&#47;or "git commit -a")
    mathie@tullibardine:books$ git add vendor&#47;rails
    mathie@tullibardine:books$ git commit -m "Pin ourselves to Rails v2.0.2."
    Created commit 5e66474: Pin ourselves to Rails v2.0.2.
     1 files changed, 1 insertions(+), 1 deletions(-)
    mathie@tullibardine:books$ git push
    [ ... ]

What we've done here is look at the Rails repository's list of tags to see
which one tags version 2.0.2. We find that it's called "v2.0.2" so we will
check out that particular tag. Since we're not making any changes, just
wanting to check out the tree at that particular state, we don't need to worry
that we're not on a branch. We then shift back up to our project root and do a
`git status`. This notes that we have made a change to `vendor&#47;rails` in that
we're tracking a different commit id. Do a `git diff` and you'll see what I
mean. We're happy to add that to the index, commit and push it upstream. Now
everybody we're sharing with is also pinning their clone to Rails 2.0.2.

How about we want to track the stable branch instead?  Just as easy:

    mathie@tullibardine:books$ cd vendor&#47;rails
    mathie@tullibardine:rails$ git co origin&#47;2-0-stable
    Note: moving to "origin&#47;2-0-stable" which isn't a local branch
    If you want to create a new branch from this checkout, you may do so
    (now or later) by using -b with the checkout command again. Example:
      git checkout -b <new_branch_name>
    HEAD is now at 2c96f50... Merge [9124] from trunk: Avoid remote_ip spoofing.

This time we're just checking out a copy of the remote branch
`origin&#47;2-0-stable`. The rest is exactly the same as before -- add the fact
that you're tracking a different commit to the index of your main project,
commit it and push. Every time you want to update to the latest version of the
2-0-stable branch (just like when you did `piston update`), you repeat this
process.