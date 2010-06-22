---
layout: post
title: JRuby 1.0 : experiences
---
<p>J&rsquo;ai d&eacute;velopp&eacute; une application Rails pour Ohm Force en interne. Il est un peu trop t&ocirc;t pour parler du contenu de cette application qui aura de toute mani&egrave;re une port&eacute;e limit&eacute;e &#8211; ce sera un extranet, qui devrait &ecirc;tre en soi une exp&eacute;rience int&eacute;ressante. </p>

<p>JRuby : K&eacute;sako ? </p>

<p>Ruby est un langage de script plut&ocirc;t populaire, et largement popularis&eacute; par Ruby On Rails, le framework qui rend le d&eacute;veloppement web amical.
  Il existe plusieurs  <a href="http://fr.wikipedia.org/wiki/Interpr%C3%A8te_(informatique)" title="http://fr.wikipedia.org/wiki/Interpr%C3%A8te_(informatique)">interpr&eacute;teurs</a>  Ruby. Le plus connu est l&rsquo;impl&eacute;mentation de r&eacute;f&eacute;rence, celle qu&rsquo;on appelle la MRI (Matz&rsquo;s Ruby Interpreter ou Matz&rsquo;s Reference Implementation) qui est d&eacute;velopp&eacute;e principalement par Matz, l&rsquo;inventeur de Ruby.  </p>

<p>Depuis quelques temps, la machine virtuelle Java s&rsquo;est enrichie d&rsquo;autres langages que le Java. Le plus connu est probablement  <a href="http://java.sun.com/developer/technicalArticles/JavaLP/groovy/" title="http://java.sun.com/developer/technicalArticles/JavaLP/groovy/">Groovy</a> . Mais  <a href="http://headius.blogspot.com/" title="http://headius.blogspot.com/">certains</a>  se sont mis en t&ecirc;te de d&eacute;velopper une impl&eacute;mentation de Ruby sur la JVM. Ca a bien plu &agrave; Sun qui a embauch&eacute; les devs principaux de JRuby.  </p>

<p>JRuby : Pourquoi ? </p>

<ul>
<li><p>Parce qu&rsquo;on peut le faire !  </p></li>
<li><p>Avec la popularit&eacute; de Java en entreprise, cela permet tr&egrave;s facilement de r&eacute;utiliser des classes et des objets Java directement en Ruby.  </p></li>
<li>Les conteneurs d&rsquo;application Java ont 7 ans d&rsquo;existence, sont fiables et permettent une grosse mont&eacute;e en charge, ce que les techniques d&rsquo;h&eacute;bergement actuelles Rails ne permettent pas avec autant de souplesse.  </li>
</ul>

<p>JRuby : A Ohm Force ? </p>

<p>C&rsquo;est pas un myst&egrave;re pour ceux qui lisent ce blog, mais ca fait un moment que je suis &agrave; fond dans Ruby, et j&rsquo;aimerai bien que mes d&eacute;veloppements futurs soient en Ruby.
 Actuellement &agrave; Ohm Force, on utilise Tomcat 5.5 pour le site web, avec un suite de Frameworks relativement standards : Struts, OJB, ACEGI, une pinc&eacute;e de Spring, Javamail.
 Il est &eacute;vident que si on doit d&eacute;ployer une nouvelle application, si c&rsquo;est une webapp avec des servlets et des JSP, on sait faire en interne. </p>

<p>L&rsquo;appli est maintenant d&eacute;ploy&eacute; sur le serveur de test en attendant une validation (qui finira bien par arriver ;) ) </p>

<p>Et c&rsquo;&eacute;tait facile ? </p>

<p>Oui et non.</p>

<p>Oui : pour le d&eacute;veloppement, c&rsquo;est plut&ocirc;t simple, une fois que JRuby est install&eacute;, il suffit de taper jruby plus ruby dans la console, et ca marche.
 Le d&eacute;marrage est un peu plus long qu&rsquo;avec la MRI, parce qu&rsquo;il faut que la JVM d&eacute;marre, mais une fois en route, les performances semble vraiment similaires. </p>

<p>Pour le d&eacute;ploiement par contre, j&rsquo;ai eu plus de probl&egrave;mes qui m&rsquo;ont co&ucirc;t&eacute; 2 jours et quelques surprises. </p>

<p>La m&eacute;moire ! </p>

<p>La JVM limite la m&eacute;moire disponible. Par d&eacute;faut, le tas est &agrave; 64Mo, c&rsquo;est tr&egrave;s largement insuffisant pour l&rsquo;int&eacute;gration Rails sur Tomcat. Avec 256Mo, ca passe beaucoup mieux :)
 Donc JRuby co&ucirc;te tr&egrave;s cher avec Tomcat. J&rsquo;avais 4 webapps qui tournaient sur 64Mo de RAM sur mon MacBook Pro, donc &eacute;videmment peu de trafic. En ajoutant mon appli sous JRuby, les besoins passent &agrave; 170Mo. Pour une utilisation mono-utilisateur &#8230;. Par contre, mon analyse me laisse &agrave; penser que plus de trafic et une application Rails beaucoup plus complexe n&rsquo;augmentent pas significativement l&rsquo;occupation m&eacute;moire. </p>

<p>Toutefois il faut &ecirc;tre prudent dans le d&eacute;veloppement/portage d&rsquo;applis sous JRuby. La MRI demande au syst&egrave;me autant de m&eacute;moire que n&eacute;cessaire, attaquant la swap si n&eacute;cessaire. JRuby est compl&egrave;tement limit&eacute; par la m&eacute;moire allou&eacute;e &agrave; la JVM, et si &ccedil;a d&eacute;passe, on se prend &ccedil;a : </p>

<pre><code>  java.lang.OutOfMemoryError : Java heap space.
</code></pre>

<p>Et ca fait tomber aussi les autres applis dans le m&ecirc;me conteneur, vu qu&rsquo;elles n&rsquo;ont plus de m&eacute;moire non plus. </p>

<p>Le r&eacute;glage de la JVM :
 Il faut passer les param&egrave;tres suivant &agrave; la JVM pour un tas de taille fixe de 256Mo :
      <code>java -Xms256m -Xmx256m</code></p>

<p>L&rsquo;int&eacute;gration et Tomcat : GoldSpike </p>

<p>Il y a un plugin Rails qui s&rsquo;appelle  <a href="http://www.headius.com/jrubywiki/index.php/Rails_Integration" title="http://www.headius.com/jrubywiki/index.php/Rails_Integration">GoldSpike</a> .<br>
 Ce plugin contient :  </p>

<ul>
<li><p>Des t&acirc;ches Rake pour construire un WAR  </p></li>
<li><p>2 servlets qui servent les fichiers dans public/ et l&rsquo;application Rails proprement dite.  </p></li>
</ul>

<p>L&rsquo;utilisation est assez simple, mais plusieurs probl&egrave;mes se sont pr&eacute;sent&eacute;s.
 GoldSpike embarque la jar deJRuby, sauf qu&rsquo;il utilise la version 0.9.9. J&rsquo;ai du aller modifier dans le code source la version de la Jar :
 Dans le fichier <code>lib/war_config.rb</code> &agrave; la ligne il faut mettre<br>
 <pre><code class="ruby"><br>
 add<em>java</em>library(maven_library('org.jruby', 'jruby-complete', '1.0'))
   </code></pre>
 Ensuite pour ajouter les jar autres n&eacute;cessaires &agrave; mon projet (le driver Postgres et une jar de classes internes &agrave; Ohm Force), il a fallu lire un peu de code source pour comprendre.
 La recette : </p>

<ol>
<li><p>Copier les jar dans lib/java de votre projet Rails  </p></li>
<li><p>Cr&eacute;er un fichier config/war.rb avec pour chaque jar la ligne : </p>

<pre><code class="ruby">
include_library 'postgresql', :version=&gt;'8.0', :locations =&gt; 'lib/java'</code></pre>    </li>
<li><p>rake war:standalone   </p></li>
</ol>

<p>L&rsquo;archive est bien construite il faut l&rsquo;envoyer sur le tomcat. </p>

<p>Finalement j&rsquo;ai d&eacute;compress&eacute; le war, et c&rsquo;est ce que j&rsquo;ai cr&eacute;&eacute; comme projet sur le subversion de boite. Plus simple de d&eacute;ployer, et &ccedil;a me fait une arborescence qui marche &agrave; la fois avec Mongrel et sous Tomcat. </p>

<p>Une fois d&eacute;tect&eacute;e par Tomcat, l&rsquo;archive s&rsquo;installe et jruby est lanc&eacute;. </p>

<p>Mais c&rsquo;est pas fini, il faut que je modifie le sch&eacute;ma de la base. Probl&egrave;me, je n&rsquo;ai pas rake. Du coup je suis oblig&eacute; d&rsquo;installer JRuby sur le serveur avec un set de gem minimum pour que rake db:migrate fonctionne. Faudrait creuser quand m&ecirc;me, je pense qu&rsquo;on peut faire mieux :) </p>

<p>L&rsquo;appli d&eacute;marre ! </p>

<p>C&rsquo;est pas encore fini, sur mon MacBook Pro, il faut une dizaine de secondes pour que les interpr&eacute;teurs ruby soient lanc&eacute;s et que Rails commence &agrave; accepter les requ&ecirc;tes. </p>

<p>Comment &ccedil;a marche ?
  Ce paragraphe fait suite &agrave; une analyse tr&egrave;s superficielle du code source des servlets GoldSpike  .<br>
 Rails n&rsquo;est pas du tout threadsafe. Vraiment pas. Donc ce que fait la servlet, c&rsquo;est charger un certain nombre d&rsquo;interpr&eacute;teurs Ruby qui chargeront chacun une instance de l&rsquo;application Rails. (D&rsquo;o&ugrave; les probl&egrave;mes de m&eacute;moire). Du coup chaque instance Rails est isol&eacute;e. </p>

<p>Affiner la configuration de la webapp.
 Dans le fichier WEB-INF/web.xml, on peut passer des param&egrave;tres &agrave; la servlet pour indiquer le nombre d&rsquo;instance de Rails il d&eacute;marre :
  <pre><code class="html">
 &lt;servlet&gt;
  &lt;servlet-name&gt;rails&lt;/servlet-name&gt;
  &lt;servlet-class&gt;org.jruby.webapp.RailsServlet&lt;/servlet-class&gt;
    &lt;init-param&gt;
        &lt;param-name&gt;jruby.pool.maxActive&lt;/param-name&gt;
        &lt;param-value&gt;4&lt;/param-value&gt;
    &lt;/init-param&gt;
        &lt;init-param&gt;
        &lt;param-name&gt;jruby.pool.maxIdle&lt;/param-name&gt;
        &lt;param-value&gt;4&lt;/param-value&gt;
    &lt;/init-param&gt;
        &lt;init-param&gt;
        &lt;param-name&gt;jruby.pool.minIdle&lt;/param-name&gt;
        &lt;param-value&gt;2&lt;/param-value&gt;
    &lt;/init-param&gt;
      &lt;init-param&gt;
        &lt;param-name&gt;jruby.pool.timeBetweenEvictionRunsMillis
            &lt;/param-name&gt;
        &lt;param-value&gt;10000&lt;/param-value&gt;
    &lt;/init-param&gt;
 &lt;/servlet&gt;
   </code></pre>
 J&rsquo;ai mis les valeurs par d&eacute;faut. Le dernier param&egrave;tre correspond au temps entre deux invocations du thread destructeur d&rsquo;instances. </p>

<p>ActiveRecord-JDBC </p>

<p>Pour se connecter &agrave; la base, JDBC est l&agrave; ! Et la gem activerecord-jdbc permet de se connecter &agrave; une base de donn&eacute;es directement ou via un pool de connexions manag&eacute; par Tomcat. </p>

<p>Pour conclure </p>

<p>Jusque-l&agrave; mes exp&eacute;riences ont &eacute;t&eacute; globalement positives. J&rsquo;ai eu des petits soucis, mais comme &agrave; chaque fois lorsqu&rsquo;on teste une nouvelle techno. J&rsquo;attends &eacute;videmment les versions &agrave; venir de JRuby qui vont maintenant se focaliser sur la performance &#8211; JRuby est un interpr&eacute;teur valide de Ruby 1.8.5.
 Pour le passage en production, je m&rsquo;inqui&egrave;terai juste de la consommation m&eacute;moire. </p>

<p>Pas de fuites toutefois. La JVM reste stable autour de 170Mo depuis 4 jours et 17h. </p>

<p>[MAJ : Je ne poste plus trop sur le sujet &#8211; &ccedil;a marche bien et pas de probl&egrave;me.]</p>      
