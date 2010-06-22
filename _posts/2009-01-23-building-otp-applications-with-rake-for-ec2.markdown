---
layout: post
title: Building OTP applications with Rake for EC2
---
<p>I uploaded a mashup of other&#8217;s code this morning to github. Namely <a href="http://charpi.net/blog/2009/01/18/update-of-my-rake-tasks-to-build-erlang-project/">charpi&#8217;s Rakefile</a>, used to build the <a href="http://dukesoferl.blogspot.com/2008/02/automatic-node-discovery.html">Duke of Erl&#8217;s ec2nodefinder</a>.</p>

<h1>Rakefile</h1>

<p>It&#8217;s way more than a Rakefile, actually. It&#8217;s a whole project organization.</p>

<p>Your OTP applications go into lib/, and you can have as many as you want in there.</p>

<p>Just typing <code>rake</code> will build the release files, doing all the chores (creating app files and rel files &#8230; BORING !)</p>

<p>Here are all the defined tasks.</p>

<pre><code class="shell">
rake clean                     # Remove any temporary products.
rake clobber                   # Remove any generated file.
rake compile                   # Compile all project
rake dialyzer                  # Run dialyzer
rake edoc[name]                # Buid Application documentation
rake edocs                     # Buid all application documentation
rake erlang_applications       # Build application resource file
rake erlang_modules            # Compile Erlang sources
rake erlang_release_files      # Build erlang boot files
rake erlang_releases           # Build release tarball
rake erlang_target_systems[n]  # Build release tarball with erts
rake run[name,node]            # Runs application
rake tests                     # Runs EUnit tests
rake upload                    # Sends release to S3 (presumably for deployment on EC2)
</code></pre>

<h1>ec2nodefinder</h1>

<p>In a nutshell, makes all erlang nodes in a single EC2 security group discover each other automatically.</p>

<p>Your applications on those instances can have processes joining <a href="http://www.erlang.org/doc/man/pg2.html">pg2</a> groups, and you get scalability with very little efforts. However pg2 is quite crude in choosing a process as its only strategy is closest process or random.</p>

<p><a href="http://dukesoferl.blogspot.com/2008/02/automatic-node-discovery.html">ec2nodefinder is described here</a>. Works well and very handy. I however would like to remove the dependency on ec2-describe-instances (which in turn requires a JRE on the deployment server). It&#8217;s working as advertised but JVM startup slows down discovery. </p>

<h1>AMIs</h1>

<p>Check out <a href="http://weblog.hypotheticalabs.com/">Kevin Smith&#8217;s blog</a>. He is building erlang centric AMI based on <a href="http://alestic.com/">Eric Hammond&#8217;s Ubuntu AMIs</a></p>

<h1>Next cool things I&#8217;d like to do or see</h1>

<p>Run OTP releases on  instances, with just one command :</p>

<pre><code class="shell">
ec2-run-instances ami-XXXXX -n  -d "release=/"
</code></pre>

<p>It won&#8217;t be <em>that</em> easy, because the AMIs will need credentials to access S3 (and EC2 admin commands)</p>

<p>Actually that&#8217;s my 10€ question. Where are AWS credentials best stored ?</p>

<ul>
<li>have the cert / private key on S3 and pass the S3 AWS<em>ACCESS</em>* values as parameters :</li>
</ul>

<pre><code class="shell">
ec2-run-instances ami-XXXXX -n  -d "release=/&amp;AWS_ACCESS_KEY=XXXXX&amp;AWS_SECRET_ACCESS_KEY=XXXX++XXXX"
</code></pre>

<ul>
<li>pass everything in a tar.gz (<code>-f</code> flag of ec2-run-instances)</li>
</ul>

<p>Not decided yet.</p>

<h1>relup, appup &#8230; hot code upgrade</h1>

<p>No rake magic yet for those. Watch this space or <a href="http://charpi.net/blog/">charpi&#8217;s</a> !</p>

<h1>Code</h1>

<p><a href="http://github.com/cstar/ec2nodefinder/tree/master">Get the code on github.</a></p>      
