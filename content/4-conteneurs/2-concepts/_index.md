+++
title = 'Concepts fondamentaux'
draft = false
weight = "420"
+++
--------------

## Image
Une image Docker est un package **léger**, **autonome** et **exécutable** qui conserve tout ce qui est nécessaire pour exécuter une application, y compris le code, les bibliothèques et les dépendances.

Une image Docker est :
+ Un modèle en lecture seule
+ Composé de couches (layers)
+ Créé à partir d’un Dockerfile : un fichier texte contenant un ensemble d'instructions pour créer l'image.
+ Stocké dans un registre (ex: Docker Hub)

Les images peuvent être utilisées pour déployer des applications de manière cohérente sur différentes plateformes.

## Conteneur

Un conteneur est **une instance en cours d’exécution d’une image**.

Chaque conteneur s'exécute comme un **processus distinct sur la machine hôte** et possède son propre système de fichiers, son réseau et d'autres ressources.

Les conteneurs Docker sont conçus pour être **portables** et **faciles à déployer**. Ils peuvent être exécutés sur n’importe quelle machine sur laquelle Docker est installé, quel que soit le système d’exploitation ou le matériel. 

Les conteneurs Docker peuvent être gérés à l'aide de Docker CLI ou d'outils d'orchestration tels que *Docker Compose* ou *Kubernetes*.

## Registres

+ Les images Docker peuvent être téléversées dans un système de stockage et de distribution d'images appelé **registre**.
+ Un registre est un service permettant de stocker, versionner, distribuer et sécuriser des images Docker.

### Docker Hub
Docker héberge l'un des plus grands registre d'images: [Docker Hub](https://hub.docker.com/). C'est un référentiel central (similaire à GitHub pour du code source) permettant aux développeurs et aux organisations de partager et de distribuer leurs images.
+ *Docker Hub* est un registre d'images publiques officielles (nginx, node, mysql, etc...)
+ Un registre permet le versionnage des images en utilisant des **tags**. 
+ Les utilisateurs peuvent rechercher et télécharger des images depuis *Docker Hub*, ainsi que publier leurs propres images dans le registre.
+ Un registre peut être **public** ou **privé** (pour donner la possibilité aux organisations de gérer leurs images et garantir qu'elles ne soient accessibles qu'aux utilisateurs autorisés).

### Autres registres populaires
Il existe plusieurs registres adaptés aux environnements cloud :

+ *Amazon Elastic Container Registry (ECR)*: Registre privé intégré à AWS
+ *Google Container Registry*: Intégré à Google Cloud
+ *GitHub Container Registry*: Intégré aux dépôts GitHub
+ *Azure Container Registry*: Intégré à Microsoft Azure
