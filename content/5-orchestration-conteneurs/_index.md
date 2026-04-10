+++
pre = '<b>6. </b>'
title = 'Orchestration de conteneurs'
draft = false
weight = "500"
+++
--------------

Avec l’adoption croissante des architectures basées sur les conteneurs, les applications modernes sont de plus en plus composées de plusieurs services (API, bases de données, frontend, etc.), chacun exécuté dans son propre conteneur.

Gérer manuellement ces conteneurs devient rapidement complexe :
+ Combien d’instances doivent être en cours d’exécution ?
+ Que faire en cas de panne ?
+ Comment gérer les mises à jour sans interrompre le service ?
+ Comment répartir la charge entre les différentes instances ?

C’est pour répondre à ces problématiques qu’intervient l’**orchestration des conteneurs**.

L’orchestration de conteneurs est l’ensemble des mécanismes permettant de **déployer**, **gérer**, **mettre à l’échelle** et **maintenir automatiquement** un ensemble de conteneurs, généralement répartis sur **plusieurs machines**, tout en garantissant un **état désiré**.
<!-- En d’autres termes, on décrit **ce que l’on veut**, et l’orchestrateur s’assure que le système reste conforme à cette description, même en cas de problème. -->

<!-- ## Nécessité de écessaire ?

Des outils comme *Docker Compose* permettent déjà de gérer des applications multi-conteneurs, mais ils atteignent rapidement leurs limites dès que l’on souhaite :

+ passer à l’échelle
+ améliorer la résilience
+ déployer en production

L’orchestration apporte des solutions à ces enjeux :
+ gestion automatique des pannes (auto-healing)
+ répartition de charge
+ déploiements sans interruption
+ scalabilité horizontale -->

## Notions abordées dans ce chapitre

Dans ce chapitre, nous allons progressivement introduire les concepts et outils essentiels de l’orchestration.
### 1. Concepts fondamentaux
Nous commencerons par introduir les concepts clés nécessaires à la compréhension de l’orchestration : mise à l’échelle (scaling horizontal et vertical), stratégies de déploiement (rolling updates, blue/green, canary), haute disponibilité et résilience.

### 2. Limites de Docker Compose
Nous analyserons ensuite les limites de *Docker Compose* afin de comprendre pourquoi il est insuffisant pour des environnements distribués et quels problèmes concrets il ne permet pas de résoudre

### 3. Introduction aux orchestrateurs
Nous terminerons par une introduction à deux solutions majeures : 
+ **Amazon ECS (*Elastic Container Service*) -** Une solution d’orchestration proposée par Amazon Web Services, qui permet une intégration native avec l’écosystème AWS, une prise en main plus simple et une gestion entièrement managée
+ **Kubernetes -** La plateforme d’orchestration la plus utilisée aujourd’hui, offrant une grande flexibilité, une gestion avancée des déploiements et une forte adoption dans l’industrie

<!-- 🔹 Objectif pédagogique

À la fin de ce chapitre, vous serez en mesure de :

comprendre les limites des outils simples comme Docker Compose
expliquer les concepts clés liés à l’orchestration
distinguer les principales solutions d’orchestration
comprendre le rôle d’outils comme Kubernetes et Amazon ECS dans un environnement cloud -->