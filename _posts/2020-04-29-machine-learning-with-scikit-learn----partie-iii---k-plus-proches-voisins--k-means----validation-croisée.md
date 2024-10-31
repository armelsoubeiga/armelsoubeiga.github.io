---
title: 'MACHINE LEARNING WITH SCIKIT-LEARN <> Partie III : k plus proches voisins (k-means) & validation croisée'
date: 2020-04-29
permalink: /posts/2020/04/machine-learning-with-scikit-learn----partie-iii---k-plus-proches-voisins--k-means----validation-croisée
tags:
  - machine
  - learning
  - with
author_profile: false
toc: true
---

{% include toc %}

<p>Dans cette partie III nous allons apprendre &agrave; manipuler :&nbsp;<br />
1. la classe <strong>KNeighborsClassifier</strong> qui permet de r&eacute;aliser de la classification par la m&eacute;thode des k plus proches voisins ou <strong>k-means</strong><br />
2. les fonctions <strong>cross_val_score</strong> et <strong>cross_val_predict</strong> qui permettent de r&eacute;aliser des exp&eacute;riences de validation crois&eacute;e.&nbsp;</p>

<p>&nbsp;</p>

<p><em>Dans les parties I et II de cette chaine d&#39;articles, nous avons abord&eacute; respectivement les r&eacute;gressions lin&eacute;aires et polynomiales et l&#39;analyse en composante principale (ACP) que je vous conseille &agrave; y regarder.</em></p>

<p>&nbsp;</p>

<p>Nous travaillerons pour cela sur le jeu de donn&eacute;es breast cancer que l&#39;on peut <a href="https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_breast_cancer.html#sklearn.datasets.load_breast_cancer"><span style="color:#3498db">charger &agrave; partir de scikit-learn</span></a> et dont on trouve un descriptif sur <a href="https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+(Diagnostic)"><span style="color:#3498db">le site de l&#39;UCI</span></a>&nbsp;.</p>

<p>Nous apprendrons &eacute;galement l&#39;importance de standardiser les descripteurs avec les k&nbsp;plus proches voisins.</p>

<p>&nbsp;</p>

<p><strong><em><span style="font-size:18px"><a href="https://github.com/armelsoubeiga/Blog-Examples/blob/master/ML_Witth_Scikit-Learn/Partie_III_k_plus_proches_voisins_et_validation_crois%C3%A9e.ipynb"><span style="background-color:#dddddd">EN SAVOIR PLUS ...</span></a></span></em></strong></p>
