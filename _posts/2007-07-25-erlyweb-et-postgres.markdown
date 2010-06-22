---
layout: post
title: ErlyWeb et Postgres
---
<p><strong>faut que je corrige le probl&egrave;me des &gt; qui devient de &amp;gt ;. Dans un premier temps faites le vous m&ecirc;me.</strong></p>

<p>Aujourd'hui, j'ai test&eacute; <a href="http://erlyweb.org/">ErlyWeb</a>, le framework web &eacute;crit en Erlang qui reprend un certain nombres d'id&eacute;es &agrave; Rails.</p>

<p>N'ayant pas MySQL d'install&eacute; sur ma machine, mais ayant PostgreSQL, je d&eacute;cide de faire tourner l'application de ce <a href="http://yarivsblog.com/articles/2006/10/27/%20introducing-erlyweb-the-erlang-twist-on-web-framworks/">tutorial de Yariv, l'auteur d'erlyweb</a>.</p>

<p>Mais plut&ocirc;t que de faire un site de musicien, je fais un moteur de blog. Plus simple encore que le mod&egrave;le de donn&eacute;e propos&eacute; par Yariv.</p>

<p>Et ce n'est pas trivial.</p>

<p>Tout d'abord, le driver PostgreSQL fourni est celui d'Erlang Consulting. Il fonctionne comme une application OTP. Donc il lui faut un fichier psql.app dans le chemin de recherche.</p>

<p>Un mod&egrave;le est l&agrave; : <code>erlyweb-0.6/src/erlang-psql-driver/psql.app.src</code></p>

<h2>ATTENTION</h2>

<p>Avant de continuer il faut absolument que l'authentification de postgresql se fasse en MD5.
C'est &agrave; dire que dans le fichier <code>pg_hba.conf</code>, il doit y avoir au moins la ligne suivante :</p>

<pre><code>
host   all         all         127.0.0.1/32          md5
</code></pre>

<p>Sinon le driver ne d&eacute;marre pas et bloque m&ecirc;me la console <code>erl</code>.</p>

<h2>Un petit script de d&eacute;marrage</h2>

<p>Je me suis inspir&eacute; de ce <a href="http://progexpr.blogspot.com/2006/12/erlyweb-blog-tutorial.html">tutorial</a>.</p>

<p>A la racine de votre projet erlyweb, cr&eacute;ez un fichier <code>start.erl</code>  : </p>

<pre><code class="erlang">
-module(start).
-export([boot/0, boot/1]).
-define(P, "/Users/cstar/devs/erlang/blog").

boot() -&gt;
    boot(true).
boot(false) -&gt;
    compile();
boot(true) -&gt;
    pgsql_start(),
    compile().

pgsql_start() -&gt;
    code:add_pathz(?P ++ "/ebin"),
    application:start(psql),
    erlydb:start(psql).

compile() -&gt;
    erlyweb:compile(?P, [{erlydb_driver, psql}]).
</code></pre>

<h2>On lance le bazar</h2>

<p>Dans le terminal : <code>yaws -i</code>
et dans la console :</p>

<pre><code class="erlang">
1&gt; c(start).
{ok,start}
2&gt; start:boot().
debug:erlyweb_compile:340: Compiling Erlang file "blog_app_controller"
debug:erlyweb_compile:335: Compiling ErlTL file "html_container_view"
debug:erlyweb_compile:340: Compiling Erlang file "html_container_controller"
debug:erlyweb_compile:340: Compiling Erlang file "entries_view"
debug:erlyweb_compile:335: Compiling ErlTL file "entries_show"
debug:erlyweb_compile:340: Compiling Erlang file "entries_controller"
debug:erlyweb_compile:340: Compiling Erlang file "entries"
debug:erlyweb_compile:104: Generating ErlyDB code for models: "entries.erl "
{ok,{{2007,7,25},{19,1,20}}}
</code></pre>

<p>Tout va bien ; C'est parti !
On pointe sur http://localhost:4000/blog/entries/ (&agrave; ajuster selon la config de Yaws)</p>

<h2>Ca marche p&ocirc; !</h2>

<p>Postgresql se plaint de la syntaxe de LIMIT X,Y. Lui il veut LIMIT Y OFFSET X.
Ouvrez un autre terminal.
Rapidement le probl&egrave;me est identifi&eacute; dans la ligne 309 du fichier <code>erlyweb-0.6/src/erlsql/erlsql.erl</code>. Il faut la remplacer par la ligne suivante :</p>

<pre><code class="erlang">
    [&lt;&gt;, encode(Num),&lt;&gt; , encode(Offset)];
</code></pre>

<p>Ensuite &agrave; la racine de ErlyWeb, on refait un <code>make</code>.
Il faut maintenant recharger le code de erlsql. </p>

<pre><code class="erlang">
3&gt;l(erlsql).
</code></pre>

<p>Il ne reste qu'&agrave; recharger la page dans le navigateur, et de profiter de notre application.</p>

<h2>Notes de fin</h2>

<ol>
<li><p>Je voulais consacrer plus temps &agrave; l'utilisation du framework. C'est un peu gach&eacute;.</p></li>
<li><p>Modifier directement le code du framework c'est pas terrible non plus. Mais j'ai pas encore trouv&eacute; de solution propre, vu que le driver erlydb ne peut pas indiquer ses pr&eacute;f&eacute;rences &agrave; erlsql. Je posterai sur la ML pour en parler.</p></li>
<li><p>Au final, je voulais surtout utiliser Mnesia, j'aimerai pouvoir interconnecter mon appli erlyweb avec ejabberd. Ca fera l'occasion d'autres post.</p></li>
</ol>      
