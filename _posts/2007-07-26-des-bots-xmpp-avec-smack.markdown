---
layout: post
title: Des bots XMPP avec Smack
---
<p>J&#8217;ai &eacute;crit il y a quelques temps deux bots qui communiquent entre eux. j&#8217;utilise la librarie <a href="http://www.igniterealtime.org/projects/smack/index.jsp">Smack</a> Java.</p>

<p>Le code : <a href="/assets/2007/7/26/chatbots.zip">chatbots.zip</a>. C&#8217;est un projet Eclipse 3.1, avec toutes les jars n&eacute;cessaires.</p>

<p>Pour l&#8217;utiliser, vous allez devoir cr&eacute;er deux comptes sur le serveur Jabber, et modifier la m&eacute;thode main.</p>

<h1>Mais que font-ils ?</h1>

<p>Il y a deux bots : sessioncreator et sessionbot.
Pour cr&eacute;er une chatroom, il faut envoyer un message &agrave; sessioncreator sous cette forme :</p>

<p><code>create MaChatRoom  &lt;liste de personnes a inviter separes par des espaces&gt;</code></p>

<p>A ce moment-l&agrave;, sessioncreator :</p>

<ul>
<li>cr&eacute;e la chatroom et met le sessionbot en <code>owner</code> de la chatroom.</li>
<li>invite le sessionbot, avec le nom listener</li>
<li>envoie les invitations au demandeur, et &agrave; la liste des personnes &agrave; inviter.</li>
<li>quitte la chatroom un fois que le sessionbot a rejoint la chatroom.</li>
</ul>

<p>Le sessionbot, lui travaille beaucoup moins :</p>

<ul>
<li>Il accepte les invitations &agrave; rejoindre les chatrooms</li>
<li>Il <code>kick</code> toutes les personnes qui disent FORBIDDEN.</li>
</ul>

<p>NB : le sessioncreator a deux hooks <code>canCreate</code> et <code>canJoin</code> qui permettent de v&eacute;rifier si un utilisateur peut cr&eacute;er ou joindre la chatroom (avec une v&eacute;rification en BDD, par exemple).</p>

<p>NB2 : Vous pouvez utiliser/modifier mon code source sans restriction. Pour les jars de Smack, vous devez respecter leur licence (mais bon c&#8217;est du Open Source Apache, ce qui est assez tranquille).</p>      
