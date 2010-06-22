---
layout: post
title: J'annule l'annulation
---
<p>Aujourd&#8217;hui un <i>rant</i> comme disent les anglo-saxons, ou un coup de gueule, comme disent les auditeurs de Fun Radio &#8211; amicalement sugg&eacute;r&eacute; par Franck, mon sympathique chef de projet &agrave; Ohm Force.</p>

<h1>L&#8217;annulation</h1>

<p>L&#8217;humain est faillible. Et va s&#8217;en rendre compte, et va tenter de corriger son erreur.
Le logiciel, b&ecirc;te comme il est, va faire ce qu&#8217;on lui dit, m&ecirc;me si c&#8217;est une connerie, et permet, c&#8217;est bien urbain d&#8217;annuler la ou les derni&egrave;res actions qu&#8217;il a effectu&eacute;.</p>

<p>Un <a href="http://www.alistapart.com/articles/neveruseawarning">article r&eacute;cent</a> sur <a href="http://www.alistapart.com/">A List Apart</a> par Aza Raskin nous explique que du point de vue interface, c&#8217;est largement sup&eacute;rieur de proposer d&#8217;annuler que de demander une confirmation.</p>

<p>Je vous laisse lire l&#8217;article, tant que vous revenez ici ensuite. Et abonnez vous au <a href="http://www.alistapart.com/feed/rss.xml">flux RSS</a> de ce site, qui se range dans les lectures indispensables pour le d&eacute;veloppeur web (et les autres aussi, finalement).</p>

<p>Bref, beaucoup d&#8217;applications proposent l&#8217;annulation, et c&#8217;est tant mieux.</p>

<h1>Je viens de cliquer 12 fois sur le bouton !</h1>

<p>Mais parfois, l&#8217;impl&eacute;mentation est vraiment foireuse, et on se dit que le bouton est vraiment l&agrave; pour la d&eacute;coration.</p>

<p>2 exemples parmi d&#8217;autres :</p>

<ul>
<li><p>Le Finder : j&#8217;envoie un fichier relativement volumineux sur un partage WebDAV. Pas dans le bon r&eacute;pertoire. Y a une jolie petite croix &agrave; c&ocirc;t&eacute; de la barre de transfert de fichier. Je clique sur la croix ; rien ne se passe. Ah si, le Finder freeze. Le Dock aussi. Je tente toutes les combos pour d&eacute;coincer &ccedil;a (&#8220;Forcer &agrave; quitter&#8221;, kill du Finder dans un terminal) rien &agrave; faire. Au final le fichier a &eacute;t&eacute; transf&eacute;r&eacute;, malgr&eacute; tout mes r&eacute;criminations.</p></li>
<li><p>Le plugin SVN sous Eclipse : Je fais un commit malheureux, vite, je clique sur Annuler. Le bouton se grise (&#8220;Ah il a pris en compte mon action&#8221;), l&#8217;interface se bloque. 3 minutes plus tard, il prend enfin en compte mon annulation. Ben tiens, justement, je voulais &eacute;conomiser ce temps &#8230; sinon j&#8217;aurais fait un commit correctif ensuite, &ccedil;a m&#8217;aurait pris moins de temps. Les gens vont dire : &#8220;oui, mais SVN c&#8217;est transactionnel, atomique, il faut qu&#8217;il nettoie gna gna &#8230;&#8221;. Ben non. Quand je fais Ctrl-C dans le terminal, le commit est annul&eacute; tout de suite.</p></li>
</ul>

<p>Bon. Ca va mieux.</p>      
