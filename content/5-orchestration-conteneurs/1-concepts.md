+++
title = 'Concepts fondamentaux'
draft = false
weight = "510"
+++
--------------

Avant d’introduire et explorer les outils d'**orchestration** tels que *Kubernetes* ou *Amazon ECS*, il est important de comprendre certains concepts fondamentaux liés au déploiement et à la gestion d’applications modernes.

## Mise à l’échelle (*Scaling*)

![Scaling vertical vs. horizontal](../images/05-01.png)


### Scaling vertical

Le **scaling vertical** consiste à augmenter les ressources d’une seule machine (plus de CPU, de RAM, de stockage). 
+ **Exemple :** passer un serveur de 4 Go de RAM à 16 Go
+ **Avantages :** Simple à mettre en place, pas de modification de l’architecture.
+ **Limites :** Capacité maximale limitée (on ne peut pas augmenter indéfiniment) et point unique de défaillance (*single point of failure*)

### Scaling horizontal

Le **scaling horizontal** consiste à ajouter plusieurs instances d’un même service : plusieurs conteneurs et/ou plusieurs serveurs

+ **Exemple :** passer de 1 instance à 5 instances d’une API
+ **Avantages :** Meilleure résilience, scalabilité quasi illimitée et répartition de la charge
+ **Limites :** Plus complexe à gérer et nécessite du load balancing

## Répartition de charge (*load balancing*)

Comme présenté dans la section précédente, le *load balancing* consiste à distribuer les requêtes entre plusieurs instances d’un service.

+ **Exemple :** Un utilisateur envoie une requête → Elle est redirigée vers l’un des conteneurs disponibles
+ **Objectifs :** Évite la surcharge d’un seul serveur, améliore les performances et assure la disponibilité.

<!-- {{%notice style="tip" title="Remarque"%}}
Dans Docker Compose, ce mécanisme est **très basique**, alors que les orchestrateurs offrent :
+ routage intelligent
+ gestion du trafic externe
+ tolérance aux pannes
{{%/notice%}} -->

## Déploiement progressif (*rolling updates*)

Un *rolling update* consiste à mettre à jour une application **progressivement**, sans interruption de service.

+ **Principe :**
  1. On remplace une instance à la fois
  2. Les autres continuent de servir les utilisateurs
  3. Le processus se répète jusqu’à mise à jour complète
+ **Avantages :** Pas de downtime, risque réduit et possibilité d’arrêter en cas de problème.

### Stratégies de déploiement progressif
![Canary Deployment vs. Blue/Green Deployment](../images/05-02.png)
#### Déploiement *Blue/Green*
+ Deux environnements identiques sont utilisés :
  + **Blue :** version actuelle (production)
  + **Green :** nouvelle version
+ **Étapes :**
  1. Déployer la nouvelle version sur *Green*
  2. Tester
  3. Basculer le trafic vers *Green*
+ **Avantages :** Zéro interruption et *rollback* très rapide

#### Déploiement *Canary*
Le *Canary deployment* consiste à déployer une nouvelle version pour une **petite portion des utilisateurs**.

+ **Exemple :**
  + 5 % des utilisateurs → nouvelle version
  + 95 % → ancienne version
  + **Si tout se passe bien →** On augmente progressivement jusqu’à 100 %
+ **Avantages :** Détection rapide des problèmes et réduction des risques en production

## Haute disponibilité (*high availability*)

Une application est donc dite **hautement disponible** lorsqu’elle reste accessible même en cas de panne.

+ Cela implique :
  + plusieurs instances
  + redondance
  + mécanismes de reprise automatique
+ **Exemple :** Si un conteneur tombe, un autre prend le relais immédiatement.

{{%notice style="tip" title="Rappel"%}}
Le concept de haute disponibilité a été introduit dans le **Chapitre 1**, lorsque nous avions mentionné l'importance de déployer une infrastructure Cloud sur plusieurs zones de disponibilité pour assurer l'accessibilité de nos services même en cas de panne.
{{%/notice%}}

## Auto-réparation (*self healing*)

L'auto-réparation (*self healing*) est l'objectif de maintenir en permanence l’**état désiré** de nos services en mettant en place des mécanismes qui permettent d'automatiquement :
+ redémarrer un conteneur en panne
+ recréer une instance supprimée
+ remplacer un service défaillant

## État désiré (*desired state*)

Dans une approche déclarative, On décrit **ce que l’on veut** et le système s’assure que cela est respecté.

+ **Exemple :**  *"Je veux 3 instances de mon API”*
+ **Si une instance tombe →** le système en recrée automatiquement une

<!-- Pourquoi ces concepts sont importants ?

Ces mécanismes répondent à des besoins réels :

gérer la montée en charge
éviter les interruptions de service
déployer sans risque
automatiser la gestion des pannes

👉 Docker Compose ne couvre que partiellement ces besoins, ce qui explique la nécessité d’utiliser des outils d’orchestration plus avancés. -->