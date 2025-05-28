---
title: "Les Transformers & HuggingFace"
date: 2025-05-27
permalink: /posts/2025/05/Les-Transformers-et-HuggingFace
categories: [FR]
tags:
  - HuggingFace
  - NLP
  - Transformers
author_profile: false
toc: true
excerpt: "Découvrez comment HuggingFace révolutionne l'IA avec sa librairie Transformers. Apprenez à utiliser les modèles pré-entraînés pour le NLP, la vision et plus encore."
---

HuggingFace rend l’IA accessible à tous grâce à sa librairie Transformers et à son écosystème riche. Découvrons ensemble ses concepts clés et ses usages pratiques.

## 1. Introduction à Hugging Face Transformers
La librairie `transformers` permet d’utiliser des modèles pré-entraînés pour le NLP, la vision, l’audio, etc. Elle simplifie l’intégration de l’IA dans vos projets Python.

```python
from transformers import pipeline
# Génération de texte
text_gen = pipeline("text-generation", model="gpt2")
print(text_gen("HuggingFace simplifie l'IA car", max_length=30)[0]['generated_text'])
```

## 2. Comprendre les Transformers avec Hugging Face
Découvrez les bases des Transformers et comment Hugging Face facilite leur utilisation. Les pipelines offrent une interface simple pour appliquer des modèles à des tâches variées. Les checkpoints, modèles et jeux de données sont accessibles en quelques clics. Les Spaces permettent de partager des démos interactives, tandis que les Auto-Classes simplifient la gestion des modèles et tokenizers.

```python
from transformers import AutoModel, AutoTokenizer
model = AutoModel.from_pretrained("bert-base-uncased")
tokenizer = AutoTokenizer.from_pretrained("bert-base-uncased")
inputs = tokenizer("Hello HuggingFace!", return_tensors="pt")
outputs = model(**inputs)
```

## 3. Concepts fondamentaux des Transformers et LLMs
Plongez dans l’architecture des Transformers : attention, embeddings, couches empilées. Comprenez comment ces modèles sont utilisés pour la classification, la génération de texte, la traduction, etc. Le transfer learning permet d’adapter un modèle pré-entraîné à vos propres données pour des résultats optimaux.

```python
from transformers import pipeline
# Classification de texte
classifier = pipeline("sentiment-analysis")
print(classifier("J'adore HuggingFace !"))
```

## 4. Zoom sur l’architecture BERT
BERT est un modèle clé pour la compréhension du contexte. Il utilise le Masked Language Modeling (MLM) pour apprendre à prédire des mots masqués et le Next Sentence Prediction (NSP) pour comprendre la relation entre phrases. Le fine-tuning permet d’adapter BERT à des tâches spécifiques et d’évaluer ses performances.

```python
from transformers import BertTokenizer, BertForMaskedLM
import torch

text = "HuggingFace rend l'IA [MASK] à tous."
tokenizer = BertTokenizer.from_pretrained("bert-base-uncased")
model = BertForMaskedLM.from_pretrained("bert-base-uncased")
inputs = tokenizer(text, return_tensors="pt")
with torch.no_grad():
    logits = model(**inputs).logits
mask_token_index = (inputs.input_ids == tokenizer.mask_token_id)[0].nonzero(as_tuple=True)[0]
predicted_token_id = logits[0, mask_token_index].argmax(axis=-1)
predicted_token = tokenizer.decode(predicted_token_id)
print(f"Texte complété : {text.replace('[MASK]', predicted_token)}")
```

## 5. Fine-tuning pratique de BERT
Exemple : fine-tunez BERT pour la classification de sentiments sur des tweets. Étapes : chargement des données, tokenization, entraînement du modèle, évaluation. Vous pouvez ainsi créer un classificateur performant adapté à vos besoins.

```python
from transformers import Trainer, TrainingArguments, BertForSequenceClassification
# ... Préparation des données et tokenization ...
model = BertForSequenceClassification.from_pretrained("bert-base-uncased")
training_args = TrainingArguments(output_dir="./results", num_train_epochs=1)
trainer = Trainer(model=model, args=training_args, train_dataset=train_ds, eval_dataset=eval_ds)
trainer.train()
```

## 6. Distillation de connaissances pour BERT
La distillation permet d’optimiser les modèles : on transfère les connaissances d’un grand modèle (BERT) vers un plus petit (DistilBERT, MobileBERT, TinyBERT). Cela réduit la taille et accélère l’inférence, tout en conservant de bonnes performances. Chaque variante a ses techniques et avantages.

```python
from transformers import DistilBertTokenizer, DistilBertForSequenceClassification
# Chargement d'un modèle DistilBERT pour la classification
model = DistilBertForSequenceClassification.from_pretrained("distilbert-base-uncased")
tokenizer = DistilBertTokenizer.from_pretrained("distilbert-base-uncased")
```

## 7. Utilisation de DistilBERT pour des cas concrets (ex : détection de fake news)
Appliquez DistilBERT, MobileBERT ou TinyBERT à la détection de fake news. Comparez leurs performances à BERT-Base. Exemples pratiques de construction, entraînement et évaluation de modèles.

```python
from transformers import pipeline
fake_news_clf = pipeline("text-classification", model="mrm8488/bert-tiny-finetuned-fake-news-detection")
print(fake_news_clf("Ce site diffuse de fausses informations."))
```

## 8. Reconnaissance d’entités nommées (NER) avec DistilBERT
Fine-tunez DistilBERT pour la NER, par exemple pour la recherche de restaurants. Préparez les données, tokenisez, entraînez et évaluez le modèle. Déployez ensuite votre modèle pour des applications concrètes.

```python
ner = pipeline("ner", grouped_entities=True, model="distilbert-base-cased")
print(ner("Le restaurant Le Gourmet est à Paris."))
```

## 9. Résumé personnalisé avec T5 Transformer
T5 permet de générer des résumés sur mesure. Analysez le dataset, tokenisez, fine-tunez le modèle, puis appliquez-le à vos propres textes pour obtenir des résumés pertinents.

```python
from transformers import pipeline
summarizer = pipeline("summarization", model="t5-small")
print(summarizer("HuggingFace propose de nombreux modèles pour le NLP et la vision."))
```

## 10. Vision Transformer pour la classification d’images
Les Vision Transformers (ViT) appliquent l’architecture Transformer à l’image. Exemple : classification d’aliments indiens. Prétraitez les images, entraînez le modèle, évaluez les résultats.

```python
from transformers import pipeline
vit = pipeline("image-classification", model="google/vit-base-patch16-224")
print(vit("chemin/vers/une/image.jpg"))
```

## 11. Fine-tuning de grands modèles de langage (LLMs) sur vos données
Découvrez comment adapter des LLMs à vos jeux de données. Techniques : PEFT, LORA, QLORA. Mettez en pratique le fine-tuning pour obtenir des modèles personnalisés.

```python
# Exemple d’utilisation de PEFT (conceptuel)
from peft import get_peft_model, LoraConfig
# ... préparation du modèle et des données ...
peft_config = LoraConfig()
model = get_peft_model(model, peft_config)
```

## 12. Sujets avancés de fine-tuning
Explorez la quantification 8 bits, l’ajout d’adapters, et d’autres techniques de pointe pour optimiser vos Transformers. Exemple : générer des descriptions produits avec un modèle affiné.

```python
# Quantification 8 bits avec bitsandbytes
from transformers import AutoModelForCausalLM
model = AutoModelForCausalLM.from_pretrained("gpt2", load_in_8bit=True)
```

## 13. Construire des modèles de chat et d’instruction avec LLAMA
LLAMA permet de créer des modèles de chat performants. Découvrez la quantification 4 bits, l’ajout d’adapters, et le fine-tuning sur des datasets de chat. Apprenez à configurer et déployer ces modèles pour des applications conversationnelles.

```python
# Exemple d’utilisation de LLAMA avec quantification 4 bits (conceptuel)
from transformers import AutoModelForCausalLM
model = AutoModelForCausalLM.from_pretrained("meta-llama/Llama-2-7b-hf", load_in_4bit=True)
```

---

> Ce guide vous donne les clés pour exploiter tout le potentiel des Transformers et des LLMs avec Hugging Face, que vous soyez débutant ou déjà initié à l’IA.

![Un robot qui danse avec un micro](https://media.giphy.com/media/26ufdipQqU2lhNA4g/giphy.gif)

## Pour aller plus loin
- [Comment utiliser Hugging Face Transformers (FR)](https://inside-machinelearning.com/comment-utiliser-hugging-face-transformers/)
- [Hugging Face Guide (EN)](https://inside-machinelearning.com/en/hugging-face-guide/)

> Explorez [HuggingFace.co](https://huggingface.co/) pour tester des modèles en ligne et rejoindre la communauté !
