---
title: 'Classification et problème de classes déséquilibrées'
date: 2020-04-22
permalink: /posts/2020/04/classification-et-problème-de-classes-déséquilibrées
tags:
  - classification
  - problème
  - classes
author_profile: false
toc: true
excerpt: 'Il arrive souvent dans les cas de classification en Machine Learning que l rsquo une des classes soit minoritaire par rapport agrave la population globale Cela peut ecirc tre un probl egrave me car la plupart des algorithmes de classification'
---

{% include toc %}

<p>Il arrive souvent dans les cas de classification en Machine Learning que l&rsquo;une des classes soit minoritaire par rapport &agrave; la population globale. Cela peut &ecirc;tre un probl&egrave;me car la plupart des algorithmes de classification se basent sur l&rsquo;exactitude (ou l&rsquo;accuracy) pour construire leurs mod&egrave;les. Voyant que la grande majorit&eacute; des observations appartient &agrave; la m&ecirc;me cat&eacute;gorie, vous risquez de vous retrouver avec un mod&egrave;le peu intelligent qui va toujours pr&eacute;dire la classe dominante.</p>

<p>Les cas d&rsquo;usages de classes d&eacute;s&eacute;quilibr&eacute;es sont multiples : d&eacute;tection de pannes, d&eacute;pistage de maladies, moteur de recherche, filtrage de spams, ciblage marketing ou commercial&hellip; C&rsquo;est pourquoi il est important de savoir aborder ce genre de probl&egrave;mes. Dans cet article nous allons d&eacute;crire plusieurs m&eacute;thodes permettant de classifier des jeux de donn&eacute;es &agrave; classes d&eacute;s&eacute;quilibr&eacute;es. Nous parlerons en particulier de deux types d&rsquo;approches : algorithmique et d&rsquo;&eacute;chantillonnage.</p>
