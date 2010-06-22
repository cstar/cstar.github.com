---
layout: post
title: mod_couch : embedding ecouch client for CouchDB in ejabberd
---
<h1>Quick and dirty :</h1>

<ul>
<li><p>checkout, compile and copy the <a href="http://code.google.com/p/ecouch/">ecouch</a> directory somewhere erlang will find it. Mine is <code>/usr/local/lib/erlang/lib</code></p></li>
<li><p><a href="https://svn.process-one.net/ejabberd-modules/atom_pubsub/trunk/mod_couch.erl">download this</a>, compile, copy the beam file in the ejabberd <code>ebin</code> directory.</p></li>
<li><p>in ejabberd.cfg :</p></li>
</ul>

<pre><code class="erlang">
{modules, [
.
.
.
.
  {mod_couch,     [{server,{"127.0.0.1", "5984"}}]},
.
.
.
]}
</code></pre>

<ul>
<li><p>restart ejabberd</p></li>
<li><p>You now have access to your CouchDB server within ejabberd.</p></li>
</ul>      
