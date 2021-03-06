---
layout: post
title: Problems with Getting Things Done
date: 2005-10-09 10:45:52 +01:00
categories:
- Geekery
- Personal
- Work
---
OK, I've been trying to implement the currently popular [Getting Things Done](http://www.davidco.com/) methodology, with the aid of [Kinkless GTD](http://http://kinkless.com/articles/2005/10/06/kinkless-gtd-0-63-fancy-pants) for [OmniOutliner](http://www.omnigroup.com/applications/omnioutliner/).  For the most part, it seems to be working pretty well; I have a list of all the stuff that needs doing for all the major projects in my life just now (wedding, selling/renting the flat in Easter Road, doing stuff with this blog, [MailManager](http://www.logicalware.com/) 2.1 UI redesign, [MailManager](http://www.logicalware.com/) outstanding bugs in head, building a photography portfolio, learning photography, learning [Rails](http://www.rubyonrails.org/), consultancy work for Oxfam International, and other miscellaneous stuff -- clearly I don't have every project entered into the system yet, but it's a good start) and I have a todo list of actionable things to move each project forward.

And it has helped me balance how I'm pushing stuff forward a little better -- dealing with the flat on Easter Road had been lurking at the back of my psyche because I just don't want to deal with it, but a couple of phone calls on Friday afternoon and things are moving on once again.  I also got around to nuking a couple of [MailManager](http://www.logicalware.com/) bugs -- since the UI redesign is lagging from the original project plan, I've been concentrating on it exclusively, but this has reminded me that a bit of balance is in order (after all, these bugs do need fixed sometime, and they were hindering the 2.0.1 release).

But there are a couple of things bugging me.  The major one is that I can't really show dependencies effectively.  Unfortunately, I don't have the book to hand (it's currently doing the rounds in the office), but I suspect this is a problem with the GTD system in general, rather than with the Kinkless implementation.  I don't recall any particular methodology for dealing with dependencies.  See, the whole, overarching, point of GTD is that you have a <em>mind like water</em> -- that you get everything out of your head so that you can concentrate on your 'next actions'.  So obviously it makes sense to write down all the tasks you can think of associated with a particular project.  And to me, it makes sense to write them out on a todo list.

The trouble is that you wind up with a bunch of stuff on your todo list that aren't actually currently actionable.  As a concrete example, under the 'wedding' project, I have a few dependent todos:

<ul>
  <li>Create maps and hotel suggestions for invites (<em>@mac online</em>)</li>
  <li>Create the invitation inserts (<em>@mac design</em>)</li>
  <li>Construct the invitations (<em>@home</em>)</li>
  <li>Send out all the invitations (<em>@errands</em>)</li>
</ul>

(The <em>@foo</em> is the context in which these tasks can be done.)  However, while the first three can effectively be done in parallel, or in any random order, the last item is dependent upon the first three being completed.  Unfortunately, this doesn't quite map to how the KGTD system displays stuff: I wind up with the first item listed as my 'next action' (actually, I don't, there's something else further up the todo list that is my next action), and the final item is still listed in my @errands context list.  Any of the first three could happily be listed as next actions.  And there's no point in the last being on my horizon until the rest are done.  I discovered this yesterday when, just before heading out to the shops, I printed my @errands list so I would have a note of all the errands I ought to run while I was out.

Maybe I'm thinking about things in the wrong way.  After all, there's only one of me, so there's only one thing I can be doing next for each project.  Maybe what I need to do is split the 'Wedding' project into a number of sub projects (Wedding: sort out invitations, Wedding: finalise meal with Saltire, etc) so that there is a single 'next action' associated with each project.  But that's going to turn the wedding project into (currently) 12 projects which seems a bit much...  However, that way, I really can just look at the 'next actions' list and ignore everything else.

Or maybe I should be able to select multiple 'next actions' for a project, which are all the currently actionable items on the list.  Again, that way I can just pick from the 'next actions' list for what to do next, and it stops the projects list from getting unmanageably large.

Or maybe I should store all my unactionable items in the @waitingfor context.  But that's abusing that context, since it should be stuff that I'm waiting for action from other people, not for action on another item by myself.  In which case, a @dependency context could be added to store all the items that can't currently be done.  However, that loses the ability to record the actual context in which an item can be done, when I'm writing it down.  So I have to remember something about that item.  Which defeats the <em>mind like water</em> principle.

I think, in writing this, I've actually clarified the problem enough to answer my own question.  (So why am I posting this at all?  To help anybody else who might have a similar warped thought process to mine!)  A project is not a <em>project</em> in the traditional sense.  It's simply a list of actions (in order) required to complete a multi-step goal.  So the project in the example above is <em>not</em> 'Wedding'.  That particular, defined, project is 'create and send out invitations'.  OK, so I could be doing any of the first three steps in any order, but I need to do all three of them, and I can only do one at a time.  So it makes sense for just one of them to be listed as a 'next action'.  And I should only look at my next actions for what needs to be done next.

In which case, I think what I'd like from the KGTD scripts is the ability to create umbrella <em>superprojects</em>, which are merely used to group sub-projects so that the project list looks 'right'.  Everything that's listed at the top level of a superproject is either a single-step task (in which case, it's actionable and goes somewhere on the next action list) or is a multi-step project (in which case, the first incomplete item on that project is the next action).

Of course, that's going to mean having a potentially <em>huge</em> next action list since there's always a dozen things I can be doing.  However, further drilling that down by context should, I think, make it manageable.

Does this make <em>any</em> sense? :-)
