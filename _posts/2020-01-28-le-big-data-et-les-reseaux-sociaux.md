---
title: 'Le Big Data et les réseaux sociaux'
date: 2020-01-28
permalink: /posts/2020/01/le-big-data-et-les-reseaux-sociaux
categories: [FR]
tags:
  - Big data
  - Facebook
  - Web scraping
  - Twitter
author_profile: false
toc: true
excerpt: "Cet article fait un tour d'horizon des outils et services qui permettent d'extraire des données et des mégadonnées des principaux réseaux sociaux (Twitter, Facebook), des sites web et des blogs."
---

{% include toc %}

<p>Cet article fait un tour d&#39;horizon des outils et services qui permettent d&#39;extraire des donn&eacute;es et des m&eacute;gadonn&eacute;es des principaux r&eacute;seaux sociaux (Twitter, Facebook)&nbsp; , des sites web et des blogs.</p>



<p>&nbsp;</p>



<h2>Introduction</h2>



<p>Ces derniers temps, je vois une sp&eacute;cialisation qui prend de l&#39;ampleur, il s&#39;agit du social media mining. Le social media mining est le processus d&#39;obtention de m&eacute;gadonn&eacute;es &agrave; partir du contenu g&eacute;n&eacute;r&eacute; par les utilisateurs sur les sites de m&eacute;dias sociaux et les applications mobiles.</p>



<p>En effet, les r&eacute;seaux sociaux sont des plateformes num&eacute;riques incontournables. En 2019, sur 7,6 milliards d&rsquo;habitants, on note 3,4 milliards d&rsquo;utilisateurs de r&eacute;seaux sociaux (<a href="https://www.blogdumoderateur.com/50-chiffres-medias-sociaux-2019/"><span style="color:#3498db">https://www.blogdumoderateur.com/50-chiffres-medias-sociaux-2019/</span></a>).&nbsp;Aujourd&rsquo;hui les membres de ces r&eacute;seaux partagent leurs propres occupations quotidiennes, mais aussi leurs avis sur des sujets d&rsquo;actualit&eacute;, culturels, ou encore politiques. Ainsi,&nbsp;Twitter,&nbsp;Facebook&nbsp;et autres&nbsp;Instagram, sont devenus des sources importantes d&rsquo;informations.</p>



<p>En bref, des quantit&eacute;s immenses de donn&eacute;es sont g&eacute;n&eacute;r&eacute;es &agrave; chaque instant par le biais de ces r&eacute;seaux. Cela illustre parfaitement les&nbsp;<a href="https://www.xsnet.com/blog/bid/205405/the-v-s-of-big-data-velocity-volume-value-variety-and-veracity"><span style="color:#3498db">V de la Big Data</span></a>, en effet, ces donn&eacute;es, en plus d&rsquo;&ecirc;tre volumineuses, sont vari&eacute;es. Elles contiennent bien s&ucirc;r le contenu des publications, suivis par diff&eacute;rents indices de popularit&eacute;s et d&rsquo;impressions (vues, likes, partages etc.), et par une multitude de m&eacute;tadonn&eacute;es.</p>



<p>Cette data est une v&eacute;ritable mine &agrave; exploiter ; selon l&rsquo;approche elle peut &ecirc;tre utilis&eacute;e pour r&eacute;pondre &agrave; diff&eacute;rents besoins (jauge de popularit&eacute;, analyse d&rsquo;opinion, syst&egrave;me de recommandation, ciblage...).</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<h2>Twitter</h2>



<p>Twitter met en oeuvre plusieurs plateformes (APIs REST), qui prennent en param&egrave;tre une requ&ecirc;te et renvoient une r&eacute;ponse au format JSON. Le tout est accessible selon trois offres : STANDARD (gratuit), ENTERPRISE et PREMIUM. (<a href="https://developer.twitter.com/en.html"><span style="color:#3498db">https://developer.twitter.com/en.html</span></a>).&nbsp;</p>



<p>Dans chaque API, il est propos&eacute; plusieurs endpoints. Il en existe assez pour r&eacute;pondre &agrave; &eacute;norm&eacute;ment de cas d&rsquo;utilisation (stream, publier des tweets, r&eacute;cup&eacute;rer les tendances etc.). Dans cet article, je vous pr&eacute;sente rapidement les outils permettant :</p>



<ul>

	<li>extraction (API SearchTweets, API Get Tweets Timelines)</li>

	<li>streamer (Filter Realtime Tweets)</li>

</ul>



<p>Pour pouvoir utiliser ces offres, il vous faudra d&rsquo;abord suivre une proc&eacute;dure de cr&eacute;ation d&rsquo;une&nbsp;App. Twitter vous demandera notamment de renseigner &agrave; quelles fins vous souhaitez utiliser leurs services, et, si tout va bien, cela vous permettra de r&eacute;cup&eacute;rer vos cl&eacute;s secr&egrave;tes (4 tokens API ).</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<h3><span style="color:#3498db">API Search Tweets</span></h3>



<p>&nbsp;</p>



<p>Si votre but est d&rsquo;extraire des publications selon une recherche particuli&egrave;re, c&rsquo;est-&agrave;-dire selon un ou plusieurs mots-cl&eacute;s, selon des hashtags/noms d&rsquo;utilisateur ou encore sur une p&eacute;riode donn&eacute;e ; l&rsquo;API Search est celle qu&rsquo;il vous faut. Elle prend une requ&ecirc;te de recherche et renvoie un JSON avec les donn&eacute;es des publications correspondantes.&nbsp;Outre le contenu du tweet, on retrouve diverses pr&eacute;cisions sur l&rsquo;auteur, la localisation, l&rsquo;appareil utilis&eacute; pour la publication, sur le nombre de retweets/likes/abonn&eacute;s, les mentions, les hashtags, les m&eacute;dias contenus et plus encore.</p>



<p>Concernant les limitations, avec l&rsquo;offre gratuite il est possible d&rsquo;effectuer jusqu&rsquo;&agrave; 400 requ&ecirc;tes sur une fen&ecirc;tre de 15 minutes. Sachant qu&rsquo;une requ&ecirc;te renvoie 100 publications maximum. Outre le nombre de requ&ecirc;tes maximum, la diff&eacute;rence entre le service STANDARD et PREMIUM se trouve dans l&rsquo;acc&egrave;s aux anciens tweets.&nbsp;L&rsquo;offre gratuite ne permet de r&eacute;cup&eacute;rer que les tweets r&eacute;cents (date de publication inf&eacute;rieure &agrave; 7 jours) alors que la version payante donne acc&egrave;s aux publications depuis 2006. (<a href="https://developer.twitter.com/en/docs/tweets/search/overview"><span style="color:#3498db">Documentation Twitter Search</span></a>)&nbsp;</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#e74c3c"><code>fetched_tweets = api.search( query = &quot;big data from:@burkinafaso&quot;,&nbsp;</code></span><span style="color:#e74c3c"><code>count = 100,</code></span><span style="color:#e74c3c"><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;result_type=&quot;recent&quot;)</code></span></div>



<p style="text-align:center">Exemple d&rsquo;utilisation de l&rsquo;API Search sous Tweepy. La requ&ecirc;te retourne les tweets les plus r&eacute;cents provenant du compte @burkinafaso&nbsp;contenant le mot cl&eacute; big data.</p>



<p style="text-align:center"><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<h3><span style="color:#3498db">Get Tweet Timelines et Stream API</span></h3>



<p>&nbsp;</p>



<p>Twetter propose &eacute;galement des API permettant&nbsp;de r&eacute;cup&eacute;rer le fil d&rsquo;actualit&eacute;s, bas&eacute; sur nos abonn&eacute;s&nbsp;ou de directement r&eacute;cup&eacute;rer les 20 derniers tweets d&rsquo;un utilisateur donn&eacute; et d&#39;effectuer en temps r&eacute;el des&nbsp;requ&ecirc;tes donn&eacute;es respectivement par&nbsp;Get Tweet API et Stream API.</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<h3><span style="color:#3498db">Les librairies</span></h3>



<p>&nbsp;</p>



<p>On peut vite se perdre parmi toutes les fonctionnalit&eacute;s propos&eacute;es par Twitter. En effet, plus d&rsquo;une dizaine d&rsquo;APIs Twitter sont disponibles. Les librairies disponibles ont principalement &eacute;t&eacute; d&eacute;velopp&eacute;es par la communaut&eacute;, on en retrouve dans plusieurs langages (<a href="https://developer.twitter.com/en/docs/developer-utilities/twitter-libraries"><span style="color:#3498db">liste des librairies</span></a>).</p>



<p>Personnellement j&#39;aime utilise Python, et Tweepy est l&rsquo;une des r&eacute;f&eacute;rences, c&rsquo;est une library assez compl&egrave;te et bien document&eacute;e.(<a href="http://docs.tweepy.org/en/v3.5.0/api.html"><span style="color:#3498db">Tweetpy</span></a>)</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<h2>Facebook</h2>



<p>Pour r&eacute;cup&eacute;rer des donn&eacute;es Facebook, vous allez d&rsquo;une fa&ccedil;on ou une autre passer par le service phare : Facebook Graph API&nbsp;<img alt="angry" src="https://armelsoubeiga.pythonanywhere.com/static/ckeditor/ckeditor/plugins/smiley/images/angry_smile.png" style="height:23px; width:23px" title="angry" />.</p>



<p>Facebook est par excellence le g&eacute;ant des r&eacute;seaux sociaux (+ de 2 milliards d&rsquo;utilisateurs actifs contre 320 millions pour Twitter). Il est pourtant surprenant de noter que sa plateforme de services est moins populaire que celle de Twitter. Cela s&rsquo;explique par plusieurs raisons :</p>



<ul>

	<li>Sur Facebook, les donn&eacute;es sont prot&eacute;g&eacute;es (en th&eacute;orie...), dans le sens o&ugrave; il y a beaucoup plus de notions de publications, groupes, et profils priv&eacute;s que sur Twitter, o&ugrave; la grande majorit&eacute; des tweets est publique. L&rsquo;acc&egrave;s aux donn&eacute;es est donc davantage contr&ocirc;l&eacute; ;</li>

	<li>L&agrave; o&ugrave; Twitter se concentre autour&hellip; des tweets, Facebook lui, propose plusieurs services de communication et de partage (videos, groupes, pages, etc.). Ce qui complique conceptuellement la donn&eacute;e ;</li>

	<li>La documentation de Graph API gagnerait &agrave; &ecirc;tre plus claire et mieux organis&eacute;e.</li>

</ul>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<p><span style="color:#e74c3c"><strong>Le service requiert ainsi un nombre cons&eacute;quent d&#39;autorisations (pour une requ&ecirc;te cela peut m&ecirc;me atteindre une vingtaine d&rsquo;autorisations) et d&rsquo;usage de tokens, ce qui peut &ecirc;tre d&eacute;routant au premier abord.</strong></span></p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<h3><span style="color:#3498db">Obtenir un token</span></h3>



<p>&nbsp;</p>



<ul>

	<li>Se connecter avec un compte facebook sur&nbsp;<a href="https://developers.facebook.com/"><span style="color:#3498db">developers.facebook.com</span></a>,</li>

	<li>Cr&eacute;er une App,</li>

	<li>Allez ensuite sur la console&nbsp;<a href="https://armelsoubeiga.pythonanywhere.com/post/7/update"><span style="color:#3498db">Explorer</span>&nbsp;</a>en s&eacute;lectionnant votre App,</li>

	<li>Demander un user access token (token d&rsquo;acc&egrave;s utilisateur), puis s&eacute;lectionner les autorisations qui conviennent &agrave; votre utilisation.</li>

</ul>



<p>Sachez que certains endpoints ne sont accessibles que si votre token contient les autorisations ad&eacute;quates. Vous pouvez retrouver&nbsp;<a href="https://developers.facebook.com/docs/graph-api/reference/v2.7"><span style="color:#3498db">leur d&eacute;tail</span></a>.</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<p style="text-align:center"><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif"><span style="font-family:&quot;Segoe UI&quot;,&quot;sans-serif&quot;"><span style="color:#212529"><img alt="http://blog.ippon.fr/content/images/2019/06/Screenshot_2019-06-13--Blog--Extraire-la-data-des-r-seaux-sociaux-2-.png" src="http://blog.ippon.fr/content/images/2019/06/Screenshot_2019-06-13--Blog--Extraire-la-data-des-r-seaux-sociaux-2-.png" style="height:394px; width:550px" /></span></span></span></span></span></p>



<p style="text-align:center">Fen&ecirc;tre de&nbsp;s&eacute;lection&nbsp;des autorisations afin de g&eacute;n&eacute;rer un token</p>



<p style="text-align:center"><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<p>Ensuite vous pouvez utiliser votre token de la fa&ccedil;on qui vous va le mieux.&nbsp;que ce soit par l&rsquo;usage de requ&ecirc;tes classiques &agrave; l&rsquo;API Rest de Graph, comme sur la requ&ecirc;te ci-dessous qui r&eacute;cup&egrave;re le feed de la page RochKaborePF (le pr&eacute;sident du faso);&nbsp;ou en le renseignant lors de votre usage du Facebook SDK (pr&eacute;sent dans plusieurs environnements).</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#e74c3c"><code>import urllib3, requests<br />

token = &quot;votretokenici&quot;<br />

page_id = &quot;RochKaborePF&quot;<br />

posts = requests.get(&quot;https://graph.facebook.com/&quot;+page_id+&quot;/feed?access_token=&quot;+token)</code></span></div>



<p style="text-align:center">Requ&ecirc;te GET &agrave; Graph API Facebook</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<h3><span style="color:#3498db">Les librairies</span></h3>



<p>&nbsp;</p>



<p>Au niveau de la limitation, pour une App donn&eacute;e, on est &agrave; 200 requ&ecirc;tes par heure, multipli&eacute;e par le nombre d&rsquo;utilisateurs.&nbsp;</p>



<p>Sache bien comme je le disais au debut, ces limites peuvent &ecirc;tre contourn&eacute;. J&#39;ai developper un algorithmes qui vous permet de recuper librement et sans contrainte de limites toutes les donn&eacute;es que vous voulez obtenir sur facebook. Ce code est gratuit est peut etre otenu sur mon compte github (<a href="https://github.com/armelsoubeiga/fb_scraping"><span style="color:#3498db">https://github.com/armelsoubeiga/fb_scraping</span></a>).&nbsp; N&#39;oublier pas d&#39;aime ce projet s&#39;il a aide.<img alt="yes" src="https://armelsoubeiga.pythonanywhere.com/static/ckeditor/ckeditor/plugins/smiley/images/thumbs_up.png" style="height:23px; width:23px" title="yes" /></p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<h2>Les articles de blogs/presse</h2>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<p><span style="color:#3498db">Scraping</span></p>



<p>&nbsp;</p>



<p>L&rsquo;extraction de donn&eacute;es de blog diff&egrave;re de celle des r&eacute;seaux sociaux, car &eacute;videmment les blogs ne sont pas d&eacute;velopp&eacute;s par les m&ecirc;mes d&eacute;veloppeurs ni avec les m&ecirc;me technologies.</p>



<p>Dans le cadre de la r&eacute;cup&eacute;ration d&rsquo;articles de blog ou des donn&eacute;es sur site web, on va parler de scraping. C&rsquo;est le terme pour d&eacute;signer la r&eacute;cup&eacute;ration du contenu d&rsquo;un site web de mani&egrave;re automatis&eacute;e.&nbsp;</p>



<p><span style="color:#e74c3c"><strong>N&eacute;anmoins, il ne faut pas oublier que les articles de blogs font partie des propri&eacute;t&eacute;s intellectuelles, et selon l&rsquo;utilisation faite des donn&eacute;es scrap&eacute;es, cela peut entrer en conflit avec la l&eacute;gislation du pays en vigueur, ou du moins avec la volont&eacute; de l&rsquo;auteur.</strong></span></p>



<p>Il existe des services ready-to-use pour scraper des blogs et sites en g&eacute;n&eacute;ral. Les produits payants (APIFY, SCRAPERAPI), permettent notamment d&rsquo;esquiver le ban de l&rsquo;adresse IP, chose courante dans le cadre d&rsquo;un scraping massif et r&eacute;gulier.</p>



<p>Au niveau des solutions open source, le framework&nbsp;Scrapy, sous un environnement Python, et le package&nbsp;rvest&nbsp;sous R sont les r&eacute;f&eacute;rences. Muni d&rsquo;une tr&egrave;s bonne documentation, ils permettent notamment de localiser et de r&eacute;cup&eacute;rer directement le texte ou des donn&eacute;es entre les balises HTML/XML.</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<h3><span style="color:#3498db">Cas d&rsquo;usage 1: extraire des images</span></h3>



<p>&nbsp;</p>



<p>Il y&#39;a un mois environs lors un de mes projet (waxclasifier: application de classification des tissus africain d&eacute;ploy&eacute; sur une application Android) j&#39;ai parcouru plusieurs site web pour r&eacute;cup&eacute;rer des images.</p>



<p>Comme m&eacute;thode, pour chaque site il faut comprendre la structure du site et r&eacute;fl&eacute;chir sur un scripting pour extraire de fa&ccedil;on automatique les donn&eacute;es (les liens vers ces images dans ce cas).&nbsp;Ci-dessous un exemple d&rsquo;applique sur le site&nbsp;<a href="https://www.etsy.com/fr/shop/LAGRACEWAX"><span style="color:#3498db">https://www.etsy.com/fr/shop/LAGRACEWAX</span></a></p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif"><span style="font-family:&quot;Segoe UI&quot;,&quot;sans-serif&quot;"><span style="color:#212529"><img alt="https://armelsoubeiga.pythonanywhere.com/media/uploads/2020/01/23/image.png" src="https://armelsoubeiga.pythonanywhere.com/media/uploads/2020/01/23/image.png" style="height:622px; width:1583px" /></span></span></span></span></span></p>



<p style="text-align:center">Structure du site<span style="color:#3498db">&nbsp;</span><a href="https://www.etsy.com/"><span style="color:#3498db">https://www.etsy.com/</span></a></p>



<p style="text-align:center"><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>library(tidyverse) &nbsp;<br />

library(rvest) &nbsp; &nbsp;<br />

library(stringr) &nbsp;&nbsp;<br />

library(lubridate)<br />

library(tidyr)</code></span></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>url &lt;-&#39;https://www.etsy.com/fr/shop/LAGRACEWAX&#39;</code></span></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>#&gt;&gt;Recuperation des lien vers toutes les pages<br />

get_last_page &lt;- function(html){<br />

&nbsp; pages_data &lt;- html %&gt;%&nbsp;<br />

&nbsp; &nbsp; html_nodes(&#39;.wt-action-group__item&#39;) %&gt;%&nbsp;<br />

html_text() &nbsp; &nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />

&nbsp; pages_data[(length(pages_data)-1)] %&gt;% &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />

&nbsp; &nbsp; unname() %&gt;%&nbsp;<br />

&nbsp; &nbsp; str_extract(&quot;[[:digit:]]+&quot;) %&gt;%<br />

&nbsp; &nbsp; as.numeric() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br />

}</code></span></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>latest_page_number &lt;- get_last_page(read_html(url))<br />

urll &lt;- &#39;https://www.etsy.com/fr/shop/LAGRACEWAX?ref=items-pagination&amp;page=&#39;<br />

list_of_pages &lt;- str_c(urll,1:latest_page_number,&#39;&amp;sort_order=custom&#39;,sep=&#39;&#39;)</code></span></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>#&gt;&gt;Recuperation de tous les blocks dans chaque pages<br />

get_block &lt;- function(html){<br />

&nbsp; html %&gt;%&nbsp;<br />

&nbsp; &nbsp; html_nodes(&#39;.display-inline-block&#39;)%&gt;%&nbsp;<br />

&nbsp; &nbsp; html_attr(&quot;href&quot;) %&gt;%<br />

&nbsp; &nbsp; na.omit() &nbsp;%&gt;%<br />

&nbsp; &nbsp; as.character()<br />

}</code></span></div>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<p>Vous pouvez &eacute;galement trouve le reste du script et bien sur d&rsquo;autres sur mon compte github dans le r&eacute;pertoire du projet&nbsp;waxclassifier.&nbsp;</p>



<p>&nbsp;</p>



<h3><span style="color:#3498db">Cas d&rsquo;usage 2: extraire des donn&eacute;es</span></h3>



<p>Dans ce deuxi&eacute;me cas d&rsquo;utilisation il s&rsquo;agit d&rsquo;une extraction de donn&eacute;es sur des films et s&eacute;ries sur le site torrent9 &nbsp;(<a href="https://www.torrent9.pl/"><span style="color:#3498db">https://www.torrent9.pl/</span></a>) pour une application de syst&egrave;me de recommandation de films. Vous trouve le projet &eacute;galement sur mon compte github dans le repertoire&nbsp;movies-space.</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<p style="text-align:center"><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif"><span style="font-family:&quot;Segoe UI&quot;,&quot;sans-serif&quot;"><span style="color:#212529"><img alt="https://armelsoubeiga.pythonanywhere.com/media/uploads/2020/01/23/capture.PNG" src="https://armelsoubeiga.pythonanywhere.com/media/uploads/2020/01/23/capture.PNG" style="height:465px; width:984px" /></span></span></span></span></span></p>



<p style="text-align:center"><em>Repertoire du projet movies-space</em></p>



<p style="text-align:center"><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>#torrent url<br />

url &lt;-&#39;https://www.torrent9.pl/torrents/films/&#39;</code></span></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><br />

<span style="color:#000000"><code>#recuperer toutes les pages<br />

all_url &lt;- str_c(url,seq(51,1551,50),sep=&#39;&#39;)<br />

all_url &lt;- c(url,all_url)</code></span></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><br />

<span style="color:#000000"><code>#recuperer les urls sur une page<br />

get_url_by_page &lt;- function(html){<br />

&nbsp; url_ &lt;- html %&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_nodes(&#39;table td a &#39;)%&gt;%<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_attr(&quot;href&quot;)<br />

&nbsp; url_ &lt;- paste(&#39;https://www.torrent9.pl&#39;,url_,sep=&#39;&#39;)<br />

&nbsp; return(url_)<br />

}</code></span></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><br />

<span style="color:#000000"><code># Pour chaque activity pour chaque page get chaque entreprise et le lien<br />

get_entreprise_of_each_page &lt;- function(html){<br />

&nbsp; movie_title &lt;-html %&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_nodes(&#39;.movie-section .pull-left&#39;)%&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_text() %&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; str_trim()<br />

&nbsp;&nbsp;</code></span></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>&nbsp; movie_category &lt;-html %&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_nodes(&#39;.movie-information ul&gt;li&#39;)%&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_text() %&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; str_trim()<br />

&nbsp; a=data.frame(v1 = movie_category) %&gt;%&nbsp;<br />

&nbsp; &nbsp; mutate(v1 = strsplit(as.character(v1), &#39;:&#39;))<br />

&nbsp; b=read.table(text = gsub(&quot;\\s&quot;, &quot;&quot;, a$v1),&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;strip.white=TRUE, header = FALSE)<br />

&nbsp; b=b[b!=&#39;character(0)&#39;]<br />

&nbsp; movie_info_ &lt;- as.data.frame(matrix(b, ncol = 6, byrow = FALSE), stringsAsFactors = FALSE)<br />

&nbsp; movie_info &lt;- data.frame(movie_info_[2,])<br />

&nbsp; colnames(movie_info) &lt;- as.character(movie_info_[1,])<br />

&nbsp;&nbsp;<br />

&nbsp; movie_description &lt;-html %&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_nodes(&#39;.movie-information p&#39;)%&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_text()<br />

&nbsp; movie_description &lt;- movie_description[3]<br />

&nbsp;&nbsp;<br />

&nbsp; movie &lt;- cbind.data.frame(movie_title,movie_info,movie_description)<br />

&nbsp; return(movie)<br />

}</code></span></div>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<p>&nbsp;</p>



<h2>Conclusion</h2>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<p>En conclusion, il existe plusieurs services pour r&eacute;cup&eacute;rer la donn&eacute;e de nos chers r&eacute;seaux sociaux. Il faut cependant faire attention &agrave; bien cibler son besoin, afin de choisir une solution qui lui corresponde, tant au niveau des limitations qu&rsquo;au niveau des tarifs qui suivent.</p>



<p>Il est conseill&eacute; de bien lire la documentation des services pr&ecirc;ts &agrave; l&rsquo;emploi, qui peuvent parfois &ecirc;tre tricky. Certains vendent seulement une agr&eacute;gation d&rsquo;outils open-source ou d&rsquo;appels aux APIs sources, ce qui ne vaut pas forc&eacute;ment le co&ucirc;t <img alt="cool" src="https://armelsoubeiga.pythonanywhere.com/static/ckeditor/ckeditor/plugins/smiley/images/shades_smile.png" title="cool" />.</p>



<p><span style="font-size:12pt"><span style="background-color:white"><span style="font-family:&quot;Times New Roman&quot;,serif">&nbsp;</span></span></span></p>



<h2>Bibliographie</h2>



<p>[1]&nbsp;&nbsp;<a href="https://gwu-libraries.github.io/sfm-ui/posts/2018-01-02-facebook"><span style="color:#3498db">https://gwu-libraries.github.io/sfm-ui/posts/2018-01-02-facebook</span></a></p>



<p>[2]&nbsp;&nbsp;<a href="https://www.lebigdata.fr/reseaux-sociaux-big-data-0811"><span style="color:#3498db">https://www.lebigdata.fr/reseaux-sociaux-big-data-0811</span></a></p>



<p>[3]&nbsp;&nbsp;<a href="https://www.lebigdata.fr/reseaux-sociaux-big-data-0811"><span style="color:#3498db">https://www.lebigdata.fr/reseaux-sociaux-big-data-0811</span></a></p>
