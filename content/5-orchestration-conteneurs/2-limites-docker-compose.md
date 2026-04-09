+++
title = 'Limites de Docker Compose'
draft = false
weight = "520"
+++
--------------

Dans les sections précédentes, nous avons utilisé **Docker Compose** pour déployer une application multi-conteneurs. Cette approche présente plusieurs avantages importants.

Tout d’abord, *Docker Compose* permet de **décrire l’état désiré** de notre application à l’aide d’un fichier `compose.yaml`. On adopte ainsi une approche **déclarative** : plutôt que d’exécuter une suite de commandes *Docker* (approche impérative), on définit le résultat attendu, et *Docker Compose* se charge d’y parvenir.

Cela apporte plusieurs bénéfices :

+ Déploiement **simple et reproductible**
+ Centralisation de la configuration dans un seul fichier YAML
+ Intégration naturelle avec le code source (Git)
+ Facilité de démarrage d’un projet (`git clone` + `docker-compose up`)
+ Possibilité de reconstruire automatiquement les images si nécessaire

<!-- De plus, Docker Compose permet :

+ De gérer les **réseaux et les dépendances** entre services
+ D’exécuter **plusieurs instances d’un même service** (mise à l'échelle/scaling horizontal)
+ De bénéficier d’un **load balancing** basique entre les conteneurs
+ De faire cohabiter plusieurs environnements (dev, test, staging) sur un même serveur
Cependant, Docker Compose présente des limitations importantes -->

## Limites de Docker Compose
Malgré ses avantages, Docker Compose reste conçu pour fonctionner sur **un seul hôte (serveur)**. Cela entraîne plusieurs limites majeures lorsqu’on souhaite déployer des applications modernes à grande échelle.

+ **Pas de gestion multi-serveurs :** *Docker Compose* ne permet pas de répartir les conteneurs sur plusieurs machines/serveurs. Toute l’application **dépend d’un seul serveur**, ce qui crée un **point unique de défaillance** (*single point of failure*) et une **limitation en capacité** (CPU, mémoire)

+ **Haute disponibilité limitée :** Si un conteneur ou le serveur tombe en panne, il n’y a **pas de mécanisme automatique avancé** pour redémarrer ailleurs. La résilience de l’application reste **très limitée**.

+ **Scalabilité restreinte :** Bien que *Docker Compose* permette de lancer plusieurs instances d’un service, cela reste limité aux ressources d’un seul serveur et il n’y a **pas de scaling automatique** basé sur la charge.

+ **Load balancing basique :** Docker Compose offre des services de load balancing, mais ils simple, implicite et limité au réseau interne Docker. Il n’est pas adapté à des architectures distribuées ou à des besoins avancés (routing intelligent, gestion du trafic externe, etc.)

+ **Pas de gestion avancée du cycle de vie :** *Docker Compose* ne fournit pas de gestion fine des déploiements (*rolling updates*, *rollback*), de stratégie de déploiement (blue/green, canary) ni de supervision intégrée des services.

+ **Peu adapté à la production à grande échelle :** Docker Compose est idéal pour le développement, les tests et les environnements simples. Mais il devient rapidement insuffisant pour des systèmes distribués, des applications critiques ou des infrastructures cloud.

## Introduction à l'orchestration

Ces limitations nous amènent à introduire un nouveau concept essentiel : **l’orchestration de conteneurs**.

Un orchestrateur permet de :
+ Déployer des conteneurs sur **plusieurs machines**
+ Assurer la **haute disponibilité**
+ Gérer le **scaling automatique**
+ Optimiser l’utilisation des ressources
+ Superviser et maintenir l’**état désiré** du système

Des outils comme *Docker Swarm*, *Kubernetes* ou *Amazon ECS* reprennent le principe déclaratif introduit par Docker Compose, mais l’étendent à une **infrastructure distribuée** et **hautement résiliente**.