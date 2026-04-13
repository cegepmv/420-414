+++
title = 'Laboratoire'
draft = false
weight = "531"
+++
--------------

Dans ce laboratoire, nous allons explorer  **Amazon Elastic Container Service (ECS)**, le service d'orchestration de conteneurs offert dans l'environnement AWS.

L'infrastructure à déployer est la suivante : 

!["infra-lab-ecs"](../../images/05-03.png)

À la fin de cet atelier, vous serez en mesure de :

+ Déployer une application multi-conteneurs sur AWS.
+ Configurer un environnement réseau sécurisé (VPC, subnets, security groups)
+ Déployer une base de données avec *Amazon RDS*
+ Mettre en place un service *ECS* assurant la haute disponibilité
+ Observer les mécanismes de **scaling** et de **self-healing**


## 1 - Création du VPC et des *Security Groups*
Dans cette étape, nous allons créer un VPC pour y déployer nos services. Les spécifications du VPC :

+ **Nom du VPC :** `lab-ecs-vpc`
+ **CIDR du VPC :** `10.0.0.0/16`
+ Sous-réseau 1 (public)
  + **Nom:** `lab-ecs-subnet-public1`
  + **CIDR:** `10.0.0.0/24`
+ Sous-réseau 2 (public)
  + **Nom:** `lab-ecs-subnet-public2`
  + **CIDR:** `10.0.1.0/24`
+ Sous-réseau 3 (privé)
  + **Nom:** `lab-ecs-subnet-private1`
  + **CIDR:** `10.0.2.0/24`
+ Sous-réseau 4 (privé)
  + **Nom:** `lab-ecs-subnet-private2`
  + **CIDR:** `10.0.3.0/24`
+ Internet Gateway (`lab-ecs-igw`)

### Création des Security Groups
+ `alb-sg` 
  + HTTP (80) → anywhere  
+ `ecs-sg`
  + HTTP (80) → alb-sg
  + API (3000) → alb-sg
  + HTTPS (443) → anywhere
+ `db-sg`
  + MySQL (3306) → `ecs-sg` uniquement

## 2 - Création de la base de données (RDS)

Dans cette étape, nous allons créer une base de données en utiliant le service *Amazon RDS*.

1. Accédez à *RDS* via la console AWS
2. Dans la barre de navigation gauche, cliquez sur *Bases de données* puis sur *Créer une base de données (configuration complète)*

**Configuration :**
  + **Moteur :** MySQL
  + **Modèle :** Environnement de test (sandbox)
  + **Nom :** `lab-ecs-db`
  + **Identifiant d'instance de base de données :** `ecommerce-db`
  + Configuration des informations d'identification :
    + **Identifiant principal :** admin
    + **Mot de passe :** *(à définir, et notez le pour plus tard)*
  + **Connectivité :**
    + **VPC :** `lab-ecs-vpc`
    + **Subnets :** privés
    + **Accès public :** **NON**
    + **Security Group :** `db-sg`
  + **Configuration supplémentaire :** 
    + Nom de la base de données initiale : `ecommerce_db`

{{%notice style="tip" title="Sécurité"%}}
La base de données n’est pas accessible depuis Internet. Seules les ressources internes (*ECS*) peuvent y accéder.
{{%/notice%}}

## 2 - Créer le cluster sur ECS

Dans cette étape, nous allons créer un cluster qui servira d’environnement d’exécution pour nos conteneurs.

1. Dans la console AWS, recherchez ECS (*Elastic Container Service*) dans la barre de recherche.
2. Dans le menu de gauche, cliquez sur *Clusters*, puis sur *Créer un cluster*.

**Configuration du cluster :**
  + **Nom :** `lab-ecs-cluster`
  + **Infrastructure :** sélectionnez *AWS Fargate* (*serverless*)

{{%notice style="tip" title="Pourquoi Fargate ?"%}}
*Fargate* permet d'exécuter des conteneurs sans avoir à gérer de machines virtuelles. AWS s’occupe automatiquement de la capacité, ce qui simplifie énormément le déploiement.
{{%/notice%}}

4. Cliquez sur *Create* pour créer le cluster.

## 3 - Création d'une Task Definition

Nous allons maintenant définir notre application (frontend + API) sous forme de *Task Definition*.
Dans le menu de gauche, cliquez sur *Définitions de tâches*, puis sur *Créer un définition de tâche*.

**Configuration générale :**
  + **Nom :** `ecommerce-task`
  + **Type de lancement :** AWS Fargate
  + Rôle d'exécution de tâche: `LabRole`
  + **Operating system :** Linux
  + Rôle de la tâche : `LabRole`
  + Rôle d'exécution de tâche: `LabRole`

### 3.1 Ajouter le conteneur API
1. Cliquez sur Add container :
  + **Nom :** `ecommerce-api`
  + **Image :** `cmvghazi/ecommerce-backend:1.3`
  + **Mappages de ports :** 3000 (port d'écoute du conteneur)
  + **Environment variables :**
    + `PORT`: `3000`
    + `DB_HOST` → endpoint RDS
    + `DB_PORT`: `3306`
    + `DB_NAME` → `ecommerce_db` 
    + `DB_USER` → admin
    + `DB_PASSWORD` → mot de passe de la BD
    + `JWT_SECRET` → (*string random*)
    + `JWT_EXPIRES_IN` → `7d`
  + **Collecte de journaux :** *Utiliser la collecte de journaux*

{{%notice style="warning" title="Important"%}}
Pour un environnement de production, il est fortement recommandé d’utiliser **AWS Secrets Manager** plutôt que des variables en clair.
{{%/notice%}}

### 3.2 Ajouter le conteneur Frontend
1. Cliquez sur *Ajouter un conteneur* :
  + **Nom :** `ecommerce-frontend`
  + **Image :** `cmvghazi/ecommerce-frontend:1.4`
  + **Port mapping :** 80
2. Cliquez sur *Create* pour finaliser la *Task Definition*.

## 4 - Création d’un Service ECS

Nous allons maintenant créer un Service pour exécuter et maintenir nos conteneurs.

1. Retournez dans *Clusters*
2. Cliquez sur `lab-ecs-cluster`
3. Cliquez sur *Create Service*

**Configuration du service :**
  + **Général :**
    + **Launch type :** *Fargate*
    + **Task Definition :** `ecommerce-task`
    + **Nom du service :** `ecommerce-service`
    + **Nombre de tâches souhaitées :** 2
{{%notice style="tip" title="Pourquoi 2 tâches ?"%}}
Cela permet d'assurer une haute disponibilité. Si une tâche tombe, l’autre continue de servir les utilisateurs.
{{%/notice%}}

  + **Réseau :**
    + **VPC :** celui créé à l’étape 1
    + **Subnets :** sélectionnez les subnets publics
    + **Security Group :** `ecs-sg`
    + **Auto-assign public IP :** activé
  + **Load Balancing** *(optionnel mais recommandé)* **:**
    + Type : *Application Load Balancer*
    + Créez un nouveau *Load Balancer*
    + Mappez :
      + Port 80 → `ecommerce-frontend`
5. Cliquez sur *Create Service* 

## 5 - Vérification du déploiement

Une fois le service créé :

1. Accédez à votre cluster `lab-ecs-cluster`
2. Cliquez sur l’onglet *Services*
3. Sélectionnez `ecommerce-service`

**Vérifications :**
+ Observez l'évolutaion de l'état des tâches, celles-ci doivent progressivement passer de "En attente" à "En cours d'exécution"
+ Une fois qu'au moins une des deux taches passe à l'état "En cours d’exécution", allez dans l'onglet "*Journaux*" pour vérifier les logs des services. 

Accès à l’application :
+ Allez dans la console EC2 et récupérez l'URL du Load Balancer. Vous serez en mesure d'accéder à l'application sur votre navigateur:

### 5.1 - Test de résilience (Self-healing)

Dans cette étape, nous allons vérifier le comportement du service en cas de panne.
1. Dans l’onglet Tâchers, sélectionnez une tâche en cours d’exécution
2. Cliquez sur Stop
3. Observez le comportement :
  + La tâche est arrêtée
  + Une nouvelle tâche est automatiquement créée

{{%notice style="info" title="Observation"%}}
C’est le Service ECS qui **garantit l’état désiré** (2 tâches en cours d’exécution).
{{%/notice%}}

## 7 - Test de scalabilité
Dans le service `ecommerce-service`, cliquez sur *Update*
1. Modifiez le nombre de tâches à 3
2. Appliquez les changements

**Résultat :** ECS lance automatiquement 2 nouvelles tâches -->


## Pour aller plus loin
+ Utilisez AWS Secrets Manager pour sécuriser vos credentials
+ Explorez le service ECR (Elastic Container Registry) pour stocker vos images Docker
+ Explorez les différents type de déploiements progressif qu'offre ECS ()
