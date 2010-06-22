---
layout: post
title: erlsdb and erls3 use ibrowse
---
<p>I had some issues with inets under heavy load with <a href="http://github.com/cstar/erlsdb/tree/ibrowse">erlsdb</a> and <a href="http://github.com/cstar/erls3/tree/ibrowse">erls3</a>.</p>

<p>And when you are talking to <a href="http://aws.amazon.com/">Amazon Web Services</a>, you&#8217;d want to write in parallel as much as possible. You also want to pipeline requests in one single socket, especially while using SSL encryption (even more costly to establish).</p>

<p>ibrowse seemed very interesting, especially since the <a href="http://couchdb.apache.org/">CouchDB</a> project <a href="http://mail-archives.apache.org/mod_mbox/couchdb-dev/200901.mbox/%3C737EDF428EB6334ABD28B2EE98E0849B036B7211@HATMSG031.TMOUSERSUK.AD.T-MOBILE.CO.UK%3E">started</a> using it !</p>

<p>Got it out of <a href="http://jungerl.sourceforge.net/">jungerl</a>, which is always a bit of a pain. You can also find it on <a href="http://github.com/dizzyd/ibrowse/tree/master">github</a>, I figured later.</p>

<p>Porting my code to ibrowse was quite easy. Though I had to change a bit of the async code. Instead of sending one message once the inets process received the HTTP response, it sends a message upon receiving headers then a slew of messages for each chunk it receives.</p>

<p>Had a few Too Many Open Files errors while loadtesting. As it appears, I had over 500 connections opened to Amazon AWS. Got more sensible defaults and the problem went away.</p>

<p>Configuration is by host, that forced me to change the naming of the S3 buckets from http://bucket.s3.amazonaws.com/ to http://s3.amazonaws.com/bucket/</p>

<p>One caveat : accessing SimpleDB using SSL gives InvalidSignature errors for the time being. Will squash that soon.</p>

<p>Using ibrowse will also unable me to write a client to S3 that will stream files to and from disk.</p>

<p>The ibrowse version are in the ibrowse branch for both projects.</p>      
