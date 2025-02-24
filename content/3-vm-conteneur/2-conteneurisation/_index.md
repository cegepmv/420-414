+++
title = 'Conteneurisation'
draft = false
weight = "302"
+++

Comme la virtualisation, la conteneurisation permet aussi d'exécuter de nombreuses instances sur un seul hôte physique, mais sans que l'hyperviseur ne joue le rôle d'intermédiaire. 

Au lieu de cela, la fonctionnalité du noyau du système hôte est utilisée pour isoler plusieurs instances indépendantes appelées **conteneurs**. 

En partageant le noyau et le système d'exploitation de l'hôte, les conteneurs évitent le gaspillage de ressources matérielles de la virtualisation (il n'est pas nécessaire de fournir un noyau et un système d'exploitation virtuels différents pour chaque instance). C'est pourquoi les conteneurs sont considérés comme une **solution plus légère** - ils nécessitent moins de ressources sans compromettre les performances.

#### Types de conteneurs

Il existe deux principaux types de conteneurs : 

![Conteneuurs](/420-414/images/3-vm-conteneur/3-03-conteneurisation.png)


+ **Conteneurs d'application** *(Docker)* : Empaquettent et exécutent un "processus" (ou service) unique par conteneur. Ils sont emballés (ou *conteneurisé*) avec toutes les bibliothèques, dépendances et fichiers de configuration dont ils ont besoin pour fonctionner, ce qui facilite leur portabilité dans différents environnements. 
+ **Conteneurs système** *(LXC)* : Similaires à une machine virtuelle. Ils exécutent un système d'exploitation complet et ont le même comportement et la même facilité de gestion que les machines virtuelles tout en étant plus légers, avec en plus les avantages de densité et d'efficacité qu'offrent les conteneurs.

##### Avantages
+ **Densité :** Il est possible de faire fonctionner plusieurs conteneurs tout en bénéficiant des performances d'un système *"bare-metal"*. 
+ **Efficacité :** Permettent de déployer des applications beaucoup plus rapidement que des VMs.
+ **Portabilité :** Toutes les dépendances sont déjà intégrées dans le conteneur.

##### Inconvénients
+ L'exécution de plusieurs conteneurs peut augmenter la **complexité** de l'environnement. 
+ Augmente la **difficulté de surveillance et d'observabilité** (dans un environnement avec des milliers de conteneurs).
+ Toute vulnérabilité du noyau de l'hôte compromet tout ce qui s'exécute dans les conteneurs.