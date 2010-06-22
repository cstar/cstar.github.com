---
layout: post
title: [Updated 2] Atom-PubSub module for ejabberd
---
<h1>As requested, the Atom PubSub bridge</h1>

<p>This module offersr an AtomPub interface to ejabberd PubSub data. Currently in two unfinished flavors, one for use with yaws embedded. One for use with ejabberd_http server</p>

<h1>Howto</h1>

<p>You need to have Yaws available. It will start in embedded mode, with the <code>mod_yaws</code> module (included).
To build, edit the <code>Makefile</code> to match your erlang install and <code>make</code> Put the resulting beams in some place where ejabberd will find them.</p>

<p>Also you&#8217;ll need to set the <code>BASEURL</code> macro in <code>atom_pubsub.erl</code> to your webserver hostname.</p>

<p>You&#8217;ll also need to add the module to your ejabberd.cfg in the <code>mmodules</code> section:</p>

<pre><code class="erlang">
{mod_yaws,[{logdir, "/tmp/"},
    {servers, [
    {"localhost", 5224, "/opt/var/yaws/www", [
     {dir_listing, true},
     {appmods, {"/atom",     atom_pubsub}}
     ]}
   ]}
  ]}
</code></pre>

<h1>What you get</h1>

<p>The AtomPub interface passes the Atom Protocol Exerciser (though some warnings remain).</p>

<p>It means that any AtomPub clients will be able to post to a specific node in your PubSub tree.</p>

<p>It also means that your PubSub tree will also be available as an AtomFeed.</p>

<p>Of course, each time an item is posted through AtomPub or PubSub on a node you are subscribed to, you&#8217;ll get the notification.</p>

<h1>Can I have it with OpenFire and Epeios ?</h1>

<p>That&#8217;s not possible. At some point, there&#8217;s no way around hitting directly the PubSub mnesia tables. So you can&#8217;t extract the code as a component.</p>

<p>Moreover, it only works with PubSub nodes derived from the default node type. (because of the mnesia tables stuff)</p>

<h1>What&#8217;s next ?</h1>

<p>I&#8217;ll update the code soon.
A few of things I&#8217;d like to implement :</p>

<ul>
<li>remove all calls to mnesia and work through mod_pubsub API.</li>
<li>add HEAD, <a href="http://intertwingly.net/blog/2006/06/05/Elevator-Pitch">etag</a> and slug support (that&#8217;s a patch for ejabberd though)</li>
<li>remove that baseurl horrible macro</li>
<li>add node subscription through REST</li>
<li>as soon as ejabberd 2.1 is published remove dependency from yaws</li>
<li>add binary collections support</li>
</ul>

<p>Mickaël Rémond from <a href="http://www.process-one.net/">Process-One</a> kindly offered to host atom-pubsub on the ejabberd_modules svn.</p>

<pre><code class="shell">
svn co https://svn.process-one.net/ejabberd-modules/atom_pubsub/trunk/
</code></pre>

<p>There&#8217;s a quick port to the ejabberd_http server at this location :
You need to be running ejabberd 2.1 or current trunk to have it work.</p>

<pre><code class="shell">
svn co https://svn.process-one.net/ejabberd-modules/atom_pubsub/branches/ejabberd_http_branch/
</code></pre>

<p>Check out the <a href="https://svn.process-one.net/ejabberd-modules/atom_pubsub/branches/ejabberd_http_branch/README">README</a> for installation.</p>

<p>Shoot your questions in the comment or via email (anything on this weblog domain goes to my inbox)</p>      
