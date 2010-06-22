---
layout: post
title: ejabberd "cloud edition alpha"
---
<h1>Objectives</h1>

<p>It&#8217;s an <a href="http://www.process-one.net/en/ejabberd/">ejabberd</a>-based proof-of-concept, with a set of custom modules aiming for making it stateless and very scalable on the storage backend.</p>

<p>All state data (including user accounts, roster information, persistent conference room, pubsub nodes and subscriptions) are stored in <a href="http://aws.amazon.com/">AWS webservices, S3 or SimpleDB.</a></p>

<p>It helps scaling up and down, and keeps managing costs at a proportianal cost. AWS services are very wide, and massively parallel access is what it&#8217;s all about. </p>

<p>Default ejabberd configuration uses mnesia, but <a href="http://www.process-one.net/en/">Process One</a> recommends switching some services like roster or auth to ODBC when load increases.</p>

<p>But DBMS have their own scaling problems, and that&#8217;s yet another piece of software to administrate.</p>

<p>CouchDB seems loads of fun, and I&#8217;d like to put some effort running ejabberd over it later on. <a href="http://github.com/twonds/ejabberd_couchdb/tree/master">Some work has started</a>, but not much progress yet. (and CouchDB is still software to one needs to manage).</p>

<h1>Current state</h1>

<ul>
<li><p><code>ejabberd_auth_sdb</code> : store users in SimpleDB. The version in github stores password encrypted, but forces password in PLAIN over XMPP, that means that TLS is required (really !). I have a version somewhere which exchanges hashes on the wire but stores password in clear in SimpleDB. Your call.</p></li>
<li><p><code>mod_roster_sdb</code> : roster information is stored in SimpleDB</p></li>
<li><p><code>mod_pubsub</code> : nodetree data is stored in S3 along with items. Subscriptions are stored in SimpleDB. I reimplemented nodetree<em>default and node</em>default, with means that PEP works fine too.</p></li>
<li><p><code>mod_muc</code> : Uses modular_muc with the S3 storage for persisting rooms.</p></li>
<li><p><code>mod_offline</code> : S3 for storing offline messages</p></li>
<li><p><code>mod_last_sdb</code> : Stores last activity in SimpleDB</p></li>
</ul>

<h1>Still lacking :</h1>

<p>Following the names of the modules, where to store data, in my opinion.</p>

<ul>
<li><p><code>mod_shared_roster</code> : in SimpleDB</p></li>
<li><p><code>mod_vcard</code> : VCards in S3, index in SimpleDB</p></li>
<li><p><code>mod_private</code> : S3</p></li>
<li><p><code>mod_privacy</code> : S3</p></li>
<li><p><code>mod_muc_log</code> : S3 (with a specific setting for direct serving, maybe)</p></li>
</ul>

<p>These modules are the only one which have state that should be persisted on disk. Mnesia is of course still be used for routing, configuration &#8211; but that&#8217;s transient data.</p>

<h1>Transactions and latency</h1>

<p>We loose transactions by switching away from mnesia or ODBC. That may or may not be a problem. I think it won&#8217;t be, but I don&#8217;t have data to prove one way or the other.</p>

<p>Latency also grows, but erlsdb and erls3, the libraries on which the modules are built, can interface with memcached (and are ketama enabled) if you use <a href="http://github.com/cstar/merle/tree/master">merle</a>. Additionally using merle will keep usage costs down.</p>

<p>ejabberd <code>mod_pubsub</code> underwent several optimizations recently, and that improved performance of non-memcached AWS mod_pubsub. Initial code had latency around 10 seconds between publishing and receiving the event. Since last week&#8217;s improvement, performance is much better.</p>

<h1>Down the road</h1>

<p>I&#8217;d wish to see an EC2 AMI based on this code, just pass the domain name or the ejabberd.cfg file to ec2-start-instance and boom ! you have an ejabberd server up and running.</p>

<p>Want more horse power ? Start another one on the same domain in the same EC2 security group, the ejabberd nodes autodiscover each other and you&#8217;ve got a cluster. <a href="http://github.com/cstar/ec2nodefinder/tree/master">ec2nodefinder</a> is designed for this use.</p>

<p>Combined with the very neat <a href="http://aws.amazon.com/contact-us/new-features-for-amazon-ec2/">upcoming load-balancing and autoscaling services Amazon Web Services</a>, there&#8217;s a great opportunity for deploying big and cheap!</p>

<p>Alternatives to the AWS loadbalancing would be <code>pen</code>, or a <a href="http://xmpp.org/internet-drafts/draft-saintandre-rfc3920bis-08.html#streams-error-conditions-see-other-host">&#8220;native&#8221; XMPP solution</a>.</p>

<p>A few things would need to be implemented for this to work well, like XMPP fast reconnect via <a href="http://xmpp.org/extensions/xep-0198.html#resumption">resumption</a> and/or C2S/S2S process migration between servers, because scaling down is as important as scaling up in the cloud.</p>

<p>If you want to participate, you&#8217;d be very welcome. Porting the modules I did not write, or testing and sending feedback would be &#8230; lovely.</p>

<p>And of course if Process One wants to integrate this code in a way or another, that would also be lovely !</p>

<h1>Get it</h1>

<p><a href="http://github.com/cstar/ejabberd/tree/cloud/r">Get it, clone it, fork it</a> ! There&#8217;s bit of documentation on the README page.</p>

<p>[edited : added links to XEP-0198 and rfc3920bis-08, thanks to <a href="http://twitter.com/zssz">Zsombor Szabó</a> for pointing me to them]</p>      
