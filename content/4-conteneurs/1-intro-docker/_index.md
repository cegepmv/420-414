+++
title = 'Introduction à Docker'
draft = false
weight = "410"
+++
------------
## Utilité

Imaginons que nous devions mettre en place un "*stack*" (plusieurs services pour faire rouler une application) incluant:
+ Un frontend *React*
+ Une API/backend *Node.js* (*Express*)
+ Une base de données *MongoDB*
+ Un système de cache ou messagerie comme *Redis*

![Conteneurs](/420-414/images/3-vm-conteneur/matrix-from-hell.png)

Plusieurs enjeux se posent :

+ **Compatibilité avec le système d’exploitation :** Il faut s'assurer que toutes les composantes soient compatibles avec la version du système d'exploitation qu'on prévoit utiliser.

+ **Compatibilité des versions de librairies et conflits entre dépendances :** Il faut vérifier que les librairies et les dépendances de chaque service soient compatibles (un service pourrait avoir besoin d'une certaine version d'une librairie pour fonctionner alors qu'un autre ne peut fonctionner que sur une version différente de la même librairie).

+ **Difficulté à reproduire l’environnement sur une autre machine :** Chaque fois qu'un nouveau développeur rentre dans une équipe, il est difficile de configurer un nouvel environnement pour lui qui satisfait toutes les dépendances nécessaires à faire rouler l'application (avoir le bon OS, les bonnes versions de chacun des composants). Il est donc impossible de garantir que l'application fonctionnerait de la même manière sur des environnements différents (PC du développeur vs. production).

+ Imaginons que nous voulions modifier le *stack* de l'application (par exemple mettre à jour un service ou changer la base de données vers *MySQL*). Chaque fois qu'une composante change, il faut passer par le même processus de vérification de la compatibilité entre les composants (OS et librairies).


{{%notice style="info" title="Note"%}}
Ce problème de matrice de compatibilité est appelé "la matrice de l'enfer" (*Matrix From Hell*).
{{%/notice%}}

Il fallait donc trouver une solution pour répondre à ces enjeux, c'est là que l'utilisation de **Docker** prend tout son sens.

Avec Docker, il est possible d'exécuter chaque composante/service dans un **conteneur séparé avec ses propres dépendances et ses propres bibliothèques**, le tout sur la même VM et le même OS:

![Conteneurs](/420-414/images/3-vm-conteneur/docker-libs-deps.png)

### Problème organisationnel : Développeur vs SysAdmin

**Avant Docker :**
+ Le développeur installe les dépendances localement.
+ Le SysAdmin doit reproduire la configuration en production.
+ Les environnements diffèrent.
+ Les erreurs apparaissent uniquement au déploiement.

**Problème classique :**
> Développeur : “Ça fonctionne sur ma machine.”
> 
> SysAdmin : 😫😫😫

Les responsabilités étaient séparées :
|Développeur|Administrateur système|
|----------|----------------------|
|Écrit le code|Gère les serveurs|
|Configure son environnement local|Configure l'environnement de production|
|Peu de visibilité sur l'infrastructure|Peu de visibilité sur le code|

Cela créait :
+ Des silos
+ Des tensions
+ Des délais de déploiement
+ Des erreurs imprévisibles

**Avec Docker, la dynamique change :**
+ Le développeur définit l’environnement dans un **Dockerfile**
+ Le SysAdmin exécute **exactement la même image**
+ L’environnement devient du **code versionné**
+ Les déploiements deviennent reproductibles



### Lien avec DevOps
Docker a contribué fortement à l’émergence et à l’adoption de la culture **DevOps**.

*DevOps* repose notamment (mais pas seulement) sur la **collaboration entre *Dev* et *Ops***, l'***automatisation*** (*automation*), le **CI/CD** et les **déploiements fréquents et fiables**.

Docker facilite cela car :
+ L’environnement est défini comme du code
+ Il est versionné
+ Il est portable

Ainsi :
+ Le développeur devient aussi responsable de l’environnement.
+ L’Ops n’a plus à “deviner” la configuration.
+ Les environnements deviennent identiques (Dev → Test → Prod).

{{%notice style="info" title="Note"%}}
Docker n’a pas inventé *DevOps*, mais il en a été un **accélérateur majeur**.
{{%/notice%}}


## Avantages

+ **Portabilité :** Les conteneurs Docker peuvent être exécutés sur n'importe quelle machine prenant en charge Docker, ce qui facilite le déploiement d'applications dans différents environnements.

+ **Cohérence :** En regroupant une application et ses dépendances dans un conteneur, Docker garantit que l'application s'exécutera de manière cohérente, quelle que soit l'infrastructure sous-jacente.

+ **Évolutivité :** Docker facilite la mise à l'échelle des applications horizontalement en exécutant plusieurs instances du même conteneur.

+ **Efficacité des ressources :** Les conteneurs Docker sont légers et nécessitent un minimum de ressources, ce qui les rend idéaux pour une exécution sur une infrastructure cloud.

+ **Securité :** Docker fournit un environnement sécurisé et isolé pour l'exécution des applications, réduisant ainsi le risque de conflits avec d'autres applications ou avec le système hôte.
