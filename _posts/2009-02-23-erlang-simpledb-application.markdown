---
layout: post
title: Erlang SimpleDB application
---
<h1>SimpleDB</h1>

<p>SimpleDB is a the cloud database by Amazon Web Services.</p>

<p>Still in beta, SimpleDB provides you with metered access to fat storage designed for an internet scale database. Compared to MySQL or other RDBMS, it has few features (no transactions, no joins &#8230;), but using it is a no-brainer.</p>

<p>Still having a library wrapping around the HTTP calls to SimpleDB is good.</p>

<h1>erlsdb</h1>

<p>Hence the <a href="http://code.google.com/p/erlsdb/">erlsdb</a> OTP app. However development seemed to have stopped. So I took it to github and hack it. </p>

<p>It went surprisingly quickly (most certainly due to erlang&#8217;s power than my own skills) as I managed to add async http calls, multiple workers and finished implementing the API in a few hours. </p>

<p>Still needs a bit of polish but it&#8217;s already waiting for feedback !</p>

<p><a href="http://github.com/cstar/erlsdb/tree/master">Get it here !</a></p>

<h1>examples</h1>

<p>(if your eyes don&#8217;t burn from the syntax coloring)</p>

      
