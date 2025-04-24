+++
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
+ Standardisation des configurations : Terraform prend en charge des composants de configuration réutilisables, appelés modules, qui définissent des ensembles configurables d'infrastructure, ce qui permet de gagner du temps et d'encourager les meilleures pratiques. Vous pouvez utiliser les modules disponibles publiquement dans le registre Terraform ou écrire les vôtres. -->