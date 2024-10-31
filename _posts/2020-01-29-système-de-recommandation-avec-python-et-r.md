---
title: 'Système de recommandation avec Python et R'
date: 2020-01-29
permalink: /posts/2020/01/système-de-recommandation-avec-python-et-r
tags:
  - NLP
  - système recommandation
  - python
author_profile: false
toc: true
excerpt: "L'article traite de la collecte de données par scraping pour un système de recommandation, en identifiant les données clés. Il examine ensuite le fonctionnement d'un algorithme de similarité, avant de décrire l'intégration et le déploiement des processus dans l'application movie-space."
---

{% include toc %}

<h2><span style="font-family:Calibri,sans-serif">Introduction</span></h2>



<p>Dans la premi&egrave;re partie de cet article, nous nous int&eacute;resserons &agrave; la partie data collection. Nous verrons comment nous avons r&eacute;cup&eacute;r&eacute; ces donn&eacute;es (par scraping),&nbsp; et &agrave; quelles&nbsp;donn&eacute;es s&#39;int&eacute;resser&nbsp;dans un syst&egrave;me de recommandation. Dans la seconde partie nous nous int&eacute;resserons au fonctionnement th&eacute;orique et pratique d&#39;un&nbsp;syst&egrave;me&nbsp;de recommandation&nbsp;bas&eacute;e sur l&rsquo;algorithme de similarit&eacute;. Et enfin, l&rsquo;int&eacute;gration et le d&eacute;ploiement de tous ces processus dans notre application movie-space.</p>



<p>Vous pouvez consulter l&rsquo;application en ligne en suivant ce lien&nbsp;: <a href="http://movie-space.ga/"><span style="color:#3498db">http://movie-space.ga/</span></a> ou <span style="color:#3498db"><a href="https://movie-space.herokuapp.com/">https://movie-space.herokuapp.com/</a>. </span>Le projet est &eacute;galement consultable sur mon repertoire Github &agrave; travers ce lien :<span style="color:#3498db">&nbsp;</span><a href="https://github.com/armelsoubeiga/Movie-Space"><span style="color:#3498db">https://github.com/armelsoubeiga/Movie-Space</span></a></p>



<p>&nbsp;</p>



<h2><span style="font-family:Calibri,sans-serif">Collecte de donn&eacute;es par Scraping</span></h2>



<p>&nbsp;</p>



<p>Nous avons construit une base de donn&eacute;es de plus de 1600 films et de plus 2000 s&eacute;ries. Ces donn&eacute;es ont &eacute;t&eacute;&nbsp;obtenues&nbsp;par le raclage du web. En effet, nous avons r&eacute;cup&eacute;rer sur le site torrent <a href="https://www.torrent9.pl/"><span style="color:#3498db">https://www.torrent9.pl/</span></a> &nbsp;(attention c&rsquo;est un site web reconnu ill&eacute;galement en France). Bref mais l&rsquo;objectif c&rsquo;est de vous montrer comment on peut extraire ce type de donn&eacute;es.</p>



<p>Pour scraper un site web sans API, il faut essentiellement definir et comprendre ces trois (3) parties ci-dessous&nbsp;:</p>



<ul>

	<li>La structure du site web&nbsp;: dans notre cas, on a remarqu&eacute; que le site est organis&eacute; par onglets (onglet des films, onglet des s&eacute;ries, &hellip;). &nbsp;Ensuite sur chaque page on a un tableau de 50 films/s&eacute;ries qui s&rsquo;affichent (en claire les m&eacute;diats sont affich&eacute;s&nbsp;par 50 sur chaque page). On a le nom, les nombres d&rsquo;enregistrement des torrents. On peut &eacute;galement voir que chaque nom constitue&nbsp;un lien qui pointe vers les informations d&eacute;tails de ce media. J&rsquo;appelle cette partie la conception de l&rsquo;algorithme de scraping.</li>

</ul>



<p>&nbsp;</p>



<p>&nbsp;</p>



<p style="text-align:center"><img alt="" src="/images/media/uploads/2020/01/29/1.png" style="height:318px; width:500px" /></p>



<p style="text-align:center"><em>Structure visuelle du site web</em></p>



<p style="text-align:center">&nbsp;</p>



<ul>

	<li>Le d&eacute;veloppement des diff&eacute;rentes fonctions pour acc&eacute;der et parcourir le sch&eacute;ma d&eacute;fini ci-dessous de fa&ccedil;on s&eacute;par&eacute;.</li>

</ul>



<p>&nbsp;</p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>library(rvest) &nbsp; &nbsp;<br />

library(stringr) &nbsp;&nbsp;<br />

library(dplyr)</code></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>#torrent url<br />

url &lt;-&#39;https://www.torrent9.pl/torrents/films/&#39;</code></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>#recuperer toutes les pages<br />

all_url &lt;- str_c(url,seq(51,1551,50),sep=&#39;&#39;)<br />

all_url &lt;- c(url,all_url)</code></div>



<p style="text-align:center"><em>Recuperation des lien de toutes les pages des 1600 films</em></p>



<p style="text-align:center">&nbsp;</p>



<p style="text-align:center">&nbsp;</p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>get_url_by_page &lt;- function(html){<br />

&nbsp; url_ &lt;- html %&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_nodes(&#39;table td a &#39;)%&gt;%<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_attr(&quot;href&quot;)<br />

&nbsp; url_ &lt;- paste(&#39;https://www.torrent9.pl&#39;,url_,sep=&#39;&#39;)<br />

&nbsp; return(url_)<br />

}</code></div>



<p style="text-align:center"><em>R&eacute;cup&eacute;ration des urls (50 films) sur une page</em>&nbsp;</p>



<p style="text-align:center">&nbsp;</p>



<p style="text-align:center">&nbsp;</p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>get_data_of_each_page &lt;- function(html){<br />

&nbsp; movie_title &lt;-html %&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_nodes(&#39;.movie-section .pull-left&#39;)%&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_text() %&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; str_trim()<br />

&nbsp;&nbsp;<br />

&nbsp; movie_category &lt;-html %&gt;%&nbsp;<br />

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

&nbsp;&nbsp;movie_description &lt;-html %&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_nodes(&#39;.movie-information p&#39;)%&gt;%&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; html_text()<br />

&nbsp; movie_description &lt;- movie_description[3]<br />

&nbsp;&nbsp;<br />

&nbsp; movie &lt;- cbind.data.frame(movie_title,movie_info,movie_description)<br />

&nbsp; return(movie)<br />

}</code></div>



<p style="text-align:center"><em>R&eacute;cup&eacute;ration des informations de chaque film&nbsp;</em></p>



<p style="text-align:center">&nbsp;</p>



<ul>

	<li>En in l&rsquo;automatisation de tout le processus en connectant les diff&eacute;rentes fonctions programm&eacute;es.</li>

</ul>



<p>&nbsp;</p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>cbind.fill &lt;- function(...){<br />

&nbsp; nm &lt;- list(...)&nbsp;<br />

&nbsp; nm &lt;- lapply(nm, as.matrix)<br />

&nbsp; n &lt;- max(sapply(nm, nrow))&nbsp;<br />

&nbsp; do.call(cbind, lapply(nm, function (x)&nbsp;<br />

&nbsp; &nbsp; rbind(x, matrix(data = NA, n-nrow(x), ncol(x)))))&nbsp;<br />

}<br />

#Scraping all data<br />

all_movie_data &lt;- data.frame()</code></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>for(page_url in all_url){</code></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>&nbsp; print(page_url)<br />

&nbsp; read_page_url &lt;- read_html(page_url)<br />

&nbsp; liste_page_movie &lt;- get_url_by_page(read_page_url)<br />

&nbsp; page_movie_data &lt;- data.frame()<br />

&nbsp;&nbsp;<br />

&nbsp; for(movie_url in liste_page_movie){<br />

&nbsp; &nbsp; print(movie_url)<br />

&nbsp; &nbsp; read_movie_url &lt;- read_html(movie_url)<br />

&nbsp; &nbsp; movie_data &lt;- get_data_of_each_page(read_movie_url)<br />

&nbsp; &nbsp;&nbsp;<br />

&nbsp; &nbsp; page_movie_data &lt;- rbind.data.frame(page_movie_data,movie_data)<br />

&nbsp; }<br />

&nbsp;&nbsp;<br />

&nbsp; all_movie_data &lt;- rbind.data.frame(all_movie_data,page_movie_data)<br />

}</code></div>



<p style="text-align:center"><em>Automatisation de tout le processus</em></p>



<p>&nbsp;</p>



<p>NB:&nbsp;il s&rsquo;agit d&rsquo;un cas assez simple de r&eacute;cup&eacute;ration des donn&eacute;es. En fonction des besoins cela peut &ecirc;tre plus compliqu&eacute;&nbsp;que &ccedil;a.</p>



<p>&nbsp;</p>



<h2><span style="font-family:Calibri,sans-serif">Syst&egrave;mes de recommandation</span></h2>



<p>&nbsp;</p>



<blockquote>

<p>&laquo; N&rsquo;&eacute;coute pas tes sentiments, &eacute;coute l&rsquo;algorithme, il te conna&icirc;t mieux. &raquo;</p>

</blockquote>



<p>Les syst&egrave;mes de recommandation (SRec) visent &agrave; proposer des &laquo; articles &raquo; (items) &agrave; des &laquo; utilisateurs &raquo; (users). Employ&eacute;s au d&eacute;part dans le commerce en ligne, leur domaine d&rsquo;application ne cesse de s&rsquo;&eacute;largir : musique, films, livres, sites web, blogs, destinations de voyages, applications pour mobiles, publications de recherche, etc. Les SRec int&egrave;grent des informations de diff&eacute;rents types, issues de plusieurs sources, explicites ou implicites : caract&eacute;ristiques des utilisateurs et des articles, filtrage collaboratif, liens sociaux entre utilisateurs, donn&eacute;es issues des capteurs (par ex. GPS), etc.</p>



<p>Il existe plusieurs m&eacute;thodes et approches de recommandation. Une synth&egrave;se assez r&eacute;cente des approches employ&eacute;es pour les SRec en g&eacute;n&eacute;ral peut &ecirc;tre trouv&eacute;e dans [BOH13]. Il est &eacute;galement int&eacute;ressant de lire [BGL15], une synth&egrave;se sur les SRec de publications de recherche.</p>



<p>Dans la conception de notre application de recommandation de film et s&eacute;rie, nous avons utilis&eacute; la m&eacute;thode de recommandation par similarit&eacute; de contenu (content-based filtering). Pour cette m&eacute;thode, un acc&egrave;s aux descriptions des articles est indispensable. Le principe est le suivant : &agrave; partir des descriptions des films ou des s&eacute;ries choisis par un utilisateur, sont ensuite propos&eacute;s &agrave; cet utilisateur des films ou s&eacute;ries dont les caract&eacute;ristiques sont similaires &agrave; son choix.</p>



<p>&nbsp;</p>



<p>Les variables de descriptions sont diverses. On a les acteurs, les nombres de t&eacute;l&eacute;chargements, l&rsquo;ensemble de mots de description textuelle. Les informations de la cat&eacute;gorie et aux sous-cat&eacute;gories du film ou la s&eacute;rie (par ex. le genre d&rsquo;un film). Ces variables sont ensuite pond&eacute;r&eacute;es par des m&eacute;thodes simples, par ex. term frequency (degr&eacute; de pr&eacute;sence x &laquo; potentiel discriminant &raquo;).</p>



<p>&nbsp;</p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>&nbsp; &nbsp; &nbsp; &nbsp; df = df[[&#39;Title&#39;, &#39;Genre&#39;, &#39;Plot&#39;]] #&#39;Seed&#39;, &#39;Leech&#39;, &#39;Poidsdutorrent&#39;,<br />

&nbsp; &nbsp; &nbsp; &nbsp; df[&#39;Genre.plot&#39;] = df[&#39;Genre&#39;]<br />

&nbsp; &nbsp; &nbsp; &nbsp; df[&#39;Plot.plot&#39;] = df[&#39;Plot&#39;]<br />

&nbsp; &nbsp; &nbsp; &nbsp; df[&#39;Plot.plot&#39;].fillna(&#39;Sorry ! Pas de descriptions&#39;, inplace=True)<br />

&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; df[&#39;Genre&#39;] = df[&#39;Genre&#39;].map(lambda x: x.lower().split(&#39;,&#39;))<br />

&nbsp; &nbsp; &nbsp; &nbsp; df[&#39;Plot&#39;] = df[&#39;Plot&#39;].map(lambda x: str(x).lower().split())</code></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; nltk.download(&quot;stopwords&quot;)<br />

&nbsp; &nbsp; &nbsp; &nbsp; nltk.download(&#39;punkt&#39;)<br />

&nbsp; &nbsp; &nbsp; &nbsp; df[&#39;Key_words&#39;] = &quot;&quot;<br />

&nbsp; &nbsp; &nbsp; &nbsp; for index, row in df.iterrows():<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; plot = row[&#39;Plot&#39;]<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r = Rake()<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r.extract_keywords_from_text(str(plot))<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; key_words_dict_scores = r.get_word_degrees()<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; row[&#39;Key_words&#39;] = list(key_words_dict_scores.keys())</code></div>



<p>&nbsp;</p>



<p>&nbsp;</p>



<p>On applique &eacute;galement une r&eacute;duction de dimension &agrave; la description textuelle (la description des diff&eacute;rents films ou s&eacute;rie). Cela nous permet de r&eacute;sumer les variables initiales par un plus petit nombre de variables (r&eacute;v&eacute;ler des &laquo; facteurs &raquo;), ce qui diminue en g&eacute;n&eacute;ral le &laquo; bruit &raquo; pr&eacute;sent dans les descriptions et r&eacute;duit la gravit&eacute; de la mal&eacute;diction de la dimension.</p>



<p>&nbsp;</p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>def simila(a,b):<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pro =[]<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for i in b.index:<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; seq = difflib.SequenceMatcher(None,a, b[i])<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rat= seq.ratio()*100<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pro.append(rat)<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; idx = pro.index(max(pro))<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return(idx)<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</code></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><br />

<code>&nbsp; &nbsp; &nbsp; &nbsp; def recommendations(title):<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; recommended_movies = []<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; recommended_movies_genre = []<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; recommended_movies_desc = []<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; try:<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; idx = simila(title,indices)<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #idx = indices[indices == title].index[0]<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; except:<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; res = &quot;This movie in not registered in our database&quot;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; genre = &#39;NaN&#39;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; desc = &#39;NaN&#39;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return res, [&#39;0&#39;], genre, desc<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # creating a Series with the similarity scores in descending order<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; score_series = pd.Series(cosine_sim[idx]).sort_values(ascending=False)<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; top_3_indexes = list(score_series.iloc[1:4].index)<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for i in top_3_indexes:<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; recommended_movies.append(list(df.index)[i])<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; recommended_movies_genre.append(df[&#39;Genre.plot&#39;][i])<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; recommended_movies_desc.append(df[&#39;Plot.plot&#39;][i])<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br />

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return recommended_movies, score_series[1:4],recommended_movies_genre, recommended_movies_desc</code><br />

&nbsp;</div>



<p>&nbsp;</p>



<h2><span style="font-family:Calibri,sans-serif"><span style="font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">D&eacute;ploiement de l&rsquo;application en ligne</span></span></h2>



<p>&nbsp;</p>



<p><span style="color:#3498db"><span style="font-size:11pt"><span style="font-family:Calibri,sans-serif"><span style="font-size:12.0pt"><span style="font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">D&eacute;veloppement de l&rsquo;application</span></span></span></span></span></p>



<p><span style="font-size:11pt"><span style="font-family:Calibri,sans-serif"><span style="font-size:12.0pt"><span style="font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">Pour le d&eacute;ploiement de notre application de recommandation de film et s&eacute;rie, nous avons&nbsp;utilis&eacute; le Framework Flask.</span></span></span></span></p>



<p>&nbsp;</p>



<p><img alt="Résultat de recherche d'images pour &quot;Framework Flask&quot;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Flask_logo.svg/1200px-Flask_logo.svg.png" style="height:196px; width:500px" /></p>



<p style="text-align:center"><em><span style="font-size:11pt"><span style="font-family:Calibri,sans-serif"><span style="font-size:12.0pt"><span style="font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">image de flask</span></span></span></span></em></p>



<p style="text-align:center">&nbsp;</p>



<p>Flask est un Framework open-source de d&eacute;veloppement web en Python. Son but principal est d&#39;&ecirc;tre l&eacute;ger, afin de garder la souplesse de la programmation Python, associ&eacute; &agrave; un syst&egrave;me de templates. Il est le deuxi&egrave;me le plus r&eacute;pandu et le plus utilis&eacute; apr&egrave;s Django. A c&ocirc;te de ces deux Framework Web en Python ont &eacute;galement (Pyramid, CherryPy, Twisted, &hellip;)</p>



<p>&nbsp;</p>



<p>Dans notre application, nous avons deux parties essentielles. La partie UI, d&eacute;veloppe en html et css qui est l&rsquo;interface d&rsquo;utilisateur (font-end). Qui permet de d&eacute;finir les variables d&rsquo;entr&eacute;es et de sorties.</p>



<p>&nbsp;</p>



<p><img alt="" src="/images/media/uploads/2020/01/29/capture.PNG" style="height:458px; width:900px" /></p>



<p style="text-align:center"><em>Un extrait de l&#39;UI de l&#39;application</em></p>



<p>&nbsp;</p>



<p>La partie SERVEUR, qui sert de back-end. Elle prend en charge les fonctions python d&eacute;velopp&eacute;es pour ex&eacute;cuter les t&acirc;ches d&eacute;finies plus haut. En effet, les calculs de similarit&eacute; et de recommandation sont ex&eacute;cutes par python et les r&eacute;sultats sont estitu&eacute;s au UI.</p>



<p>&nbsp;</p>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code># Rating Page<br />

@app.route(&quot;/&quot; , methods=[&quot;GET&quot;, &quot;POST&quot;])<br />

def rating():<br />

&nbsp; &nbsp; return render_template(&#39;welcome.html&#39;)</code></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><br />

<code># Results Page<br />

@app.route(&quot;/recommendation&quot;, methods=[&quot;GET&quot;, &quot;POST&quot;])<br />

def recommendation():<br />

&nbsp; &nbsp; if request.method == &#39;POST&#39;:</code></div>



<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px">&nbsp; &nbsp; &nbsp; ...</div>



<p style="text-align:center"><em>Un&nbsp;extrait&nbsp; du code de la partie serveur&nbsp;python</em></p>



<p style="text-align:center">&nbsp;</p>



<h3><span style="color:#3498db"><span style="font-size:11pt"><span style="font-family:Calibri,sans-serif"><span style="font-size:12.0pt"><span style="font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">Serveur de d&eacute;ploiement</span></span></span></span></span></h3>



<p style="text-align:center"><img alt="" src="/images/media/uploads/2020/01/29/telechargement.png" style="height:146px; width:346px" /></p>



<p style="text-align:center"><em>logo heroku</em></p>



<p>Pour cette application j&rsquo;ai choisi de la d&eacute;ployer&nbsp;sur HEROKU. Heroku est une entreprise cr&eacute;ant des logiciels pour serveur qui permettent le d&eacute;ploiement d&#39;applications web. Cr&eacute;&eacute;e en 2007, elle est rachet&eacute;d en 2010 par l&#39;&eacute;diteur Salesforce.com.</p>



<p>Vous pouvez avoir plus d&rsquo;informations sur ce lien&nbsp;: <a href="https://dashboard.heroku.com/"><span style="color:#3498db">https://dashboard.heroku.com/</span></a></p>



<p>&nbsp;</p>



<h2><span style="font-family:Calibri,sans-serif">Resource</span></h2>



<p><span style="color:#3498db">[BOH13] :&nbsp;</span>Bobadilla, J., F. Ortega, A. Hernando, A. Guti&eacute;rez. Recommender systems survey. Knowledge-Based Systems, 46:109&ndash;132, July 2013.</p>



<p><span style="color:#3498db">[BGL15] :&nbsp;</span>Beel, J., B. Gipp, S. Langer, C. Breitinger. Research-paper recommender systems: a literature survey. International Journal on Digital Libraries, pages 1&ndash;34, 2015.</p>



<p><span style="font-size:11pt"><span style="font-family:Calibri,sans-serif">Scikit-learn @ Fondation Inria:&nbsp;</span></span><a href="https://scikit-learn.fondation-inria.fr/accueil/"><span style="color:#3498db">https://scikit-learn.fondation-inria.fr/accueil/</span></a></p>
