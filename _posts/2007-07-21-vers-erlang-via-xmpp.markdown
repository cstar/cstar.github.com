---
layout: post
title: Vers Erlang via XMPP
---
<p><a href="http://www.xmpp.org/" title="http://www.xmpp.org/">XMPP</a> , n&eacute; Jabber, m&rsquo;occupe depuis maintenant quelques mois.<br>
 Ce protocole s&rsquo;occupe de la messagerie instantan&eacute;e, et se cache derri&egrave;re le r&eacute;seau GoogleTalk.
 Une de ses grosses forces est l&rsquo;ouverture et l&rsquo;interop&eacute;rabilit&eacute; entre les serveurs XMPP.
  Il faut imaginer le r&eacute;seau XMPP comme le r&eacute;seau de routage des emails. L&rsquo;utilisateur est indentifi&eacute; via son jid (Jabber ID) :  <a href="mailto:eric@cestari.info" title="mailto:eric@cestari.info">eric@cestari.info</a> . Ca ressemble &agrave; une adresse mail, et pour cause. Un ami, Olivier, est sur GoogleTalk. Son jid est  <a href="mailto:of@gmail.com" title="mailto:of@gmail.com">of@gmail.com</a> . Lorsque je souhaite envoyer un message, il est rout&eacute; par mon serveur (cestari.info) vers le serveur gmail.com qui d&eacute;livre enfin le message &agrave; Olivier.  </p>

<p>Int&eacute;gr&eacute; aussi, le syst&egrave;me de chatroom, de publication/abonnement, annuaire, etc. </p>

<p>Bref, le protocole de messagerie instantan&eacute;e qui finira par gagner :).
 Je voulais installer un serveur XMPP sur mon serveur, pour jouer avec et &eacute;crire une version custom du module MUC (multi-user chat, les chatrooms).
 Parmi les serveurs XMPP les plus r&eacute;pandus, j&rsquo;en ai test&eacute; 2 et gard&eacute; 1.
 <a href="http://www.igniterealtime.org/projects/openfire/index.jsp" title="http://www.igniterealtime.org/projects/openfire/index.jsp">OpenFire</a>  : Ecrit en Java, administr&eacute; via http. Respecte les principales XEP (extensions de XMPP). Dimensionn&eacute; pour 5000 utilisateurs simultan&eacute;s, avec la possibilit&eacute; d&rsquo;utiliser des connecteurs pour augmenter la capacit&eacute;e.<br>
 J&rsquo;ai eu un probl&egrave;me de connexion S2S (Server to Server) vers d&rsquo;autres serveurs comme GoogleTalk. J&rsquo;ai arr&ecirc;ter de creuser dessus, bien que Java soit le langage que je connaisse le mieux.
 <a href="http://www.process-one.net/fr/projects/ejabberd/" title="http://www.process-one.net/fr/projects/ejabberd/">ejabberd</a>  : Ecrit en Erlang (on y arrive !), tr&egrave;s bonne couverture du protocole et de ses extensions. Et ensuite, les trucs mortels : </p>

<ul>
<li><p>Mise en cluster : J&rsquo;ai besoin de plus de puissance ? j&rsquo;ajoute un serveur avec une nouvelle instance d&rsquo;ejabberd que je connecte en 30 secondes, sur la premi&egrave;re. </p></li>
<li><p>Possibilit&eacute; de mettre &agrave; jour le code sans interruption : Je compile, je me connecte &agrave; la console du serveur, je lui dit que le code d&rsquo;un module a &eacute;t&eacute; mis &agrave; jour, et les requ&ecirc;tes suivantes seront trait&eacute;s par la nouvelle version. </p></li>
<li><p>Scalabilit&eacute; incroyable : on peut lui balancer des utilisateurs &#8230; Il existe des installations d&rsquo;ejabberd qui g&egrave;rent  des centaines de milliers d&rsquo;utilisateurs et des dizaines de milliers d&rsquo;utilisateurs simultan&eacute;ments. Un simple PIII 1,5GHz g&egrave;re 2000 messages par seconde et 7000 utilisateurs connect&eacute;s ! </p></li>
</ul>

<p>Toutes ses fonctionnalit&eacute;s arrivent avec un co&ucirc;t. Tout est &eacute;crit en  <a href="http://erlang.org/" title="http://erlang.org/">erlang</a> . Langage invent&eacute; par les su&eacute;dois d&rsquo;Ericsson, pour avoir un outil adapt&eacute; au d&eacute;veloppement de leurs produits t&eacute;l&eacute;com. Ce  <a href="http://video.google.com/videoplay?docid=-5830318882717959520" title="http://video.google.com/videoplay?docid=-5830318882717959520">petit film ind&eacute;pendant</a>  tr&egrave;s cheesy pr&eacute;sente les avantages d&rsquo;Erlang. Avant de cliquer sur ce lien, n&rsquo;oubliez pas qu&rsquo;il s&rsquo;agit des concepteurs du langage eux-m&ecirc;me qui s&rsquo;occupent de la pr&eacute;sentation.  </p>

<p>Je regarde un peu le code source d&rsquo;ejabberd, et je comprends initialement que dalle.  <a href="http://svn.process-one.net/ejabberd/trunk/src/mod_muc/mod_muc_room.erl" title="http://svn.process-one.net/ejabberd/trunk/src/mod_muc/mod_muc_room.erl">Regardez plut&ocirc;t.</a>    </p>

<p>Interlude Java &#8230;. </p>

<p>Pendant la phase de r&eacute;flexion, je m&rsquo;oriente vers des bots XMPP qui r&eacute;pondrait aux requ&ecirc;tes. J&rsquo;utilise la librairie  <a href="http://www.igniterealtime.org/projects/smack/index.jsp" title="http://www.igniterealtime.org/projects/smack/index.jsp">Smack</a> , par Jive Software. (oui ceux derri&egrave;re OpenFire !). C&rsquo;est du Java, je connais. En quelques heures et 300 lignes de code j&rsquo;ai deux bots qui se connectent &agrave; mon serveur, qui causent entre eux et g&egrave;rent des chatrooms.  </p>

<p>Mais ca ne me pla&icirc;t pas. M&ecirc;me si l&rsquo;informatique distribu&eacute;, c&rsquo;est toujours marrant, le c&ocirc;t&eacute; myst&eacute;rieux et &ldquo;best kept secret&rdquo; m&rsquo;intrigue. </p>

<p>En effet, les avantages d&rsquo;ejabberd sont directement des avantages du langage et de l&rsquo;environnement Erlang. Il fonctionne sur une machine virtuelle comme Java. </p>

<p>Du coup, je creuse. Je tombe sur des blogs :  <a href="http://wagerlabs.com/" title="http://wagerlabs.com/">Tenerife Skunkworks</a> ,  <a href="http://armstrongonsoftware.blogspot.com/" title="http://armstrongonsoftware.blogspot.com/">Joel Armstrong</a>  (l&rsquo;un des concepteurs, justement) et  <a href="http://yarivsblog.com/" title="http://yarivsblog.com/">Yariv&rsquo;s Blog</a> , qui parlent causent erlang.  </p>

<p>Des PDF int&eacute;ressants :
 <a href="http://www1.erlang.org/download/getting_started-5.4.pdf" title="http://www1.erlang.org/download/getting_started-5.4.pdf">Getting started with Erlang</a>
 <a href="http://www.sics.se/~joe/thesis/" title="http://www.sics.se/~joe/thesis/">La th&egrave;se de Joel Armstrong</a> </p>

<p>Et comme par hasard, ce dernier vient de publier chez  <a href="http://www.pragmaticprogrammer.com/" title="http://www.pragmaticprogrammer.com/">Pragmatic Programmers</a> ,  <a href="http://www.pragmaticprogrammer.com/titles/jaerlang/index.html" title="http://www.pragmaticprogrammer.com/titles/jaerlang/index.html">Programming Erlang</a> .  </p>

<p>J&rsquo;ach&egrave;te le PDF (des bouts sont dispos sur la page du livre). Pas le temps d&rsquo;attendre la livraison, et avec un dollar aussi bas &#8230; c&rsquo;est cadeau. </p>

<p>Et finalement, petit &agrave; petit, le code source de  <a href="http://svn.process-one.net/ejabberd/trunk/src/" title="http://svn.process-one.net/ejabberd/trunk/src/">ejabberd</a>  commence &agrave; prendre sens.  </p>

<p>Apr&egrave;s 2 jours de travail, et une dizaine de programmes de test, et une premi&egrave;re bidouille sur un module d&rsquo;ejabberd, je sens que je  peux vous parler de mani&egrave;re plus inform&eacute;e de ce langage. </p>

<p>Les caract&eacute;risques notable d&rsquo;Erlang : </p>

<ul>
<li>Langage fonctionnel, comme Lisp et OCaml </li>
<li>Donc largement bas&eacute; sur les closures et fonctions anonymes, ce qui rend la programmation &eacute;v&eacute;nementielle tr&egrave;s pratique &agrave; utiliser. </li>
<li>La communication se fait uniquement par passage de message d&rsquo;un processus &agrave; l&rsquo;autre, il n&rsquo;y a pas d&rsquo;&eacute;tat global </li>
<li>Les processus sont compl&egrave;tement isol&eacute;s, donc pas de synchronisation &agrave; faire. Chaque processus a une boite &agrave; message qu&rsquo;il rel&egrave;ve avec  <code>receive</code>.   Les processus sur des noeuds (instances) s&eacute;par&eacute;s peuvent communiquer tr&egrave;s simplement.  </li>
<li>La cr&eacute;ation d&rsquo;un processus, et le changement de contexte ne co&ucirc;tent rien. Un petit script qui va cr&eacute;er 20000 processus cr&eacute;era chacun d&rsquo;eux en 2,5 ms. </li>
<li>Le pattern matching et les variantes de fonctions permettent d&rsquo;exprimer la gestion des cas particuliers : </li>
</ul>

<pre><code class="erlang">
 -module(testblog).
 -export([hello/1]).

 hello({hello, eric}) -&gt;
     io:format("Bonjour Eric~n"),
     ok;
 hello({hello, Name}) -&gt;
     io:format("Bonjour, ~w~n", [Name]),
     ok;

 hello({Action, Name}) -&gt;
     io:format("action : ~p pour : ~p~n", [Action, Name]),
     ok.
</code></pre>

<p>Le tuple (le truc entre {}) pass&eacute; en param&egrave;tre sera test&eacute; sur chacun des prototypes en partant du haut. Les mots commen&ccedil;ant par une minuscule sont des atomes (utilis&eacute;s entre autres comme cl&eacute;s. hello represente un truc qui s&rsquo;appelle hello et qui peut &ecirc;tre identifi&eacute; par hello.) Les mots commen&ccedil;ant par une majuscule sont des variables. </p>

<p>Donc : </p>

<ul>
<li><code>testblog:hello({hello, eric})</code> appelera la premi&egrave;re version. </li>
<li><code>testblog:hello({hello, marc})</code> ne sera pas match&eacute; par la premi&egrave;re version, car marc est diff&eacute;rent de eric. On teste sur la deuxi&egrave;me. Le premier &eacute;l&eacute;ment est l&rsquo;atome hello, et le deuxi&egrave;me est une variable, que je peux matcher avec n&rsquo;importe quoi (donc marc). Il n&rsquo;y a pas d&rsquo;autres &eacute;l&eacute;ments dans le tuple, donc cette version de la fonction convient. C&rsquo;est donc celle-ci qui est ex&eacute;cut&eacute;. </li>
<li><code>testblog:hello({bonjour, eric})</code>. Seule la troisi&egrave;me version de la fonction accepte un premier param&egrave;tre diff&eacute;rent de 0. </li>
</ul>

<p>Enfin bref, ce billet n&rsquo;est pas un tutorial sur Erlang, c&rsquo;est un truc qui peut vous donner envie de l&rsquo;utiliser. </p>

<p>Une fois qu&rsquo;on sait lire la syntaxe du langage (ce qui ne prend que quelques heures), on commence &agrave; appr&eacute;cier la clart&eacute; compacte qu&rsquo;elle engendre. </p>

<p>Du coup, je me suis livr&eacute; &agrave; une &eacute;tude non-scientifique sur la complexit&eacute; relative d&rsquo;un gros projet entre Java et Erlang, en regardant le nombre de lignes entre ejabberd et OpenFire.
  Alors que OpenFire compte &agrave; peu pr&egrave;s  <a href="http://www.igniterealtime.org/fisheye/browse/svn-org/openfire" title="http://www.igniterealtime.org/fisheye/browse/svn-org/openfire">200 000 lignes</a> , ejabberd n&rsquo;en compte que  <a href="https://forge.process-one.net/browse/ejabberd" title="https://forge.process-one.net/browse/ejabberd">80 000</a> , avec plus de fonctionnalit&eacute;s.  </p>

<p>Damn ! </p>

<p>Un autre exemple, comparaison des performances entre  <a href="http://httpd.apache.org/" title="http://httpd.apache.org/">Apache</a>  et  <a href="http://yaws.hyber.org/" title="http://yaws.hyber.org/">yaws</a>  (serveur web &eacute;crit en erlang). Le  <a href="http://www.sics.se/~joe/apachevsyaws.html" title="http://www.sics.se/~joe/apachevsyaws.html">benchmark</a>  s&rsquo;attache au nombre de connexions simultan&eacute;e.<br>
 Apache l&acirc;che autour de 4000 connexions simultan&eacute;es. Yaws fonctionne toujours &agrave; 80 000 connexions simultan&eacute;es. </p>

<p>Duh ! </p>

<p>Pour d&eacute;marrer,  <a href="http://www.process-one.net/en/" title="http://www.process-one.net/en/">Process One,</a>  le sponsor de ejabberd maintient  <a href="http://cean.process-one.net/" title="http://cean.process-one.net/">CEAN</a>  (Comprehensive Erlang Archive Network), le CPAN d&rsquo;Erlang.  <a href="http://cean.process-one.net/download/" title="http://cean.process-one.net/download/">Avec des packages pour d&eacute;marrer</a> .  </p>

<p>J&rsquo;en re-parlerais tr&egrave;s bient&ocirc;t. Pour l&rsquo;heure, il est samedi, et Martin veut jouer avec son papa. </p>      
