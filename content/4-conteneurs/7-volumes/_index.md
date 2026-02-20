+++
title = 'Volumes'
draft = false
weight = "470"
+++

Pourquoi les volumes sont-ils nécessaires ?

Par défaut, les données d’un conteneur sont éphémères :

+ Si le conteneur est supprimé → les données sont perdues
+ Si l’image est reconstruite → les données sont perdues
+ Si le conteneur est recréé → l’état est perdu

Or, dans une application réelle :

+ Une base de données doit conserver ses données
+ Des fichiers uploadés doivent survivre
+ Des logs doivent être persistés

Les volumes Docker permettent de **conserver les données en dehors du cycle de vie du conteneur**.

## Fonctionnement

Docker stocke les volumes dans un répertoire géré par le moteur Docker :

```bash
/var/lib/docker/volumes/
```

Le volume est :
+ Indépendant du conteneur
+ Réutilisable
+ Persistant même si le conteneur est supprimé

## Types de stockage avec Docker

Il existe principalement deux façons de gérer les données :

### Volume nommé (recommandé)

C’est la méthode la plus propre et la plus utilisée.

**Créer un volume :**
```bash
docker volume create mon-volume
```
Lister les volumes :
```bash
docker volume ls
```
Inspecter un volume :
```bash
docker volume inspect mon-volume
```
Supprimer un volume :
```bash
docker volume rm mon-volume
```
Utiliser un volume dans un conteneur
```bash
docker run -d \
  --name ma-db \
  -v mon-volume:/var/lib/mysql \
  mysql
```
Ici :
+ mon-volume → volume Docker
+ /var/lib/mysql → répertoire dans le conteneur

### Bind mount (montage direct)

Permet de monter un dossier de la machine hôte directement dans le conteneur.
```bash
docker run -d \
  -v $(pwd)/data:/app/data \
  nginx
```
**Différences :**

|Volume nommé|Bind mount|
|------------|----------|
|Géré par Docker|Géré par l’utilisateur|
|Portable|Dépend du chemin local|
|Recommandé en production|Souvent utilisé en développement|


## Bonnes pratiques

+ Ne jamais stocker des données importantes uniquement dans le conteneur
+ Utiliser des volumes nommés pour les bases de données
+ Utiliser des *bind mounts* pour le développement
+ Nettoyer les volumes inutilisés :
```bash
docker volume prune
```

## Exemple classique

Architecture simple :
+ Backend
+ Base de données
+ Volume pour la DB

```bash
docker network create app-network

docker volume create db-data

docker run -d \
  --name db \
  --network app-network \
  -v db-data:/var/lib/mysql \
  mysql

docker run -d \
  --name api \
  --network app-network \
  -p 3000:3000 \
  mon-api
```

Si le conteneur `db` est supprimé et recréé, les données restent dans `db-data`.