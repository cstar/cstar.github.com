---
layout: post
title: Calendriers partages
---
<p>Dans une organisation relativement d&eacute;centralis&eacute;e, l&#8217;utilisation de calendriers partag&eacute;s permet un suivi, et une organisation facilit&eacute;e.</p>

<h1>Un &eacute;chec, pour commencer</h1>

<p>L&#8217;ann&eacute;e derni&egrave;re, j&#8217;ai d&eacute;ploy&eacute; &agrave; Ohm Force un intranet sous <a href="http://plone.org">Plone</a>. Avec, entre autres, une solution de calendrier partag&eacute; bas&eacute;e sur <a href="http://plone.org/products/calendaring">Calendaring</a>.</p>

<p>Sauf que &ccedil;a n&#8217;a jamais march&eacute;, en particulier avec une gestion des fuseaux horaire, et Calendaring p&eacute;tait les calendriers locaux, en d&eacute;calant les &eacute;v&eacute;nements d&#8217;une heure &agrave; chaque mise &agrave; jour sur le calendrier local. Suffisant pour &eacute;nerver n&#8217;importe quel utilisateur, et &ecirc;tre s&ucirc;r qu&#8217;il n&#8217;utiliserait jamais l&#8217;outil.</p>

<p>Personne du coup n&#8217;a utilis&eacute; l&#8217;outil, et le suivi est parti dans les limbes.</p>

<h1>Take two</h1>

<p>Franck, le bien aim&eacute; chef de projet &agrave; Ohm Force, m&#8217;a demand&eacute; si je pouvais remettre en place une solution.</p>

<p>J&#8217;ai regard&eacute; Google Calendars, qui est sympathique, et tout et tout, mais pas h&eacute;berg&eacute; chez nous. Et nous, on aime pas trop les trucs pas h&eacute;berg&eacute;s chez nous.</p>

<p>J&#8217;ai repris le cahier des charges &agrave; la base. Et finalement, tout ce qu&#8217;il faut, c&#8217;est un serveur <a href="http://www.webdav.org/">WebDAV</a>.</p>

<p>Et un serveur WebDAV, sur un serveur qui fait d&eacute;j&agrave; tourner <a href="http://subversion.tigris.org/">Subversion</a> et un serveur LDAP, &ccedil;a s&#8217;installe en quelques lignes :</p>

<pre><code>
&lt;Directory /var/www/dav&gt;
    Dav On
    #Options Indexes FollowSymLinks
    AllowOverride None
    order allow,deny
    allow from all
    AuthName "LDAP"
    AuthType Basic

    &lt;Limit GET PUT POST DELETE PROPFIND PROPPATCH MKCOL COPY MOVE LOCK UNLOCK&gt;

    Require valid-user
        &lt;IfModule mod_auth_ldap.c&gt;
         AuthLDAPURL ldap://localhost/ou=unit,dc=domain,dc=top
        &lt;/IfModule&gt;
    &lt;/Limit&gt;
&lt;/Directory&gt;
</code></pre>

<p>Donc mon serveur webdav est accessible &agrave; sur l&#8217;url https://server/dav/. Oui, c&#8217;est du <code>https</code>, on est jamais trop prudent.</p>

<h1>Les clients</h1>

<p>Ils y a deux clients principaux utilis&eacute;s &agrave; Ohm Force :</p>

<ul>
<li><p>Sunbird : le client de la mozilla foundation, qui s&#8217;am&eacute;liore toujours.</p></li>
<li><p>iCal : le client de Mac OS X. Limit&eacute;, mais l&#8217;interface utilisateur est sympa, (et je l&#8217;utilise depuis qu&#8217;il est sorti, je n&#8217;ai pas pr&eacute;vu d&#8217;en changer :)</p></li>
<li><p>un truc sous Linux dont le nom m&#8217;&eacute;chappe.</p></li>
</ul>

<p>Le cas iCal est int&eacute;ressant car il ne fonctionne pas sur https.</p>

<p>De plus, iCal, dans sa version actuelle, (Leopard change apparamment tout &ccedil;a), consid&egrave;re que le monde des calendriers est s&eacute;par&eacute; en deux groupes :</p>

<ul>
<li><p>Ceux qu&#8217;on publie (et &agrave; chaque modification, on &eacute;crase la version sur le webdav)</p></li>
<li><p>Ceux auxquels on est abonn&eacute;s (ils sont en lecture seule sur le client).</p></li>
</ul>

<h1>Utiliser iCal sur un serveur https</h1>

<p>La solution est <a href="http://www.stunnel.org/">stunnel</a>, qui permet d&#8217;encrypter/d&eacute;crypter des flux SSL.</p>

<h2>Pour PPC</h2>

<p>Vous pouvez utiliser ces <a href="http://rulink.rutgers.edu/macical.html">instructions de configuration</a>, la partie &#8220;Access with login, Tiger (10.4)&#8221;</p>

<p>Il faut &eacute;diter le fichier <code>/etc/stunnel.rulink.conf</code>, en changeant l&#8217;url s&eacute;curis&eacute;e vers le site de Rutgers U vers votre partage WebDAV.</p>

<p>Toutefois, la derni&egrave;re fois que j&#8217;avais utilis&eacute; le binaire, il n&#8217;&eacute;tait pas compil&eacute; pour Intel, uniquement pour PPC. Ca tourne, mais c&#8217;est pas optimal.</p>

<h2>Pour Intel</h2>

<p>J&#8217;ai cr&eacute;e un petit installeur qui permet d&#8217;installer le binaire. Le truc, c&#8217;est que le dev Mac n&#8217;est pas mon truc, et qu&#8217;il faut bricoler dans le terminal pour finaliser l&#8217;installation. </p>

<p>J&#8217;ai r&eacute;alis&eacute; l&#8217;installeur pour Ohm Force, ce qui &eacute;tait facile, car le serveur de calendrier est le m&ecirc;me pour tout le monde ; l&#8217;adresse du serveur est donc en dur.</p>

<p>Dans celui-ci, il faut modifier le fichier de conf apr&egrave;s l&#8217;installation <code>/etc/stunnel.ohmforce.com</code> pour mettre la bonne URL, puis red&eacute;marrer le service avec <code>sudo launchctl stop com.ohmforce.stunnel ; sudo launchctl start com.ohmforce.stunnel</code></p>

<p>Voil&agrave; l&#8217;image : <a href="/assets/2007/8/6/HTTPS_iCal.dmg.zip">HTTPS iCal.dmg.zip</a>.</p>      
