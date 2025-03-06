+++
title = 'Dockerfile'
draft = false
weight = "404"
+++

Un Dockerfile est un fichier qui contient une série d'instructions et d'arguments. Ces instructions sont utilisées pour créer automatiquement une image Docker. Il s'agit essentiellement d'un script de commandes successives que Docker exécutera pour assembler une image, automatisant ainsi le processus de création d'image.

### Instructions d'un Dockerfile

#### FROM
L'instruction `FROM` définit l'image de base pour les instructions suivantes.
```dockerfile
FROM ubuntu:24.04
```
Cette instruction est généralement la première d'un fichier Docker.

#### LABEL
`LABEL` ajoute des métadonnées à une image sous forme de paires clé-valeur.
```dockerfile
LABEL version="1.0" maintainer="john@example.com"
description="Ceci est un exemple d'image Docker »
```
Les étiquettes sont utiles pour l'organisation des images, les annotations ou autres métadonnées.

#### ENV
`ENV` définit les variables d'environnement dans l'image.

```dockerfile
ENV APP_HOME=/app NODE_ENV=production
```

#### WORKDIR
`WORKDIR` définit le répertoire de travail pour les instructions `RUN`, `CMD`, `ENTRYPOINT`, `COPY` et `ADD` subséquentes.
```dockerfile
WORKDIR /app
```
Si le répertoire n'existe pas, il sera crée.

#### COPY et ADD
Les instructions `COPY` et `ADD` copient les fichiers de l'hôte dans l'image.
```dockerfile
COPY package.json .
ADD https://example.com/big.tar.xz /usr/src/things/
```
`COPY` est généralement préféré pour sa simplicité. `ADD` possède quelques fonctionnalités supplémentaires comme l'extraction de fichiers compressés `tar` la prise en charge des URL distantes, mais celles-ci peuvent rendre la compilation moins prévisible.

#### RUN
`RUN` exécute des commandes dans une nouvelle couche au dessus de l'image courante et commet les résultats.
```dockerfile
RUN apt-get update && apt-get install -y nodejs
```
Il est conseillé d'enchaîner les commandes avec && afin de réduire le nombre de couches.

#### CMD
`CMD` fournit la commande par défaut pour un conteneur en cours d'exécution. **Il ne peut y avoir qu'une seule instruction CMD** dans un `Dockerfile`.
```dockerfile
CMD ["node", "app.js"]
```
#### ENTRYPOINT
`ENTRYPOINT` configure un conteneur qui s'exécutera en tant qu'exécutable.
```dockerfile
ENTRYPOINT ["nginx", "-g", "daemon off ;"]
```
`ENTRYPOINT` est souvent utilisé en combinaison avec `CMD` : `ENTRYPOINT` définit l'exécutable et `CMD` fournit les arguments par défaut.

#### EXPOSE
`EXPOSE` informe Docker que le conteneur écoute sur les ports réseau spécifiés au moment de l'exécution.
```dockerfile
EXPOSE 80 443
```
Cela n'expose pas réellement le port. Cette commande fonctionne comme une documentation entre la personne qui construit l'image et la personne qui exécute le conteneur.

#### VOLUME
`VOLUME` crée un point de montage et le marque comme contenant des volumes montés en externe de l'hôte natif ou d'autres conteneurs.
```dockerfile
VOLUME /data
```
Ceci est utile pour toutes les parties mutables et/ou utilisables par l'utilisateur de votre image.
#### ARG
`ARG` définit une variable que les utilisateurs peuvent passer au moment de la construction au constructeur avec la commande `docker build`.

```dockerfile
ARG VERSION=latest
```
Cela permet de faire des *builds* plus flexibles.

### Dockerfile : bonnes pratiques

1. Réduire au minimum le nombre de couches : Combinez les commandes lorsque cela est possible afin de réduire le nombre de couches et la taille de l'image.
2. Exploiter le cache de construction : Classer les instructions par ordre décroissant de fréquence afin de maximiser l'utilisation de la mémoire cache.
3. Utiliser .dockerignore : Exclure les fichiers non pertinents pour la construction, similaire à .gitignore.
4. N'installez pas de paquets inutiles : Gardez l'image légère et sécurisée en n'installant que ce qui est nécessaire.
5. Utilisez des balises spécifiques : Évitez la balise latest pour les images de base afin d'assurer des constructions reproductibles.
6. Définissez le répertoire WORKDIR : utilisez toujours WORKDIR au lieu de proliférer des instructions telles que RUN cd ... && do-something.
7. Utilisez COPY au lieu de ADD : À moins que vous n'ayez explicitement besoin de la fonctionnalité supplémentaire de ADD, utilisez COPY pour la transparence.
8. Utiliser les variables d'environnement : En particulier pour les numéros de version et les chemins d'accès, ce qui rend le fichier Docker plus flexible.