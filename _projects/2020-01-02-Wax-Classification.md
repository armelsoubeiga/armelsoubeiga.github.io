---
title: "Wax Classification"
collection: projects
permalink: /projects/2020-01-02-Wax-Classification
excerpt: "WaxClassification : africa wax classification app with Tensorflow Image Classifiaction + Anrdoid"
data: 2020-01-02
image:
  teaser: /projets/waxclassification.png
---

# Wax Classification


<div align="center">
<img src="https://raw.githubusercontent.com/armelsoubeiga/armelsoubeiga.github.io/master/dist/img/projects/waxclassification.png" style="height:150px; width:300px;" />
</div><br />

[Website]() \ [Get Started](https://github.com/armelsoubeiga/WaxClassification) \ [Docs]()

------

# WaxClassification
Classification des images de tissus africain en fonction de la marque, du type, de l'impression, du prix et de la qualité des pagnes africains

Ce travail est divisé en cinq (5) étapes nécessaires qui s’enchaînent :

## 1. La collecte des images
Il s'agit du développement d'algorithmes qui parcourent plusieurs sites web et grattent des images en 2D. A cet effet nous avons développés entre 5 à 10 algorithmes pour parcourir les sites comme : Amazon, Cdiscount, ...
 
## 2. Modèle de classification
Nous avons utilisé Tensorflow pour développer notre modèle de classification sur les images collectées. Ce modèle a été ensuite validé par des images de test avec une performance de 90%.

## 3. Convertir le modèle
Nous utilisons ensuite le convertisseur TensorFlow Lite et quelques lignes de Python pour convertir notre modèle Tensorflow machine au format TensorFlow Lite (adapter au mobile).

## 4. Déploiement du modèle
Nous développons notre application à l'aide *Android Studio* en Java et Exécutons notre modèle sur le périphérique avec l’interpréteur TensorFlow Lite, avec des API dans de nombreuses langues.

## 5. Optimisation du modèle
Optimisation du modèle pour réduire la taille de notre modèle et augmenter son efficacité avec un impact minimal sur la précision sur mobile. 
