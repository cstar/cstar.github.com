---
layout: post
title: Erlang, le hasard fait bien les choses
---
<p>Aujourd&#8217;hui, je voulais r&eacute;aliser un prototype de serveur TCP en Erlang/OTP.</p>

<p><a href="http://www.pragmaticprogrammer.com/titles/jaerlang/index.html">Le bouquin de Joe Armstrong</a> contient plusieurs serveurs TCP. Un serveur de chat, un serveur SHOUTcast entre autres, et le code de la librarie lib_chan, mais rien qui utilise les principes OTP.</p>

<p>Et voil&agrave; qu&#8217;en arrivant sur la home de <a href="http://www.trapexit.org/">TrapExit</a> (la ressource indispensable en erlang), je tombe sur &ccedil;a :</p>

<p><a href="http://www.trapexit.org/Building_a_Non-blocking_TCP_server_using_OTP_principles">Building a Non-blocking TCP server using OTP principles</a> sorti le 16 ao&ucirc;t</p>

<p>La vie est bien faite. (Merci Serge Aleynikov ;)</p>

<p>UPDATE : et j&#8217;ai aussi d&eacute;couvert appmon:start(). Very nice.</p>      
