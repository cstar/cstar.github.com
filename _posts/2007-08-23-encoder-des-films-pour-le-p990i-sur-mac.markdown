---
layout: post
title: Encoder des films pour le P990i et le P1i sur Mac
---
<p>Ayant une carte de 1 Go sur mon P990i, il me fallait la remplir &#8230; avec de la vid&eacute;o !</p>

<p>Les AVI ne passent pas nativement sur le t&eacute;l&eacute;phone, et n&eacute;cessite de les convertir vers un format reconnu. Soit le 3gp, soit le mp4.</p>

<p>Il faut aussi un outil. <a href="http://fr.wikipedia.org/wiki/FFmpeg">ffmpeg</a> est le couteau suisse ultime de la conversion vid&eacute;o. Toutefois dans un acc&egrave;s de flemmardise, je suis pass&eacute; par le front-end <a href="http://ffmpegx.com/fr/download.html">ffmpegX</a>, dont j&#8217;ai sauv&eacute; quelques r&eacute;glages.</p>

<p>En voici deux :</p>

<ul>
<li><p><a href="/assets/2007/8/23/toP990-43.ffx">pour les vid&eacute;os en 4:3</a></p></li>
<li><p><a href="/assets/2007/8/23/toP990i-169.ffx">pour les vid&eacute;os en 16:9</a></p></li>
</ul>

<p>L&#8217;op&eacute;ration : </p>

<ol>
<li><p>Drag and drop du fichier &agrave; convertir</p></li>
<li><p>Fichier -&gt; Charger pr&eacute;-r&eacute;glage</p></li>
<li><p>Encoder !</p></li>
</ol>

<p>UPDATE : L&#8217;ajout de sous-titre se fait avec l&#8217;onglet &#8220;Filtre&#8221; de ffmpegX. On importe les sous-titres, et ils sont incrust&eacute;s directement. Nice (mais je ne m&#8217;en sers pas).</p>      
