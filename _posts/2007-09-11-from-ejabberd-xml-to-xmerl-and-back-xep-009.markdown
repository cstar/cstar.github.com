---
layout: post
title: From ejabberd xml to xmerl and back - XEP-009
---
<p>Those last days I was busing implementing an ejabberd module responding to Jabber-RPC (a.k.a <a href="http://www.xmpp.org/extensions/xep-0009.html">XEP-009</a>).</p>

<p>I used the <code>xmlrpc</code> module shipped with erlang to do the parsing. But that was tricky. <code>xmlrpc</code> uses <code>xmerl</code> for parsing and representing XML but ejabberd does not. It a simpler <code>xml</code> module handling the parsing.</p>

<p>To make a long story short, to get ejabberd&#8217;s xml understood by xmlrpc, here&#8217;s the thing :</p>

<pre class="erlang">
% ....
xmlrpc_decode:payload(xmerl_ucs:to_utf8(
            xml:element_to_string(xml:get_subtag(SubEl, "methodCall")))),
% ....
</pre>

<p><code>SubEl</code> being the <code>sub_el</code> field of an <code>iq</code> packet.</p>

<p>The complex part is that you need to call <code>xmerl_ucs:to_utf8/1</code> else the module will crash.</p>

<p>For returning the resulting XML to the client, you need to call <code>xml_stream:parse_element</code> (ejabberd&#8217;s internal XML parser) to get the XML structure right for handling by ejabberd.</p>

<pre class="erlang">
case xmlrpc_encode:payload(handle(State,Decoded)) of % handle is the xmlrpc method
 {ok, EncodedPayload} -&gt;
    Res = IQ#iq{type = result,
        sub_el = [{xmlelement, "query", [{"xmlns", ?NS_RPC}],
        [ xml_stream:parse_element(EncodedPayload) ]
               }]
    },
%....
</pre>

<p>That&#8217;s not very optimal of course, as data is converted at nearly every step : </p>

<p><code>XML -&gt; ejabberd -&gt; XML -&gt; xmerl -&gt; XML -&gt; ejabberd -&gt; XML</code>. </p>

<p>But developper time is more expensive than machine time, right ?</p>

<p>So now I can call methods on the server directly from Groovy using Groovy Jabber-RPC (using XMPPPool, of course).</p>

<p>If there is any interest, I&#8217;ll release the code, but for the time being it is very crude. I&#8217;ll like to &#8220;componentize&#8221; a bit more, and hook up ACLs for specific RPC handlers.</p>      
