---
layout: post
title: SVN et PHP, attention !
---
<h1>PHP</h1>

<p>Le site <a href="http://www.gforcesoftware.com/">GForceSoftware</a> nouveau est arrivé.</p>

<p>Il est hébergé sur le serveur d&#8217;Ohm Force dont j&#8217;ai la charge ; c&#8217;était une expérience intéressante, car je devait mixer une application à base de Servlets avec une application PHP, derrière le même domaine.</p>

<p>En frontal, il y a <a href="http://nginx.net/">nginx</a>, le serveur http russe léger et qui fonce.</p>

<p>Pendant 24 heures, il y avait un trou de sécurité flagrant, qui permettait de récupérer le code source des scripts php, à cause de svn. (je me suis tapé sur la tête quand je m&#8217;en suis rendu compte. Heureusement en analysant les logs, personne n&#8217;a eu l&#8217;idée de l&#8217;exploiter).</p>

<h1>SVN</h1>

<p>Le déploiement sur la production, c&#8217;est un checkout des scripts. C&#8217;est à dire que tous les répertoires ont un répertoire <code>.svn</code> qui contient les métadonnées sur les fichiers du répertoires ainsi qu&#8217;un cache contenant les fichiers originaux tels qu&#8217;ils sont stockés sur le repository svn.</p>

<p>Les fichiers originaux sont identifiés par une extension svn-base.</p>

<h1>La faille</h1>

<p>Or la configuration du serveur est d&#8217;envoyer le contenu tel quel pour une extension inconnue.</p>

<p>Du coup, on pouvait récupérer le code de la page d&#8217;index avec ce lien :</p>

<blockquote>
    <p>http://www.gforcesoftware.com/.svn/text-base/index.php.svn-base</p>
</blockquote>

<p>Pas glop.</p>

<h1>La correction</h1>

<p>Donc pensez bien à ajouter la configuration suivante dans votre serveur web (ici pour nginx) :</p>

<pre><code>
location ~ .svn/ {
        deny all;
    }
</code></pre>

<h1>La conclusion</h1>

<p>C&#8217;est un des trucs qui me plaît le moins avec PHP, le fait que l&#8217;arborescence détermine l&#8217;URL, je préfère un MVC un peu plus abstrait comme avec les servlets ou avec Rails. On a beaucoup plus de souplesse, sans s&#8217;encombrer de rewrite rules trop complexes.</p>

<p>Vu que pour le MVC, toutes les URLs sont masqués derrière le contrôleur l&#8217;utilisateur ne sait même pas quel est l&#8217;arborescence système.</p>

<p>Sur le site Ohm Force, les JSP elles-même sont cachés dans le répertoire WEB-INF dont le contenu n&#8217;est pas publié.</p>      
