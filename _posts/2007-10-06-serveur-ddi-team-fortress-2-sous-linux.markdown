---
layout: post
title: Serveur d&#xE9;di&#xE9; Team Fortress 2 sous Linux
---
<p>Le serveur Djudge! Team Fortress 2 tourne. Sur le serveur qui vous sert en ce moment ce billet.</p>

<p>Vu que c&#8217;est basé sur le moteur Source, j&#8217;imagine que tous les admins de CS:S savent déjà tout ça, mais j&#8217;ai un peu lutté, donc je résume.</p>

<p>On choppe Steam et on télécharge le serveur de TF. C&#8217;est gros, vu qu&#8217;on télécharge aussi Half-Life 2.</p>

<pre><code>
sudo mkdir /usr/local/steam
cd /usr/local/steam
sudo adduser steam
sudo chown steam /usr/local/steam
sudo su steam

wget http://www.steampowered.com/download/hldsupdatetool.bin
chmod +x hldsupdatetool.bin
./hldsupdatetool.bin
# tapez yes
chmod +x steam
./steam -command update -game "tf" -dir
</code></pre>

<blockquote>
    <p>il faut reprendre la dernière ligne plusieurs fois, parce qu&#8217;on se fait déconnecter.</p>
</blockquote>

<p>Ensuite il faut ouvrir les ports du firewall.</p>

<p>J&#8217;utilise <code>iptables-restore</code> et <code>iptables-save</code> pour respectivement charger et dumper mes règles à partir de l&#8217;entrée standard.</p>

<p>Voici les règles que j&#8217;ajoute à mon fichier <code>/etc/iptables.up.rules</code></p>

<pre><code>
#Source server
-A INPUT -p udp -m udp --dport 1200 -j ACCEPT
-A INPUT -p udp -m udp --dport 27000:27015 -j ACCEPT
-A INPUT -p udp -m udp --dport 27020 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 27030:27039 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 27015 -j ACCEPT
# a placer avant cette ligne :
-A INPUT -j DROP
# et les autres DROP
</code></pre>

<p>Qu&#8217;on charge ensuite avec :</p>

<pre><code>
sudo iptables-restore &lt; /etc/iptables.up.rules
</code></pre>

<p>Pour finir on lance le serveur  :</p>

<pre><code>
cd /usr/local/steam/orangebox
./srcds_run -console -game tf +ip ip -port port +hostname "Mon serveur" +maxplayers 24 +map ctf_2fort
</code></pre>

<p>Le serveur doit indiquer à un moment qu&#8217;il se connecte sur les serveurs steam, et c&#8217;est bien.</p>

<p>Une fois qu&#8217;il est lancé, la console reste accessible pour donner des commandes (kick/ban user etc)</p>

<p>La liste des commandes peut être affiché avec :</p>

<pre><code>
cvarlist mp
# et
cvarlist sv
</code></pre>

<p>On peut les sauver dans un fichier log avec </p>

<pre><code>
cvarlist log listecvar.txt
</pre></code>
Il est donc recommander de lancer le serveur dans un terminal virtuel comme `screen`.

<pre><code>
screen
./srcds_run -console -game tf +ip ip -port port +hostname "Mon serveur" +maxplayers 24
</code></pre>

<p>Avec : <code>control-a-d</code> pour se déconnecter du terminal
et <code>screen -r</code> pour se ré-attacher au terminal.</p>

<p>Sources : le forum de <a href="http://www.teamfortress2.fr/">http://www.teamfortress2.fr/</a></p>      
