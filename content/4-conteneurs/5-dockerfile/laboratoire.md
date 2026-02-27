+++
title = 'Laboratoire'
draft = false
weight = "451"
+++
-------------------

Ce laboratoire a pour objectif de conteneuriser une application fullstack composée :

+ d’un **frontend React servi par Nginx**
+ d’un **backend NestJS**
+ d’une **base de données MySQL**

Vous allez construire les images Docker, configurer les variables d’environnement et exécuter les conteneurs afin d’obtenir un stack complet fonctionnel.

## 1 – Dockeriser un frontend (React/Nginx)

### Objectif
Créer une image Docker multi-stage permettant :
+ de construire l’application React
+ de servir les fichiers statiques via Nginx
+ d’optimiser la taille de l’image finale

### Étape 1 – Fork le dépôt
1. Faites un fork (copie personnelle) du dépôt suivant :  [dépôt frontend](https://github.com/gbenachour/ecommerce-frontend)
2. Cloner le dépôt : 
```bash
git clone <lien du dépôt>
```
**Structure du projet:**
```bash
ecommerce-frontend/
  ├── src/
  ├── nginx.conf
  ├── package.json
  ├── package-lock.json
  ├── index.html
  ├── README.md  
  ├── .env.example
  └── .gitignore


```

### Étape 2 – Dockerfile
Créez un fichier `Dockerfile` à la racine du projet :
```dockerfile
# ─── Stage 1: Build ───
FROM node:20-alpine AS builder

WORKDIR /app

# Accepter une variable d'environnement pour l'URL de l'API, avec une valeur par défaut
ARG VITE_API_URL=http://localhost:3000
ENV VITE_API_URL=${VITE_API_URL}

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ─── Stage 2: Production (Nginx) ───
FROM nginx:stable-alpine AS production

# Supprimer la configuration par défaut de Nginx (évite les conflits)
RUN rm -rf /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copier les fichiers construits depuis l'étape de build vers le dossier de Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

```

### Étape 3 – .dockerignore
Créez un fichier `.dockerignore` :
```bash
# Git
.git
.gitignore
.gitattributes

# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Build
dist/
build/
dist-ssr/

# Environment
.env
.env.local
.env.*.local

# IDE and editor
.vscode/
.idea/
.DS_Store
*.swp
*.swo
*~

# Testing
/coverage

# Logs
logs/
*.log

# Documentation
*.md

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Misc
.cache/
.turbo/
*.pid
```
**Utilité du `.dockerignore`:**
+ Réduit le contexte de build
+ Accélère la compilation
+ Réduit la taille de l’image

### Étape 4 – Build
```bash
docker build -t ecommerce-frontend:1.0 .
```

### Étape 5 – Variable d'environnement
Le frontend a besoin de l'url de l'API avec laquelle il va communiquer. Pour la lui fournir, il nous faut créer un fichier `.env`contenant les variables d'environnement injectées lors de l'exécution du conteneur. Un exemple est donnée avec le fichier `.env.example` de la repo.

**Contenu du fichier `.env.example`:**
```bash
VITE_API_URL=http://localhost:3000
```
Copiez le fichier et nommez-le `.env` :
```bash
cp .env.example .env
```

## 2 – Dockeriser une API (NestJS)

### Objectif 
Créer une image Docker optimisée pour la production :
+ Utiliser un build multi-stage
+ Supprimer les dépendances inutiles
+ Réduire la taille de l’image finale

### Étape 1 – Fork le dépot
1. Faites un fork (copie personnelle) du dépôt suivant :  [dépôt backend](https://github.com/gbenachour/ecommerce-backend)
2. Cloner le dépôt : 
```bash
git clone <lien du dépôt>
```
**Structure du projet:**
```bash
ecommerce-backend/
  ├── src/
  ├── package.json
  ├── package-lock.json
  ├── nest-cli.json
  ├── .gitignore
  └── .env.example
```

### Étape 2 – Dockerfile
```dockerfile
# ─── Stage 1: Build ───
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Prune les dépendances de développement pour réduire la taille de l'image finale
RUN npm prune --production

# ─── Stage 2: Production ───
FROM node:20-alpine AS production

ENV NODE_ENV=production

WORKDIR /app

# Copier seulement les fichiers nécessaires pour l'exécution de l'application
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

EXPOSE 3000

CMD ["node", "dist/main"]
```
### Étape 3 – .dockerignore
```bash
# Git
.git
.gitignore
.gitattributes

# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Build
dist/
build/
.tsbuildinfo

# Environment
.env
.env.local
.env.*.local

# IDE and editor
.vscode/
.idea/
.DS_Store
*.swp
*.swo
*~

# Testing
/coverage
.nyc_output/

# Logs
logs/
*.log

# Documentation
*.md

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Misc
.cache/
.turbo/
*.pid
```
### Étape 4 – Build
```bash
docker build -t ecommerce-backend:1.0 .
```

### Étape 5 – Variable d'environnement
Le backend a aussi besoin de variables d'environnement (communication avec la base de données, JWT, etc...), il nous faut donc aussi créer un fichier `.env` contenant les variables d'environnement injectées lors de l'exécution. Un exemple est donné avec le fichier `.env.example` (racine du projet).

**Contenu de `.env.example`:**
```bash
# Application
PORT=3000
NODE_ENV=development

# Database
DB_HOST=<HOST IP ADDRESS> # Remplacer cela par votre adresse IP
DB_PORT=3306
DB_NAME=ecommerce
DB_USER=root
DB_PASSWORD=rootpassword

# JWT
JWT_SECRET=your-super-secret-jwt-key-change-in-production
JWT_EXPIRES_IN=7d

```
Copiez le fichier et nommez-le `.env` :
```bash
cp .env.example .env
```

## 3 – Intégration des composantes
Assembler les trois services dans un stack complet :
+ Base de données MySQL
+ Backend 
+ Frontend
### 1 – Base de données
  + Créer un fichier `.env` pour la base de données :
  ```bash
  MYSQL_ROOT_PASSWORD=rootpassword
  MYSQL_DATABASE=ecommerce
  MYSQL_USER=ecommerce_user
  MYSQL_PASSWORD=ecommerce_password  
  ```
  + Lancer le conteneur :  
  ```bash
  docker run -d --name ecommerce-db -p 3306:3306 --env-file <chemin du fichier .env> mysql:8.0
  ```

### 2 – Backend
```bash
docker run -d --name ecommerce-backend -p 3000:3000 --env-file <chemin du fichier .env du backend>  ecommerce-backend:1.0
```

### 3 – Frontend
```bash
docker run -d --name ecommerce-frontend -p 8080:80 --env-file <chemin du fichier .env du frontend> ecommerce-frontend:1.0
```

### 3 – Vérification
Accédez à l’application via votre navigateur.

Si cela ne fonctionne pas, utilisez les commandes suivantes :

```bash
docker ps # vérifier que les conteneurs sont en cours d'exécution
docker logs -f ecommerce-frontend # vérifier les logs des conteneurs
docker logs -f ecommerce-backend
docker logs -f ecommerce-db
```

## 4 – Pour aller plus loin

Industrialiser votre travail et préparer un déploiement réel.

1. Committez les `Dockerfile` et `.dockerignore` dans les dépôts `ecommerce-frontend` et `ecommerce-backend`
2. Poussez vos images dans des registres Docker Hub
3. Déployez l’application sur une instance EC2