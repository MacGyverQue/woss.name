title: Using git submodules to track vendor/rails
  content: ! '<p>Thanks for your "git" series of posts; they''re helpful.</p>
    <p>/g</p>'
  content: ! '<p>Thanks for the post, it was really helpful! One question:</p>
    vlad even works with git submodules at all?</p>
    <p>Thanks a lot!</p>
    <p>Cheers,</p>
    <p>Helder</p>'
    vendor/rails at all (i.e. getting off edge and just using gems). Looks  like deleting
    your vendor/rails directory and removing the references to that directory from
    your .git/config and .gitmodules files then committing those changes does the
    trick.</p>
  content: <p>Great post - just what I needed to know to submodule my plugins.</p>
In a previous post, [Using git submodules to track plugins](http://woss.name/2008/04/09/using-git-submodules-to-track-vendorrails/)
repository at <http://github.com/rails/rails>. So, how to we track Rails with
Let's start from our books application of the [previous post](http://woss.name/2008/04/09/using-git-submodules-to-track-vendorrails/).
    mathie@tullibardine:books$ git submodule add git://github.com/rails/rails.git vendor/rails
    Initialized empty Git repository in /Users/mathie/tmp/src/books/vendor/rails/.git/
    remote:  100% (67937/67937) done
    Receiving objects: 100% (67937/67937), 9.88 MiB | 20 KiB/s, done.
    Resolving deltas: 100% (52081/52081), done.
    #	new file:   vendor/rails
    diff --git a/.gitmodules b/.gitmodules
    --- a/.gitmodules
    +++ b/.gitmodules
     [submodule "vendor/plugins/timestamped_booleans"]
            path = vendor/plugins/timestamped_booleans
            url = git://github.com/rubaidh/timestamped_booleans
    +[submodule "vendor/rails"]
    +       path = vendor/rails
    +       url = git://github.com/rails/rails.git
    diff --git a/vendor/rails b/vendor/rails
    --- /dev/null
    +++ b/vendor/rails
     create mode 160000 vendor/rails
    mathie@tullibardine:books$ cd vendor/rails/
    mathie@tullibardine:rails$ cd ../..
    #	modified:   vendor/rails
    no changes added to commit (use "git add" and/or "git commit -a")
    mathie@tullibardine:books$ git add vendor/rails
`git status`. This notes that we have made a change to `vendor/rails` in that
    mathie@tullibardine:books$ cd vendor/rails
    mathie@tullibardine:rails$ git co origin/2-0-stable
    Note: moving to "origin/2-0-stable" which isn't a local branch
`origin/2-0-stable`. The rest is exactly the same as before -- add the fact