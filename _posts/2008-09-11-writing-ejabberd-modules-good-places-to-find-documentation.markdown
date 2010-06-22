---
layout: post
title: Writing ejabberd modules, good places to find documentation [Updated]
---
<p>Just found on the ejabberd mailing list <a href="http://anders.conbere.org/journal/">Anders Conbere&#8217;s blog</a>, with quite a lot of information to get you started, and code for the http server, write a bot.</p>

<p>[U] And Jack Moffit in the comment directed me to his <a href="http://metajack.im/">weblog</a>. Very good read about ejabberd deployment and administration.</p>

<p>Both of these live well in my NetNewsWire subscriptions.</p>

<h1>Other locations</h1>

<p>The <a href="http://www.process-one.net/en/wiki/ejabberd_module_development/">Process One wiki</a> is also a location to bookmark. All the standard hooks are listed.</p>

<p>Last but not least, <a href="https://svn.process-one.net/ejabberd/trunk/src/">the source code</a> ! The simple features of erlang make it quite easy to navigate through the source code.</p>

<p>Modules you&#8217;ll use on a frequent basis are <a href="https://svn.process-one.net/ejabberd/trunk/src/jlib.erl">jlib</a>, <a href="https://svn.process-one.net/ejabberd/trunk/src/ejabberd_router.erl">ejabberd<em>router</a>, <a href="https://svn.process-one.net/ejabberd/trunk/src/xml.erl">xml</a> and <a href="https://svn.process-one.net/ejabberd/trunk/src/xml_stream.erl">xml</em>stream</a> along with <a href="http://www.erlang.org/doc/man/mnesia.html">mnesia</a> and <a href="http://www.erlang.org/doc/man/lists.html">lists</a>.</p>

<ul>
<li><p>jlib : for manipulating JIDs, iq stanzas</p></li>
<li><p>ejabberd_router : send your stanzas elsewhere</p></li>
<li><p>xml_stream and  xml  : for parsing xml into the internal tuple representation or the other way round.</p></li>
</ul>      
