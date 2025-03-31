+++
title = 'Atelier'
draft = false
weight = "500"
+++

Dans ce chapitre, nous allons étudier quelques stratégies pour "dockeriser" une application fullstack, publier les images sur le registre DockerHub, puis déployer notre application sur le cloud AWS.

### *Stack* de l'application

+ Frontend : React
+ Backend : Springboot
+ Base de données : H2

### Pré-requis

Le dépôt GitHub utilisé pour cet atelier est le suivant : https://github.com/gbenachour/fullstack-demo. 

Il est fortement recommandé, dans le cas où vous développemez une autre application fullstack, de refaire les mêmes démarches pour vos propres projets. 

1. Commencez par faire un fork (une copie du dépôt) puis clonez votre repo sur un environnement de travail avec Docker installé.

2. Créez un compte sur Docker Hub, et créez deux *repositories* publique (va faciliter le déploiement par la suite) : `atelier-frontend` et `atelier-backend`.


### Atelier 1 - Conteneuriser un frontend React

Nous allons créer un Dockerfile dans le répertoire frontend (multi-stage)

#### Méthode 1 - Conteneuriser pour la production (recommandé)

##### Étape 1 - Création du fichier Dockerfile et de .dockerignore 

1. Dans le dossier `frontend`, créer un fichier nommé `Dockerfile` avec les informations suivantes : 

```dockerfile
# STAGE 1 : BUILD
FROM node:20-alpine AS build
WORKDIR /usr/src
COPY package*.json ./
RUN ["npm", "install"]
COPY . .
RUN ["npm", "run", "build"]

# STAGE 2 : WEB SERVER
FROM nginx:1.25.1-alpine AS prod
COPY --from=build /usr/src/dist /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx/nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

Précisions sur ce fichier :
+ Ligne 1-6 : Étape de compilation (build)
    + Ligne 1 : Sélection d'une image de base (node) 
    + Ligne 2 : Définission du répertoire de travail (*Working Directory*). Dans notre cas : `/usr/src`
    + Ligne 3 : Copie des fichiers `package.json` et `package-lock.json`
    + Ligne 4 : Exécution de la commande `npm install` (installation les dépendances du projet React)
    + Ligne 5 : Copie du reste des fichiers du projet (`.jsx` etc...)
    + Ligne 6 : Exécution de la commande `npm run build`. Cette commande va créer un répertoire `dist` contenant une version du projet pour la production.
+ Ligne 7-10 : Stage Serveur Web Nginx
    + Le premier *stage* nous a permis de compiler le projet React dans le répertoire /usr/src/dist. Le deuxième stage a pour objectif de créer un serveur web Nginx pour héberger notre application React.
    + Ligne 7 : Sélection de l'image de base (nginx)
    + Ligne 8 : Copie, à partir du premier stage, le contenu du répertoire /usr/src/dist dans le répertoire /usr/share/nginx/html du deuxième stage.
    + Ligne 9 : Suppression des fichiers de configuration par défaut de Nginx
    + Ligne 10 : Copie du fichier de configuration nginx.conf dans le répertoire /etc/nginx/conf.d du conteneur.
    + Ligne 11 : Exposer le port 80 (HTTP)
    + Ligne 12 : Exécution de la commande `nginx -g deamon off;` (point d'entrée de notre image)

2. Créez un fichier `.dockerignore`. Ce fichier a la même utilité qu'un `.gitignore` (ignore certains répertoires et fichiers lors de la création de l'image) :
```
node_modules
build
dist
config
.env
.gitignore
.vscode
.cache
.docker
.ssh
.vs-code-server
docker-compose.yaml
Dockerfile
README.md
```

##### Étape 2 - Création de l'image 

1. Lancez la commande suivante pour créer une image à partir du `Dockerfile` crée dans l'étape précédente :

```bash
docker build -t <nom_utilisateur_dockerhub>/atelier-frontend:v1 <chemin vers le Dockerfile>
```

Détails de la commande :
+ `-t` : pour nommer l'image (tag)
    + Convention de nommage : `<nom_utilisateur_dockerhub>/<nom_du_repo>:<version>`
+ `<chemin vers le Dockerfile>`: Dans le cas où vous vous situez dans le répertoire `frontend`, mettez `.` pour référer au répertoire courant.

+ Vérifiez que l'image est crée et qu'elle est disponible localement :
```bash
docker images
```

##### Étape 3 - publication de l'image dans DockerHub

1. Connectez-vous à votre compte Docker :
```bash
docker login --username <nom_utilisateur>
```
Vous devriez avoir à taper votre mot de passe
2. Après la connexion, il suffit de lancer la commande pour publier l'image dans le repo `frontend` crée précédemment :
```bash
docker push <nom_utilisateur>/atelier-frontend:v1 
```

3. Vérifiez que votre image est disponible sur votre compte `DockerHub`

### Atelier 2 - Conteneuriser la partie backend

##### Étape 1 - Création d'un Dockerfile et d'un .dockerignore

1. Dans le dossier `frontend`, créer un fichier nommé `Dockerfile` avec les informations suivantes : 

```dockerfile
# STAGE 1 : BUILD
FROM eclipse-temurin:23.0.2_7-jdk-alpine AS build
WORKDIR /opt/app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ["./mvnw", "dependency:go-offline"]
COPY ./src ./src
RUN ["./mvnw", "clean", "install"]

# STAGE 2 : APP FINALE
FROM eclipse-temurin:23.0.2_7-jre-alpine AS final
WORKDIR /opt/app
EXPOSE 8787
COPY --from=build /opt/app/target/*.jar /opt/app/*.jar
ENTRYPOINT ["java", "-jar", "/opt/app/*.jar"]
```

Précisions sur ce fichier :
+ Ligne 1-7 : Étape de compilation (build)
    + Ligne 1 : Sélection d'une image de base avec le JDK java (pour pouvoir créer les `.jar`) (eclipse-temurin-jdk) 
    + Ligne 2 : Définission du répertoire de travail (*Working Directory*). Dans notre cas : `/opt/app`
    + Ligne 3 : Copie du répertoire `.mvn` (propriétés du *Maven Wrapper*) dans le répertoire `/opt/app/.mvn`
    + Ligne 4 : Copie des fichiers `mvnw` et `pom.xml` dans le répertoire dans le répertoire `/opt/app/`
    + Ligne 5 : Exécution du Maven Wrapper pour installer les dépendances 
    + Ligne 6 : Copie du répertoire `src` contenant les fichiers du projet 
    + Ligne 7 : Exécution de la commande `./mvnw clean install`. Cette commande va compiler le projet et créer des fichiers `.jar`.
+ Ligne 8-12 : Stage final
    + Le premier *stage* nous a permis de compiler le projet et créer les exécutables `.jar` dans le répertoire /opt/app. Le deuxième stage a pour objectif de créer un environnement plus léger (seulement le JRE) pour exécuter les `.jar` crées dans le stage précédent.
    + Ligne 8 : Sélection de l'image de base (eclipse-temurin-jre)
    + Ligne 9 : Définission du répertoire de travail (*Working Directory*). Dans notre cas : `/opt/app`
    + Ligne 10 : Exposer le port 8787 (port d'écoute du backend)
    + Ligne 11 : Copie, à partir du premier stage, les fichiers `.jar` du créer au premier stage (répertoire /opt/app/target/) dans le répertoire /opt/app/ du deuxième stage.
    + Ligne 12 : Exécution de la commande `java -jar /opt/app/*.jar` (point d'entrée de notre image)

<!-- 2. Créez un fichier `.dockerignore`. Ce fichier a la même utilité qu'un `.gitignore` (ignore certains répertoires et fichiers lors de la création de l'image) :
```
node_modules
build
dist
config
.env
.gitignore
.vscode
.cache
.docker
.ssh
.vs-code-server
docker-compose.yaml
Dockerfile
README.md
``` -->

##### Étape 2 - Création de l'image 

1. Lancez la commande suivante pour créer une image à partir du `Dockerfile` crée dans l'étape précédente :

```bash
docker build -t <nom_utilisateur_dockerhub>/atelier-backend:v1 <chemin vers le Dockerfile>
```
2. Vérifiez que l'image est crée et qu'elle est disponible localement :
```bash
docker images
```
##### Étape 3 - publication de l'image dans DockerHub

1. Connectez-vous à votre compte Docker :
```bash
docker login --username <nom_utilisateur>
```
2. Après la connexion, il suffit de lancer la commande pour publier l'image dans le repo `backend` crée précédemment :
```bash
docker push <nom_utilisateur>/atelier-backend:v1 
```

3. Vérifiez que votre image est disponible sur votre compte `DockerHub`

### Atelier 3 - Déploiement de l'application sur AWS

Maintenant que nous avons crée nos images pour chaque composant de notre application, nous allons la déployer dans une instance EC2.

Dans cet atelier, nous allons utiliser le VPC par défaut.

##### Étape 1 - Création d'un groupe de sécurité
1. Connectez-vous à votre environnement AWS, puis naviguez à la console VPC
2. Naviguez à l'onglet **Groupes de sécurité**
3. Créez un groupe sécurité pour l'instance EC2. Vous devez autoriser le trafic suivant
    + SSH : port 22
    + HTTP : port 80
    + TCP personnalisé : port 8787

##### Étape 2 - Déploiement d'une instance EC2
1. Naviguez à la console EC2
2. Créez une instance EC2 :
    + AMI : Ubuntu
    + VPC : par défaut
    + Clé : créez en une et téléchargez-la
    + Groupe de sécurité : Sélectionnez celui que vous avez crée dans l'étape précédente.
    + Données utilisateur :

```bash
#!/bin/bash

# Installation de docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh 

# Création d'un réseau docker
sudo docker network create my-network

# Lancer le backend
sudo docker run -d -p 8787:8787 \
    --name backend \
    -h backend \
    --network my-network \
    <nom-utilisateur>/atelier-backend:v1

# Lancer le frontend 
sudo docker run -d -p 80:80 \
    --name frontend \
    -h frontend \
    --network my-network \
    <nom-utilisateur>/atelier-frontend:v1
```

### Atelier 4 - Création d'un docker-compose
Pour faciliter la publication, le déploiement des conteneurs et éviter d'utiliser des commandes avec plusieurs options, il est possible de créer un fichier de configuration décrivant toutes les options pour créer les images, mapper les ports, créer des réseaux dans Docker etc... Ce fichier s'appelle `docker-compose.yml`

Voici un exemple d'un `docker-compose.yml` pour notre frontend et backend : 

```yaml
services:
  backend:
      image: cmvghazi/atelier-backend:v3
      build:
        context: ./backend
      ports:
        - "8787:8787"
      networks:
        - my-network
  
  frontend:
      image: cmvghazi/atelier-frontend:v3
      build:
        context: ./frontend
      ports:
        - "80:80"
      depends_on:
        - backend
      networks:
        - my-network

networks:
  my-network:
    driver: bridge
```

Commande pour créer une nouvelle image à partir du docker-compose et push ses images dans Docker Hub:
```bash
docker compose build --push
``` 
Commande pour seulement push de nouvelles images à partir du docker-compose.yml :
```bash
docker compose push
```

Commande pour démarrer les conteneurs à partir du docker-compose : 
```bash
docker compose up -d
```




