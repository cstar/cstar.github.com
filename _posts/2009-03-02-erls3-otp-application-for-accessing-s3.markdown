---
layout: post
title: erls3 : OTP application for accessing S3
---
<p>Just committed <a href="http://github.com/cstar/erls3/tree/master">erls3 over to github.</a></p>

<p>Enables access to S3. Tailored for highly concurrent access with small items rather than sending multigigabyte items. Everything you get/send from/to S3 is stored in the VM.</p>

<p>Usage examples will come shortly.</p>

<p>The API is however very <a href="http://github.com/cstar/erls3/blob/dc2d8a194a5ba8b572f67186007f9c3688ebf1e1/lib/s3/src/s3.erl">straightforward</a>.</p>      
