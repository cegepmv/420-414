+++
title = 'Terraform'
draft = false
weight = "510"
+++
------------
Dans ce chapitre, nous allons découvrir **Terraform**, un outil d’**infrastructure en tant que code (IaC)** développé par HashiCorp.

Terraform permet de **définir, provisionner et gérer une infrastructure** (cloud ou locale) à l’aide de **fichiers de configuration**, au même titre que du code logiciel. Ces fichiers peuvent être **versionnés** (Git), **partagés** et/ou **réutilisés**.

On peut ainsi gérer l’infrastructure de façon **automatisée, reproductible et collaborative**.

## Principe général

Terraform adopte une approche **déclarative** : on décrit **l’état souhaité** de l'infrastructure, puis Terraform se charge ensuite de :
- comparer cet état avec l’infrastructure existante
- déterminer les changements nécessaires
- appliquer ces changements automatiquement

## Fonctionnement

Terraform interagit avec les différents services **via leurs APIs**.

Pour cela, il utilise des **fournisseurs (*providers*)**, qui sont des plugins permettant de communiquer avec une plateforme ou un service.

Il existe des fournisseurs pour :
- Amazon Web Services (AWS)
- Microsoft Azure
- Google Cloud Platform (GCP)
- Kubernetes
- GitHub
- etc.

Il est même possible de créer ses propres fournisseurs.

## Concepts clés

### Ressources (*Resources*)

Les ressources sont les **éléments d’infrastructure** qu'on souhaite créer ou gérer.

**Exemples :** machine virtuelle, réseau, base de données, etc...

### Fournisseurs (*Providers*)

Un fournisseur est responsable de la **communication avec une API externe**.

Exemple :
- le provider AWS permet de créer des ressources AWS
- le provider Azure permet de gérer des ressources Azure


### Fichier d’état (*State*)

Terraform maintient un **fichier d’état (*terraform.tfstate*)** qui représente l’infrastructure réelle.

Ce fichier permet de suivre les ressources existantes et sert de référence pour calculer les changements à effectuer

{{%notice style="warning" title="Gestion du fichier de state"%}}
Il est important de bien gérer ce fichier (souvent stocké à distance en équipe).
{{%/notice%}}

### Idempotence

Terraform est **idempotent**, ce qui signifie que si on applique plusieurs fois la même configuration, on est assuré de toujours produire le même résultat.

## Workflow Terraform

Le flux de travail (*workflow*) de Terraform se déroule en plusieurs étapes :

![Workflow Terraform](../images/5-05-terraform-workflow.avif)

### 1. *Write* (Écriture)

Vous écrivez vos fichiers de configuration (en langage HCL).

Exemple :
- définir un serveur
- créer un réseau
- configurer des règles de sécurité

### 2. *Init* (Initialisation)

Commande :  
```bash
terraform init
```
Permet de télécharger les providers nécessaires et initialiser le projet Terraform

### 3. Plan (Planification)

Commande :
```bash
terraform plan
```
Terraform génère un plan d’exécution qui décrit : les ressources à créer, les modifications à effectuer et/ou les ressources à supprimer.

À ce stade, **aucune modification n’est encore appliquée**.

### 4. Apply (Application)
**Commande :**
```bash
terraform apply
```

Terraform :
+ exécute les actions prévues
+ respecte les dépendances entre ressources
+ crée/modifie/supprime l’infrastructure

## Avantages de Terraform
+ **Automatisation :** Permet de déployer une infrastructure complète en quelques commandes.
+ **Reproductibilité :** Les environnements peuvent être recréés à l’identique.
+ **Gestion des changements :** visualisation avec terraform plan, possibilité de rollback via le code, 
+ **Multi-cloud :** Terraform fonctionne avec plusieurs fournisseurs, ce qui permet d’éviter le verrouillage (*vendor lock-in*) et de standardiser les pratiques

<!-- +++
title = 'Terraform'
draft = false
weight = "510"
+++

Dans ce chapitre, nous allons explorer Terraform, un outil d'infrastructure en tant que code qui vous permet de définir des ressources *Cloud* et sur site (*on-site* ou *on-premises*) dans des fichiers de configuration qu'il est possible versionner, réutiliser et partager (comme du code). 

Il est ensuite possible utiliser ce code pour approvisionner (*provisioning*) et gérer l'ensemble d'une infrastructure tout au long de son cycle de vie.

### Fonctionnement
Terraform crée et gère des ressources sur des plateformes *Cloud* et d'autres services **par le biais de leurs APIs**.

HashiCorp et la communauté Terraform ont déjà écrit des milliers de fournisseurs pour gérer de nombreux types de ressources et de services différents, y compris Amazon Web Services (AWS), Azure, Google Cloud Platform (GCP), Kubernetes, Helm, GitHub, Splunk, DataDog, et bien d'autres.

### Workflow Terraform

Le flux de travail (*workflow*) de base de Terraform se compose de trois principales étapes :

![Workflow Terraform](../images/5-05-terraform-workflow.avif)

1. ***Write* (Écriture) :** Vous définissez les ressources, qui peuvent être réparties entre plusieurs fournisseurs et services cloud. Par exemple, vous pouvez créer une configuration pour déployer une application sur des machines virtuelles dans un réseau VPC (Virtual Private Cloud) avec des groupes de sécurité et un équilibreur de charge.
2. ***Plan* (Planification) :** Terraform crée un plan d'exécution décrivant l'infrastructure qu'il va créer, mettre à jour ou détruire en fonction de l'infrastructure existante et de votre configuration.
3. ***Apply* (Application) :** Après approbation, Terraform exécute les opérations proposées dans le bon ordre, en respectant les dépendances des ressources. Par exemple, si vous mettez à jour les propriétés d'un VPC et modifiez le nombre de machines virtuelles dans ce VPC, Terraform recréera le VPC avant de mettre à l'échelle les machines virtuelles.


<!-- ### Avantages
+ Meilleure gestion de l'infrastructure : Vous trouverez des fournisseurs pour de nombreuses plateformes et services que vous utilisez déjà dans le registre Terraform. Vous pouvez également écrire les vôtres. Terraform adopte une approche immuable (et idempotente) de l'infrastructure, réduisant ainsi la complexité de la mise à niveau ou de la modification de vos services et de votre infrastructure.
+ Meilleur suivi de l'évolution de l'infrastructure : Terraform génère un plan et demande une approbation avant de modifier une infrastructure. Il assure également le suivi de votre infrastructure réelle dans un fichier d'état (state), qui sert de source de vérité pour votre environnement. Terraform utilise le fichier d'état pour déterminer les modifications à apporter à votre infrastructure afin qu'elle corresponde à votre configuration.
+ Automatisation des changements : Les fichiers de configuration Terraform sont déclaratifs, ce qui signifie qu'ils décrivent l'état final de votre infrastructure. Vous n'avez pas besoin d'écrire des instructions étape par étape pour créer des ressources, car Terraform gère la logique sous-jacente. Terraform construit un graphe de ressources pour déterminer les dépendances des ressources et crée ou modifie les ressources non dépendantes en parallèle. Cela permet à Terraform de provisionner les ressources de manière efficace.
+ Standardisation des configurations : Terraform prend en charge des composants de configuration réutilisables, appelés modules, qui définissent des ensembles configurables d'infrastructure, ce qui permet de gagner du temps et d'encourager les meilleures pratiques. Vous pouvez utiliser les modules disponibles publiquement dans le registre Terraform ou écrire les vôtres. --> -->