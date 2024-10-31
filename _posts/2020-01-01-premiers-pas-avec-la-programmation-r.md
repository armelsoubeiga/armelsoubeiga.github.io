---
title: 'Premiers pas avec la programmation R'
date: 2020-01-01
permalink: /posts/2020/01/premiers-pas-avec-la-programmation-r
tags:
  - premiers
  - pas
  - programmation
author_profile: false
toc: true
excerpt: 'R est un langage de programmation ax eacute sur l 39 analyse statistique et graphique nbsp Il est donc couramment utilis eacute dans l 39 inf eacute rence statistique l 39 analyse des donn eacute es et l 39 apprentissage'
---

{% include toc %}

<h2>Introduction</h2>

<p>R est un langage de programmation ax&eacute; sur l&#39;analyse statistique et graphique.&nbsp;Il est donc couramment utilis&eacute; dans l&#39;inf&eacute;rence statistique, l&#39;analyse des donn&eacute;es et l&#39;apprentissage automatique.&nbsp;R est actuellement l&#39;un des langages de programmation les plus demand&eacute;s sur le march&eacute; du travail en science des donn&eacute;es (figure 1).</p>

<p>&nbsp;</p>

<p><img alt="Figure 1: Langages de programmation les plus demandés pour la science des données en 2019 [1]" src="https://cdn-images-1.medium.com/max/2000/1*lsI8O_2yGfYoUpCT6kNynw.png" /></p>

<h5 style="margin-left:120px">Figure 1: Langages de programmation les plus demand&eacute;s pour la science des donn&eacute;es en 2019 [1]</h5>

<p style="margin-left:80px">&nbsp;</p>

<p>R est disponible pour &ecirc;tre install&eacute; &agrave; partir de&nbsp;<a href="http://www.r-project.org/"><span style="color:#3498db">r-project.org</span></a>&nbsp;et l&#39;un des R environnement de d&eacute;veloppement int&eacute;gr&eacute; (IDE) le plus utilis&eacute; est certainement&nbsp;<a href="http://www.rstudio.com/ide/"><span style="color:#3498db">RStudio</span></a>.&nbsp;</p>

<p>IL existe deux principaux types de packages (bliblioth&egrave;ques) qui peuvent &ecirc;tre utilis&eacute;s pour ajouter des fonctionnalit&eacute; &agrave; R: les packages de base et les packages distribu&eacute;s. Les packages de base sont livr&eacute;s avec l&#39;installation de R, les packages distribu&eacute;s peuvent &ecirc;tre t&eacute;l&eacute;charg&eacute;s gratuitement &agrave; l&#39;aide du CRAN.</p>

<p>Une fois R install&eacute;, nous pouvons commencer &agrave; faire quelques analyses&nbsp; de donn&eacute;es.</p>

<p>&nbsp;</p>

<h2>Analyse des donn&eacute;es</h2>

<p>Dans cet exemple, je vais vous guider &agrave; travers une analyse de bout en bout de l&#39;ensemble de donn&eacute;es de&nbsp;<a href="https://www.kaggle.com/iabhishekofficial/mobile-price-classification#train.csv"><span style="color:#3498db">classification des prix de t&eacute;l&eacute;phones mobiles</span></a>&nbsp;disponible sur Kaggle&nbsp;pour pr&eacute;dire la fourchette de prix des t&eacute;l&eacute;phones mobiles. Le code que j&#39;ai utilis&eacute; pour cette d&eacute;monstration est disponible sur mon compte <a href="https://github.com/armelsoubeiga/Blog-Examples/tree/master/Getting-Started-With-R-Programming"><span style="color:#3498db">Github : Getting-Started-With-R-Programming</span></a><span style="color:#3498db">.</span></p>

<p>&nbsp;</p>

<h3 style="text-align:start"><span style="color:#9b59b6"><span style="font-size:17.6px"><span style="font-family:&quot;Open Sans&quot;,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif">Importation de biblioth&egrave;ques</span></span></span></h3>

<p>Tout d&#39;abord, nous devons importer toutes les biblioth&egrave;ques n&eacute;cessaires.</p>

<p>Les packages peuvent &ecirc;tre install&eacute;s dans R &agrave; l&#39;aide de la commande <code><em><strong>install.packages()</strong></em></code> puis charg&eacute;s &agrave; l&#39;aide de la commande <em><strong><code>library()</code>. </strong></em>Dans ce cas, j&#39;ai d&eacute;cid&eacute; d&#39;installer d&#39;abord <em><strong>PACMAN</strong></em> (Package Management Tool) puis de l&#39;utiliser pour installer et charger tous les autres packages. <em><strong>PACMAN</strong></em> facilite le chargement de la biblioth&egrave;que car il peut installer et charger toutes les biblioth&egrave;ques n&eacute;cessaires dans une seule ligne de code.</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#000000"><span style="font-family:Comic Sans MS,cursive"><em><code>.rs.restartR() # Restart Kernel Session<br />
install.packages(&quot;pacman&quot;)<br />
library(pacman)<br />
pacman::p_load(pacman,dplyr, ggplot2, rio, gridExtra, scales, ggcorrplot, caret, e1071)</code></em></span></span>&nbsp;</div>

<p>&nbsp;</p>

<p>Les packages import&eacute;s sont utilis&eacute;s pour ajouter les fonctionnalit&eacute;s suivantes:&nbsp;</p>

<ul style="margin-left:40px">
	<li><strong>dplyr</strong>:&nbsp;traitement et analyse des donn&eacute;es.</li>
	<li><strong>ggplot2</strong>:&nbsp;visualisation des donn&eacute;es.</li>
	<li><strong>rio</strong>:&nbsp;importation et exportation de donn&eacute;es.</li>
	<li><strong>gridExtra</strong>:&nbsp;pour cr&eacute;er des trac&eacute;s d&#39;objets graphiques auxquels vous&nbsp;pouvez librement disposer sur une page.</li>
	<li><strong>scales:</strong>&nbsp;utilis&eacute;es pour mettre &agrave; l&#39;&eacute;chelle les donn&eacute;es dans les graphiques.</li>
	<li><strong>ggcorrplot</strong>:&nbsp;est utilis&eacute; pour visualiser les matrices de corr&eacute;lation en utilisant ggplot2 dans le backend.</li>
	<li><strong>caret:</strong>&nbsp;est utilis&eacute; pour former et tracer des mod&egrave;les de classification et de r&eacute;gression.</li>
	<li><strong>e1071:</strong>&nbsp;contient des fonctions pour ex&eacute;cuter des algorithmes d&#39;apprentissage automatique tels que les machines &agrave; vecteurs de support, Naive Bayes.</li>
	<li><strong>etc.</strong></li>
</ul>

<p>&nbsp;&nbsp;</p>

<p><span style="color:#9b59b6"><span style="font-size:17.6px"><span style="font-family:&quot;Open Sans&quot;,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif">Pr&eacute;-traitement des donn&eacute;es</span></span></span></p>

<p>Nous pouvons maintenant charg&eacute; notre jeu de donn&eacute;es, afficher ses 5 premi&egrave;res colonnes (figure 2) et imprimer un r&eacute;sum&eacute; des principales caract&eacute;ristiques de chaque entit&eacute; (figure 3).&nbsp;Dans R, nous pouvons cr&eacute;er de nouveaux objets en utilisant l&#39;&nbsp;op&eacute;rateur&nbsp;<strong><span style="background-color:#8e44ad">&lt;-</span></strong><span style="background-color:#8e44ad">&nbsp;.</span></p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code># Loading our dataset<br />
df &lt;- import(&quot;./mobile_price.csv&quot;)<br />
head(df)<br />
summary(df)</code></div>

<p>&nbsp;</p>

<p><img src="https://cdn-images-1.medium.com/max/2600/1*RzDAdwpOXq7ORvz1crltzg.png" /></p>

<p style="text-align:center">Figure 2: header de l&#39;ensemble de donn&eacute;es</p>

<p>&nbsp;</p>

<blockquote>
<p>Quelques statistques que nous pouvons&nbsp;v&eacute;rifier (toujours conseill&eacute;)</p>

<p># Mise en place de statistiques descriptives, selon le type de variable.<br />
# Dans le cas d&#39;une variable num&eacute;rique -&gt; Donne la moyenne, la m&eacute;diane, le mode, la plage et les quartiles.<br />
# Dans le cas d&#39;une variable de facteur -&gt; Donne un tableau avec les fr&eacute;quences.<br />
# En cas de Facteur + Variables Num&eacute;riques -&gt; Donne le nombre de valeurs manquantes.<br />
# En cas de variables de caract&egrave;re -&gt; Donne la longueur et la classe.&nbsp;</p>
</blockquote>

<p>&nbsp;</p>

<p>La fonction de r&eacute;sum&eacute; nous fournit une br&egrave;ve description statistique de chaque entit&eacute; de notre ensemble de donn&eacute;es.&nbsp;Selon la nature de la fonctionnalit&eacute; consid&eacute;r&eacute;e, diff&eacute;rentes statistiques seront fournies:</p>

<ul style="margin-left:40px">
	<li><strong>Caract&eacute;ristiques num&eacute;riques</strong>:&nbsp;moyenne, m&eacute;diane, mode, plage et quartiles.</li>
	<li><strong>Caract&eacute;ristiques des facteurs</strong>:&nbsp;fr&eacute;quences.</li>
	<li><strong>Un m&eacute;lange de facteurs et de fonctionnalit&eacute;s num&eacute;riques</strong>:&nbsp;Nombre de valeurs manquantes.</li>
	<li><strong>Caract&eacute;ristiques des personnages</strong>:&nbsp;Dur&eacute;e de la classe.</li>
</ul>

<p>&nbsp;</p>

<p><img src="https://cdn-images-1.medium.com/max/2000/1*T-bvpDXlP_1u4Cjl719Hfg.png" /></p>

<p style="text-align:center">Figure 3: R&eacute;sum&eacute; de l&#39;ensemble de donn&eacute;es</p>

<p>Enfin, nous pouvons maintenant v&eacute;rifier si notre ensemble de donn&eacute;es contient des valeurs manquantes (NaN) en utilisant le code ci-dessous.</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code># Checking for Missing values<br />
missing_values &lt;- df %&gt;% summarize_all(funs(sum(is.na(.))/n()))<br />
missing_values &lt;- gather(missing_values, key=&quot;feature&quot;, value=&quot;missing_pct&quot;)<br />
missing_values %&gt;% &nbsp;&nbsp;<br />
ggplot(aes(x=reorder(feature,-missing_pct),y=missing_pct)) +<br />
geom_bar(stat=&quot;identity&quot;,fill=&quot;red&quot;)+<br />
coord_flip()+theme_bw()</code></div>

<p>&nbsp;Comme nous pouvons le voir sur la figure 4, aucune valeur manquante n&#39;a &eacute;t&eacute; trouv&eacute;.</p>

<p><img src="https://cdn-images-1.medium.com/max/2000/1*dLrXdkrfZCsRQ8vVskgJYQ.png" /></p>

<p style="text-align:center">Figure 4: Pourcentage de NaN dans chaque variable</p>

<p>&nbsp;</p>

<h4><span style="color:#9b59b6"><span style="font-size:17.6px"><span style="font-family:&quot;Open Sans&quot;,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif">Visualisation de donn&eacute;es</span></span></span></h4>

<p>Nous pouvons maintenant commencer notre visualisation des donn&eacute;es en tra&ccedil;ant une matrice de corr&eacute;lation de notre ensemble de donn&eacute;es (figure 5).</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>corr &lt;- round(cor(df), 8)<br />
ggcorrplot(corr)</code></div>

<p><img src="https://cdn-images-1.medium.com/max/2000/1*hTwUWOHz4Aqw5CQ-eAjHBg.png" /></p>

<p style="text-align:center">Figure 5: Matrice de corr&eacute;lation</p>

<p style="text-align:center">&nbsp;</p>

<p>Par la suite, nous pouvons commencer &agrave; analyser les variables (entit&eacute;s)&nbsp;individuellement&nbsp;&agrave; l&#39;aide des graphiques BarCharts et BoxPlots.&nbsp;Avant de cr&eacute;er ces trac&eacute;s, nous devons d&#39;abord convertir les entit&eacute;s consid&eacute;r&eacute;es comme num&eacute;rique en facteur (cela nous permet de regrouper nos donn&eacute;es, puis de tracer les donn&eacute;es regroup&eacute;es).</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>df$blue &lt;- as.factor(df$blue)<br />
df$dual_sim &lt;- as.factor(df$dual_sim)<br />
df$four_g &lt;- as.factor(df$four_g)<br />
df$price_range &lt;- as.factor(df$price_range)</code></div>

<p>&nbsp;</p>

<p>Nous pouvons maintenant cr&eacute;er 3 diagrammes &agrave; barres en les stockant dans diff&eacute;rentes variables (p1, p2, p3), puis les ajouter &agrave; grid.arrange() pour cr&eacute;er un sous-trac&eacute;. Dans ce cas, j&#39;ai d&eacute;cid&eacute; d&#39;examiner les fonctionnalit&eacute;s Bluetooth, Dual Sim et 4G.</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code># Bar Chart Subplots<br />
p1 &lt;- &nbsp;ggplot(df, aes(x=blue, fill=blue)) +<br />
&nbsp; theme_bw() +<br />
&nbsp; geom_bar() +<br />
&nbsp; ylim(0, 1050) +<br />
&nbsp; labs(title = &quot;Bluetooth&quot;) +<br />
&nbsp; scale_x_discrete(labels = c(&#39;Not Supported&#39;,&#39;Supported&#39;))<br />
p2 &lt;- ggplot(df, aes(x=dual_sim, fill=dual_sim)) +<br />
&nbsp; theme_bw() +<br />
&nbsp; geom_bar() +<br />
&nbsp; ylim(0, 1050) +<br />
&nbsp; labs(title = &quot;Dual Sim&quot;) +<br />
&nbsp; scale_x_discrete(labels = c(&#39;Not Supported&#39;,&#39;Supported&#39;))<br />
p3 &lt;- ggplot(df, aes(x=four_g, fill=four_g)) +<br />
&nbsp; theme_bw() +<br />
&nbsp; geom_bar() +<br />
&nbsp; ylim(0, 1050) +<br />
&nbsp; labs(title = &quot;4 G&quot;) +<br />
&nbsp; scale_x_discrete(labels = c(&#39;Not Supported&#39;,&#39;Supported&#39;))<br />
grid.arrange(p1, p2, p3, nrow = 1)</code></div>

<p style="text-align:center"><img src="https://cdn-images-1.medium.com/max/2000/1*15BiE6Sl6xI10xgO0F6HZg.png" />&nbsp;Figure 6: Analyse du diagramme &agrave; barres</p>

<p style="text-align:center">&nbsp;</p>

<p>Ces trac&eacute;s ont &eacute;t&eacute; cr&eacute;&eacute;s &agrave; l&#39;aide de la biblioth&egrave;que ggplot2 . Lors de l&#39;appel de la fonction <code><strong>ggplot()</strong></code> , nous cr&eacute;ons un syst&egrave;me de coordonn&eacute;es sur lequel nous pouvons ajouter des couches par-dessus [2].</p>

<p>Le premier argument que nous donnons &agrave; la fonction <code><strong>ggplot()</strong></code> est l&#39;ensemble de donn&eacute;es que nous allons utiliser et le second est plut&ocirc;t une fonction esth&eacute;tique dans laquelle nous d&eacute;finissons les variables que nous voulons tracer. Nous pouvons ensuite continuer d&#39;ajouter d&#39;autres arguments tels que nous d&eacute;finissant une fonction g&eacute;om&eacute;trique souhait&eacute;e (par exemple barplot, scatter, boxplot, histogram, etc&hellip;), en ajoutant un th&egrave;me de trac&eacute;, des limites d&#39;axe, des &eacute;tiquettes, etc&hellip;</p>

<p>En poussant notre analyse un peu plus loin, nous pouvons maintenant calculer les pourcentages pr&eacute;cis de la diff&eacute;rence entre les diff&eacute;rents cas en utilisant la fonction <code><strong>prop.table()</strong></code>. Comme nous pouvons le voir sur la sortie r&eacute;sultante (figure 7), 50,5% des appareils mobiles consid&eacute;r&eacute;s ne prennent pas en charge Bluetooth, 50,9% est Dual Sim et 52,1% a 4G.</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>prop.table(table(df$blue)) # cell percentages<br />
prop.table(table(df$dual_sim)) # cell percentages<br />
prop.table(table(df$four_g)) # cell percentages</code></div>

<p><img src="https://cdn-images-1.medium.com/max/2000/1*ecc1dSMUIcruaGc_Ah-poQ.png" /></p>

<p style="text-align:center">Figure 7: Pourcentage de distribution des classes</p>

<p>Nous pouvons maintenant continuer &agrave; cr&eacute;er 3 Box Plots diff&eacute;rents en utilisant la m&ecirc;me technique utilis&eacute;e auparavant. Dans ce cas, j&#39;ai d&eacute;cid&eacute; d&#39;examiner comment le fait d&#39;avoir plus de puissance de batterie, de poids de t&eacute;l&eacute;phone et de RAM (Random Access Memory) peut affecter les prix des mobiles. Dans cet ensemble de donn&eacute;es, nous ne recevons pas les prix r&eacute;els du t&eacute;l&eacute;phone, mais une fourchette de prix indiquant &agrave; quel point le prix est &eacute;lev&eacute; (quatre niveaux diff&eacute;rents de 0 &agrave; 3).</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code># Bar Chart Subplots<br />
p1 &lt;- &nbsp;ggplot(df, aes(x=price_range, y = battery_power, color=price_range)) +<br />
&nbsp; geom_boxplot(outlier.colour=&quot;red&quot;, outlier.shape=8,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;outlier.size=4) +<br />
&nbsp; labs(title = &quot;Battery Power vs Price Range&quot;)<br />
p2 &lt;- ggplot(df, aes(x=price_range, y = mobile_wt, color=price_range)) +<br />
&nbsp; geom_boxplot(outlier.colour=&quot;red&quot;, outlier.shape=8,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;outlier.size=4) +<br />
&nbsp; labs(title = &quot;Phone Weight vs Price Range&quot;)<br />
p3 &lt;- ggplot(df, aes(x=price_range, y = ram, color=price_range)) +<br />
&nbsp; geom_boxplot(outlier.colour=&quot;red&quot;, outlier.shape=8,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;outlier.size=4) +<br />
&nbsp; labs(title = &quot;RAM vs Price Range&quot;)<br />
grid.arrange(p1, p2, p3, nrow = 1)</code></div>

<p>&nbsp;</p>

<p>Les r&eacute;sultats sont r&eacute;sum&eacute;s dans la figure 8. L&#39;augmentation de la puissance de la batterie et de la RAM entra&icirc;ne syst&eacute;matiquement une augmentation du prix. Au lieu de cela, les t&eacute;l&eacute;phones plus chers semblent globalement plus l&eacute;gers. Dans le graphique RAM vs Price Range, des valeurs aberrantes ont &eacute;t&eacute; enregistr&eacute;es dans la distribution globale.</p>

<p><img src="https://cdn-images-1.medium.com/max/2000/1*CTX61Y3K4UG7_lKBLedwdg.png" /></p>

<p style="text-align:center">Figure 8: Analyse du diagramme en bo&icirc;te</p>

<p style="text-align:center">&nbsp;</p>

<p>Enfin, nous allons maintenant examiner la distribution de la qualit&eacute; de la cam&eacute;ra en m&eacute;gapixels pour les cam&eacute;ras frontale et primaire (figure 9).&nbsp;Fait int&eacute;ressant, la distribution de la cam&eacute;ra avant semble suivre une distribution en d&eacute;croissance exponentielle tandis que la cam&eacute;ra principale suit &agrave; peu pr&egrave;s une distribution uniforme.</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>data = data.frame(MagaPixels = c(df$fc, df$pc), Camera = rep(c(&quot;Front Camera&quot;, &quot;Primary Camera&quot;),&nbsp;&nbsp;c(length(df$fc), length(df$pc))))<br />
ggplot(data, aes(MagaPixels, fill = Camera)) +&nbsp;&nbsp; geom_bar(position = &#39;identity&#39;, alpha = .5)</code></div>

<p><img src="https://cdn-images-1.medium.com/max/2000/1*g5gfU-x3F200_OltYlDDQg.png" /></p>

<p style="text-align:center">&nbsp;Figure 9: Analyse d&#39;histogramme</p>

<p>&nbsp;</p>

<h2 style="text-align:start">Apprentissage automatique</h2>

<p>&nbsp;</p>

<p>Afin d&#39;effectuer notre analyse d&#39;apprentissage automatique, nous devons d&#39;abord convertir nos variables de facteur sous forme num&eacute;rique, puis diviser notre ensemble de donn&eacute;es en trains et ensembles de tests (ratios 75:25). Et ensuite nous s&eacute;parons les donn&eacute;es de fonctionnalit&eacute;s aux donn&eacute;es d&#39;&eacute;tiquettes.</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>df$blue &lt;- as.numeric(df$blue)<br />
df$dual_sim &lt;- as.numeric(df$dual_sim)<br />
df$four_g &lt;- as.numeric(df$four_g)<br />
df$price_range &lt;- as.numeric(df$price_range)</code></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><br />
<code>## 75% of the sample size<br />
smp_size &lt;- floor(0.75 * nrow(df))</code></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code># set the seed to make our partition reproducible<br />
set.seed(123)<br />
train_ind &lt;- sample(seq_len(nrow(df)), size = smp_size)</code></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>train &lt;- df[train_ind, ]<br />
test &lt;- df[-train_ind, ]</code></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>x_train &lt;- subset(train, select = -price_range)<br />
y_train &lt;- train$price_range<br />
x_test &lt;- subset(test, select = -price_range)<br />
y_test &lt;- test$price_range</code></div>

<p>&nbsp;</p>

<p>Il est maintenant temps de former notre mod&egrave;le d&#39;apprentissage automatique.&nbsp;Dans cet exemple, j&#39;ai d&eacute;cid&eacute; d&#39;utiliser&nbsp;<a href="https://fr.wikipedia.org/wiki/Machine_%C3%A0_vecteurs_de_support"><span style="color:#3498db">les machines &agrave; vecteurs de support (SVM)</span></a><a href="https://fr.wikipedia.org/wiki/Machine_%C3%A0_vecteurs_de_support">&nbsp;</a>comme classificateur multiclasse.&nbsp;En utilisant R&nbsp;summary (),&nbsp;nous pouvons ensuite inspecter les param&egrave;tres de notre mod&egrave;le form&eacute; (figure 10).</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>model &lt;- svm(x_train, y_train, type = &#39;C-classification&#39;,&nbsp;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;kernel = &#39;linear&#39;)&nbsp;</code></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>print(model)<br />
summary(model)</code></div>

<p><img src="https://cdn-images-1.medium.com/max/2000/1*GDrVoWCUEQ__UHBqiEKquA.png" /></p>

<p style="text-align:center">Figure 10: R&eacute;sum&eacute; du mod&egrave;le d&#39;apprentissage automatique</p>

<p>&nbsp;</p>

<p>Enfin, nous pouvons maintenant tester notre mod&egrave;le en faisant des pr&eacute;dictions sur l&#39;ensemble des donn&eacute;es de test.&nbsp;En utilisant la fonction R&nbsp;<code><strong>confusionMatrix()</strong></code>&nbsp;, nous pouvons alors obtenir un rapport complet de la pr&eacute;cision de notre mod&egrave;le (figure 11).&nbsp;Dans ce cas, une pr&eacute;cision de 96,6% a &eacute;t&eacute; enregistr&eacute;e.&nbsp;</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code># testing our model<br />
pred &lt;- predict(model, x_test)</code></div>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>pred &lt;- as.factor(pred)<br />
y_test &lt;- as.factor(y_test)<br />
confusionMatrix(y_test, pred)</code></div>

<p>&nbsp;</p>

<p><img src="https://cdn-images-1.medium.com/max/2000/1*mzj3sdAtFO9AcVs3uOBdqQ.png" /></p>

<p style="text-align:center">Figure 11: Mod&egrave;le de rapport d&#39;exactitude</p>

<p>&nbsp;</p>

<h2>Conclusion</h2>

<p>C&#39;est la fin de l&#39;initiation &agrave; la programmation en R. J&#39;esp&egrave;re que cet article vous a plu, merci d&#39;avoir lu!</p>

<p>&nbsp;</p>

<h2>Bibliographie</h2>

<p>[1] Which languages are important for Data Scientists in 2019? Quora. Consult&eacute; sur:<a href="http:// https://www.quora.com/Which-languages-are-important-for-Data-Scientists-in-2019"><span style="color:#3498db">&nbsp;</span><span style="color:#3498db">https://www.quora.com/Which-languages-are-important-for-Data-Scientists-in-2019</span></a></p>

<p>[2] R for Data Science, Garrett Grolemund and Hadley Wickham.&nbsp;Consult&eacute; sur:&nbsp;<a href="https://www.bioinform.io/site/wp-content/uploads/2018/09/RDataScience.pdf"><span style="color:#3498db">https://www.bioinform.io/site/wp-content/uploads/2018/09/RDataScience.pdf</span></a></p>
