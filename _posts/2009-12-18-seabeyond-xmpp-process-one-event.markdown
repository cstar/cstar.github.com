---
layout: post
title: Seabeyond, XMPP Process One event
---
Yesterday was the day it snowed in Paris for the first time this season.

But it was not the only event. People gathered from ten countries to Paris to attend the <a href="http://www.process-one.net/seabeyond/">SeaBeyond</a> meetup.

And it was a good one.<div style="text-align:right;float:right;"><img src="http://cestari.files.wordpress.com/2009/12/capture-de28099ecc81cran-2009-12-18-acc80-18-31-40.png" alt="Capture d’écran 2009-12-18 à 18.31.40.png" border="0" width="78" height="164" /></div>

There's the <a href="http://www.process-one.net/en/blogs/article/sea_beyond_event_summary/">official point of view</a> just available.

But wait, here's mine ! 

<h1>mod_pubsub</h1>
Hacking occasionally on ejabberd, meeting the devs is always good. Christophe, mod_pubsub's maintainer hosted a great discussion on the subject. 

Among the subjects : 
Pubsub performance, the usual questions ... How fast is pubsub ? Should I use ODBC or mnesia ? Why two modules ?

<h2>How fast is Pubsub ?</h2>
As of ejabberd 2.1, many improvements are now implemented. But how fast depends on how you use pubsub. Many nodes, few subscribers ? Many subscribers ? What is the subscription rate ? How many items per node ?

the last_item_cache did a lot of good for performance especially if you have a high user churn.

<h2>ODBC or Mnesia ?</h2>

Vast question, but you've got many nodes and many many items, you're better off with ODBC.

<h2>Why two modules ?</h2>
There will never be a merge between ODBC and mnesia. ODBC has gone under many optimisations, limiting the number of queries (6 times less since 2.0). It's too bad we won't get storage backend abstraction ... maintaining my S3/SimpleDB version is still a bit of work, and pushing fancy nosql versions (riak ? redis backends ?), but it's for a better performance in each case.

<h2>There was more !</h2>
But I got sidetracked by an interesting discussion with <a href="http://www.erlang-consulting.com/">Erlang Solutions</a>'s Mietek Bąk on Haskell — apologies to the rest of the guys on the pubsub tables, as we got quite enthusiastic and noisy ... and put off our discussion until later.

Christophe told that as version 3 of ejabberd would implement exmpp, one should get ready to rewrite one's nodes and node_trees, but performance would get way better with exmpp.

<h1>Many people, many discussions</h1>
Discussed with one of the Nokia guys, told me about the difficulties of being Nokia when you try to innovate. You have to please 250 mobile operators all with different opinions.  Especially when you try to get around their old abusively expensive business as Nokia is trying with Ovi.
Also toyed a bit with the N900. Nice phone.

Talked with Sebastian Geib, freelance sysadmin from Berlin, about working in Berlin/Germany, compared to Paris/France.

Also learned about Meetic's chat architecture (overpowered) and how erlang is viewed by sysadmin (not favorably by default :).

<h1>And presentations</h1>
About the admin panel for ejabberd, Jingle, BBC use of <del datetime="2010-01-05T11:24:44+00:00">PEP</del>anon pubsub on ejabberd, Yoono and Process One's Wave Server.

<a href="http://www.bbc.co.uk/radio1/">BBC's use of  <del datetime="2010-01-05T11:24:44+00:00">PEP</del>anon pubsub can be seen here.</a>, in the topmost flash.

Had to leave early and missed the Champagne and the Wave Server demo. But this talk by Mickaël Rémond was quite interesting. Quote of day : "Google wants third party wave servers to be good but not too good."


<h1>Next year</h1>
I'll be back.

      
