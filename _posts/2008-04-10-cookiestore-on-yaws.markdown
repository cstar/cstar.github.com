---
layout: post
title: CookieStore on Yaws
---
<p>I implemented a session cookie store, just like <a href="http://www.railsmanual.org/class/CGI::Session::CookieStore">the one in Ruby on Rails 2.0</a>.</p>

<p>Available with the same caveats :
Session data is encoded in base64 and sent in the cookie with a SHA MAC of this data.
This means that the user can see what&#8217;s inside, but will not be able to tamper with it.</p>

<p>Moreover session data should stay in small amount as the encoded and signed data may not exceed 4096 bytes.</p>

<p>This being said, that should give us Yaws clustering for free :)
And no more sessions to expire, just set the cookie expiration date.</p>

<p>One small thing, make sure crypto is started.</p>

<p>session1.yaws has been rewritten to make use of this code.</p>

<p><a href="/assets/2008/4/10/CookiStore.zip" title="CookiStore.zip">Download here.</a></p>      
