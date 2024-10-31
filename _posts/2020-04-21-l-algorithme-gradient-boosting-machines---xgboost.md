---
title: 'L'algorithme Gradient Boosting Machines : XGBOOST'
date: 2020-04-21
permalink: /posts/2020/04/l-algorithme-gradient-boosting-machines---xgboost
tags:
  - l
  - algorithme
  - gradient
author_profile: false
toc: true
---

{% include toc %}

<p>XGBoost signifie eXtreme Gradient Boosting. Comme son nom l&rsquo;indique, c&rsquo;est un algorithme de Gradient Boosting. Il est cod&eacute; en C++ et disponible dans &agrave; peu pr&egrave;s tous les langages de programmations utiles en Machine Learning, tels que Python, R ou encore Julia.</p>

<p>&nbsp;</p>

<h2 style="text-align:center"><img alt="" src="images/media/uploads/2020/04/21/xgboost1.JPG" style="height:250px; width:330px" /></h2>

<h2><br />
&nbsp;<br />
<strong>Qu&rsquo;est-ce que le Gradient Boosting</strong></h2>

<p>Le Gradient Boosting est un algorithme particulier de Boosting. Le Boosting consiste &agrave; assembler plusieurs &laquo; weak learners &raquo; pour en faire un &laquo; strong learner &raquo;, c&rsquo;est-&agrave;-dire assembler plusieurs algorithmes ayant une performance peu &eacute;lev&eacute;e pour en cr&eacute;er un beaucoup plus efficace et satisfaisant. L&rsquo;assemblage de &laquo; weak learners &raquo; en &laquo; strong learner &raquo; se fait par l&rsquo;appel successif de ceux-ci pour estimer une variable d&rsquo;int&eacute;r&ecirc;t.</p>

<p>Dans le cadre d&rsquo;une r&eacute;gression, le principe va &ecirc;tre d&rsquo;estimer nos outputs par le mod&egrave;le 1, puis d&rsquo;utiliser les r&eacute;sidus de ce mod&egrave;le comme variable cible du mod&egrave;le 2 et ainsi de suite :&nbsp;</p>

<p><img alt="" src="images/media/uploads/2020/04/21/capture.JPG" style="height:70px; width:502px" />&nbsp;<br />
Pour pouvoir pr&eacute;dire un output en fonction d&rsquo;un input dont on ne connait pas la variable cible, il faut pr&eacute;dire le r&eacute;sidu de chaque mod&egrave;le et ensuite en faire la somme :</p>

<p style="text-align:center"><img alt="" src="images/media/uploads/2020/04/21/capture1.JPG" style="height:106px; width:302px" /></p>

<p>Dans le cadre d&rsquo;une classification, chaque individu dispose d&rsquo;un poids qui sera le m&ecirc;me au d&eacute;part, et qui, si un mod&egrave;le se trompe, sera augment&eacute; avant d&rsquo;estimer le mod&egrave;le suivant (qui prendra donc en compte ces poids) :</p>

<p><img alt="" src="images/media/uploads/2020/04/21/capture2_3ZE0i4z.JPG" style="height:54px; width:580px" /></p>

<p><br />
La particularit&eacute; du Gradient Boosting est que dans la classification, l&rsquo;actualisation des poids se calculera de la m&ecirc;me fa&ccedil;on que la descente de gradient stochastique, et dans la r&eacute;gression, la fonction de co&ucirc;t globale aura aussi la m&ecirc;me structure que la descente de gradient stochastique.</p>

<p>Le Gradient Boosting est la plupart du temps utilis&eacute; avec des algorithmes d&rsquo;Arbre de D&eacute;cision, consid&eacute;r&eacute;s dans ce cadre comme des &laquo; weak learners &raquo;.</p>

<p>&nbsp;</p>

<h2><strong>Sp&eacute;cificit&eacute;s de XGBoost</strong></h2>

<p>La principale diff&eacute;rence entre XGBoost et d&rsquo;autres impl&eacute;mentations de la m&eacute;thode du Gradient Boosting r&eacute;side dans le fait que XGBoost est informatiquement optimis&eacute; pour rendre les diff&eacute;rents calculs n&eacute;cessaires &agrave; l&rsquo;application d&rsquo;un Gradient Boosting rapide. Plus pr&eacute;cis&eacute;ment, XGBoost traite les donn&eacute;es en plusieurs blocs compress&eacute;s permettant de les trier &nbsp;beaucoup plus rapidement ainsi que de les traiter en parall&egrave;le.</p>

<p>Mais les avantages de XGBoost ne sont pas uniquement li&eacute;s &agrave; l&rsquo;impl&eacute;mentation de l&rsquo;algorithme, et donc &agrave; ses performances, mais aussi aux divers param&egrave;tres que celui-ci propose. En effet XGBoost propose un panel d&rsquo;hyperparam&egrave;tres tr&egrave;s important;&nbsp;il est ainsi possible gr&acirc;ce &agrave; cette diversit&eacute; de param&egrave;tres, d&rsquo;avoir un contr&ocirc;le total sur l&rsquo;impl&eacute;mentation du Gradient Boosting. Il est aussi possible de rajouter diff&eacute;rentes r&eacute;gularisations dans la fonction de perte, limitant un ph&eacute;nom&egrave;ne qui arrive assez souvent lors de l&rsquo;utilisation d&rsquo;algorithmes de Gradient Boosting : l&rsquo;overfitting (le sur-apprentissage).</p>

<p>C&rsquo;est pour cela que XGBoost est souvent l&rsquo;algorithme gagnant des comp&eacute;titions Kaggle, il est rapide, pr&eacute;cis et efficace, permettant une souplesse de man&oelig;uvre in&eacute;dite sur le Gradient Boosting. Finalement, rappelons-le, le Gradient Boosting servant principalement &agrave; am&eacute;liorer des mod&egrave;les faibles, XGBoost aura quasi tout le temps de meilleurs r&eacute;sultats que son mod&egrave;le faible de base.</p>
