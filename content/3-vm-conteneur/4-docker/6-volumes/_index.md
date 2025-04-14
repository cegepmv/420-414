+++
title = 'Volumes'
draft = false
weight = "346"
+++

Les volumes Docker sont le mécanisme privilégié pour conserver les données générées et utilisées par les conteneurs Docker. Bien que les conteneurs puissent créer, mettre à jour et supprimer des fichiers, ces modifications sont perdues lorsque le conteneur est supprimé et toutes les modifications sont isolées de ce conteneur. Les volumes permettent de connecter des chemins spécifiques du système de fichiers du conteneur à la machine hôte. Si un répertoire du conteneur est monté, les modifications apportées à ce répertoire sont également visibles sur la machine hôte. Si nous montons ce même répertoire à chaque redémarrage du conteneur, nous verrons les mêmes fichiers.

### Utilité des volumes Docker
1. Persistance des données : Les volumes vous permettent de conserver les données même lorsque les conteneurs sont arrêtés ou supprimés.
2. Partage des données : Les volumes peuvent être partagés et réutilisés entre plusieurs conteneurs.
3. Performance : Les volumes sont stockés sur le système de fichiers de l'hôte, ce qui offre généralement de meilleures performances d'E/S, en particulier pour les bases de données.
4. Gestion des données : Les volumes facilitent la sauvegarde, la restauration et la migration des données.
5. Découplage : Les volumes découplent la configuration de l'hôte Docker de l'exécution du conteneur.

### Types de volumes Docker
#### Volumes nommés
Les volumes nommés (*named volumes*) sont le moyen recommandé pour conserver les données dans Docker. Ils sont créés explicitement et reçoivent un nom.

+ Création d'un volume nommé :
```bash
docker volume create my_volume
```
+ Utiliser un volume nommé :
```bash
docker run -d --name devtest -v mon_volume:/app nginx:latest
```
#### Volumes anonymes
Les volumes anonymes sont automatiquement créés par Docker et reçoivent un nom aléatoire. Ils sont utiles pour les données temporaires que vous n'avez pas besoin de conserver au-delà de la durée de vie du conteneur.

+ Utilisation d'un volume anonyme :
```bash
docker run -d --name devtest -v /app nginx:latest
```
#### *Bind mounts*
Les *Bind mounts* font correspondre un chemin spécifique de la machine hôte à un chemin dans le conteneur. Ils sont utiles pour les environnements de développement.

+ Utilisation d'un *bind mount* :
```bash
docker run -d --name devtest -v /path/on/host:/app nginx:latest
```

### Travailler avec les volumes Docker
#### Lister les volumes
Pour lister tous les volumes :
```bash
docker volume ls
```
#### Inspecter les volumes
Pour obtenir des informations détaillées sur un volume :
```bash
docker volume inspect my_volume
```
#### Supprimer des volumes
Pour supprimer un volume spécifique :
```bash
docker volume rm mon_volume
```
Pour supprimer tous les volumes inutilisés :
```bash
docker volume prune
```