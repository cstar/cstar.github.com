---
layout: post
title: Auth me on Jabber
---
<p><a href="http://www.ja-sig.org/products/cas/">CAS</a> est un service très populaire permettant de mettre en place le <a href="http://fr.wikipedia.org/wiki/Authentification_unique">Single Sign On</a>, avec des librairies clientes pour la plupart des langages.</p>

<p>On peut facilement rajouter des handlers d&#8217;authentification.</p>

<p>En voici un très rapide, permettant de s&#8217;authentifier sur un service Jabber.</p>

<h1>Installation :</h1>

<blockquote>
    <p>Uniquement compatible CAS v3.</p>
</blockquote>

<p>Installez ce bout de xml dans le deployerConfigContext, dans la liste des AuthHandlers :</p>

<pre><code class="xml">
&lt;bean class="com.ohmforce.cas.JabberAuthenticationHandler"&gt;
 &lt;property name="jabberHostname" value="<i>DOMAIN</i>"/&gt;
&lt;/bean&gt;
</code></pre>

<p>Copiez <a href="/assets/2008/3/7/jabber-cas.jar.zip" title="jabber-cas.jar.zip">jabber-cas.jar.zip</a> et la jar de <a href="http://www.igniterealtime.org/projects/smack/index.jsp">Smack</a>, relancez la webapp CAS et c&#8217;est tout.</p>

<p>Pour se logger sur vos applications CASifiées, vos utilisateurs utiliserons leur compte défini dans sur le domaine indiqué par jabberHostname, le mal nommé.</p>

<h1>Le code</h1>

<p>Y en a tellement peu que ca tient ici.</p>

<pre><code class="java">
package com.ohmforce.cas;
import org.jasig.cas.authentication.handler.AuthenticationException;
import org.jasig.cas.authentication.handler.support.AbstractUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;

final public class JabberAuthenticationHandler extends
        AbstractUsernamePasswordAuthenticationHandler {
    private String jabberHostname;
    @Override
    protected boolean authenticateUsernamePasswordInternal(
            UsernamePasswordCredentials credentials)
            throws AuthenticationException {
        XMPPConnection conn = new XMPPConnection(jabberHostname);
        try {
            conn.connect();
            conn.login(credentials.getUsername(), credentials.getPassword());
        } catch (XMPPException e) {
            log.error("Failed", e);
            return false;
        }
        finally{
            conn.disconnect();
        }
        return true;
    }

<pre><code>public void setJabberHostname(String server)
{
    jabberHostname=server;
}
public String getJabberHostname()
{
    return jabberHostname;
}
</code></pre>

<p>}
</code><pre></p>      
