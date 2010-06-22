---
layout: post
title: VDM, Ohm Force dans les magasins
---
<h1>La distribution des logiciels Ohm Force</h1>

<p><a href="http://www.ohmforce.com">Ohm Force</a> vend ses logiciels en ligne. Un business model facile à mettre en place quand on vend du logiciel, pas de stock, pas de contrat. Une bande d&#8217;ingénieurs et autres geeks est capable de mettre ça en place.</p>

<p>En plus le coût est très bas : la location d&#8217;un serveur, et le pourcentage que nous prend la banque pour traiter les paiements par carte de crédit.</p>

<p>La communication coûte aussi, mais on a toujours fait au moins cher, une newsletter, parfois de la pub et des groupbuys. Notre image et nos produits plaisent, et c&#8217;est pas pour rien qu&#8217;on est toujours là 7 ans plus tard !
(La communication, ça va changer bientôt avec l&#8217;arrivée d&#8217;un gars dont ce sera le boulot !)</p>

<h1>Les distributeurs</h1>

<p>Du coup, une idée qui revenait régulièrement dans les premières années d&#8217;Ohm Force était d&#8217;obtenir un contrat avec un distributeur qui prendrait en charge la communication, la force de vente, la fabrication du packaging et des DVD. On profite aussi de ses entrées dans les magasins de musique du monde.
La contrepartie, c&#8217;est qu&#8217;Ohm Force ne touche que 25% du prix de vente, mais on compense avec le volume.</p>

<p>Voilà l&#8217;équation simplificatrice :</p>

<ul>
<li><p>en ligne : peu de ventes, beaucoup de sous par ventes</p></li>
<li><p>en magasin, via le distributeur : beaucoup de ventes, peu de sous par ventes</p></li>
</ul>

<p>La théorie est séduisante !</p>

<p>Mais c&#8217;est aussi faire un pacte avec le diable. Je simplifie encore un peu, mais passer par un distributeur, c&#8217;est signer un contrat standard réalisé par les avocats américains du distributeur. Le distributeur en question, c&#8217;est le plus gros du marché de la musique.</p>

<p>Le contrat contient un nombre de clauses terribles, avec en particulier l&#8217;interdiction, pour nous, sur le site web de faire de la concurrence avec les vendeurs de nos produits.</p>

<p>Donc pas d&#8217;offres promotionnelles sur notre site, on est obligé de vendre au même prix que les vendeurs <i>retail</i>. Avec une différence, ils vendent une boite, alors que nous on ne vend que du téléchargement.</p>

<p>Et il y a pire. Par contrat, on est obligé de vendre au MSRP (Manufacturer&#8217;s Suggested Retail Price), alors que les magasins peuvent descendre plus bas, au MAP (Minimum Advertising Price) et communiquer dessus. Et parmi les magasins, il n&#8217;y pas que les magasins de Pigalle, il y a aussi les revendeurs qui ont une présence en ligne.</p>

<p>Du coup, les plugins qui sont partis dans le circuit de distribution pouvaient être acheté en ligne moins cher ailleurs que chez nous.</p>

<p>Situation peu agréable, mais on va avoir du volume !</p>

<p>Ah non. Pas de volume. Ventes ridicules. Apparemment le distributeur a eu des problèmes avec <a href="http://en.wikipedia.org/wiki/SAP_ERP">SAP</a>. Ce dernier disait qu&#8217;il n&#8217;y avait pas de stock, du coup les magasins ne pouvaient pas commander, alors que les boites s&#8217;entassaient dans les entrepôts. Ceci dit, on ne parle pas gros volume, la fabrication initiale était, si ma mémoire est bonne, que 1000 unités.</p>

<p>Et si on veut en sortir, c&#8217;est simple, le distributeur demande  au développeur de racheter tous les invendus, (et tu pleures ton cash-flow)</p>

<h1>La &#8220;Vente Download en Magasin&#8221;</h1>

<p>Donc, pas de distributeur pour Ohm Force. La partie précédente ne s&#8217;appliquait pas directement à Ohm Force, mais à la société anglaise avec qui Ohm Force avait co-développé des instruments. Ohm Force touche des royalties.</p>

<p>Toutefois il est vrai qu&#8217;au bout de la chaîne, il y a le magasin, avec des vendeurs qui ont parfois très envie de vendre nos logiciels. On a déjà eu des requêtes de magasins qui achetaient sur notre site des plugins pour le compte d&#8217;un client.</p>

<p>L&#8217;idée nous est arrivée, il y deux ans. (oui, sur certains sujets, Ohm Force n&#8217;est pas très réactif)</p>

<p>On fait des DVD qui contiennent tous nos plugins, un joli présentoir, que le vendeur dispose dans son magasin.</p>

<p>Lorsque le client dans le magasin veut acheter nos plugins, il prend le DVD, et le vendeur se connecte sur une application web hébergée par Ohm Force, pour générer le numéro de série. Derrière on garde la trace de l&#8217;achat, et on envoie une facture regroupant toutes les ventes du mois.</p>

<p>Le vendeur peut régler directement sa facture avec sa carte de crédit sur l&#8217;application.</p>

<h1>Les avantages</h1>

<p>Le magasin n&#8217;a pas besoin de stock (sinon les DVD, mais ils sont dans une petite pochette carton).
Il ne paye que ce qu&#8217;il a effectivement vendu, et n&#8217;a pas besoin de retourner les invendus, donc le cash-flow s&#8217;en trouve bien amélioré.</p>

<p>De notre côté, le contrat qu&#8217;on signe avec les vendeurs, est souple quant aux possibilités de promotions (des deux côtés d&#8217;ailleurs). Le coût de fabrication des DVD est minime, et on a un bon suivi des ventes.</p>

<p>Et pour finir, on enlève le <i>middleman</i> et sa part de 40% sera répartie entre nous et les magasins. Donc plus d&#8217;argent pour toutes les parties.</p>

<p>C&#8217;est du <i>win/win</i> !</p>

<h1>Start small, scale later</h1>

<p>L&#8217;application est depuis hier en phase de test. C&#8217;était mon travail dans le projet, j&#8217;aborderai dans un prochain post le côté technique &#8211; c&#8217;est une application <a href="http://www.cestari.info/2007/7/2/jruby-1-0-premi-egrave-re-experience">JRuby on Rails</a> hébergée sur un serveur <a href="https://glassfish.dev.java.net/">GlassFish</a>.</p>

<p>Nous avons quelques magasins qui sont très intéressés. Sur la côte Est des USA, sur la côte Ouest, et évidememnt, en France.</p>

<p>On va commencer en douceur, en commençant par la France, sur Paris, pour pouvoir discuter avec eux facilement et physiquement.</p>

<p>Est-ce que ça va marcher ?</p>

<p>Ohm Force y croit beaucoup !</p>

<p>PS : si vous avez un magasin de musique, et que ça vous intéresse, envoyez un mail sur <a href="mailto:contact@ohmforce.com">contact@ohmforce.com</a> avec VDM dans le sujet.</p>      
