---
title: "Hello Transformers : Guide pratique HuggingFace"
date: 2025-05-27
categories: [NLP, HuggingFace, IA]
author: armelsoubeiga
description: Tour d’horizon des fonctionnalités HuggingFace et exemples de pipelines.
---

## Introduction
HuggingFace rend l’IA accessible à tous grâce à sa librairie Transformers et à son écosystème riche. Découvrons ensemble ses concepts clés et ses usages pratiques.

## 1. Introduction à Hugging Face Transformers
La librairie `transformers` permet d’utiliser des modèles pré-entraînés pour le NLP, la vision, l’audio, etc. Elle simplifie l’intégration de l’IA dans vos projets Python.

## 2. Introduction aux Pipelines HuggingFace
Un pipeline est une interface clé-en-main pour appliquer un modèle à une tâche précise (génération de texte, classification, etc.).

```python
from transformers import pipeline
# Génération de texte
generator = pipeline("text-generation", model="gpt2")
print(generator("HuggingFace simplifie l'IA car", max_length=30)[0]['generated_text'])
```

![Un chat qui tape sur un clavier](https://media.giphy.com/media/JIX9t2j0ZTN9S/giphy.gif)

## 3. Checkpoints, Modèles et Jeux de Données
Des milliers de modèles et datasets sont accessibles sur [huggingface.co/models](https://huggingface.co/models) et [huggingface.co/datasets](https://huggingface.co/datasets).

## 4. Hugging Face Spaces
Les Spaces permettent de déployer et partager facilement des démos IA interactives (ex : Streamlit, Gradio).

## 5. Auto-Classes
Les auto-classes (`AutoModel`, `AutoTokenizer`, etc.) détectent automatiquement le bon modèle/tokenizer à partir d’un nom ou chemin.

## 6. Le Transfer Learning avec Transformers
Adaptez un modèle pré-entraîné à vos propres données pour des performances optimales, même avec peu de données.

## 7. Applications des Transformers
- **NLP** : classification, résumé, traduction, Q/R, génération de texte
- **Vision** : classification, segmentation d’images
- **Audio** : transcription, text-to-speech, génération musicale

## 8. Exemples de Pipelines
### a) Classification de sentiment et émotions
```python
classifier = pipeline("sentiment-analysis")
print(classifier("J'adore HuggingFace !"))
```

### b) Reconnaissance d’entités nommées (NER)
```python
ner = pipeline("ner", grouped_entities=True)
print(ner("HuggingFace est basé à New York."))
```

### c) Question/Réponse
```python
qa = pipeline("question-answering")
print(qa(question="Où est basé HuggingFace ?", context="HuggingFace est basé à New York."))
```

### d) Résumé automatique
```python
summarizer = pipeline("summarization")
print(summarizer("HuggingFace propose de nombreux modèles pour le NLP et la vision."))
```

### e) Génération de texte
```python
# Voir plus haut
```

### f) Traduction
```python
translator = pipeline("translation_en_to_fr")
print(translator("HuggingFace makes AI easy!"))
```

### g) Classification d’images (émotions, âge)
```python
img_classifier = pipeline("image-classification")
print(img_classifier("chemin/vers/image.jpg"))
```

### h) Segmentation d’images
```python
img_segmenter = pipeline("image-segmentation")
print(img_segmenter("chemin/vers/image.jpg"))
```

### i) Audio : Text-to-Speech
```python
tts = pipeline("text-to-speech")
print(tts("Bonjour, je suis HuggingFace!"))
```

### j) Audio : MusicGen
```python
musicgen = pipeline("text-to-music", model="facebook/musicgen-small")
print(musicgen("une mélodie joyeuse et entraînante"))
```

![Un robot qui danse avec un micro](https://media.giphy.com/media/26ufdipQqU2lhNA4g/giphy.gif)

## Pour aller plus loin
- [Comment utiliser Hugging Face Transformers (FR)](https://inside-machinelearning.com/comment-utiliser-hugging-face-transformers/)
- [Hugging Face Guide (EN)](https://inside-machinelearning.com/en/hugging-face-guide/)

> Explorez [HuggingFace.co](https://huggingface.co/) pour tester des modèles en ligne et rejoindre la communauté !
