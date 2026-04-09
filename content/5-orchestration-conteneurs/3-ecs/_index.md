+++
title = 'ECS'
draft = false
weight = "530"
+++
--------------

*Amazon Elastic Container Service (ECS)* est un service d'orchestration de conteneurs proposé par *Amazon Web Services*. Contrairement à Kubernetes, qui est un standard open-source, ECS est conçu pour s'intégrer nativement et de manière simplifiée avec l’écosystème AWS.


## Concepts fondamentaux ECS

Voici les trois piliers fondamentaux pour comprendre le fonctionnement d’ECS :

### 1- Task Definition (Définition de tâche)

La **Task Definition** est le "plan de construction" de notre application. Cette configuration décrit un ou plusieurs conteneurs (jusqu'à 10) qui doivent fonctionner ensemble.

**Ce qu'on y trouve :**
+ Image Docker
+ CPU / mémoire
+ Variables d’environnement
+ Ports réseau
+ Volumes

{{%notice style="tip" title="Analogie"%}}
C'est la recette de cuisine. Elle ne se mange pas, mais elle explique exactement comment préparer le plat.
{{%/notice%}}

### 2- Task & Service (Tâches et Services)
#### Task (Tâche)
Une **Task** est l'**instanciation d'une Task Definition**.

C’est le ou les conteneurs qui s’exécutent réellement.

#### Service

Le Service est le gestionnaire du cycle de vie des tâches.

+ **Rôle :** Maintenir un nombre défini de tâches (ex : 2 instances) et redémarrer automatiquement en cas de panne (self-healing)
+ **Connectivité :** Peut être relié à un *Load Balancer* (ALB) pour distribuer le trafic

### 3- Cluster

Le **Cluster** est l’environnement d’exécution des tâches et services.

**Deux modes de capacité :**
+ **EC2 :** gestion manuelle des machines
+ **AWS Fargate :** mode *serverless* (aucune gestion de serveurs, plus besoin de maintenir des instances EC2)
