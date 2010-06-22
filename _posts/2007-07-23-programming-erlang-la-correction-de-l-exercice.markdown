---
layout: post
title: Programming Erlang : La correction de l'exercice !
---
<p>Sur la page 158 de Programming Erlang, il y a un exercice.
Faire un anneau de N processus. On envoie le message &agrave; l&#8217;un deux, et le message parcourt l&#8217;anneau M fois.</p>

<pre>
<code class="ruby">
-module (exoc).
-export([start/2]).

start(Max,Tours) -&gt;
    start(Max,Max,0, Tours).

start(0, _Max,PrevPid, _Tours)-&gt;
    PrevPid;
start(Max, Max, _Pid, Tours) -&gt;
    F = fun() -&gt;
            LastPid = start(Max-1, Max, self(), Tours),
            loop(LastPid, Tours)
        end,
    spawn(F);
start(N, Max,PrevPid,Tours) -&gt;
    Pid=spawn(fun() -&gt; loop(PrevPid, Tours) end ),
    start(N-1, Max, Pid, Tours).

loop(_ToPid,0) -&gt;
    io:format("~nFini pour :~p",[self()]);
loop(ToPid, Tours) -&gt;
  receive
    M-&gt;
     ToPid ! M,
     io:format("~n(~p) :~p -&gt; ~p.",[self(),M, ToPid]),
      loop(ToPid, Tours-1)
  end.
</code>
</pre>      
