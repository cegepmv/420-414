+++
title = 'Laboratoire'
draft = true
weight = "451"
+++
-------------------


## 1 – Dockeriser un frontend (React/Nginx)

**Objectif :**
+ Construire une image *React*
+ Servir via *Nginx*
+ Utiliser **multi-stage build**
+ Optimiser avec `.dockerignore`

### Étape 1 – Structure projet
```bash
frontend/
  ├── src/
  ├── public/
  ├── package.json
  ├── nginx.conf
  ├── Dockerfile
  └── .dockerignore
```

### Étape 2 – Dockerfile
```dockerfile
# ---- Build React ----
FROM node:20 AS build

WORKDIR /app
COPY package*.json .
RUN npm install

COPY . .
RUN npm run build

# ---- Serve with Nginx ----
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Étape 3 – .dockerignore
```bash
node_modules
.git
Dockerfile
.dockerignore
README.md
```
**Utilité:**
+ Réduit le contexte de build
+ Accélère la compilation
+ Réduit la taille de l’image

### Étape 4 – Build & Run
```bash
docker build -t react-app .
docker run -p 8080:80 react-app
```
## 2 – Dockeriser une API (NestJS)

**Objectif :** Créer une image optimisée pour production.

### Étape 1 – Dockerfile
```dockerfile
# ---- Build ----
FROM node:20 AS builder

WORKDIR /app
COPY package*.json .
RUN npm install

COPY . .
RUN npm run build

# ---- Production ----
FROM node:20-alpine

WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY package*.json ./

RUN npm install --omit=dev

EXPOSE 3000
CMD ["node", "dist/main.js"]
```
### Étape 2 – .dockerignore
```bash
node_modules
dist
.git
```
### Étape 3 – Build
```bash
docker build -t nest-api .
docker run -p 3000:3000 nest-api
```

<!-- ### 🎓 Laboratoire avancé (intégration)

Créer :

+ Un réseau Docker
+ Lancer frontend
+ Lancer backend
+ Tester communication
+ Observer les logs -->