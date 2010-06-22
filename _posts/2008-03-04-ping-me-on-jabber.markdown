---
layout: post
title: Ping me on Jabber
---
<p>Je suis en train de faire migrer Ohm Force d&#8217;IRC à full Jabber.</p>

<p>Ca marche bien, mais il manque une fonctionnalité indispensable :</p>

<p>Que ca bippe le client quand dans une chatroom, on cite mon nickname.</p>

<p>Ni <a href="http://www.apple.com/fr/macosx/features/ichat.html">iChat</a> ni <a href="http://www.jivesoftware.com/products/spark/">Spark</a> ne l&#8217;ont.</p>

<h1>iChat</h1>

<p>Pour iChat, c&#8217;est facile avec AppleScript:</p>

<pre><code class="applescript">
using terms from application "iChat"
    on chat room message received theMessage from theBuddy for theChat
        set theUser to "VOTRE NICKNAME"
        if theMessage contains theUser then
            say theUser
        end if
    end chat room message received
end using terms from
</code></pre>

<p>Tout ça dans le script editor, on enregistre dans le rep <code>~/Library/Scripts/iChat</code> sous le nom de <code>beep.scpt</code> et ensuite on configure comme ça  :</p>

<p><img src="/assets/2008/3/4/Image_2.png" alt="Configuration d'iChat" border="0" width="519" height="243" /></p>

<h1>Spark</h1>

<p>Pour Spark, j&#8217;ai du écrire un plugin. Rapide, j&#8217;ai passé plus de temps à trouver comment le compiler qu&#8217;à l&#8217;écrire.</p>

<p>J&#8217;ai pris le son <code>bell.wav</code> de Spark, et je l&#8217;ai embarqué dedans.</p>

<p>Pour le télécharger, c&#8217;est ici :
<a href="/assets/2008/3/4/beep.jar.zip" title="beep.jar.zip">beep.jar.zip</a></p>

<p>Il faut dézipper, et glisser la jar dans le répertoire <code>plugins</code> de Spark.</p>

<p>Sur Mac et Linux, cherchez dans le répertoire Spark à la racine de votre compte. Sur Windows &#8230; j&#8217;en sais rien.</p>

<p>C&#8217;est dans la même licence que Spark, et si vous voulez le code source, <a href="cstar@cestari.info">contactez-moi</a>.</p>

<p>(oui, je dois toujours configurer mon serveur SVN pour l&#8217;accès public)</p>

<h1>Pour finir :</h1>

<p>Une fonctionnalité qui complémente bien celle-ci est l&#8217;autocomplétion des nicknames. Mais c&#8217;est beaucoup plus de travail, donc c&#8217;est pour plus tard ! </p>

<p>Pour l&#8217;instant, dites à vos amis de choisir des nicknames plus courts.</p>      
