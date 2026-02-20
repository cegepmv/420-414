+++
title = 'Dockerfile'
draft = false
weight = "460"
+++

Un Dockerfile est un fichier texte contenant une suite d’instructions permettant de construire une image Docker.

Il décrit :

+ L’image de base
+ Les dépendances nécessaires
+ Les fichiers à copier
+ Les variables d’environnement
+ La commande de démarrage

On peut le voir comme :
> Une recette reproductible pour générer une **image immuable**.

Lorsqu’on exécute :
```bash
docker build -t monapp:1.0 .
```

Docker lit le Dockerfile et exécute chaque instruction dans l’ordre en créant des **couches (layers)**.

## Instructions d'un Dockerfile

### FROM
Définit l'image de base.
```dockerfile
FROM ubuntu:24.04
```
+ Généralement première instruction
+ Peut être utilisée plusieurs fois (multi-stage)

### LABEL
Ajoute des métadonnées.
```dockerfile
LABEL version="1.0" \
      maintainer="john@example.com" \
      description="Exemple d'image Docker"

```
Utile pour :
+ Organisation
+ CI/CD
+ Documentation

### ENV
`ENV` définit les variables d'environnement permanentes dans l'image.

```dockerfile
ENV APP_HOME=/app 
ENV NODE_ENV=production
```

### ARG

Définit une variable disponible **uniquement au moment du build**.

```dockerfile
ARG VERSION=latest
```

Utilisation :
```bash
docker build --build-arg VERSION=1.2 .
```

### WORKDIR
Définit le répertoire de travail.
```dockerfile
WORKDIR /app
```
+ Crée le dossier s’il n’existe pas
+ Évite d’utiliser `RUN cd ...`

### COPY
Copie des fichiers depuis l’hôte vers l’image.
```dockerfile
COPY package.json .
COPY src ./src
```
Simple et prévisible.
### ADD
Similaire à COPY mais avec fonctionnalités supplémentaires :
+ Extraction automatique de .tar
+ Support d’URL distante

```dockerfile
ADD https://example.com/big.tar.xz /usr/src/things/
```
{{%notice style="tip" title="Bonne pratique"%}}
Préférer **COPY** sauf besoin explicite.
{{%/notice%}}

### RUN
Exécute une commande lors du build.
```dockerfile
RUN apt-get update && apt-get install -y nodejs
```



{{%notice style="tip" title="Bonne pratique"%}}
Chaque **RUN** crée une nouvelle couche. Il est conseillé d'enchaîner les commandes avec `&&` afin de réduire le nombre de couches.

```dockerfile
RUN apt-get update && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# MOINS BON :
RUN apt-get update
RUN apt-get install -y nodejs
RUN rm -rf /var/lib/apt/lists/*

```
{{%/notice%}}



### CMD
Commande par défaut au démarrage du conteneur.
```dockerfile
CMD ["node", "app.js"]
```

+ Une seule instruction `CMD`
+ Peut être remplacée au docker run

### ENTRYPOINT
Définit l’exécutable principal.
```dockerfile
ENTRYPOINT ["nginx", "-g", "daemon off ;"]
```
Différence : 
+ `ENTRYPOINT` = exécutable fixe
+ `CMD` = agruments par défaut

Exemple combiné : 
```dockerfile
ENTRYPOINT ["node"]
CMD ["app.js"]
```


### EXPOSE
Documente les ports utilisés.
```dockerfile
EXPOSE 3000
```
{{%notice style="warning" title="Attention"%}}
**EXPOSE** n'ouvre pas réellement le port (c'est une documentation entre la personne qui construit l'image et la personne qui exécute le conteneur). L'exposition réelle se fait avec:
```bash
docker run -p 8080:3000
```
{{%/notice%}}


### VOLUME
Déclare un point de montage.
```dockerfile
VOLUME /data
```
Utile pour :
+ Données persistantes
+ Bases de données
+ Fichiers utilisateur

### Dockerfile – Bonnes pratiques

1. Minimiser les couches : Combinez les commandes lorsque c'est possible pour réduire le nombre de couches et la taille de l'image.
2. Exploiter le cache : Classer les instructions par ordre décroissant de fréquence afin de maximiser l'utilisation de la mémoire cache.
3. Utiliser `.dockerignore` : Exclure les fichiers non pertinents pour le build (similaire à `.gitignore`).
4. Installer uniquement le nécessaire pour garder l'image légère et sécurisée.
7. Utilisez **COPY** au lieu de **ADD**.

## Mutli-Stage Builds

### Utilité
**Problème :**
+ Image trop volumineuse
+ Contient outils de compilation inutiles en production
+ Surface d’attaque plus grande

**Solution :**
+ Utiliser plusieurs étapes de build dans un même Dockerfile.

**Exemple – Application Node compilée :**
```dockerfile
# ---- Étape 1 : Build ----
FROM node:20 AS builder

WORKDIR /app
COPY package*.json .
RUN npm install

COPY . .
RUN npm run build

# ---- Étape 2 : Production ----
FROM node:20-alpine

WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

RUN npm install --omit=dev

EXPOSE 3000
CMD ["node", "dist/main.js"]
```

**Résultat :**
+ Image plus petite
+ Pas d’outils de build
+ Plus sécuritaire
+ Plus rapide à déployer