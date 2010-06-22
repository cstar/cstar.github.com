---
layout: post
title: A redis backend for riak.
---
<h2>Awesome + Awesome = AWESOMER</h2>
<a href="http://riak.basho.com/">Riak</a> is <a href="http://www.google.com/search?q=basho+riak+awesome">AWESOME</a>.

<a href="http://code.google.com/p/redis/">redis</a> is <a href="http://www.google.com/search?q=redis+awesome">AWESOME</a>.

Why not marry them and keep the babies ?

The riak_redis_backend is exactly the point. Data stuffed into riak is stored on a redis running on localhost on the standard port. (Having non-local data would kind of miss the point, right ?)
An added trick is that the redis database index is different for each riak nodes — if you happen to run all your Riak nodes on the same machine.

Warnings :

Implementation sucks big time, and though it passes the  riak_test_util:standard_backend_test, I made it timeout on some MapRed jobs. And MapRed tasks also runs slower than dets ones.

[Update] performance has been improved by using a better encoding (meaning I removed that base64 horror ... fprof told me that). My test code went down from 25 seconds to 15 seconds.

<h2>Can it be useful — one day ?</h2>

Not sure. Given that redis cannot currently have a dataset bigger than memory (but plans to have virtual memory), it kind of limit the data size.

Performance is currently worse than riak_dets_backend, but given that Redis is *fast*, one can hope for enhancements. I think that most of the improvement should come from the <a href="http://bitbucket.org/japerk/erldis/">erldis</a> library which could need some tweaking for better handling binaries.


<h2>Where is it ?</h2>

It's over <a href="http://gist.github.com/261670">there</a> !

<h2>How can I use it</h2>
Install the <a href="http://github.com/cstar/erldis/tree/binaries">erldis</a> (binary branch) application in your lib/ Riak node directory.
Compile and hurl in the riak/ebin directory. Restart riak node, make sure redis is running, and off you go.





      
