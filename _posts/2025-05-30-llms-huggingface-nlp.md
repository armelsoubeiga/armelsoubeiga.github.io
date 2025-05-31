---
title: "Les LLMs & Hugging Face"
date: 2025-05-30
permalink: /posts/2025/05/Les-LLMs-et-HuggingFace
categories: [FR]
tags:
  - HuggingFace
  - LLMs
  - GenAI
author_profile: false
toc: true
excerpt: "Découvrez comment Hugging Face révolutionne l'IA avec les LLMs et GenAI. Apprenez à utiliser les modèles pré-entraînés pour le NLP, la vision et plus encore."
---

Les Grands Modèles de Langage (LLMs) et l'IA générative (GenAI) représentent aujourd'hui la frontière la plus avancée de l'intelligence artificielle. Hugging Face s'est imposé comme l'écosystème de référence pour exploiter ces technologies transformatrices, offrant aux développeurs et chercheurs les outils nécessaires pour les intégrer facilement dans leurs projets. Découvrons comment cette plateforme révolutionne l'approche des LLMs dans les applications modernes.


## Introduction
Les Grands Modèles de Langage ont évolué à un rythme exponentiel depuis 2020, passant de simples outils de complétion de texte à des assistants capables de raisonnement complexe. Cette évolution a été marquée par plusieurs jalons importants :

- **GPT, BLOOM, LLaMA** : Ces architectures ont successivement repoussé les limites de ce que les modèles peuvent accomplir.
- **Instruction Tuning** : L'alignement des modèles sur les instructions humaines a permis d'améliorer significativement leur utilisabilité.
- **RLHF (Reinforcement Learning from Human Feedback)** : Cette technique d'apprentissage a considérablement amélioré la qualité et la sécurité des réponses.

Hugging Face propose un accès simplifié à ces modèles de pointe, que ce soit via la bibliothèque Transformers ou directement depuis le Hub, avec des modèles comme Falcon, Mistral, LLaMA et bien d'autres.

```python
from transformers import AutoModelForCausalLM, AutoTokenizer

# Chargement d'un modèle LLM avancé
model_name = "mistralai/Mistral-7B-Instruct-v0.1"
model = AutoModelForCausalLM.from_pretrained(model_name, device_map="auto")
tokenizer = AutoTokenizer.from_pretrained(model_name)

# Génération de texte avec instruction
instruction = "Explique-moi comment fonctionne un transformeur en IA en termes simples."
prompt = f"<s>[INST] {instruction} [/INST]"
inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
outputs = model.generate(inputs.input_ids, max_length=500)
response = tokenizer.decode(outputs[0], skip_special_tokens=True)
print(response)
```

## RAG (Retrieval-Augmented Generation) avec Hugging Face
L'intégration de connaissances externes dans les réponses des LLMs représente une avancée majeure pour améliorer leur pertinence et leur exactitude. Hugging Face facilite la mise en œuvre de systèmes RAG complets :

```python
from transformers import pipeline
from datasets import load_dataset
from langchain import HuggingFacePipeline
from langchain.vectorstores import FAISS
from langchain.embeddings import HuggingFaceEmbeddings

# 1. Préparation de la base de connaissances
embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
dataset = load_dataset("your-dataset (pdf, pptx, docx, txt, csv, json, etc.)", split="train")
documents = [doc["text"] for doc in dataset["train"]]
vectorstore = FAISS.from_texts(documents, embeddings)

# 2. Configuration du modèle de génération
llm = pipeline("text-generation", model="google/flan-t5-xl")
hf_pipeline = HuggingFacePipeline(pipeline=llm)

# 3. Recherche et génération augmentée
query = "Comment fonctionne le fine-tuning des LLMs?"
relevant_docs = vectorstore.similarity_search(query, k=3)
context = "\n\n".join([doc.page_content for doc in relevant_docs])
augmented_query = f"Contexte: {context}\n\nQuestion: {query}\n\nRéponse:"
response = hf_pipeline(augmented_query)
```

## Fine-tuning pour LLMs
L'adaptation des grands modèles aux tâches spécifiques représente un défi technique considérable en raison de leur taille. Hugging Face a démocratisé plusieurs approches innovantes pour répondre à ce problème :

### PEFT (Parameter-Efficient Fine-Tuning)
Cette famille de techniques permet d'adapter les LLMs en ne modifiant qu'une infime partie de leurs paramètres, réduisant drastiquement les ressources nécessaires.

```python
from transformers import AutoModelForCausalLM, AutoTokenizer
from peft import get_peft_model, LoraConfig, TaskType

# Configuration de LoRA
peft_config = LoraConfig(
    task_type=TaskType.CAUSAL_LM,
    r=16,  # Rang de la matrice d'adaptation
    lora_alpha=32,  # Facteur d'échelle
    lora_dropout=0.1,  # Taux de dropout
    target_modules=["q_proj", "v_proj"]  # Couches à adapter
)

# Chargement et adaptation du modèle
model = AutoModelForCausalLM.from_pretrained("meta-llama/Llama-2-7b-hf")
peft_model = get_peft_model(model, peft_config)
# Le modèle est désormais prêt pour un fine-tuning efficace
print(f"Paramètres entraînables: {sum(p.numel() for p in peft_model.parameters() if p.requires_grad)}")
```

### QLoRA et Quantification
La quantification permet de réduire la précision des poids d'un modèle pour économiser de la mémoire, tandis que QLoRA combine quantification et adaptation LoRA pour un fine-tuning sur matériel grand public.

```python
from transformers import AutoModelForCausalLM, BitsAndBytesConfig

# Configuration pour la quantification 4 bits
bnb_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_quant_type="nf4",
    bnb_4bit_compute_dtype="float16",
)

# Chargement du modèle quantifié
model = AutoModelForCausalLM.from_pretrained(
    "meta-llama/Llama-2-7b-hf",
    quantization_config=bnb_config,
    device_map="auto"
)
```



## Agents IA et MPC (Model-Programmer-Computer)
L'écosystème Hugging Face s'étend désormais aux agents IA autonomes capables d'interagir avec leur environnement pour résoudre des problèmes complexes. Le paradigme MPC, où les modèles agissent comme programmeurs interagissant avec des systèmes informatiques, ouvre de nouvelles possibilités :

### Transformers Agents
Cette bibliothèque permet de créer facilement des agents dotés d'outils et capables d'exécuter des actions en fonction du contexte.

```python
from transformers import HfAgent

# Création d'un agent basé sur un LLM
agent = HfAgent("https://api-inference.huggingface.co/models/bigcode/starcoder")

# L'agent peut exécuter des tâches variées
result = agent.run("Génère une visualisation des données du CSV suivant", 
                  files=["données.csv"])

# L'agent peut également écrire et exécuter du code
code_result = agent.run("Crée un modèle de classification pour ces données")
```

### Orchestration avec LangChain et Hugging Face
La combinaison de LangChain et Hugging Face permet de créer des workflows sophistiqués où les LLMs prennent des décisions et déclenchent des actions.

```python
from langchain import LLMChain
from langchain.prompts import PromptTemplate
from langchain.agents import AgentType, initialize_agent, Tool
from transformers import pipeline

# Création d'un LLM via Hugging Face
llm = HuggingFacePipeline(pipeline=pipeline("text-generation", model="mistralai/Mistral-7B-Instruct-v0.1"))

# Définition des outils accessibles à l'agent
tools = [
    Tool(
        name="Recherche",
        func=lambda q: vectorstore.similarity_search(q),
        description="Recherche d'informations dans une base documentaire"
    ),
    Tool(
        name="Calculatrice",
        func=lambda q: eval(q),
        description="Utile pour effectuer des calculs mathématiques"
    )
]

# Initialisation de l'agent
agent = initialize_agent(
    tools, 
    llm, 
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True
)

# Exécution d'une tâche complexe
agent.run("Calcule le ROI d'un projet qui a coûté 50000€ et rapporté 75000€ sur 2 ans")
```

## Déploiement et industrialisation
Hugging Face propose plusieurs options pour déployer efficacement les LLMs en production :

1. **Inference Endpoints** : Service managé pour déployer des API de modèles pré-entraînés ou personnalisés.
2. **Optimum** : Bibliothèque d'optimisation pour accélérer l'inférence et réduire les coûts d'exécution.
3. **Text Generation Inference (TGI)** : Serveur optimisé pour la génération de texte à haut débit.

```python
# Déploiement via Hugging Face Inference API
from huggingface_hub import InferenceClient

client = InferenceClient("https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.1")

response = client.text_generation(
    "Comment puis-je implémenter un système RAG?",
    max_new_tokens=512,
    temperature=0.7
)

print(response)
```

### Considérations éthiques et biais
L'utilisation responsable des LLMs reste un défi majeur. Hugging Face propose des outils pour évaluer et atténuer les biais :

```python
from evaluate import load

# Chargement d'outils d'évaluation
toxic_eval = load("toxicity")
bias_eval = load("bias")

# Évaluation des réponses d'un modèle
responses = ["Le modèle génère plusieurs réponses à évaluer..."]
toxic_scores = toxic_eval.compute(predictions=responses)
bias_scores = bias_eval.compute(predictions=responses)
```

---

Hugging Face continue d'innover rapidement dans le domaine des LLMs et de l'IA générative, rendant ces technologies de pointe accessibles à un public toujours plus large. Que vous soyez chercheur, développeur ou simplement curieux, la plateforme vous offre toutes les ressources nécessaires pour explorer et exploiter le potentiel révolutionnaire des grands modèles de langage dans vos projets.

---

> Ce guide vous donne les clés pour exploiter tout le potentiel des Transformers et des LLMs avec Hugging Face, que vous soyez débutant ou déjà initié à l'IA.

<div style="text-align:center">
  <img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbHJ3YjN4aTZmYmU1NXRxbTByYTBvdjY0YjF3YXRvemE0ZmJmNnp4NiZlcD12MV9naWZzX3RyZW5kaW5nJmN0PWc/gjgWQA5QBuBmUZahOP/giphy.gif">
</div>

## Pour aller plus loin
- [Evaluate RAG pipeline using HuggingFace](https://huggingface.co/blog/lucifertrj/evaluate-rag)
- [Hugging Face Guide (EN)](https://inside-machinelearning.com/en/hugging-face-guide/)

> Explorez [HuggingFace.co](https://huggingface.co/) pour tester des modèles en ligne et rejoindre la communauté !
