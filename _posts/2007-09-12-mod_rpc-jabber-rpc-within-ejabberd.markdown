---
layout: post
title: mod_rpc : Jabber-RPC within ejabberd
---
<h1>What is mod_rpc ?</h1>

<p>mod_rpc is an ejabberd module which will handle rpc queries &#8230; in a modular way.</p>

<p>It is is easily extensible, and is designed to access the mnesia database from XMPP clients.</p>

<p>It plugs in the access control list to allow or prevent access to the rpc modules.</p>

<h1>Installing mod_rpc</h1>

<p>Download the mod_rpc.erl file and copy it over your ejabberd src/ directory.
<code>make</code> ejabberd.</p>

<p>Do not restart yet, we have some configuration to do !</p>

<h1>Using mod_rpc</h1>

<p>Let&#8217;s say you want to publish two functions, <code>echo</code> and <code>mult</code>. The code would go as follow :</p>

<blockquote>
    <p>rpc_test.erl :</p>
</blockquote>

<pre><code class="erlang">
-module(rpc_test).
-export([handle/2]).

handle(_State, {call, echo, [A]}) -&gt; {response, [A]};
handle(_State, {call, mult, [A, B]}) -&gt; {response, [A*B]};
</code></pre>

<p>Copy into your ejabberd source directory and <code>make</code>.</p>

<p>Now you need to configure access to your functions.
In </p>

<blockquote>
    <p>ejabberd.cfg</p>
</blockquote>

<pre><code class="erlang">
% 2 groups : admins, and the rest.
{access, rpc_admin, [{allow, admin}]}.
{access, rpc_all, [{allow, all}]}.
%...

%... in modules configuration
%...
  {mod_register,   [{access, register}]},
  {mod_rpc, [{access, [{rpc_test, rpc_admin}] }]}, % only admins can call echo and mult
  {mod_roster,     []},
%....
</code></pre>

<p>Now start ejabberd. (of course you could do the hot code stuff if you want)</p>

<p>From now on I have <code>rpc_test@rpc.localhost</code> answering to my rpc queries.</p>

<p>Let&#8217;s test from ruby using <a href="http://home.gna.org/xmpp4r/">xmpp4r</a>. Get the SVN version for jabber-RPC support.</p>

<pre><code class="ruby">
require 'xmpp4r'
require 'xmpp4r/rpc/helper/client'
require 'xmpp4r/rpc/helper/server'
include Jabber
jid = JID::new('cstar@localhost') #this one is admin !
cl = Client::new(jid)
cl.connect
cl.auth("PASS")
rpc= RPC::Client.new(cl, 'rpc_test@rpc.localhost')
puts rpc.call("echo", 'Test string') # outputs Test string
puts rpc.call("mult", 2,4) # outputs ... 8
</code></pre>

<p>If you try with a non-admin user, you&#8217;d get</p>

<blockquote>
    <p>Jabber::AuthenticationFailure: not-authorized</p>
</blockquote>

<h1>About Groovy Jabber-RPC</h1>

<p>I have been playing with it, and it does not work directly out of the box. The groovy lib will try to see if rpc_test@rpc.localhost is in the user roster.</p>

<p>Patching to making it work is quite simple ;
In file xmlrpc-groovy/src/main/java/groovy/net/xmlrpc/JabberRPCServerProxy.java</p>

<p>Just replace :  <code>request.setTo(getId(connection.getRoster(), this.to));</code> (line 102) </p>

<p>with :  <code>request.setTo(this.to);</code></p>

<p>And the following will work :</p>

<pre><code class="groovy">
import groovy.net.xmlrpc.*
import org.jivesoftware.smack.XMPPConnection

def clientConnection = new XMPPConnection("localhost")
clientConnection.connect()
clientConnection.login("cstar", "PASS")
def serverProxy = new JabberRPCServerProxy(clientConnection, "rpc_test@rpc.localhost")
serverProxy.echo("test")
clientConnection.disconnect()
</code></pre>

<h1>Necessary caveats</h1>

<p>This is my first foray in developping a module in ejabberd, I still have to check how this actually scales. I only have one process handling all queries, which is not very concurrency oriented programming :)</p>

<h1>Thanks</h1>

<p>The guys from ejabberd, for making software really easy to use and extend ;)</p>

<h1>Download :</h1>

<p><a href="/assets/2007/9/12/mod_rpc.erl" title="mod_rpc.erl">mod_rpc.erl</a></p>

<h1>Feedback</h1>

<p>I really welcome enhancements and fixes (especially regarding the concurrency stuff!)</p>

<h1>License</h1>

<p>Don&#8217;t sue me, don&#8217;t remove copyright/name kind of license.</p>      
