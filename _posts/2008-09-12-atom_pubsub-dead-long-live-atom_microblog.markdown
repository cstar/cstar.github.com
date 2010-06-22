---
layout: post
title: Atompub interface for distributed microblogging over XMPP
---
<p><a href="http://www.cestari.info/2008/6/19/atom-pubsub-module-for-ejabberd">atom<em>pubsub</a> has been updated and simplified and renamed to atom</em>microblog. Some might argue that it&#8217;s useful now. </p>

<p>The scope of the plugin is reduced to one node : the &#8220;urn:xmpp:microblog&#8221; node of the upcoming <a href="http://www.xmpp.org/extensions/inbox/microblogging.html">Microblogging over XMPP</a> XEP.</p>

<p>Also improved : removed dependency on Yaws and <a href="http://bitworking.org/projects/atom/rfc5023.html#etags">implemented caching like they want it</a>.</p>

<p>The code is on the <a href="https://svn.process-one.net/ejabberd-modules/atom_pubsub/trunk/">ejabberd_modules svn</a>.</p>

<p>For full context, <a href="http://lists.jabber.ru/pipermail/ejabberd/2008-September/004201.html">these</a> <a href="http://lists.jabber.ru/pipermail/ejabberd/2008-September/004211.html">mails</a> tell about production use.</p>

<p>Once <a href="https://support.process-one.net/browse/EJAB-739">this patch</a> is implemented, it&#8217;s going to be even better. I will move <code>entry</code> payload processing into a node<em>macroblog. And maybe I&#8217;ll find a more generic interface for atom</em>microblog.erl.</p>

<p>To the broader subject of distributed microblogging over XMPP, you might want to read <a href="http://metajack.im/2008/09/10/xmpp-microblogging-thoughts/">Jack Moffit&#8217;s blog post</a>. Follow the links !</p>

<p>PS : Yup, very pompous title.</p>      
