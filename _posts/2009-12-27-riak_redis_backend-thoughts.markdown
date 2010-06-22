---
layout: post
title: riak_redis_backend thoughts
---
<h2>Post Mortem</h2>

riak_redis_backend has migrated from a gist to a <a href="http://github.com/cstar/riak_redis_backend">full size github project</a>.

Finally, my code passes all tests I throw at it. It's been a fun ride up to now. I still have a few ideas to implement but the bulk of the work is done — and it's not even a 100 LOCs ...

I recently spent some quality time with <a href="http://code.google.com/p/redis/">redis</a> and the <a href="http://bitbucket.org/japerk/erldis/">erldis</a> erlang library for a project.

And last week I decided that Riak would be my "week-end sized tech". In the wee hours of Monday morning, I decided that writing a Redis backend for Riak should be fun and easy.

It was easy — in hindsight. But I hit a few roadblocks.

The riak_backend_tests passed quite quickly but it was not enough. My own riak test code tendend to be slow and mapreduce jobs would timeout.

At first I thought about improving the performance of erldis (the erlang Redis library). With the help of <a href="http://streamhacker.com/">Jacob Perkins</a>, the erldis maintainer, we identified where to improve performance. Basically it consisted in moving from strings/lists to binaries. Performance was improved and 50% better.

<a href="http://github.com/cstar/erldis/tree/binaries">Code available here</a>

I also removed many useless checks on keys belonging to sets. Just write every time as data in that case is very short and redis has very good write performance.

But my code still had mapreduce failures.


It all came from a misconception about that Partition argument in the start function ... I ignored it and I was wrong. All the riak_redis_backends would connect to the same key space and exchange uselessly information until timeout.

I tried to have partitions connect to different redis databases. Not good as a Redis server can only have 16 databases. [update : this is by default. <a href="http://twitter.com/antirez/status/7090743024">Redis can be configured to handle way more in redis.conf</a>]

So I prefixed the key name by <code>node()Partition</code>

Also, using the synchronous version of erldis also certainly slowed a bit. A put/delete operation is four Redis operations :
   
  - adding to the bucket/key to the <code>world</code> set.

  - setting the bucket/key to the <code>binary_to_term</code>'ed <code>Value</code>.

  - adding the key to the specific <code>Bucket</code> set.

  - adding the <code>Bucket</code> to the buckets set.

An incoming improvement will be to rollback if one of these operation fail (that's an important one).

I sped up things by starting a process for each operation and wait for the result. The four operations are done in parallel for better efficiency.

Code is still a bit slower on insert/delete than DETS reference code, but consistently faster on mapreduce operations. (see the <a href="http://github.com/cstar/riak_redis_backend/blob/master/riak-playground">riak-playground</a> escript)

<h2>The future</h2>

Will this code be useful ?

I hope it can help. Both Riak and Redis are great and are great complements to each other. Redis is very fast while Riak handles masterless replication redundancy and mapreduce. So I do find them being a great match together.

For the time being the problem is that Redis is limited to RAM sized data sets. But it won't last. <a href="http://antirez.com/post/one-year-of-redis.html">antirez is committed to releasing to a virtual memory version of redis this year.</a>

So that should not be an issue soon.

And is it really a problem ? I see my code as mitigating this temporary issue !

I taught RDBMS for several years. I'm sorry Dr. Codd, but database systems never have been this fun.      
