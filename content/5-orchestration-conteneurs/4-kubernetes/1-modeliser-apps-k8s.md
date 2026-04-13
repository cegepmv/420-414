+++
title = "Modélisation d'applications"
draft = false
weight = "541"
+++
--------------

*Kubernetes* propose de nombreuses abstractions permettant de modéliser une application à différents niveaux : calcul (compute),réseau (networking), stockage (storage), configurations, données sensibles, etc...

Dans cette section, nous allons nous concentrer sur les ressources fondamentales que vous utiliserez dans la majorité des cas : **Namespaces**, **Pods**, **Deployments** et **Services**.

![Schéma deployment, pod et service](../images/5-03.png)

## Pods et Deployments
### Pods : unité de base
Dans Kubernetes, les conteneurs ne sont jamais exécutés directement. Ils sont toujours encapsulés dans une ressource appelée **Pod**.

+ **Définition :** Un *Pod* est la plus petite unité déployable dans Kubernetes. Il peut contenir un ou plusieurs conteneurs et un stockage partagé entre eux.

+ **Rôle :** Le *Pod* est responsable d'exécuter les conteneurs.

{{%notice style="tip" title="En pratique"%}}
1 Pod = 1 instance de l'application (dans la majorité des cas)
{{%/notice%}}

{{%notice style="warning" title="Limite importante"%}}
Les Pods sont éphémères et non fiables individuellement. On ne les crée presque jamais directement en production.
{{%/notice%}}

### Deployments : gestion des pods

Pour gérer correctement les **Pods**, Kubernetes fournit une abstraction de plus haut niveau : les **Deployments**.

+ **Définition :** Un *Deployment* est une ressource qui crée et gère des *Pods*, assure leur disponibilité et permet de facilement les mettre à jour
+ **Rôle :** Un Deployment permet de définir combien de *Pods* doivent être actifs, maintenir ce nombre (**self-healing**), effectuer des **rolling updates** ou revenir en arrière (**rollback**).

{{%notice style="tip" title="Service ECS vs. Deployment Kubernetes "%}}
Un Service dans ECS joue à peu près le même rôle qu’un Deployment dans Kubernetes : maintenir des conteneurs en vie selon une configuration déclarative. Par contre, le Service Kubernetes est un objet complètement différent qui sert au réseau.

Aussi, ECS Service peut être directement lié à un ALB/NLB

Kubernetes sépare :
+ Deployment (déploiement)
+ Service (réseau)
{{%/notice%}}

**Exemple:** 
+ Vous demandez : “Je veux 3 instances de mon API”
+ Le Deployment : crée 3 Pods, remplace automatiquement un Pod s’il tomb et met à jour progressivement les Pods si l’image change.

## Services : couche réseau

Kubernetes sépare complètement la partie réseau du calcul. Cette abstraction s’appelle un **Service**

+ Définition : Un Service est une ressource qui expose vos Pods, fournit un point d’accès stable et distribue le trafic
+ Rôle: Un Service permet notamment de donner un nom DNS aux Pods, d'exposer un port, de faire du load balancing et/ou de router le trafic vers les bons Pods

**Exemple concret:** Imaginons une application avec une base de données (MySQL), une API et un frontend.

**Architecture :**
+ Service DB → accessible uniquement en interne
+ Service API → communique avec la DB
+ Service Web → exposé à Internet

{{%notice style="tip" title="Comment communiquent les composants?"%}}
Les composants communiquent entre eux via les noms DNS des services. Nous verrons cela plus en détail dans un prochain laboratoire !
{{%/notice%}}

#### Types de Services

Il existe plusieurs types de Services dans Kubernetes, chacun adapté à un cas d’usage spécifique.

1. **ClusterIP** (par défaut) : Service interne au cluster
    + Accessible uniquement depuis l’intérieur du cluster
    + Non exposé à Internet
    + Utilisation typique : communication entre services (API ↔ base de données)
2. **NodePort :** Expose le service à l’extérieur du cluster
    + Ouvre un port sur chaque nœud du cluster
    + Accessible via : `<IP-du-node>:<nodePort>`
    + **Limites :** peu sécurisé, peu flexible, ports limités (30000–32767)
3. **LoadBalancer :** Expose le service via un *Load Balancer* externe
    + Crée automatiquement un équilibreur de charge (cloud)
    + Fournit une IP ou DNS (et non pas IP:port)


{{%notice style="warning" title="Important – Contexte du laboratoire"%}}
Dans le carde du cours, le cluster *Kubernetes* est hébergé sur nos propres serveurs (*self hosted*), il n'y a pas de *Load Balancer* cloud disponible (pour le moment). Vous pouvez donc uniquement utiliser *ClusterIP* et *NodePort*.

Si vous utilisez *Kubernetes* dans un environnement cloud comme *Amazon EKS*, *Azure AKS* ou *Google GKE*, vous pourrez utiliser le type `LoadBalancer`. Le fournisseur créera automatiquement un équilibreur de charge externe pour exposer votre application.
{{%/notice%}}

##### Résumé

|Type|Accès	|Disponible en labo|	Cas d’usage|
|----|------|----------------|----------|
|ClusterIP|	Interne	|✅	|Communication entre services|
|NodePort|	Externe (port)|	✅	|Tests / dev|
|LoadBalancer|	Externe (IP ou DNS)|	❌|	Production (cloud)|

<!-- 🧠 À retenir
Par défaut, un Service est de type ClusterIP
Dans ce cours :
vous utiliserez principalement NodePort pour exposer vos applications
Le type LoadBalancer est surtout utilisé en environnement cloud -->

### Résumé des rôles

|Ressource|	Rôle|
|---------|-----|
|**Pod**|	Exécute les conteneurs|
|**Deployment**|	Gère les Pods (scaling, mises à jour, résilience)|
|**Service**|	Gère le réseau et l’accès|

## *Namespaces* : isolation des ressources
![Schéma cluster k8s séparés par des namespaces](../images/5-04.png)

Dans Kubernetes, les **Namespaces** permettent de **séparer logiquement les ressources à l’intérieur d’un même cluster**. On peut les voir comme des “espaces de travail” indépendants.


**Définition :** Un Namespace est une **partition logique** du cluster qui permet d’isoler les ressources (Pods, Services, Deployments, etc.), d’organiser les environnements (dev, test, prod) et de gérer les accès et permissions.

{{%notice style="tip" title="Pourquoi utiliser des namespaces ?"%}}
Les namespaces sont utiles pour éviter les conflits de noms, séparer les utilisateurs/les équipes, limiter les accès (sécurité) et/ou organiser les ressources.
{{%/notice%}}
### Cadre du laboratoire

Dans le carde de ce cours, chaque étudiant dispose de son propre *namespace*. Sur le cluster, vous avez les **droits de lecture et écriture dans votre namespace** et **lecture seule dans le namespace du groupe** (`cloud-class`)

{{%notice style="info" title="Comportement par défaut"%}}
Si vous n’indiquez pas de namespace dans vos commandes, Kubernetes utilise automatiquement votre namespace par défaut.

Pour interagir avec un autre namespace, on utilise l’option :
```bash
kubectl get pods -n <nom-du-namespace>
```
{{%/notice%}}


**Exemple (namespace de l’enseignant) :**
```bash
kubectl get pods -n cloud-class
```

Vous ne pourrez pas modifier les ressources dans ce namespace.

{{%notice style="note" title="Pourquoi un namespace pour le groupe-classe?"%}}
Durant le cours et les laboratoires, vous pourrez observer les ressources déployées par l’enseignant puis les comparer avec vos propres déploiements (sur vos propres *namespaces*).
{{%/notice%}}

Pour lister les *namespaces* : 
```bash
kubectl get namespaces # ou get ns
```


