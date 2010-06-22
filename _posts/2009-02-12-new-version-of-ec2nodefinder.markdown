---
layout: post
title: New version of ec2nodefinder
---
<p><a href="http://github.com/cstar/ec2nodefinder/tree/master">ec2nodefinder</a> is an application that enables remote erlang node discovery when hosted on EC2.</p>

<p>This new version uses the EC2 query interface instead of <code>os:cmd</code>&#8217;ing the amazon api tools.</p>

<p>It has no external dependencies now when deploying the release. Previous needed Java and the API tools.</p>

<p>Finally removed the need for the cert and pk files. It only uses AMAZON<em>ACCESS</em>KEY<em>ID and AMAZON</em>SECRET<em>ACCESS</em>KEY.</p>

<p>Also new is an implementation of <a href="http://github.com/cstar/ec2nodefinder/blob/935c4451f95090de1bae565f6f9f56344de3cf7c/lib/ec2nodefinder/src/awssign.erl">V2 signature code for AWS</a>.
Given that V1 is deprecating at the end of the year, that&#8217;s a head start.</p>

<p>I did not see it anywhere in erlang yet, so HTH (as they say).</p>

<p>TODO : the secret key tend to come up in the logs. It will be removed in an upcoming release.</p>      
