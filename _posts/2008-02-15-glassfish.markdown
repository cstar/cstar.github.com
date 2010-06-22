---
layout: post
title: GlassFish
---
<p>Ça y est, le serveur d&#8217;application Ohm Force est passé sous GlassFish 2.</p>

<p>Maintenant le serveur est organisé avec :</p>

<ul>
<li><a href="http://nginx.net/">nginx</a> en frontal, configuration simple et courte,</li>
<li>PHP en FCGI pour le site vitrine de <a href="http://www.gforcesoftware.com">GForceSoftware</a>,</li>
<li><a href="https://glassfish.dev.java.net/">GlassFish</a> pour l&#8217;hébergement d&#8217;Ohm Force, du site magasin de GForce (c&#8217;est le même code) (des applis Struts/OJB/Spring) et du site de VDM, une appli jRuby on Rails.</li>
<li>le tout connecté à un <a href="http://www.postgresql.org/">PostgreSQL</a> 8.</li>
</ul>

<p>Avant le setup était globalement le même, mais avec <a href="http://tomcat.apache.org/">Tomcat</a> 6.</p>

<h1>GlassFish</h1>

<p>Plutôt agréable à utiliser. C&#8217;est une grosse machinerie qui se laisse manipuler assez facilement. Toutefois la doc est <em>vraiment</em> volumineuse, et rien que chercher les infos dedans va prendre du temps. </p>

<p>Au cours du &#8220;portage&#8221; depuis Tomcat, j&#8217;ai utilisé 2-3 trucs :</p>

<blockquote>
    <p><code>touch .reload</code></p>
</blockquote>

<p>Ca force GlassFish à recharger la webapp, si c&#8217;est fait à la racine du répertoire de celle-ci. Il faut avoir configurer GlassFish pour autoriser l&#8217;autoriser.</p>

<p>C&#8217;est plus agréable au final que la méthode automatique de Tomcat. On a le droit de choisir quand ça arrive :)</p>

<p>Par contre ce redéploiement change la conf des webapp dans le <code>domain.xml</code></p>

<blockquote>
    <p><code>asadmin set server.http-service.virtual-server.server.property.allowLinking=true</code></p>
</blockquote>

<p>Permet d&#8217;utiliser des liens symboliques dans les webapps servies par le serveur virtuel <code>server</code>.</p>

<blockquote>
    <p><code>~/.asadminpass</code> et <code>~/.asadmintruststore</code></p>
</blockquote>

<p>Ces fichiers stockent les identifiants pour administrer GlassFish via <code>asadmin</code>.</p>

<blockquote>
    <p><code>asadmin deploydir &lt;i&gt;rep&lt;/i&gt;</code></p>
</blockquote>

<p>Déploie ou redéploie la webapp dans le répertoire <code>rep</code>.</p>

<blockquote>
    <p><code>$GLASSFISH_ROOT/domains/domain1/config/domain.xml</code> </p>
</blockquote>

<p>Le fichier de configuration, celui modifié par l&#8217;interface d&#8217;admin. Evidemment, il faut redémarrer le serveur après une modification.</p>

<blockquote>
    <p><code>$GLASSFISH_ROOT/domains/domain1/lib/</code></p>
</blockquote>

<p>Les jars placées ici sont accessibles dans tous les classloaders du domaine. Pour pouvoir utiliser les datasources avec PostgreSQL, on place la jar du driver dans le sous-repertoire <code>ext/</code> (et pas <code>databases/</code>!)</p>

<h1>Attention &#8230;</h1>

<p>GlassFish a tendance à cacher les fichiers des webapps <code>$GLASSFISH_ROOT/domains/domain1/generated</code>.</p>

<p>Faire un rsync entre deux serveurs pour synchroniser le répertoire de glassfish, c&#8217;est une mauvaise, très mauvaise idée. Les webapps ont récupéré la configuration de l&#8217;autre serveur, et les droits.</p>

<h1>Les trucs biens</h1>

<p>GlassFish semble vraiment plus solide que Tomcat. Il fait tourner les 3 webapp sans problème, alors que Tomcat ne supportait pas d&#8217;avoir l&#8217;appli jRuby on Rails, et crashait avec un vilain problème de mémoire.</p>

<p>L&#8217;interface d&#8217;admin &#8230; vraiment top. Quel changement ! J&#8217;utilisais Probe sur Tomcat, mais c&#8217;est pas aussi bien :)</p>

<h1>Les trucs louches</h1>

<p>Au démarrage, la présence de l&#8217;appli jRuby on Rails fait pomper au serveur 99% des ressources pendant plusieurs minutes. Je n&#8217;ai pas encore réussi à comprendre pourquoi &#8230; surtout qu&#8217;après on redescend à une charge tout à fait raisonnable. Mais j&#8217;aimerai comprendre &#8230;</p>      
