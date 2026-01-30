+++
pre = '<b>1. </b>'
title = 'Modèles Infonuagiques'
draft = false
weight = "110"
+++

L’infonuagique repose sur différents **modèles de services** et **modèles de déploiement**. Ces modèles permettent de définir clairement :
+ qui est responsable de quoi,
+ quel niveau de contrôle possède l’utilisateur,
+ quel degré de flexibilité, de simplicité et de gestion est offert.

Comprendre ces modèles est essentiel pour choisir la solution la plus adaptée aux besoins techniques, financiers et organisationnels.


#### Les modèles "as-a-Service"

![as-a-Service](/420-414/images/1-introduction/1-03-iaas-paas-saas.png)

L’expression *"as-a-Service* signifie qu’un fournisseur tiers prend en charge une partie (ou la totalité) de l’infrastructure informatique et la fournit sous forme de service accessible via Internet.

L’objectif principal est de permettre aux organisations de **se concentrer sur leurs activités à valeur ajoutée** (développement, innovation, relation client), plutôt que sur la gestion du matériel et des systèmes.

Plus le service est "haut niveau", plus le fournisseur gère d’éléments, et moins l’utilisateur a de responsabilités techniques.


#### Infrastructure sur-site (*On-Premise / On-Site*)
Avant le cloud, la majorité des organisations utilisaient une **infrastructure sur site**.
##### Caractéristiques
+ Tout le matériel et les logiciels sont hébergés localement.
+ L’organisation est responsable de :
    + l’achat du matériel,
    + l’installation,
    + la maintenance,
    + les mises à jour,
    + la sécurité,
    + le remplacement des équipements défectueux.
+ Ce modèle offre un **contrôle total**, mais implique aussi un **coût élevé**, une grande complexité opérationnelle et peu de flexibilité.

Le cloud computing permet d’**externaliser une partie ou la totalité de ces responsabilités**.

#### IaaS – Infrastructure as a Service

Le modèle **IaaS** fournit des ressources informatiques de base sous forme de services.
##### Répartition des responsabilités
**Responsabilités de l’utilisateur :**
+ Applications
+ Données
+ Moteur d’exécution (runtime)
+ Intergiciel (middleware)
+ Système d’exploitation

**Responsabilités du fournisseur :**
+ Virtualisation
+ Serveurs physiques
+ Stockage
+ Réseau

Ce modèle offre une **grande flexibilité** et un **haut niveau de contrôle**, mais nécessite davantage de gestion technique.
##### Exemples de fournisseurs IaaS
Amazon Web Services (AWS)
Google Cloud Platform (GCP)
Microsoft Azure


#### PaaS Platform as a Service

![PaaS](/420-414/images/1-introduction/1-04-paas.png?width=700px)

Le modèle **PaaS** fournit une plateforme complète permettant de développer, tester et déployer des applications sans se soucier de l’infrastructure sous-jacente.

##### Principe
Le fournisseur gère le matériel, le système d’exploitation et les environnements d’exécution. L’utilisateur se concentre sur le **code et la logique applicative**.

Ce modèle est particulièrement adapté aux **développeurs et équipes de programmation**.
##### Avantages
+ Réduction de la complexité opérationnelle
+ Déploiement rapide des applications
+ Moins de maintenance et de mises à jour à gérer
##### Exemples de services PaaS
+ **Amazon Elastic Beanstalk (AWS)** : service d’orchestration et de déploiement d’applications
+ **Google App Engine (GCP)** : plateforme de développement et d’hébergement d’applications web


#### SaaS


![SaaS](/420-414/images/1-introduction/1-05-saas.png?width=700px)

Le modèle **SaaS** correspond à des applications prêtes à l’emploi, accessibles directement via Internet.
##### Caractéristiques
Dans ce modèle, **tout est géré par le fournisseur** :
+ Application
+ Données
+ Environnement d’exécution
+ Intergiciel
+ Système d’exploitation
+ Virtualisation
+ Serveurs
+ Stockage
+ Réseau

L’utilisateur se contente d’utiliser le logiciel, généralement via un navigateur web.
##### Exemples de services SaaS
+ Zoom
+ Dropbox (stockage de fichiers)
+ Slack (messagerie et collaboration)
+ Mailchimp (marketing par courriel)

#### Comparaison des modèles de services
Plus on se rapproche du SaaS, plus la **simplicité d’utilisation augmente**, mais plus le **niveau de contrôle diminue**.

À l’inverse, le modèle IaaS offre davantage de flexibilité et de contrôle, au prix d’une gestion plus complexe.


#### Modèles de déploiement

![Modèles de déploiement](/420-414/images/1-introduction/1-08-modele-deploiement.png?width=700px)


Les modèles de déploiement
En plus des modèles de services, le cloud se décline selon différents modèles de déploiement.

##### Cloud privé (Private Cloud)
Le **cloud privé** est une infrastructure dédiée à une seule organisation.
###### Caractéristiques
+ Les ressources ne sont pas partagées avec d’autres organisations.
+ L’infrastructure est généralement hébergée sur site (on-premise).
+ Offre un niveau élevé de contrôle et de sécurité.
###### Limites
+ Peu ou pas d’avantages liés à l’élasticité et aux économies d’échelle du cloud public.
+ Coûts élevés de mise en place et de maintenance.

##### Cloud public (Public Cloud)
Le cloud public repose sur une infrastructure appartenant à un fournisseur de services cloud (CSP).
###### Caractéristiques
+ Les ressources sont mutualisées entre plusieurs clients.
+ Aucun matériel à gérer pour l’utilisateur.
+ Paiement à l’utilisation.
+ Ce modèle est le plus répandu et constitue la base de services comme AWS, Azure et GCP.

##### Cloud hybride (Hybrid Cloud)
Le cloud hybride combine un cloud privé et un cloud public.
##### Principe
+ Les données sensibles ou critiques restent hébergées localement.
+ Les autres charges de travail sont déployées dans le cloud public.
+ La connexion entre les deux environnements se fait généralement via un VPN ou une liaison dédiée.

Ce modèle permet de tirer parti de la flexibilité du cloud public tout en conservant un contrôle accru sur certaines données.
