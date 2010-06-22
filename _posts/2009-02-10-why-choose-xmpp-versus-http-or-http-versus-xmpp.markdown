---
layout: post
title: Why choose (XMPP versus HTTP or HTTP versus XMPP) ?
---
<h1>Morning reading</h1>

<p>With the aftermath of the XMPP Summit, I&#8217;ve seen a <a href="http://www.olympum.com/future/will-xmpp-be-the-messaging-middleware-for-the-rest-web/">few</a> <a href="http://ubikod.com/otmf/2009/02/10/pourquoi-xmpp-nest-pas-le-futur-http/">posts</a> about XMPP as a potential replacement for HTTP.</p>

<h1>HTTP</h1>

<p>I love HTTP. That protocol has so many great features, I wouldn&#8217;t know where to start. </p>

<p>And it&#8217;s only a couple of years that the world (and me) really understood what this HTTP thing was really about. (Before that, it was only inside the brain of <a href="http://www.ics.uci.edu/~fielding/">Roy Fielding</a> and a few others) &#8211; I thank DHH for raising awareness and Richardsson and Ruby for writing <a href="http://oreilly.com/catalog/9780596529260/">that great O&#8217;Reilly book</a>.</p>

<p>The bits and pieces one describes as REST (the VERBS, mime-types, caching strategies) build a very clever and stable architecture.</p>

<p>Yet it&#8217;s polling based and every 30 minutes my feed reader polls a load of feed, most of them returning 304 Not Modified.</p>

<h1>XMPP</h1>

<p>XMPP is a decade old, it&#8217;s only becoming <em>very</em> popular recently. But it still has that &#8220;new frontier&#8221; smell I like. Still a lot of work to do. And I hope I can be part of that. </p>

<p>It&#8217;s a place where a lot of work has been done, but that protocol is still working to expand itself beyond instant messaging.</p>

<p>Enters PubSub. The solution to polling endlessly Atom feeds. Machines sending events to machines in a distributed, decentralized way. Bandwidth saved.</p>

<p>Yet XMPP has limits :</p>

<ul>
<li><p>message size : Sending more than a few kilobytes of data per stanza can fill up your server queues (especially when you have thousand of messages to route)</p></li>
<li><p>binary transfer : encode your data in base64, split it up in approprietly sized stanzas, send it over. It&#8217;s slow as hell (but reliable).</p></li>
<li><p>connected socket : one connects usually on an XMPP server on TCP port 5222. Loose the socket, loose the connection. Hence on iPhone, task switching means loosing the connection. And each time I chat from the iPhone, I have the need to switch between OneTeam XMPP client and my calendar or mail.</p></li>
</ul>

<p>There are other nitpicks I have : discovery is cool, but without paging and caching your bandwidth and CPU bills will go through the roof. I started implementing <a href="http://xmpp.org/extensions/xep-0059.html">paging</a> in ejabberd&#8217;s MUC, <a href="http://xmpp.org/extensions/xep-0131.html">SHIM</a> &#8211; for caching &#8211; is an itch I may scratch one day.</p>

<h1>Overcoming those limits</h1>

<p>Every time HTTP has a solution for &#8220;fixing&#8221; XMPP.</p>

<p>The first two limits can be fixed by running a WebDAV server. Upload to the WebDAV server, share the link. That&#8217;s a solution everyone can do without XMPP client support. Of course, having a way to do that transparently with client and server support, with signed URLs (à la S3) would greatly improve the process.</p>

<p>For the connected socket problem, there&#8217;s BOSH. That&#8217;s basically running XMPP over HTTP. With the added bonus of having the server retaining the &#8220;connection&#8221; for a couple of minutes &#8211; that fixes my iPhone problem. Once I relaunch the client in the two minutes window, all the pending messages are delivered.</p>

<p>There&#8217;s also a nice side effect : HTTP tools (load balancers, proxys) can be used in front of the server.</p>

<h1>XMPP and HTTP are here to stay.</h1>

<p>In my opinion XMPP needs more HTTP than HTTP needs XMPP.</p>

<p>I wouldn&#8217;t mind if my XMPP avatar was accessed by clients through the HTTP component of the XMPP server (they all have one embedded, that&#8217;s a sign, right ?), as opposed to fetching the VCard base64 encoded database stored version of it through XMPP.</p>

<p>I wouldn&#8217;t mind if my filetransfers never fail because the binary files are uploaded first on my XMPP server via HTTP, itself notifying the receiving client I am sending the file to that the payload is ready.</p>

<p>As a final note, writing my Atompub-PubSub bridge was quite gratifying, I could leverage MarsEdit to publish on my pubsub nodes.</p>      
