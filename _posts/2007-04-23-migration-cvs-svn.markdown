---
layout: post
title: Migration CVS-SVN
---
<p>[Cet article a été initialement publié le 1 juillet 2006]</p>

<p>Cette semaine, &agrave; Ohm Force, avec le retour de Raf, notre d&eacute;veloppeur Mac, la d&eacute;cision a enfin &eacute;t&eacute; prise. Le code des plugins Ohm Force va migrer de Concurrent Version System(le v&eacute;n&eacute;rable CVS) au moderne SVN. La conversion s&rsquo;appuie sur l&rsquo;outil bien pratique  <a href="http://cvs2svn.tigris.org/" title="http://cvs2svn.tigris.org/">cvs2svn </a> .  </p>

<p>L&rsquo;op&eacute;ration a &eacute;t&eacute; longue &#8230; le repository CVS fait 9,1Go, cvs2svn m&rsquo;a g&eacute;n&eacute;r&eacute; un dump de 27Go et 10300 commits qu&rsquo;il a fallu ensuite &#8220;rejouer&#8221; dans le repository SVN.
 Il y a eu quelques soucis : il faut pr&eacute;ciser l&rsquo;encoding des message de commit (<code>cvs2svn &#8211;encoding=latin1</code>), et certains fichiers avec de l&rsquo;accentuation ne sont pas pass&eacute; dans la moulinette (silencieusement, en plus). Quelques fichier dans les rep&eacute;rtoires Attic/ de CVS &eacute;tait corrompus, mais cela n&rsquo;etait pas grave. Finalement, s&rsquo;ils sont dans le grenier, c&rsquo;est pour une bonne raison. </p>

<p>Il a bien fallu 10 heures pour tout convertir (oui, oui, nuit blanche &#8230;). </p>

<p>Installation de <a href="http://trac.edgewall.org/">Trac</a>, et bienvenue au 21e si&egrave;cle les codeurs ! </p>

<p>J&rsquo;utilise la version 1.1.4 de SVN [UPDATE : depuis le serveur tourne en 1.3.2). Je vais migrer &agrave; la derni&egrave;re version, tant pis pour Debian &#8230; En effet je suspecte une fuite m&eacute;moire dans certaines conditions. Un processus Apache qui fait 800Mo pendant un checkout, ce n&rsquo;est pas raisonnable &#8230; Il y a quand m&ecirc;me 2Go de SDRam ECC qui arrivent par le courrier. </p>

<p>UPDATE : Quelques remarques sur la conversion :</p>

<ul>
<li>Ne pas ex&eacute;cuter le &#8220;svnadmin load&#8221; en root &#8230; c&rsquo;est mal, et &ccedil;a bloque l&rsquo;acc&egrave;s ult&eacute;rieur au svn via le webdav.  </li>
<li>Toujours travailler sur des copies du repository CVS. Certains fichiers peuvent &ecirc;tre corrompus et il faut parfois les supprimer du CVS.  </li>
<li>Certains fichiers avec des noms accentu&eacute;s ne sont pas pass&eacute;s dans la conversion. Heureusement, c&rsquo;&eacute;tait des fichiers mineurs.  </li>
</ul>      
