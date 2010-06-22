---
layout: post
title: Why fork the whole ejabberd tree ?
---
I had the question on <a href="http://www.planeterlang.org/en/planet/article/ejabberd_cloud_edition_alpha/">PlanetErlang</a>.
<blockquote>Why have you put whole ejabberd source to the repository? You could just put your modules to avoid constant merging from upstream.</blockquote>
Thank you, Anton, for enabling me to express some love to <a href="http://git-scm.com/"><code>git</code></a> and <a href="https://github.com/"><code>github</code></a>.
<h1>The short answer</h1>
It’s easy <em>and</em> fun.
<h1>The longer answer</h1>
The early version of the code was actually in a separate private SVN repository. Part of my install procedure was copying the beams into the ejabberd <code>ebin</code> folder. But each time <code>mod_muc</code> or <code>mod_pubsub</code> modules were updated I had to launch FileMerge and merge things. And those modules are not slim.

Enters git and github. <a href="http://github.com/bjc">Brian J. Cully</a> has a script updating every hour his <a href="http://github.com/bjc/ejabberd/tree/master">ejabberd repository</a> on github from the<a href="https://svn.process-one.net/ejabberd/trunk/src/"> Process One svn repository</a>.

My own <a href="http://github.com/cstar/ejabberd/tree/master">ejabberd repository</a> is fork from his.

And having my own tree up-to-date is only a matter of one (1) command :
<blockquote>“github pull bjc master“</blockquote>
Run <code>sudo gem install github</code> for installing the <a href="http://github.com/defunkt/github-gem/tree/master">github gem</a>.

Merges are done automatically. Of course the occasional conflict may arise, but whatever the process, I cannot avoid it.

Pushing to my github repository is also one command :
<blockquote>“git push origin master“</blockquote>
<h1>And if I want to send a patch right up to Process One ?</h1>
Say for pubsub …
<blockquote>“git diff bjc/master – src/mod_pubsub &gt; pubsub.patch“</blockquote>
<h1>Contributing is easy</h1>
Fork my project, hack, push, pull request.

Can it be any simpler ? (This question is <strong>not</strong> rethorical)      
