---
title: 'Scraping et visualisation des données Facebook avec  R'
date: 2020-01-31
permalink: /posts/2020/01/scraping-et-visualisation-des-données-facebook-avec--r
tags:
  - scraping
  - visualisation
  - des
author_profile: false
toc: true
---

{% include toc %}

<h2>Introduction</h2>

<p>Dans mon pr&eacute;c&eacute;dant article, j&#39;ai montr&eacute;&nbsp;combien les r&eacute;seaux sociaux constituaient&nbsp; une mine d&#39;or de donn&eacute;es. Dans ce article, nous allons gratter les donn&eacute;es de Facebook avec le package <em>Rfacebook</em>. Ensuite, nous utiliserons <em>ggplot2</em> pour nos visualisations. Je vais utiliser les donn&eacute;es d&#39;un groupe priv&eacute; que je partageais&nbsp;avec des amis pour publier des liens vers de la musique qui, selon nous, m&eacute;ritaient&nbsp;d&#39;&ecirc;tre &eacute;cout&eacute;es, mais cela peut &ecirc;tre appliqu&eacute; &agrave; n&#39;importe quelle page Facebook. Particuli&egrave;rement utile si vous&nbsp;voulez essayer de donner un sens aux donn&eacute;es d&#39;un groupe Facebook, ou si vous &ecirc;tes juste un narcissique enrag&eacute; et que vous voulez savoir &agrave; quelle heure de la journ&eacute;e pour publier votre photo de profil pour avoir le plus de likes.</p>

<p>&nbsp;</p>

<h2>Data Scraping par API</h2>

<p>Nous allons commencer par charg&eacute; les packages n&eacute;cessaire pour le raclage te la visualisation.</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>library(Rfacebook)<br />
library(tidyverse)<br />
library(forcats)<br />
library(lubridate)<br />
library(hrbrthemes)<br />
library(ggalt)<br />
library(ggbeeswarm)<br />
library(plotly)</code></span></div>

<p>&nbsp;</p>

<p>Maintenant, pour acc&eacute;der &agrave; l&#39;API Facebook, vous devez vous rendre sur <a href="https://developers.facebook.com/tools/explorer"><span style="color:#3498db">le site des d&eacute;veloppeurs de Facebook</span></a> , cr&eacute;er votre propre &lt;&lt;application &gt;&gt;, puis enregistrer le token qu&#39;il vous donne en tant que variable pour faciliter l&#39;utilisation plus tard.</p>

<p>Une fois cela fait, enregistrez votre group_id en tant que variable (normalement c&#39;est un nombre &agrave; 15 chiffres qui vient apr&egrave;s le nom du groupe dans&nbsp;l&#39;URL du groupe).</p>

<p>NB: vous pouvez &eacute;galement essayer cela avec des pages&nbsp;Facebook publics. Collez simplement l&#39;ID de la page.</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>token &lt;- &#39;XXXXXXXXXXXXXXXXXXXXX&#39;</code></span></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>group_id &lt;- &#39;XXXXXXXXXXXXXXXXXX&#39;</code></span></div>

<p>&nbsp;</p>

<p>Maintenant, construisons une fonction qui fera tout le n&eacute;cessaire pour nous et produira une trame de donn&eacute;es bien rang&eacute;e avec uniquement les donn&eacute;es qui nous int&eacute;ressent. Dans notre cas, ce sera le titre d&#39;une vid&eacute;o youtube qui sera tr&egrave;s probablement un titre de chanson. Cela me permet de savoir rapidement quelles chansons ont &eacute;t&eacute; publi&eacute;es dans le groupe sans avoir &agrave; suivre chaque URL.</p>

<p>Cela n&eacute;cessite un peu de travail suppl&eacute;mentaire dans la fonction car la fonction getGroup de Rfacebook ne renvoie pas les titres des liens, seulement les URL. Mais si vous n&#39;avez pas besoin de ces informations, vous pouvez les ignorer et votre vie est beaucoup plus facile.&nbsp;</p>

<p>Les principales modifications que nous allons effectuer sont toutes li&eacute;es &agrave; la date et l&#39;heure. Pour explorer diverses relations entre les publications dans le groupe et l&#39;heure, il est utile d&#39;agr&eacute;ger jusqu&#39;&agrave; des cat&eacute;gories de temps plus larges. Facebook nous donne la date et l&#39;heure de chaque publication &agrave; la seconde exacte. Nous arrondirons ensuite cette date &agrave; la minute, l&#39;heure, le jour de la semaine et le mois.&nbsp;</p>

<p>Voici la fonction de grattage compl&egrave;te. La variable limit permet de d&eacute;finir combien de publications nous voulons r&eacute;cup&eacute;rer sur les serveurs de Facebook. Sans cela, vous obtenez 25 messages assez path&eacute;tiques, mais l&#39;une de mes motivations pour ce faire &eacute;tait d&#39;obtenir un acc&egrave;s instantan&eacute; aux messages historiques remontant au d&eacute;but du groupe fin 2015 jusqu&#39;&agrave; 2017 l&#39;ann&eacute;e &agrave; laquelle le groupe est rest&eacute; inactive (parce qu&#39;on devenait plus responsable).<br />
&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>group_scrape &lt;- function(token, group_id, limit) {<br />
&nbsp;&nbsp;<br />
&nbsp; #fonction pour traiter les dates<br />
&nbsp; format.facebook.date &lt;- function(datestring) {<br />
&nbsp; date &lt;- as.POSIXct(datestring, format = &quot;%Y-%m-%dT%H:%M:%S+0000&quot;, tz = &quot;GMT&quot;)<br />
&nbsp; }<br />
&nbsp;&nbsp;<br />
&nbsp; #appel de la fonction Rfacebook&nbsp;<br />
&nbsp; data_main &lt;- &nbsp;getGroup(group_id, token, feed = TRUE, n = limit)<br />
&nbsp;&nbsp;<br />
&nbsp; #appel de l&#39;API poour obtenir le nom du lien dans toute publication qui en a un<br />
&nbsp; link_names &lt;- callAPI(paste0(&quot;https://graph.facebook.com/v2.9/&quot;, group_id,&nbsp;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;?fields=feed.limit(&quot;, limit, &quot;){name}&quot;), token)</code></span></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>&nbsp; #fonction pour extraire les donn&eacute;es des listes et les placer dans data_main<br />
&nbsp; link_names &lt;- bind_rows(lapply(link_names$feed$data, as.data.frame))<br />
&nbsp;&nbsp;<br />
&nbsp; #Gestion des dates<br />
&nbsp; days &lt;- c(&quot;Monday&quot;, &quot;Tuesday&quot;, &quot;Wednesday&quot;, &quot;Thursday&quot;, &quot;Friday&quot;, &quot;Saturday&quot;, &quot;Sunday&quot;)<br />
&nbsp;&nbsp;<br />
&nbsp; #fusionner les deux jeux de donn&eacute;es sur la variable id post<br />
&nbsp; final &lt;- merge(data_main, link_names, by = &quot;id&quot;)<br />
&nbsp;&nbsp;<br />
&nbsp; #suppression les publications qui ne contiennent pas de lien<br />
&nbsp; final &lt;- final[complete.cases(final[,12]),] %&gt;%<br />
&nbsp; &nbsp; mutate(created_time = format.facebook.date(created_time),<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Date = as.Date(created_time, format = &quot;%d/%m/%y&quot;),<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Minute = make_datetime(2017, 01, 01, hour(created_time), minute(created_time), 0, tz = &quot;GMT&quot;),<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Hour = make_datetime(2017, 01, 01, hour(created_time), 0, 0, tz = &quot;GMT&quot;),<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Day = factor(weekdays(created_time), levels = days),<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Month = make_date(year(created_time), month(created_time), 01),<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Link = paste0(&quot;&lt;a href=&#39;&quot;,link,&quot;&#39; target=&#39;_blank&#39;&gt;&quot;,&quot;open link...&quot;,&quot;&lt;/a&gt;&quot;)) %&gt;%<br />
&nbsp; &nbsp; select(Date, Month, `Posted By` = from_name, Track = name, Day, Hour, Minute, Likes = likes_count,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Comments = comments_count, Link)<br />
&nbsp;&nbsp;<br />
&nbsp; #suppression des emojis<br />
&nbsp; final$Track &lt;- sapply(final$Track, function(row) iconv(row, &quot;latin1&quot;, &quot;ASCII&quot;, sub=&quot;&quot;))<br />
&nbsp;&nbsp;<br />
&nbsp; return(final)<br />
}</code></span></div>

<p>&nbsp;</p>

<p>Maintenant, appellons la fonction group_scrape avec notre token, group_id et limit=1500 pour les 1500 messages</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>tunes &lt;- group_scrape(token = token, group_id = group_id, limit = 1500)</code></span></div>

<p>&nbsp;</p>

<h2>Visualisation des donn&eacute;es &nbsp;</h2>

<p>&nbsp;</p>

<p>Je vais explorer quelques relations dans les donn&eacute;es &agrave; titre d&#39;exemple.<br />
Pour &eacute;viter que mes amis et moi-m&ecirc;me ne soyons g&ecirc;n&eacute;s par des choses comme les post-pitoyables: j&#39;aime anonymiser les noms des membres du groupe.</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>per_month &lt;- count(tunes, &#39;Posted By&#39;, Month) %&gt;%<br />
&nbsp; mutate(&#39;Posted By&#39; = &#39;Posted By&#39; %&gt;% fct_rev())</code></span></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>ggplot(per_month, aes(Month, n, group = `Posted By`, fill = `Posted By`)) +<br />
&nbsp; geom_area(alpha = 0.7) +<br />
&nbsp; theme_ipsum_rc(caption_size = 12) +<br />
&nbsp; scale_x_date(date_labels = &quot;%b %Y&quot;, date_breaks = &quot;2 months&quot;) +<br />
&nbsp; scale_fill_brewer(palette = &quot;Dark2&quot;) +<br />
&nbsp; labs(y = &quot;&quot;, x = &quot;&quot;, title = &quot;Facebook Group&quot;, subtitle = &quot;Posts per Month&quot;) +<br />
&nbsp; theme(legend.direction = &quot;horizontal&quot;, legend.position=c(0.8, 1.05))</code></span></div>

<p>&nbsp;</p>

<p><img alt="" src="images/media/uploads/2020/02/02/capture_9MKcDvx.PNG" style="height:246px; width:700px" /></p>

<p>&nbsp;</p>

<p>Nous allons maintenant essayer de regarder le message par jour de la semaine puis par heure pour voir s&#39;il y a des variations sensibles.</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code><tt>per_day &lt;- count(tunes, Day) %&gt;%<br />
&nbsp; mutate(Day = Day %&gt;% fct_rev())</tt></code></span></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code><tt>ggplot(per_day, aes(n, Day)) +<br />
&nbsp; geom_lollipop(point.colour = &quot;SteelBlue&quot;, point.size = 4, horizontal = TRUE) +<br />
&nbsp; theme_ipsum_rc(grid = &quot;X&quot;, caption_size = 12) +<br />
&nbsp; labs(y = &quot;&quot;, x = &quot;&quot;, title = &quot;Facebook Group&quot;, subtitle = &quot;Posts per Day&quot;)</tt></code></span></div>

<p>&nbsp;</p>

<p><img alt="" src="images/media/uploads/2020/02/02/capture1.PNG" style="height:253px; width:700px" /></p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>per_hour &lt;- count(tunes, Hour)</code></span></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><code>ggplot(per_hour, aes(Hour, n)) +<br />
&nbsp; geom_bar(stat = &quot;identity&quot;, fill = &quot;SteelBlue&quot;) +<br />
&nbsp; theme_ipsum_rc(caption_size = 12) +<br />
&nbsp; scale_x_datetime(date_labels = &quot;%H:%M&quot;, date_breaks = &quot;2 hours&quot;) +<br />
&nbsp; labs(y = &quot;&quot;, x = &quot;&quot;, title = &quot;Facebook Group&quot;, subtitle = &quot;Posts per Hour&quot;)</code></span><br />
&nbsp;</div>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><img alt="" src="images/media/uploads/2020/02/02/capture2.png" style="height:292px; width:700px" /></p>

<p>&nbsp;</p>

<h2>Conclusion</h2>

<p>&nbsp;</p>

<p>C&#39;est tout pour cet article. Si vous avez des pens&eacute;es ou des questions ou d&#39;autres id&eacute;es pour am&eacute;liorer mes articles, merci de mes les laisse en commentaire.</p>

<p>Et si vous souhaitez donner vie &agrave; vos donn&eacute;es avec une visualisation sur mesure comme ci-dessus, contactez-moi.</p>

<p>&nbsp;</p>
