---
layout: post
title: A strategy for testing for ejabberd modules
---
I've always been looking for an elegant way of testing custom <a href="http://github.com/processone/ejabberd/">ejabberd</a> modules.
Tried a couple of ways before but was never convinced. Running tests against a running ejabberd node for example. But it's not easy, many dependancies, and hard to set up. Mocking modules such as ejabberd_router. But either I hit weird issues, either it's so cumbersome, I knew I'd never use it again.

But this time, I think I've got it.

Check out the cool combination of <a href="http://github.com/ngerakines/etap">etap</a> and <a href="http://github.com/charpi/erl_mock">erl_mock</a> !

<a href="http://github.com/cstar/ejabberd_testing">It's on github</a> with more blathering from yours truly.      
