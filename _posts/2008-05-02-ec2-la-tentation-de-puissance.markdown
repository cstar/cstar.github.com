---
layout: post
title: EC2, La tentation de puissance
---
<p><a href="http://aws.amazon.com/ec2">Amazon Elastic Computing Cloud</a>, aka EC2, mon nouveau jouet.</p>

<p>En quelques clics, on dispose d&#8217;une puissance de feu capable d&#8217;affronter à du Slashdotting, du Facebooking ou du Digging.</p>

<p>Jusqu&#8217;à récemment, EC2 était à la fois sexy et limité.</p>

<h1>Les deux manques (d&#8217;avant)</h1>

<p>Pas d&#8217;IP statique : il fallait utiliser un provider de DNS dynamique pour maintenir le lien avec le monde extérieur (oui, comme avant, avec l&#8217;ADSL de Francetélécom).</p>

<p>Pas de stockage en mode bloc persistent : La plus grosse instance (octo-core, 15Gig de RAM) a bien 1,5 To de stockage, mais en cas de arrêt de l&#8217;instance (volontairement du locataire ou involontairement en cas de défaillance matérielle sur la machine qui héberge la machine virtuelle), on perd tout.</p>

<p>Heureusement, un écosystème s&#8217;est développé pour pallier aux manques. <a href="http://www.elasticdrive.com/">Elastic Drive</a>, par exemple, est un module FUSE qui permet de monter un bucket S3 en système de fichier par bloc.</p>

<p>Du coup pour héberger une base de donnée, on crée une partition RAID 1 : d&#8217;un côté la partition non persistente, mais performante de la machine EC2, et de l&#8217;autre, lent mais fiable, le stockage sur <a href="http://aws.amazon.com/s3">S3</a>.</p>

<p>En cas de crash, le RAID est reconstruit à partir du S3.</p>

<h1>Ah non, ça ne manque plus &#8230;</h1>

<p>On peut maintenant avoir des IP statiques, et c&#8217;est implémenté avec beaucoup d&#8217;élégance. Les IPs sont décorrellés des machines virtuelles, et on peut faire pointer une IP d&#8217;une machine à une autre instantanément. Les IPs statiques sont limités à 5 par compte AWS, et coûtent $0.01 lorsqu&#8217;elles ne sont pas utilisées/</p>

<p>Le Persistent Storage arrive lui aussi. Des partitions (jusqu&#8217;à 1To) peuvent être attachées à n&#8217;importe quelle instance EC2 (pas de partage toutefois).
On peut ensuite en faire des snapshots sur S3.</p>

<p>How cool is that ?</p>

<p>Le système est encore en closed beta, j&#8217;attends avec impatience mon invitation pour tester le service.</p>

<h1>Pour quels usages ?</h1>

<h2>La souplesse</h2>

<p>Le prix de la plus petite instance par mois est de 45 Euro. Pour une machine de la puissance d&#8217;une dédibox vieux modèle.
Donc pas vraiment rentable en soi.</p>

<p>Mais, on y gagne la souplesse. Si je m&#8217;y suis bien pris, si j&#8217;ai un pic de trafic (durable ou non) je peux en quelques minutes augmenter le nombre de mes serveurs et donc la charge que peut encaisser mon site/service.</p>

<p>Et encore mieux, je peux diminuer le coût de mon infrastructure si la réalisation de mon business plan n&#8217;est pas aussi réussie :)</p>

<p>Et il ne faut pas négliger tous les coûts annexes lorsqu&#8217;on installe un cluster de machines : il faut des switchs (redondants) des routeurs (redondants) de quoi faire des backups (redondants), et aligner la force de frappe en fonction de la charge prévue.</p>

<p>Cette souplesse ne vient pas toute seule, il faut développer et/ou des outils de management, pour faciliter le déploiement. Ces <a href="http://developer.amazonwebservices.com/connect/entry.jspa?externalID=1085">deux</a> <a href="http://developer.amazonwebservices.com/connect/entry.jspa?externalID=1403&amp;ref=featured">articles</a> abordent le déploiement rapide.</p>

<p>On peut automatiser encore plus, en allouant ou libérant des machines en fonction de la charge. Les serveurs d&#8217;application, souvent déployés en share-nothing (comme Ruby on Rails) sont lancés facilement (pas d&#8217;état à transférer).
La solution <a href="http://code.google.com/p/scalr/">Scalr</a> propose tout ça. Ça a l&#8217;air super cool. Mais j&#8217;ai pas encore pu tester, l&#8217;appli PHP de contrôle plantent sur mon portable &#8230;</p>

<h2>Un besoin spontané</h2>

<p>Je me suis mis récemment à utiliser <a href="http://www.process-one.net/fr/projects/tsung/">tsung</a>, l&#8217;outil de load testing de <a href="http://www.process-one.net/fr/">Process-One</a>. (oui, ceux qui maintiennent ejabberd)</p>

<p>Un soft erlang/OTP qui permet de rejouer des sessions HTTP préalablement enregistrée avec son <code>recorder</code>. C&#8217;est un proxy qui génére le fichier de configuration.</p>

<p>Tsung permet de faire des &#8220;attaques&#8221; distribuées sur plusieurs machines.</p>

<p>Sexy, mais mon MacBook Pro derrière sa ligne ADSL ne sera jamais aussi violent qu&#8217;un serveur dans un datacenter.</p>

<p>J&#8217;ai donc créé une Amazon Machine Image (à partir d&#8217;une Ubuntu 8.04) qui va exécuter Tsung à partir d&#8217;un fichier passé en paramètre :</p>

<pre><code class="shell">
ec2-run-instances ami-0146xxx -t m1.large -k cle  -f tsung.xml.zip
</code></pre>

<p>Le fichier est décompressé et tsung se lance. Une fois le testing fini, le rapport est généré, et disponible via le navigateur.</p>

<p>Avec la ligne ci-dessus, j&#8217;ai un quadcore avec 8 Go de RAM dans un datacenter d&#8217;Amazon qui travaille pour moi.</p>

<p>Je vais probablement publier cette AMI quand je l&#8217;aurais fignolée, et j&#8217;espère pouvoir la configurer de manière lancer directement un cluster de machines qui vont se répartir la charge.</p>

<h1>Pour conclure</h1>

<p>Ce serait bien si la solution pouvait venir en Europe (S3 y est bien) &#8230; Profitons déjà du dollar faible, et de l&#8217;énorme marché américain :p</p>

<p>Et j&#8217;ai hâte de tester PersistentStorage !</p>      
