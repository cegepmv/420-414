+++
title = 'Laboratoire'
draft = false
weight = "481"
+++
------------

## Objectifs
À la fin de ce laboratoire, vous serez capable de :

+ Structurer un projet contenant **plusieurs services conteneurisés** ;
+ Déployer une application complète avec **Docker Compose** ;
+ Utiliser des **variables d’environnement** ;
+ Configurer des **volumes persistants** ;
+ Configurer un **réseau Docker** ;
+ Comprendre la communication entre plusieurs services. 

## Étapes préliminaires
### Configuration de Git et GitHub
**Génération d'une clé SSH :**
```bash
ssh-keygen
cat ~/.ssh/id_ed25519.pub
```
Copiez la clé affichée et ajoutez-la dans votre compte **GitHub**.

**Configuration de git :**
```bash
git config --global user.name <username github>
git config --global user.email <email github>
```
### Fork des dépôts
Fork les deux dépôts suivants sur votre compte GitHub :

+ [Dépôt frontend](https://github.com/gbenachour/ecommerce-frontend)
+ [Dépôt backend](https://github.com/gbenachour/ecommerce-frontend)

### Création du répertoire du projet
Créer un répertoire pour contenir l’application complète :
```bash
mkdir ecommerce-app
cd ecommerce-app
```
Cloner les deux dépôts *forkés* :
```bash
git clone <repo-frontend>
git clone <repo-backend>
```

### Création des Dockerfiles

À partir du laboratoire précédent :

+ Créer le `Dockerfile` du frontend
+ Créer le `Dockerfile` du backend
+ Créer les fichiers `.dockerignore`

### Commit des modifications 
Dans chaque dépôt :
```bash
git add .
git commit -m "ajout Dockerfile"
git push
```

## 1 – Création du dépôt racine
Nous allons créer un dépôt principal qui contiendra les deux projets sous forme de *submodules* Git.

Créer le fichier `.gitmodules` :
```bash
[submodule "ecommerce-frontend"]
    path = ecommerce-frontend
    url = <lien SSH du repo du frontend>

[submodule "ecommerce-backend"]
    path = ecommerce-backend
    url = <lien SSH du repo du backend>
```
Initialiser le dépôt :
```bash
git init
```
Puis :
```bash
git add .
git commit -m "Initialisation projet ecommerce-app"
```
Créez une repo sur votre compte GitHub puis suivez les étapes décrites dans la section "*…or push an existing repository from the command line*" pour push la repo locale sur la repo GitHub nouvellement créée.

Nous avons maintenant un **dépôt racine** qui référence les projets frontend et backend. Dans les étapes suivantes, nous allons créer le fichier `compose.yaml` qui nous permettra de gérer (build, run et push) le stack à partir des deux dépôts.

## 2 – Création du fichier compose.yaml
Créer un fichier : 
```bash
compose.yaml
```
**Configuration complète :**
```yaml
services:

  db:
    image: mysql
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    networks:
      - ecommerce-network
    volumes:
      - db_data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-u", "root", "-p${MYSQL_ROOT_PASSWORD}"]
      interval: 10s
      timeout: 5s
      retries: 5

  backend:
    image: cmvghazi/ecommerce-backend:${BACKEND_VERSION:-latest}
    build:
      context: ./ecommerce-backend
      dockerfile: Dockerfile
    restart: unless-stopped
    environment:
      DB_HOST: db
      DB_PORT: 3306
      DB_NAME: ${MYSQL_DATABASE}
      DB_USER: ${MYSQL_USER}
      DB_PASSWORD: ${MYSQL_PASSWORD}
      PORT: ${BACKEND_PORT:-3000}
      JWT_SECRET: ${JWT_SECRET}
      JWT_EXPIRES_IN: ${JWT_EXPIRES_IN:-7d}
    networks:
      - ecommerce-network
    ports:
      - "${BACKEND_PORT:-3000}:3000"
    depends_on:
      db:
        condition: service_healthy

  frontend:
    image: cmvghazi/ecommerce-frontend:${FRONTEND_VERSION:-latest}
    build:
      context: ./ecommerce-frontend
      dockerfile: Dockerfile
      args:
        VITE_API_URL: ${VITE_API_URL}
    restart: unless-stopped
    networks:
      - ecommerce-network
    ports:
      - "${FRONTEND_PORT:-8080}:80"
    depends_on:
      - backend

volumes:
  db_data:

networks:
  ecommerce-network:
    driver: bridge
```

### Explication du fichier
Le fichier `compose.yaml` permet de définir **l’ensemble des services qui composent l’application** et la manière dont ils interagissent entre eux.

Dans ce fichier, trois services sont définis : `db` (base de données MySQL), `backend` (API Node.js / NestJS) et `frontend` (interface React servie par Nginx)

Le fichier définit également :
+ un volume pour stocker les données de la base
+ un réseau Docker pour permettre aux services de communiquer entre eux

Chaque service possède des propriétés : 
+ `image`: image Docker utilisée pour créer le conteneur.
+ `restart`: politique de redémarrage du conteneur. `unless-stopped` signifie que Docker redémarrera automatiquement le conteneur si celui-ci s’arrête ou si le serveur redémarre. Il ne sera pas redémarré seulement si l’utilisateur l’arrête manuellement.
+ `environment`: variables d’environnement dans le conteneur (les valeurs proviendront du fichier `.env`).
+ `networks`: Connecte le conteneur à un réseau Docker (dans notre cas `ecommerce-network`).
+ `ports`: *mappage* du port du conteneur vers un port de la machine hôte (`PORT_HOTE:PORT_CONTENEUR`).
+ `volumes`: Associe un volume Docker au dossier où MySQL stocke ses données (pour conserver les données même si le conteneur est supprimé.).
+ `healthcheck`: Permet de vérifier si le service fonctionne correctement. Une commande est executé pour voir si le conteneur est "sain" (*healthy*). Si la commande échoue plusieurs fois, le conteneur sera considéré comme non sain (*unhealthy*). Cela permet à d’autres services d’attendre que la base de données soit réellement prête.
+ `build`: Permet de **construire l’image Docker localement**.
    + `context`: Définit le dossier contenant le code source, le Dockerfile et les fichiers nécessaires au build du service.
    + `dockerfile`: Spécifie le nom du fichier Dockerfile à utiliser.
+ `depends_on`: Indique si le service dépend d'un autre service. Docker attendra que l'autre service soit démarré avant de lancer le service.

## 3 – Création du fichier .env
Créer le fichier `.env` qui contiendra les variables d'environnement pour l'ensemble du *stack* : 
```bash
# ─── BD ───
MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_DATABASE=ecommerce
MYSQL_USER=ecommerce_user
MYSQL_PASSWORD=ecommerce_password  

# ─── BACKEND ───
BACKEND_VERSION=1.1
BACKEND_PORT=3000

JWT_SECRET=your-super-secret-jwt-key-change-in-production
JWT_EXPIRES_IN=7d

# ─── FRONTEND ───
FRONTEND_VERSION=1.1
FRONTEND_PORT=8080
```
Créer un fichier `.gitignore` :
```bash
.env
``` 
Cela empêche les **variables sensibles** d’être poussées vers GitHub.

## 4 – Lancement du stack
Construire les images et lancer les conteneurs :
```bash
docker compose up --build -d
```
**Vérifier les logs :**
```bash
docker compose logs <service>
# ou
docker compose logs
```

**Tester l’application en vérifiant que:**
+ le **frontend** est accessible dans le navigateur
+ le **backend** répond aux requêtes API

## 5 – Nettoyage

Arrêter les conteneurs :
```bash
docker compose down
```
Supprimer aussi les volumes :
```bash
docker compose down -v
```

## 6 – Publication du projet

Créer un fichier `.env.example` :
```bash
cp .env .env.example
```
Ce fichier sert de **documentation des variables d’environnement**.

Puis :
```bash
git add .
git commit -m "Ajout configuration Docker Compose"
git push
```

Pour pousser les images buildés : 
```bash
docker compose push <service>
# ou pour tous les services :
docker compose push
```

## Pour aller plus loin 
### 1 – Initialisation automatique de la base de données
Nous allons ajouter un **script SQL exécuté automatiquement au démarrage de du conteneur de la base de données**.
1. Création du répertoire `seed`:  
Créer un dossier
```bash
mkdir seed
```
Télécharger et copier le [fichier suivant](/420-414/files/seed.sql) dans le répertoire `seed`. 

2. Ajouter le volume dans `compose.yaml` :

Dans le service `db`, ajouter :
```yaml
volumes:
  - db_data:/var/lib/mysql
  - ./seed:/docker-entrypoint-initdb.d:ro
```
Les scripts placés dans `/docker-entrypoint-initdb.d` sont exécutés **uniquement lors de la création initiale du volume**.

3. Tester :
```bash
docker compose up -d
```
4. Vérifier : Ouvrir l’application et vérifier que les produits sont présents.

5. Nettoyage :
```bash
docker compose down -v
```
6. Sauvegarder les modifications
```bash
git add .
git commit -m "Ajout seed base de données"
git push
```

### 2 – Déploiement sur une instance EC2
*En vous basant sur ce laboratoire et les laboratoires précédents, déployez le stack sur une instance EC2.*