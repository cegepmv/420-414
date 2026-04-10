+++
title = "Modélisation d'applications"
draft = true
weight = "541"
+++
--------------

*Kubernetes* propose de nombreuses abstractions permettant de modéliser une application à différents niveaux : calcul (compute),réseau (networking), stockage (storage), configurations, données sensibles, etc...

Dans cette section, nous allons nous concentrer sur les ressources fondamentales que vous utiliserez dans la majorité des cas : **Namespaces**, **Pods**, **Deployments** et **Services**.

## Pods, Deployments et Services
### 1. Les Pods : unité de base
Dans Kubernetes, les conteneurs ne sont jamais exécutés directement. Ils sont toujours encapsulés dans une ressource appelée **Pod**.

+ **Définition :** Un Pod est la plus petite unité déployable dans Kubernetes. Il peut contenir un ou plusieurs conteneurs, un stockage partagé et une configuration réseau.

+ **Rôle :** Le Pod est responsable d'exécuter les conteneurs, de maintenir leur état et de configurer leur environnement (réseau, variables, filesystem)

{{%notice style="tip" title="En pratique"%}}
1 Pod = 1 instance de votre application (dans la majorité des cas)
{{%/notice%}}

{{%notice style="warning" title="Limite importante"%}}
Les Pods sont éphémères et non fiables individuellement. On ne les crée presque jamais directement en production.
{{%/notice%}}

### 2. Les Deployments : gestion des Pods

Pour gérer correctement les **Pods**, Kubernetes fournit une abstraction de plus haut niveau : les **Deployments**.

+ **Définition :** Un Deployment est une ressource qui crée et gère des Pods, assure leur disponibilité et permet de facilement les mettre à jour
+ Rôle : Un Deployment permet de Définir combien de Pods doivent être actifs, maintenir ce nombre (**self-healing**), effectuer des **rolling updates** ou Revenir en arrière (**rollback**)

**Exemple:** 
+ Vous demandez : “Je veux 3 instances de mon API”
+ Le Deployment :
  + crée 3 Pods
  + remplace automatiquement un Pod s’il tombe
  + met à jour progressivement les Pods si l’image change

### 3. Les Services : couche réseau

Kubernetes sépare complètement la partie réseau du calcul. Cette abstraction s’appelle un **Service**

+ Définition : Un Service est une ressource qui expose vos Pods, fournit un point d’accès stable et distribue le trafic
+ Rôle: Un Service permet notamment de donner un nom DNS aux Pods, d'exposer un port, de faire du load balancing et/ou de router le trafic vers les bons Pods

**Exemple concret:** 
+ Imaginons une application avec :
  + une base de données (PostgreSQL)
  + une API
  + un frontend

**Architecture :**
+ Service DB → accessible uniquement en interne
+ Service API → communique avec la DB
+ Service Web → exposé à Internet

Les composants communiquent entre eux via les noms DNS des services. Nous verrons cela plus en détail dans un prochain laboratoire !

#### Types de Services Kubernetes

Il existe plusieurs types de Services dans Kubernetes, chacun adapté à un cas d’usage spécifique.

##### 1. ClusterIP (par défaut)

👉 Service interne au cluster

Accessible uniquement depuis l’intérieur du cluster
Non exposé à Internet
Utilisation typique :
communication entre services (API ↔ base de données)

👉 Exemple :

votre API accède à PostgreSQL via db-service
##### 2. NodePort

👉 Expose le service à l’extérieur du cluster

Ouvre un port sur chaque nœud du cluster

Accessible via :

<IP-du-node>:<nodePort>
Exemple :
http://192.168.1.10:30007
Utilisation :
tests
environnements de développement

⚠️ Limites :

peu sécurisé
peu flexible
ports limités (30000–32767)
##### 3. LoadBalancer

👉 Expose le service via un Load Balancer externe

Crée automatiquement un équilibreur de charge (cloud)
Fournit une IP publique ou DNS
Utilisation :
applications en production
accès public (frontend, API)


#### ⚠️ Important – Contexte du laboratoire

Dans notre environnement :

Le cluster Kubernetes est hébergé sur nos propres serveurs (self-hosted)
Aucun Load Balancer cloud n’est disponible

👉 Conséquence :

Vous pouvez utiliser uniquement :
ClusterIP
NodePort
##### Cas des environnements cloud

Si vous utilisez Kubernetes dans un environnement cloud comme :

Amazon EKS
Azure AKS
Google GKE

👉 Dans ce cas, vous pourrez utiliser le type :

LoadBalancer

➡️ Le fournisseur cloud créera automatiquement un équilibreur de charge externe pour exposer votre application.

🔁 Résumé
Type	Accès	Disponible en labo	Cas d’usage
ClusterIP	Interne	✅	Communication entre services
NodePort	Externe (port)	✅	Tests / dev
LoadBalancer	Externe (IP publique)	❌	Production (cloud)
🧠 À retenir
Par défaut, un Service est de type ClusterIP
Dans ce cours :
vous utiliserez principalement NodePort pour exposer vos applications
Le type LoadBalancer est surtout utilisé en environnement cloud

## Résumé des rôles
|Ressource|	Rôle|
|---------|-----|
|Pod|	Exécute les conteneurs|
|Deployment|	Gère les Pods (scaling, mises à jour, résilience)|
|Service|	Gère le réseau et l’accès|

## Les Namespaces : isolation des ressources

Dans Kubernetes, les Namespaces permettent de séparer logiquement les ressources à l’intérieur d’un même cluster.

👉 On peut les voir comme des “espaces de travail” indépendants.

🔹 Définition

Un Namespace est une partition logique du cluster qui permet :

d’isoler les ressources (Pods, Services, Deployments, etc.)
d’organiser les environnements (dev, test, prod)
de gérer les accès et permissions
🔹 Pourquoi utiliser des namespaces ?

Les namespaces sont utiles pour :

éviter les conflits de noms
séparer les utilisateurs ou les équipes
limiter les accès (sécurité)
organiser les ressources
🔹 Dans le cadre du laboratoire

Dans ce cours :

Chaque étudiant dispose de son propre namespace
Vous avez :
lecture et écriture dans votre namespace
lecture seule dans le namespace de l’enseignant
🔹 Comportement par défaut

Si vous n’indiquez pas de namespace dans vos commandes :

👉 Kubernetes utilise automatiquement votre namespace par défaut

🔹 Accéder à un autre namespace

Pour interagir avec un autre namespace, on utilise l’option :

kubectl get pods -n <nom-du-namespace>

👉 Exemple (namespace de l’enseignant) :

kubectl get pods -n prof-namespace
🔹 Cas d’usage en laboratoire

Vous pourrez :

observer les ressources déployées par l’enseignant
comparer avec vos propres déploiements
analyser le comportement des applications

⚠️ Vous ne pourrez pas modifier les ressources dans ce namespace.

🔹 Lister les namespaces
kubectl get namespaces
