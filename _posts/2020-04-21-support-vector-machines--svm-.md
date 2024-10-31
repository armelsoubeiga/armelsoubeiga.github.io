---
title: 'Support Vector Machines (SVM)'
date: 2020-04-21
permalink: /posts/2020/04/support-vector-machines--svm-
tags:
  - support
  - vector
  - machines
author_profile: false
toc: true
---

{% include toc %}

<h2>SVM: s&eacute;lection de fonctionnalit&eacute;s et noyaux</h2>

<p>Une machine &agrave; vecteur de support (SVM) est un algorithme d&#39;apprentissage automatique supervis&eacute; qui peut &ecirc;tre utilis&eacute; &agrave; des fins de classification et de r&eacute;gression. (<em>Noel Bambrick.</em>)</p>

<p>&nbsp;</p>

<h2>Introduction</h2>

<p>Support Vector Machines (SVM) est un algorithme d&#39;apprentissage machine qui peut &ecirc;tre utilis&eacute; pour de nombreuses t&acirc;ches diff&eacute;rentes (figure 1). Dans cet article, je vais expliquer la base math&eacute;matique pour d&eacute;montrer comment cet algorithme fonctionne &agrave; des fins de classification binaire.</p>

<p>&nbsp;</p>

<p style="text-align:center"><img alt="" src="images/media/uploads/2020/04/21/capture3.JPG" style="height:300px; width:375px" /></p>

<p style="text-align:center">Figure 1: Applications SVM</p>

<p style="text-align:center">&nbsp;</p>

<p>L&#39;objectif principal dans SVM est de trouver l&#39;hyperplan optimal pour classer correctement entre les points de donn&eacute;es de diff&eacute;rentes classes (figure 2). La dimensionnalit&eacute; de l&#39;hyperplan est &eacute;gale au nombre d&#39;entit&eacute;s en entr&eacute;e moins un (par exemple. Lorsque vous travaillez avec trois entit&eacute;s, l&#39;hyperplan sera un plan bidimensionnel).</p>

<p>&nbsp;</p>

<p style="text-align:center"><img alt="" src="images/media/uploads/2020/04/21/capture4.JPG" style="height:292px; width:641px" /></p>

<p style="text-align:center">Figure 2: Hyperplan SVM</p>

<p style="text-align:center">&nbsp;</p>

<p>Les points de donn&eacute;es d&#39;un c&ocirc;t&eacute; de l&#39;hyperplan seront class&eacute;s dans une certaine classe tandis que les points de donn&eacute;es de l&#39;autre c&ocirc;t&eacute; de l&#39;hyperplan seront class&eacute;s dans une classe diff&eacute;rente (par exemple, vert et rouge comme sur la figure 2). La distance entre l&#39;hyperplan et le premier point (pour toutes les diff&eacute;rentes classes) de chaque c&ocirc;t&eacute; de l&#39;hyperplan est une mesure s&ucirc;re que l&#39;algorithme concerne sa d&eacute;cision de classification. Plus la distance est grande et plus nous pouvons &ecirc;tre confiants, SVM prend la bonne d&eacute;cision.</p>

<p>Les points de donn&eacute;es les plus proches de l&#39;hyperplan sont appel&eacute;s vecteurs de support. Les vecteurs de support d&eacute;terminent l&#39;orientation et la position de l&#39;hyperplan, afin de maximiser la marge du classificateur (et donc le score de classification). Le nombre de vecteurs de support que l&#39;algorithme SVM doit utiliser peut &ecirc;tre choisi arbitrairement en fonction des applications.</p>

<p>La classification SVM de base peut &ecirc;tre facilement impl&eacute;ment&eacute;e &agrave; l&#39;aide de la biblioth&egrave;que Scikit-Learn Python en quelques lignes de code.</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><code>from sklearn import svm<br />
trainedsvm = svm.SVC().fit(X_Train, Y_Train)<br />
predictionsvm = trainedsvm.predict(X_Test)<br />
print(confusion_matrix(Y_Test,predictionsvm))<br />
print(classification_report(Y_Test,predictionsvm))</code></div>

<p>&nbsp;</p>

<p>Il existe deux principaux types d&#39;algorithmes de classification SVM Marge dure et Marge souple:</p>

<p><em><strong>Marge dure</strong></em>: vise &agrave; trouver le meilleur hyperplan sans tol&eacute;rer aucune forme de mauvaise classification.<br />
<em><strong>Marge souple</strong></em>: nous ajoutons un degr&eacute; de tol&eacute;rance dans SVM. De cette fa&ccedil;on, nous permettons au mod&egrave;le de classer volontairement quelques points de donn&eacute;es si cela peut conduire &agrave; identifier un hyperplan capable de g&eacute;n&eacute;raliser mieux les donn&eacute;es invisibles.</p>

<p><br />
Soft Margin SVM peut &ecirc;tre impl&eacute;ment&eacute; dans Scikit-Learn en ajoutant un terme de p&eacute;nalit&eacute; C dans <code><span style="background-color:#bdc3c7">svm.SVC</span></code>. Plus C est &eacute;lev&eacute; et plus l&#39;algorithme est p&eacute;nalis&eacute; lors d&#39;une erreur de classification.</p>

<p>&nbsp;</p>

<h2><strong>Astuce du noyau</strong></h2>

<p><br />
Si les donn&eacute;es avec lesquelles nous travaillons ne sont pas s&eacute;parables lin&eacute;airement (conduisant ainsi &agrave; de mauvais r&eacute;sultats de classification SVM lin&eacute;aire), il est possible d&#39;appliquer une technique connue sous le nom de Kernel Trick. Cette m&eacute;thode est capable de cartographier nos donn&eacute;es s&eacute;parables non lin&eacute;aires dans un espace de dimension sup&eacute;rieure, ce qui rend nos donn&eacute;es s&eacute;parables lin&eacute;airement. L&#39;utilisation de ce nouvel espace dimensionnel SVM peut alors &ecirc;tre facilement impl&eacute;ment&eacute;e (figure 3).&nbsp;<br />
&nbsp;</p>

<p style="text-align:center"><img alt="" src="images/media/uploads/2020/04/21/capture5.JPG" style="height:353px; width:649px" /></p>

<p style="text-align:center">Figure 3: noyau</p>

<p style="text-align:center">&nbsp;</p>

<p>Il existe de nombreux types de noyaux diff&eacute;rents qui peuvent &ecirc;tre utilis&eacute;s pour cr&eacute;er cet espace de dimension sup&eacute;rieure, certains exemples sont la fonction de base lin&eacute;aire, polynomiale, sigmo&iuml;de et radiale (RBF). Dans Scikit-Learn, une fonction de noyau peut &ecirc;tre sp&eacute;cifi&eacute;e en ajoutant un param&egrave;tre de noyau dans svm.SVC. Un param&egrave;tre suppl&eacute;mentaire appel&eacute; gamma peut &ecirc;tre inclus pour sp&eacute;cifier l&#39;influence du noyau sur le mod&egrave;le.</p>

<p>Il est g&eacute;n&eacute;ralement sugg&eacute;r&eacute; d&#39;utiliser des noyaux lin&eacute;aires si le nombre d&#39;entit&eacute;s est sup&eacute;rieur au nombre d&#39;observations dans l&#39;ensemble de donn&eacute;es (sinon RBF pourrait &ecirc;tre un meilleur choix).</p>

<p>Lorsque vous travaillez avec une grande quantit&eacute; de donn&eacute;es &agrave; l&#39;aide de RBF, la vitesse peut devenir une contrainte &agrave; prendre en compte.</p>

<p>&nbsp;</p>

<h2><strong>S&eacute;lection de fonctionnalit&eacute;</strong></h2>

<p><br />
Une fois notre SVM lin&eacute;aire ajust&eacute;, il est possible d&#39;acc&eacute;der aux coefficients du classificateur &agrave; l&#39;aide &nbsp;.coef_du mod&egrave;le entra&icirc;n&eacute;. Ces poids repr&eacute;sentent les coordonn&eacute;es vectorielles orthogonales orthogonales &agrave; l&#39;hyperplan. Leur direction repr&eacute;sente plut&ocirc;t la classe pr&eacute;dite.</p>

<p>L&#39;importance des caract&eacute;ristiques peut donc &ecirc;tre d&eacute;termin&eacute;e en comparant la taille de ces coefficients les uns aux autres. En examinant les coefficients SVM, il est donc possible d&#39;identifier les principales caract&eacute;ristiques utilis&eacute;es dans la classification et de se d&eacute;barrasser de celles qui ne sont pas importantes (qui contiennent moins de variance).</p>

<p>La r&eacute;duction du nombre de fonctionnalit&eacute;s dans Machine Learning joue un r&ocirc;le tr&egrave;s important, en particulier lorsque vous travaillez avec de grands ensembles de donn&eacute;es. Cela peut en effet: acc&eacute;l&eacute;rer la formation, &eacute;viter le surapprentissage et finalement conduire &agrave; de meilleurs r&eacute;sultats de classement gr&acirc;ce &agrave; la r&eacute;duction du bruit dans les donn&eacute;es.</p>

<p>&nbsp;</p>

<h2><strong>Bibliographie</strong></h2>

<p>[1] Support Vector Machine without tears, Ankit Sharma. Consult&eacute; &agrave;: <a href="https://www.slideshare.net/ankitksharma/svm-37753690"><span style="color:#3498db">https://www.slideshare.net/ankitksharma/svm-37753690</span></a></p>

<p>[2] Support Vector Machine &mdash; Introduction to Machine Learning Algorithms, Rohith Gandhi. Consult&eacute; sur: <a href="https://towardsdatascience.com/support-vector-machine-introduction-to-machine-learning-algorithms-934a444fca47"><span style="color:#3498db">https://towardsdatascience.com/support-vector-machine-introduction-to-machine-learning-algorithms-934a444fca47</span></a></p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>
