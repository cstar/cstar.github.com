---
layout: post
title: Libraries et clients XMPP
---
<p><a href="http://www.cestari.info/2007/7/23/vers-erlang-via-xmpp">Le post pr&eacute;c&eacute;dent</a> &eacute;tait trop long. J&rsquo;esp&egrave;re que vous avez tenu. </p>

<p>Indispensable pour d&eacute;velopper des applications XMPP,  <a href="http://psi-im.org/" title="http://psi-im.org/">le client Psi</a> . Permet d&rsquo;afficher le trafic depuis et vers le client, la possibilit&eacute; de composer en brut les stanzas (paquets) XMPP, connexions multiples, bref id&eacute;al pour d&eacute;velopper et d&eacute;bugger.  </p>

<ul>
<li><p>Pour causer : </p>

<p>Il y aussi iChat sur les Mac, GAIm et le  <a href="http://openwengo.com/" title="http://openwengo.com/">WengoPhone</a> .<br>
Un client plut&ocirc;t sympa :  <a href="http://coccinella.im/" title="http://coccinella.im/">Coccinella</a> . Avec une fonctionnalit&eacute; de whiteboard en SWF. Malheureusement l&rsquo;interface utilisateur est plut&ocirc;t maladroite.<br>
<a href="http://www.jabber.org/software/clients.shtml" title="http://www.jabber.org/software/clients.shtml">La page des clients sur Jabber.org</a> </p></li>
<li><p>Pour d&eacute;velopper : </p>

<p>Les APIs que j&rsquo;ai test&eacute;e sont en g&eacute;n&eacute;ral bas&eacute; sur un mod&egrave;le &eacute;v&eacute;nementiel, ce qui colle plut&ocirc;t bien :)
Il y a  <a href="http://www.igniterealtime.org/projects/smack/index.jsp" title="http://www.igniterealtime.org/projects/smack/index.jsp">Smack</a>  dont je parle dans le post pr&eacute;c&eacute;dent qui g&egrave;re tout le support de XMPP-Core, et entre autres, la connexion au serveur de discussion, et les data-forms (envoi de formulaires &agrave; la   HTML).  </p>

<p>C&rsquo;est une librairie Java, et elle semble la plus avanc&eacute;e dans ce langage.
Par contre, pas de d&eacute;veloppement de composants, il faut utiliser  <a href="http://www.igniterealtime.org/fisheye/browse/svn-org/whack" title="http://www.igniterealtime.org/fisheye/browse/svn-org/whack">Whack</a> , qui n&rsquo;est curieusement pas document&eacute; du tout sur le site IgniteRealtime.  </p>

<p>J&rsquo;ai test&eacute; XMPP4R, mais pas longtemps. J&rsquo;ai jou&eacute; avec les exemples, remarqu&eacute; que la couverture de XMPP Core et des Extensions est large, et y a des helpers pour d&eacute;velopper des Multi-User Chatrooms (MUC) en composant assez facilement. Par contre j&rsquo;ai eu des probl&egrave;mes curieux pendant le d&eacute;veloppement de mes bots, et par flemme (?) j&rsquo;ai bascul&eacute; mon d&eacute;veloppement sur Smack en Java.
<a href="http://www.jabber.org/software/libraries.shtml" title="http://www.jabber.org/software/libraries.shtml">Les librairies XMPP sur Jabber.org</a> </p></li>
</ul>

<p>.
 .
 . Enough pour aujourd&rsquo;hui. </p>      
