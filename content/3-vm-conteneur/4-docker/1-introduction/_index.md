+++
title = 'Introduction'
draft = false
weight = "401"
+++

### Vue d'ensemble et utilité

Pour comprendre l'utilité de Docker, commençons par un exemple :

Imaginons que nous devions mettre en place un "*stack*" (plusieurs services pour faire rouler une application) incluant plusieurs technologies différentes comme un serveur Web utilisant *Node.js* (*Express*) une base de données (*MongoDB*) et un système de messagerie comme *Redis*.

![Conteneurs](/420-414/images/3-vm-conteneur/matrix-from-hell.png)

Plusieurs enjeux se posent :

+ Nous devons nous assurer que tous ces services soient **compatibles** avec la version du système d'exploitation qu'on prévoit utiliser. Dans certains cas, des versions de ces services peuvent ne pas être compatibles avec un OS mais sont compatibles avec un autre. 

+ Il faut aussi vérifier que les bibliothèques et les dépendances de ces services soient compatibles entre elles. En effet, un service pourrait avoir besoin d'une certaine version d'une bibliothèque pour fonctionner alors qu'un autre service ne peut fonctionner que sur une version différente de la même bibliothèque.

+ Imaginons maintenant que nous voulons changer l'infrastructure de l'application, comme par exemple mettre à jour un service ou changer la base de données vers *MySQL*. Chaque fois que quelque chose change dans notre *stack*, il faut passer par le même processus de vérification de la compatibilité entre les composants de notre application et l'infrastructure sous-jacente (OS).

+ Ce problème de matrice de compatibilité est appelé "la matrice de l'enfer" (*Matrix From Hell*).

+ Chaque fois qu'un nouveau développeur rentre dans une équipe, il est difficile de configurer un nouvel environnement pour lui qui satisfait toutes les dépendances nécessaires à faire rouler l'application : Il doit s'assurer d'avoir le bon OS, les bonnes versions de chacun des composants. Chaque développeur devait tout configurer lui-même à chaque fois. Il était donc impossible de garantir que l'application fonctionnerait de la même manière dans des environnements différents, ce qui rend notre vie dans le développement, le build et le shipping de l'application très difficile. 

Il faut donc trouver quelque chose qui pourrait aider avec ce problème de compatibilité, qui permettrait de modifier ou changer une composant sans affecter les autres et même modifier le système d'exploitation si nécessaire. C'est dans cette situation que Docker prend tout son sens.

![Conteneurs](/420-414/images/3-vm-conteneur/docker-libs-deps.png)


Avec Docker, il est possible d'exécuter chaque composant dans un conteneur séparé avec ses propres dépendances et ses propres bibliothèques, le tout sur la même VM et le même OS ! Une fois que Docker est installé, tous les développeurs peuvent lancer l'application avec une simple commande `docker run`, peu importe quel OS ils utilisent.


#### Fonctionnement

Docker crée un environnement virtualisé pour une application appelée **conteneur**. Un conteneur est un package **léger** qui intègre tout ce dont vous avez besoin pour exécuter un service, y compris le code, les bibliothèques et les dépendances. 

Les conteneurs sont **isolés du système hôte**. Par conséquent, ils peuvent s’exécuter sur n’importe quelle machine prenant en charge Docker, quel que soit le système d’exploitation ou le matériel sous-jacent.

Les conteneurs sont créés à partir d'**images** qui sont des **modèles (ou templates)** en lecture seule qui définissent l'application et ses dépendances. Ces images sont stockées dans un registre, tel que *Docker Hub* ou un registre privé. Les développeurs peuvent créer eux-mêmes des images personnalisées ou utiliser des images prédéfinies à partir du registre.

Lorsqu'un conteneur est lancé, il est construit à partir d'une image et doté de son propre système de fichiers, réseau et espace de processus isolés. Le conteneur peut alors exécuter l'application comme si elle s'exécutait sur un serveur dédié.

#### Workflow Docker

1. *Build* : Créer un Dockerfile qui définit votre application et ses dépendances.
2. *Ship* : *Push* votre image Docker vers un registre comme Docker Hub.
3. *Run* : Télécharger l'image et l'exécuter sur n'importe quel hôte compatible avec Docker.

**Exemple  :**
```bash
# Build une image
docker build -t myapp:v1 .
# Pull l'image vers Docker Hub
username/myapp:v1
# Exécuter le conteneur
docker run -d -p 8080:80 username/myapp:v1
```


### Images

Une image Docker est un package **léger**, **autonome** et **exécutable** qui conserve tout ce qui est nécessaire pour exécuter une application, y compris le code, les bibliothèques et les dépendances. Les images Docker sont utilisées pour créer et exécuter des conteneurs, qui sont des environnements isolés pouvant être utilisés pour exécuter des applications.

Les images Docker sont **créées à partir d'un Dockerfile**, qui est un fichier texte contenant un ensemble d'instructions pour créer l'image. Le Dockerfile spécifie l'image de base, le code de l'application et ses dépendances, les variables d'environnement et d'autres options de configuration nécessaires à la création de l'image.

Les images Docker sont stockées dans un **registre** public, tel que *Docker Hub*, ou privé. Chaque fois qu'un conteneur est créé à partir d'une image, il s'exécute en tant que processus distinct sur la machine hôte, isolé des autres processus et conteneurs.

Les images Docker peuvent être utilisées pour déployer des applications de manière cohérente sur différentes plates-formes. Ils facilitent l'**empaquetage** (*build*), la **distribution** (*shipping*) et le déploiement (*deploiment*) d'applications et garantissent qu'elles fonctionnent de la même manière partout.

### Conteneurs

Un conteneur est **une instance en cours d'exécution d'une image**.

Chaque conteneur s'exécute comme un processus distinct sur la machine hôte et possède son propre système de fichiers, son réseau et d'autres ressources.

Les conteneurs Docker sont conçus pour être **portables** et **faciles à déployer**. Ils peuvent être exécutés sur n’importe quelle machine sur laquelle Docker est installé, quel que soit le système d’exploitation ou le matériel sous-jacent. Les conteneurs fournissent un environnement cohérent pour l'exécution des applications, ce qui facilite le déplacement d'applications entre différents environnements, tels que le développement, les tests et la production.

Les conteneurs Docker peuvent être gérés à l'aide de Docker CLI ou d'outils Docker tels que Docker Compose ou Kubernetes. Ils peuvent être démarrés, arrêtés, mis en pause et redémarrés selon les besoins. Ils peuvent également être surveillés et gérés à l’aide d’une gamme d’outils et de plateformes.

Dans l'ensemble, les conteneurs Docker offrent un moyen flexible et évolutif de regrouper et de déployer des applications, ce qui simplifie la gestion et la mise à l'échelle d'applications complexes sur différents environnements et plates-formes.

### Registres d'images Docker

Docker héberge l'un des plus grands registre d'images Docker, appelé *Docker Hub*. 

Il s'agit d'un système de stockage et de distribution d'images Docker. Il fournit un référentiel central permettant aux développeurs et aux organisations de partager et de distribuer leurs images Docker, ce qui rend plus agréable la création, le partage et le déploiement d'applications avec Docker.

Docker Hub permet aux utilisateurs et aux organisations de stocker et de gérer leurs images Docker et fournit également des fonctionnalités telles que la gestion des versions, le balisage et la collaboration. Les utilisateurs peuvent rechercher et télécharger des images depuis Docker Hub, ainsi que publier leurs propres images dans le registre.

En plus du registre public, Docker Hub fournit un registre privé pour les organisations qui souhaitent gérer leurs propres images Docker et garantir qu'elles ne sont accessibles qu'aux utilisateurs autorisés.

### Avantages

+ **Portabilité :** Les conteneurs Docker peuvent être exécutés sur n'importe quelle machine prenant en charge Docker, ce qui facilite le déploiement d'applications dans différents environnements.

+ **Cohérence :** En regroupant une application et ses dépendances dans un conteneur, Docker garantit que l'application s'exécutera de manière cohérente, quelle que soit l'infrastructure sous-jacente.

+ **Évolutivité :** Docker facilite la mise à l'échelle des applications horizontalement en exécutant plusieurs instances du même conteneur.

+ **Efficacité des ressources :** Les conteneurs Docker sont légers et nécessitent un minimum de ressources, ce qui les rend idéaux pour une exécution sur une infrastructure cloud.

+ **Securité :** Docker fournit un environnement sécurisé et isolé pour l'exécution des applications, réduisant ainsi le risque de conflits avec d'autres applications ou avec le système hôte.