---
layout: post
title: mini Auth CAS on Yaws
---
<p><a href="http://yaws.hyber.org/">Yaws</a>, c&#8217;est le serveur web écrit en erlang, célèbre pour <a href="http://www.sics.se/~joe/apachevsyaws.html">ce graphe</a> qui montre comment Yaws met sa pâté à Apache.</p>

<p>Voici le client minimal permettant de s&#8217;authentifier sur un serveur CAS.</p>

<p>A sauver dans un fichier cas.yaws à mettre dans le <code>/var/yaws</code> (document root par défaut).</p>

<p>N&#8217;oubliez pas d&#8217;adapter <code>CASHOST</code> et <code>SERVICE</code> à votre configuration.</p>

<pre><code class="erlang">&lt;erl&gt;
-define(CASHOST, "http://localhost:8080/cas/").
-define(SERVICE, "service=http%3A%2F%2Flocalhost%3A5224%2Fcas.yaws").
-include_lib("xmerl/include/xmerl.hrl").

out(A)-&gt;
    H = A#arg.headers,
    C = H#headers.cookie,
    inets:start(),
    case yaws_api:find_cookie_val("casuser", C) of
        []-&gt;
            check_auth(A);
        Cookie -&gt;
            {ok, Username} = yaws_api:cookieval_to_opaque(Cookie),
            {html, "Authentified as "++Username}
    end.

check_auth(A)-&gt;
    case queryvar(A,"ticket") of
        {ok, Ticket}-&gt;
            case verify_ticket(Ticket) of
                {ok, Username} -&gt;
                    Cookie = yaws_api:new_cookie_session(Username),
                    CO = yaws_api:setcookie("casuser",Cookie,"/"),
                    [{html, "Authentified as "++Username}, CO];
                {error, Reason} -&gt;
                    [{status, 403},{html, "Unauthorized : "++Reason}]
            end;
        undefined -&gt;
            {redirect, ?CASHOST ++ "login?" ++ ?SERVICE }
        end.

verify_ticket(Ticket) -&gt;
    inets:start(),
    Url =?CASHOST++"proxyValidate?"++?SERVICE++"&amp;ticket="++Ticket,
    {ok, {_Status, _Headers, Body}} =
          http:request(Url),
    { Xml, _Rest } = xmerl_scan:string(Body),
    inets:stop(),
    case xmerl_xpath:string("//cas:user/text()",Xml) of
        [ #xmlText{value=Username} ] -&gt;
            {ok, Username};
        [] -&gt;
            {error, "invalid ticket " ++ Url}
        end.
&lt;/erl&gt;
</code></pre>

<p>Tant qu&#8217;on est sur le sujet, il y a un article très intéressant <a href="http://www.infoq.com/articles/vinoski-erlang-rest">sur le REST dans Yaws</a> chez InfoQ.</p>      
