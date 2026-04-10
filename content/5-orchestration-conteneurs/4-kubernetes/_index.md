+++
title = 'Kubernetes'
draft = true
weight = "540"
+++
--------------
Après avoir exploré *Amazon ECS*, nous allons maintenant introduire une plateforme beaucoup plus répandue dans l’industrie : **Kubernetes**.

**Kubernetes** est une plateforme open source d’orchestration de conteneurs conçue pour automatiser le déploiement, gérer et mettre à l’échelle des applications conteneurisées. Développée par Google et maintenant gérée par la **Cloud Native Computing Foundation**, elle est devenue la norme mondiale pour l’exécution d’applications natives du cloud.

Kubernetes est aujourd’hui la solution d’orchestration de conteneurs la plus utilisée. Elle est extrêmement puissante, mais aussi réputée pour sa complexité et sa courbe d’apprentissage élevée.

{{%notice style="info" title="Note"%}}
Cette réputation est justifiée. Cependant, l’investissement en vaut largement la peine.
{{%/notice%}}

## Faits clés
+ **Création :** 2014 chez Google
+ **Type :** Plateforme d’orchestration de conteneurs open source
+ **Organisation responsable :** *Cloud Native Computing Foundation (CNCF)*
+ **Nom abrégé :** K8s
+ **Langage principal :** Go


## Pourquoi Kubernetes ?

Kubernetes offre un avantage majeur : la **portabilité**.

Comme pour *Docker*, Une application déployée sur Kubernetes peut fonctionner de la même manière sur votre machine locale, dans le cloud (AWS, Azure, GCP) ou dans un centre de données

Contrairement à ECS (spécifique à AWS), Kubernetes est **open-source**, **standardisé** et **supporté par tous les grands fournisseurs cloud**.

## Kubernetes : un orchestrateur de conteneurs
Comme *ECS*, *Kubernetes* est un **orchestrateur de conteneurs**. Son rôle est de déployer des conteneurs, les maintenir en fonctionnement, gérer la scalabilité (*high availability*) et assurer la résilience (*self-healing*).

## Architecture d’un cluster Kubernetes
Un cluster Kubernetes est composé de plusieurs machines (appelées nodes), organisées en deux grandes parties :

### 1. Control Plane (plan de contrôle)
Le **Control Plane** est le “cerveau” du cluster. Il est responsable de gérer l’état global du cluster, décider où lancer les conteneurs, surveiller les applications et réagir aux pannes.

### 2. Worker Nodes (nœuds de travail)
Les **Worker Nodes** sont les machines qui exécutent réellement les conteneurs. Chaque nœud exécute un moteur de conteneurs (ex : Docker), héberge les applications et communique avec le *Control Plane*

### Communication continue

Le *Control Plane* et les *Worker Nodes* communiquent en permanence :
+ envoi d’instructions (déploiement, scaling)
+ remontée d’état (*health checks*)
+ synchronisation de l’état réel vs désiré

Cela permet à Kubernetes de maintenir automatiquement le système en bon état (**desired state**).

## L’API Kubernetes : le point central
Toutes les interactions avec Kubernetes passent par une API centrale.

Cette API permet de :
+ déployer des applications
+ consulter l’état du cluster
+ modifier la configuration

### kubectl : l’outil en ligne de commande
L’outil principal pour interagir avec Kubernetes est `kubectl`

**Exemple :**
```bash
kubectl apply -f app.yaml
```

Cette commande permet de lire un fichier de configuration YAML et appliquer l’état désiré au cluster

## Approche déclarative
Comme avec Docker Compose, Kubernetes adopte une approche déclarative.

+ On décrit : “Voici ce que je veux”
+ Kubernetes s’occupe de créer les ressources, maintenir leur état et corriger les écarts automatiquement.

## Modélisation des applications
Même si Kubernetes utilise les mêmes images Docker, la manière de décrire une application est différente

+ Docker Compose → simple et centralisé
+ Kubernetes → plus modulaire et granulaire

C’est ici que la complexité apparaît :
+ beaucoup de concepts
+ beaucoup de fichiers YAML
+ beaucoup de possibilités

## Un comportement uniforme partout
Un des plus grands avantages de Kubernetes : Le même fonctionnement, peu importe l’environnement

**Exemples :**
+ Un cluster local avec Docker Desktop
+ Un cluster cloud avec 100 nœuds

On utilise :
+ les mêmes fichiers YAML
+ les mêmes commandes (`kubectl`)

## Kubernetes dans le cloud
Tous les grands fournisseurs proposent une version managée :
+ AWS → *Elastic Kubernetes Service (EKS)*
+ Azure → *Azure Kubernetes Service (AKS)*
+ Google Cloud → *Google Kubernetes Engine (GKE)*

Cela permet de déléguer la gestion de l’infrastructure et se concentrer sur les applications

## Conclusion
*Kubernetes* est plus complexe que *ECS* mais plus flexible, plus puissant et plus universel (*open-source*). C’est un standard incontournable pour les applications modernes.

<!-- 🔜 Prochaine étape

Maintenant que nous comprenons son fonctionnement global, nous allons voir :

➡️ comment modéliser une application dans Kubernetes, en introduisant ses ressources de base comme :

les Pods
les Services -->