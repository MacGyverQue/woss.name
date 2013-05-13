---
layout: post
status: publish
published: true
title: Digital Photography Workflow
author: Graeme Mathieson
author_login: mathie
author_email: mathie@woss.name
author_url: http://woss.name/
wordpress_id: 70
wordpress_url: http://woss.name/?p=70
date: 2005-08-19 22:50:08.000000000 +01:00
categories:
- Geekery
- Photography
tags: []
comments:
- id: 56
  author: Breton
  author_email: bretonh@gmail.com
  author_url: http://bretonh.com
  date: !binary |-
    MjAwNS0xMC0wNSAwNDo0Nzo1NiArMDEwMA==
  date_gmt: !binary |-
    MjAwNS0xMC0wNSAwMzo0Nzo1NiArMDEwMA==
  content: ! 'Hi,


    This sounds great...and I use a very similar process on my PC. However, my girlfriend
    got a mac a few days ago and we have tried to do the same method. It works fine...the
    only annoyance is that iphoto opens up every time we attach her Canon Digital
    Rebel. Is there any way to have the image capture utility be the default and shut
    iphoto''s detection off?


    Best,

    Breton'
- id: 57
  author: Janie Jenkins
  author_email: jjbellava@yahoo.com
  author_url: http://www.simonandbaker.com/wp/2006/12/18/digital-photography-book-chock-full-of-useful-tips-and-tricks/
  date: !binary |-
    MjAwNy0wMi0xMyAxMzo1NTozMSArMDAwMA==
  date_gmt: !binary |-
    MjAwNy0wMi0xMyAxMjo1NTozMSArMDAwMA==
  content: ! '<p>Great step by step instructions.  Thanks!<&#47;p>


    <p>Janie<&#47;p>'
---
Once upon a time, I had a Sony DSC-S75 digital camera.  I'd snap some pictures, grab them off the memory stick and upload them to <a href="http:&#47;&#47;www.mathie.org.uk&#47;graeme&#47;gallery&#47;">my gallery<&#47;a>.  Life was simple.  Then one day I became a Mac weenie, and so I started using <a href="http:&#47;&#47;www.apple.com&#47;ilife&#47;iphoto&#47;">iPhoto<&#47;a>.  That was even easier -- I'd use iPhoto to import photos from the camera, add titles and comments, then use <a href="http:&#47;&#47;zwily.com&#47;iphoto&#47;">iPhotoToGallery<&#47;a> to push them up to my gallery.

But gradually, I became dissatisfied with the ability to attach meta data to images.  It's awkward to add keywords in iPhoto (something which <a href="http:&#47;&#47;homepage.mac.com&#47;kenferry&#47;software.html">Keyword Assistant<&#47;a> mitigates somewhat) and there's insufficient access to meta data to append the kind of information I would like to apply to my images in a structured format.  Add to that the fact that I've started to take my photography a little more 'seriously'.  I've got a <a href="http:&#47;&#47;woss.name&#47;2005&#47;08&#47;13&#47;my-photography-kit&#47;">shiny new camera<&#47;a> and now I shoot in RAW format.  Unfortunately, iPhoto doesn't support the new Canon RAW (<code>.CR2<&#47;code>) format.  And I'm unimpressed with iPhoto's support for RAW images anyway.

So, what to do?  Well, currently I'm using Mac OS X 10.4, and <a href="http:&#47;&#47;www.adobe.com&#47;products&#47;photoshop&#47;main.html">Adobe Photoshop CS2<&#47;a>.  The workflow works something along the lines of:

<ol>
  <li>Take some photographs.  This is probably quite an important stage. :-)<&#47;li>
  <li>Import all the  photos into the <code>Photography&#47;Inbox&#47;Canon Raw<&#47;code> directory using <a href="http:&#47;&#47;www.apple.com&#47;macosx&#47;features&#47;imagecapture&#47;">Image Capture<&#47;a> (which is bundled with Mac OS X).<&#47;li>
  <li>Convert the images to <acronym title="Digital Negative">DNG<&#47;acronym> format (an open RAW format which retains all the original photographic data and allows attaching of metadata, instead of the proprietary formats used by individual camera manufacturers) using Adobe's <a href="http:&#47;&#47;www.adobe.com&#47;products&#47;dng&#47;main.html">DNG Converter<&#47;a>.<&#47;li>
  <li>Use <a href="http:&#47;&#47;www.adobe.com&#47;products&#47;creativesuite&#47;bridge.html">Adobe Bridge<&#47;a> to apply basic meta data to all the images.  Basically I'm applying regular <a href="http:&#47;&#47;www.iptc.org&#47;pages&#47;index.php">IPTC<&#47;a> ownership information (copyright, my personal details), details of the location the photograph was taken, and a broad description.  This is a case of applying a standard meta data template.<&#47;li>
  <li>Once that's done, <em>all<&#47;em> of the images get burned to CD.  Well, actually, they get dumped in a different folder and, once I've got enough of them, I push it onto a DVD.  I do this by creating a 'burn folder', pushing all the images into there and hitting 'burn'.  Dead easy.<&#47;li>
  <li>Now that I've got the original images safely stored away, I can start editing.  First thing to do is delete all the obviously poor photos.  I tend to shoot on drive mode, so I will probably have at least 3-5 photographs of every composition.  This is the point to choose the best of those images, and to remove blurred or otherwise unrescueable images.<&#47;li>
<&#47;ol>

... and that's the point I've got to  so far.  Next up is to tweak the photographs in Photoshop, save as a PSD file, export a low-res version for the web, upload them to the gallery and upload the finished hi-res images to CD.  But seeing exactly what that will involve requires a little more playing.  One thing I do know is that whatever modification can be done should be done with the RAW image, before importing into Photoshop.  I've already customised the <a href="http:&#47;&#47;">Camera RAW<&#47;a> importer to fix up the white balance nicely, not to twiddle with the sharpness (which it tries to apply by default, but I'd rather do that later in Photoshop with Unsharp Mask).  And I've been playing with the lens correction filter in Photoshop to correct unwanted 'fish-eye' effects on images with a short focal length.  But I need to put it all together learn the other necessary techniques.

I'd like to automate more of what is happening.  It's something I'm unfamiliar with on Mac OS X.  If it were a set of command line applications, I'd be right at home -- move from camera to folder; convert to DNG; apply a meta data template; archive -- that sounds very easy to bung together in a shell script.  But it's a bit more awkward for me to figure out <a href="http:&#47;&#47;www.apple.com&#47;macosx&#47;features&#47;automator&#47;">Automator<&#47;a> (or AppleScript?  Or whatever the scripting system for Adobe products is?) to do the same task.

And I need to actually develop the skill to take good photographs, and to tweak them well in Photoshop. :-)