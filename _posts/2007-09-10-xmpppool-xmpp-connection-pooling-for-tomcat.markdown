---
layout: post
title: [UPDATED] XMPPPool, XMPP Connection Pooling for Tomcat and Grails/Jetty
---
<p>Release 0.3 of XMPPPool</p>

<p>[Update : also added support for Grails Jetty]</p>

<p>[Update 2 : Simplified the API a lot. It is now basically invisible &#8230;]</p>

<h1>About</h1>

<p>It provides XMPP connection pooling for Tomcat, configured as a resource in the <code>$TOMCAT_HOME/conf/server.xml</code>.</p>

<p>The main use case to use <a href="http://groovy.codehaus.org/Groovy+Jabber-RPC">Groovy Jabber-RPC</a>, with the webapp acting as a client :</p>

<ul>
<li>You fetch a XMPPConnection from the pool,</li>
<li>call an RPC method,</li>
<li>get the result,</li>
<li>return the XMPPConnection to the pool.</li>
</ul>

<p>Of course you can use the code to write XMPP &#8220;servers&#8221;/bots, but you&#8217;ll have to manage the lifecycle of the connection (i.e. launch a separate thread)</p>

<h1>How it works</h1>

<p>A pool is created, with connections to the XMPP server. All connections use the same XMPP account, but each have a unique resource.</p>

<p>Rule 10.5 of <a href="http://www.xmpp.org/rfcs/rfc3920.html#rules">RFC 3920 (XMPP Core)</a> means that is a stanza is sent to a JID with a specific resource, it MUST be delivered to this resource or it MUST fail.
However if a stanza is sent to a jid without any resource identifier, it SHOULD be sent to at least one of the resources.</p>

<p>So make sure that the code answering to a query coming from an XMPPPool managed connection sends it to a specific JID.</p>

<h1>Quick install guide for Tomcat</h1>

<p>Download <a href="/assets/2007/9/10/XMPPPool-0.3.0-jar-with-dependencies.jar.zip" title="XMPPPool-0.3.0-jar-with-dependencies.jar.zip">XMPPPool-0.3.0-jar-with-dependencies.jar.zip</a> and copy it in your <code>$TOMCAT_HOME/common/lib</code>.
Then in server.xml, configure your source as follow : </p>

<pre><code class="xml">
&lt;Resource auth="Container" maxActive="10" maxIdle="5" maxWait="10000"
  factory="com.ohmforce.xmpp.XMPPSourceFactory" type="com.ohmforce.xmpp.XMPPConnectionPool" name="xmpp/connection"
  username="username" password="pass" service="localhost" port="5222"/&gt;
</code></pre>

<p>The pooling code is using commons-pool from Apache. All the usual options are available. <code>port</code> is optional and defaults to 5222.</p>

<p>Now restart your container.</p>

<h1>Quick install guide for Grails/Jetty</h1>

<p>First you need to patch Grails as per this <a href="http://jira.codehaus.org/browse/GRAILS-1557">report</a> (which should be implemented soon in Grails). Don&#8217;t forget to add the jars to $GRAILS_HOME/lib!</p>

<p>Also unzip and add <a href="/assets/2007/9/10/XMPPPool-0.3.0-jar-with-dependencies.jar.zip" title="XMPPPool-0.3.0-jar-with-dependencies.jar.zip">XMPPPool-0.3.0-jar-with-dependencies.jar</a> in GRAILS_HOME/lib</p>

<p>Then add a jetty-env.xml file in WEB-INF/ directory (of your Grails app)</p>

<pre><code class="xml">
&lt;Configure class=&quot;org.mortbay.jetty.webapp.WebAppContext&quot;&gt;
  &lt;New id=&quot;xmpp&quot; class=&quot;org.mortbay.jetty.plus.naming.Resource&quot;&gt;
    &lt;Arg&gt;xmpp/connection&lt;/Arg&gt;
    &lt;Arg&gt;
    &lt;New class=&quot;com.ohmforce.xmpp.XMPPSourceFactory&quot;&gt;
     &lt;Set name=&quot;properties&quot;&gt;
       &lt;New class=&quot;java.util.Properties&quot;&gt;
         &lt;Put name=&quot;username&quot;&gt;username&lt;/Put&gt;
         &lt;Put name=&quot;password&quot;&gt;pass&lt;/Put&gt;
         &lt;Put name=&quot;service&quot;&gt;localhost&lt;/Put&gt;
       &lt;/New&gt;
      &lt;/Set&gt;
   &lt;/New&gt;
 &lt;/Arg&gt;
   &lt;/New&gt;
&lt;/Configure&gt;
</code></pre>

<p>Start the grails app : <code>grails -Denable.jndi=true run-app</code></p>

<p>Now inside a grails controller you can connect to a Jabber-RPC service :</p>

<h1>Using from Grails :</h1>

<p>Now inside a grails controller you can connect to a Jabber-RPC service :</p>

<pre><code class="groovy">
import javax.naming.InitialContext;
import groovy.net.xmlrpc.*
class HelloController{
def hello = {
        def p =new InitialContext().lookup("java:comp/env/xmpp/connection")
        def serverProxy = new JabberRPCServerProxy(p, "cstar@localhost")
        def s = serverProxy.add(2,6)
        def e = serverProxy.echo("toto")
        flash.message = "${s} and ${e}"
        p.disconnect() // does not actually disconnect, but returns connection in pool
    }
}
</code></pre>

<p>The server code (slightly modified from the <a href="http://groovy.codehaus.org/Groovy+Jabber-RPC">examples on the Groovy website</a>. fixed typos and updated to latest Smack version) :</p>

<pre><code class="groovy">
import groovy.net.xmlrpc.*
import org.jivesoftware.smack.XMPPConnection
def server = new JabberRPCServer()
server.echo = {return it+"toto"}
server.add = {i,j -&gt; return i+j}
def serverConnection = new XMPPConnection("localhost")
serverConnection.connect()
serverConnection.login("user", "pass")
server.startServer(serverConnection)
</code></pre>

<h1>Using the datasource in a servlet</h1>

<pre><code class="java">
try{
    InitialContext ctx = new InitialContext();
    XMPPConnection conn = (XMPPConnection) ctx.lookup("java:/comp/env/xmpp/connection");
    // Do things here
    conn.disconnect(); // does not actually disconnect, but returns connection in pool
}
catch(Exception e){
    e.printStackTrace();
}

</code></pre>

<p>For actually using the connection, please refer to the <a href="http://www.igniterealtime.org/projects/smack/documentation.jsp">Smack developper guide</a></p>

<h1>Building the source code</h1>

<p>The project is built with Maven. </p>

<p><code>mvn assembly:assembly</code></p>

<p><code>cp target/XMPPPool-0.3.0-jar-with-dependencies.jar $TOMCAT_HOME/common/lib/</code></p>

<p>And you&#8217;re set.</p>

<h1>Bugs ? Patches ?</h1>

<ul>
<li>mail : eric at ohmforce dot com</li>
<li>xmpp : cstar at cestari dot info</li>
</ul>

<h1>Known issues</h1>

<ul>
<li>Only one pool can be configured on a given tomcat instance (Although that should fit most use cases)</li>
</ul>

<h1>Todo</h1>

<ul>
<li>Better error reporting, I guess :)</li>
</ul>

<h1>License</h1>

<p>Apache 2.0 license, the same as Smack and others libs XMPPPool is built upon. Free to use, as long as you don&#8217;t sue me or remove my name from the code &#8230;</p>

<h1>Download</h1>

<ul>
<li><p><a href="/assets/2007/9/10/XMPPPool-0.3.0-jar-with-dependencies.jar.zip" title="XMPPPool-0.3.0-jar-with-dependencies.jar.zip">XMPPool and dependancies in a single jar</a></p></li>
<li><p><a href="/assets/2007/9/10/XMPPPool-0.3.0-src_1.zip" title="XMPPPool-0.3.0-src.zip">Source code</a></p></li>
</ul>      
