---
layout: post
title: Erlang : De l'infrastructure d'internet
---
<p>Si vous suivez ce blog, ces derniers temps vous aurez vu <a href="http://www.cestari.info/erlang">quelques posts sur Erlang</a>, le langage utilis&eacute; par Ericsson pour son mat&eacute;riel t&eacute;l&eacute;phonique et utilis&eacute; pour l&#8217;impl&eacute;mentation la plus performante du protocole de messagerie XMPP.</p>

<p>L&#8217;id&eacute;e de ce post m&#8217;est tomb&eacute;e dessus assez rapidement, et ces derniers temps, j&#8217;ai l&#8217;impression de voir beaucoup de probl&eacute;matiques expos&eacute;es dans d&#8217;autres langages qui sont r&eacute;solue <i>de facto</i> par l&#8217;architecture du langage.</p>

<p>Deux exemples de ce mois-ci :</p>

<ul>
<li><p><a href="http://blogs.sun.com/rvs/entry/the_problem_with_threads">Le probl&egrave;me avec les threads</a>.</p></li>
<li><p><a href="http://www.infoq.com/news/2007/08/scalability-patterns">Nouveau patterns et middleware pour une scalabilit&eacute; lin&eacute;aire</a></p></li>
</ul>

<h1>Ad&eacute;quation avec l&#8217;orientation du hardware</h1>

<p>Jusqu&#8217;&agrave; r&eacute;cemment les d&eacute;veloppeurs pouvaient se cacher derri&egrave;re la loi de Moore pour garantir que leur application fonctionnerait toujours mieux. Si elle est un peu lente &agrave; sa sortie, dans 1 an, elle ira beaucoup plus vite, parce que le hardware aura (presque) doubl&eacute; au niveau des performances. Mais c&#8217;est fini. La course &agrave; la puissance a lieu en multipliant le nombre de coeurs sur un processeur. Puissance qu&#8217;on ne peut r&eacute;cup&eacute;rer que si on d&eacute;veloppe en parall&eacute;lisant notre code. Ce qui pose des probl&egrave;mes dans tous les domaines de l&#8217;informatique. En particulier les jeux. Comme le dit Tim Sweeney, le lead developer d&#8217;Unreal :</p>

<p>
&#8220;Implementing a multithreaded system requires two to three times the development and testing effort of implementing a comparable non-multithreaded system, so it&#8217;s vital that developers focus on self-contained systems that offer the highest effort-to-reward ratio.&#8221;
</p>

<p>Pour ceux qui ne lisent pas l&#8217;anglais, il faut 2 &agrave; 3 fois plus d&#8217;efforts pour mettre en place un syst&egrave;me multithread. Les jeux ne sont pas r&eacute;ellement le point de ce post, mais je veux mettre le doigt sur la difficult&eacute; de maximiser l&#8217;utilisation de la puissance des processeurs actuels (dual-core ou plus).</p>

<p>A  un niveau plus &eacute;lev&eacute;, l&#8217;approche utilis&eacute;e par Google et par tous les autres depuis 2000 n&#8217;est plus d&#8217;acheter un serveur incroyablement puissant (et cher), mais plut&ocirc;t de prendre des serveurs peu chers (relativement peu puissants). Si j&#8217;ai besoin de plus de puissance, j&#8217;ajoute des serveurs. On peut m&ecirc;me virtualiser compl&egrave;tement les serveurs en allant chez Amazon avec leur service <a href="http://www.amazon.com/b/ref=sc_fe_l_2/104-9647351-5691958?ie=UTF8&amp;node=201590011&amp;no=3435361&amp;me=A36L942TSJ2AJA">Elastic Computing Cloud (EC2)</a>, qui permet d&#8217;obtenir une puissance de calcul virtuellement illimit&eacute;e en parall&eacute;lisant un grand nombre d&#8217;instance.</p>

<h1>La grande orientation !</h1>

<p>La solution propos&eacute;e dans les deux articles pr&eacute;c&eacute;dent est toujours la m&ecirc;me :</p>

<ul>
<li><p>On arr&ecirc;te avec les threads et la m&eacute;moire partag&eacute;e. Du coup si les unit&eacute;s de traitement ne partagent rien, on est plus oblig&eacute; de synchroniser l&#8217;acc&egrave;s.</p></li>
<li><p>La transmission d&#8217;information se fait par passage de message, IPC-style.</p></li>
</ul>

<p>C&#8217;est tr&egrave;s exactement le sch&eacute;ma propos&eacute; par l&#8217;article que je citait plus haut :
<a href="http://www.infoq.com/news/2007/08/scalability-patterns">Nouveau patterns et middleware pour une scalabilit&eacute; lin&eacute;aire</a>.</p>

<p>Les avantages de cette approche sont bien d&eacute;taill&eacute;es dans <a href="http://armstrongonsoftware.blogspot.com/2006/09/why-i-dont-like-shared-memory.html">l&#8217;article de Joe Armstrong</a> l&#8217;architecte et concepteur d&#8217;Erlang.</p>

<p>La scalabilit&eacute; par les applications Erlang est quasiment lin&eacute;aire (J&#8217;ai un CPU, la puissance totale vaut 1, j&#8217;ajoute un autre CPU la puissance totale vaut presque 2, et non pas 1,66 avec d&#8217;autres architectures qui perdent de temps en synchronisation)</p>

<p>L&#8217;exemple donn&eacute; <a href="http://eric_rollins.home.mindspring.com/erlangAnt.html">ici</a>, une simulation de colonie de fourmis, le montre plut&ocirc;t bien.
On note que les performances d&#8217;Erlang sont largement inf&eacute;rieures &agrave; Haskell, mais lorsque l&#8217;application passe d&#8217;un simple core &agrave; un dual core, le temps d&#8217;ex&eacute;cution est divis&eacute; par deux.</p>

<h1>Le langage est facile</h1>

<p>Le langage est facile, oui, une fois qu&#8217;on saisi les grands concepts du langage, on comprend rapidement le code source. J&#8217;ai pass&eacute; quelques temps &agrave; parcourir le code source <a href="http://svn.process-one.net/ejabberd/trunk/">d&#8217;ejabberd</a>, et on rentre dedans <em>tr&egrave;s</em> facilement, malgr&eacute; le peu de commentaires dans le code.
Evidemment, le seul m&eacute;rite ne revient pas uniquement au langage, mais &eacute;videmment aux d&eacute;veloppeurs d&#8217;ejabberd, qui ont une base de code tr&egrave;s claire et dont le style m&#8217;apprend beaucoup sur le langage.</p>

<p>Je <a href="http://www.cestari.info/2007/7/21/vers-erlang-via-xmpp">remarquai</a> la derni&egrave;re fois que le code d&#8217;ejabberd est 3 fois plus compact que le code d&#8217;OpenFire. Il faut remarquer toutefois que le code d&#8217;OpenFire est bien mieux document&eacute; :)</p>

<h1>Mais le langage n&#8217;est pas orient&eacute; objet ?</h1>

<p>Bien que Joe Armstrong s&#8217;en d&eacute;fende, il est orient&eacute; objet, en utilisant le mod&egrave;le de l&#8217;Acteur, avec des objets (les processus) qui s&#8217;envoient des messages.</p>

<p>Certes, il n&#8217;y a pas d&#8217;h&eacute;ritage de classe et autres habitudes architecturales de l&#8217;orient&eacute; objet, mais c&#8217;est de l&#8217;objet. Le <a href="http://www.cincomsmalltalk.com/userblogs/ralph/blogView?showComments=true&amp;printTitle=Erlang,_the_next_Java&amp;entry=3364027251">post de Ralph E. Johnson</a> (oui, l&#8217;un des quatre du <a href="http://en.wikipedia.org/wiki/Gang_of_Four_%28software%29">Gang of Four</a>) l&#8217;explique avec beaucoup de d&eacute;tails.</p>

<p>Au passage, Johnson fait le calcul de la fiabilit&eacute; des neuf 9 (99,999999% d&#8217;<i>uptime</i>) obtenu par le AXD 301 d&#8217;Ericsson (celui aux 1,7 millions de ligne de code d&#8217;erlang). C&#8217;est 1 seconde de downtime tous les 30 ans !</p>

<p>Et de toute mani&egrave;re, le faisait remarquer<a href="http://azaidi.blogspot.com/2007/04/zen-and-art-of-functional-programming.html"> A. Zaidi sur son blog</a>, faire de l&#8217;objet &agrave; tout prix, en particulier dans le d&eacute;veloppement d&#8217;application web (ou plus g&eacute;n&eacute;ralement de serveurs bas&eacute; sur des protocoles texte, comme tous les protocoles internet), est-ce tellement pertinent ?
Finalement on r&eacute;cup&egrave;re du texte, qu&#8217;on case dans des objets, et qu&#8217;on stocke ensuite dans une base de donn&eacute;e relationnel, il faut donc re-<i>marshaller</i> les donn&eacute;es pour qu&#8217;elles puissent rentrer. Typiquement le genre de truc qui contribue au r&eacute;chauffement plan&eacute;taire.</p>

<p>NB : Ok, c&#8217;est un peu extr&ecirc;me. J&#8217;appr&eacute;cie certes le mod&egrave;le objet, mais lisez le post de A. Zaidi : <a href="http://azaidi.blogspot.com/2007/04/zen-and-art-of-functional-programming.html">Zen and the Art of Functional Programming</a>.</p>

<h1>Best Kept Secret ?</h1>

<p>Erlang n&#8217;a pas le <i>mindshare</i> de Java et de Ruby et de leurs frameworks phare respectif.</p>

<p>Toutefois, ce langage a r&eacute;solu dans son coin, l&agrave;-bas, dans le nord, il y a dix ans, les probl&egrave;mes de mont&eacute;e en charge qu&#8217;affronte les grandes applications d&#8217;aujourd&#8217;hui.</p>

<p>La publication de Programming Erlang chez <a href="http://www.pragmaticprogrammer.com/">Pragmatic Programmer</a> semble &ecirc;tre un succ&egrave;s. Et PragDave fait des <a href="http://pragdave.pragprog.com/pragdave/2007/04/a_first_erlang_.html">tutoriaux</a> sur son <a href="http://pragdave.pragprog.com/pragdave/2007/04/adding_concurre.html">blog</a>.</p>

<p>Il faut donc s&#8217;attendre &agrave; un accroissement du nombre de d&eacute;veloppements dans ce langage.
Il y a d&eacute;j&agrave; une premi&egrave;re application publique d&eacute;velopp&eacute;e avec le framework <a href="http://erlyweb.org/">ErlyWeb</a> dont je parlais ici : <a href="http://beerriot.com/">http://beerriot.com/</a> qui fonctionne aussi en application sur <a href="http://www.facebook.com/">FaceBook</a>.</p>

<p><a href="http://blog.beerriot.com/">Le blog</a> de ce dernier est int&eacute;ressant, en particulier <a href="http://blog.beerriot.com/2007/06/09/erlang-observations/">Erlang Observations</a> et <a href="http://blog.beerriot.com/2007/07/26/facebook-development-in-erlang/">FaceBook Development (in Erlang)</a> sur le sujet.</p>      
