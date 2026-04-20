+++
title = "Laboratoire"
draft = false
weight = "543"
+++
--------------

Dans ce laboratoire, nous allons appliquer concrètement les ressources vues précédemment (Pods, Deployments, Services) en déployant l'application `e-commerce` des laboratoires précédents sur K8s.

## Architecture du projet
+ **Base de données :** MySQL tournant sur votre conteneur LXC personnel (via Docker Compose).
+ **Backend (ecommerce-api)** : Déployé sur Kubernetes (Deployment + Service NodePort).
+ **Frontend (ecommerce-frontend) :** Déployé sur Kubernetes (Deployment + Service NodePort).

## 0 - Déploiement de la Base de données (sur votre conteneur)
Avant de lancer l'application sur Kubernetes, nous devons déployer la base de données de ecommerce sur votre conteneur LXC.

Créez un répertoire `db-ecommerce` sur votre conteneur LXC et placez-y les fichiers `compose.yaml` et `.env` suivants : 

**`compose.yaml`:**
```yaml
services:
  db:
    image: mysql:8.0
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    ports:
      - "3306:3306"
    volumes:
      - db_data:/var/lib/mysql

volumes:
  db_data:

```

**`.env`:**
```bash
MYSQL_ROOT_PASSWORD=<mot de passe root>
MYSQL_DATABASE=ecommerce_db
MYSQL_USER=ecommerce_user
MYSQL_PASSWORD=<mot de passe de l'utilisateur>
```
Lancez la base de données :

```Bash
sudo docker-compose up -d
```

**Vérification :** Assurez-vous que le conteneur tourne et que le port `3306` est accessible. Notez l'adresse IP de votre conteneur LXC.

## 1 - Configuration du Backend (API)
Créez un répertoire `k8s-manifests/ecommerce/ecommerce-api`. C'est dans ce répertoire qu'on mettra les manifestes (deployment et service) de l'API.

### 1.1 Deployment
**Contenu du fichier `k8s-manifests/ecommerce/ecommerce-api/ecommerce-api-deployment.yaml` :**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ecommerce-api
spec:
  selector:
    matchLabels:
      app: ecommerce-api
  template:
    metadata:
      labels:
        app: ecommerce-api
    spec:
      containers:
        - name: ecommerce-api
          image: cmvghazi/ecommerce-backend:1.3
          env:
            - name: PORT
              value: "3000"
            - name: DB_HOST
              value: "10.10.22.191" # Mettez l'adresse IP de votre VM qui héberge la BD
            - name: DB_PORT
              value: "3306"
            - name: DB_NAME
              value: ecommerce
            - name: DB_USER
              value: ecommerce_user
            - name: DB_PASSWORD
              value: ecommerce_password
            - name: JWT_SECRET
              value: supersecret
            - name: JWT_EXPIRES_IN
              value: 7d
          ports:
            - containerPort: 3000
```
{{%notice style="warning" title="Variables d'environnement en clair"%}}
Dans ce manifeste, des variables d'environnement sensibles sont écrites en clair. Normalement, les variables d'environnement sensibles doivent être gérées par une autre ressource Kubernetes : les **Secrets**. 

[Documentation Kubernetes sur les Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
{{%/notice%}}

### 1.2 - Service
**Contenu du fichier `k8s-manifests/ecommerce/ecommerce-api/ecommerce-api-svc.yaml` :**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: ecommerce-api
spec:
  type: NodePort
  ports:
    - port: 3000
      targetPort: 3000
  selector:
    app: ecommerce-api
```

### Déploiement
```bash
kubectl apply -f k8s-manifests/ecommerce/ecommerce-api/
```

### Vérification
1. Vérifiez que le **Pod** est en état `Running` : 
  ```bash
  kubectl get pods
  ```
2. Consultez les logs pour confirmer la connexion à la BD : 
  ```bash
  kubectl logs -l app=ecommerce-api
  ```

## Étape 2 : Configuration du frontend
Créer un répertoire `k8s-manifests/ecommerce/ecommerce-frontend` qui contiendra les manifests (service et deployment) du frontend.

### 2.1 - Deployment
**Contenu du fichier `k8s-manifests/ecommerce/ecommerce-frontend/ecommerce-frontend-deployment.yaml` :**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ecommerce-frontend
spec:
  selector:
    matchLabels:
      app: ecommerce-frontend
  template:
    metadata:
      labels:
        app: ecommerce-frontend
    spec:
      containers:
        - name: ecommerce-frontend
          image: cmvghazi/ecommerce-frontend:1.5
          ports:
            - containerPort: 80
```

### 2.2 - Service
**Contenu du fichier `k8s-manifests/ecommerce/ecommerce-frontend/ecommerce-frontend-svc.yaml` :**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: ecommerce-frontend
spec:
  type: NodePort
  ports:
    - targetPort: 80
  selector:
    app: ecommerce-frontend
```

### Déploiement 
```bash
kubectl apply -f k8s-manifests/ecommerce/ecommerce-frontend
```
### Vérification
1. Vérifiez que le **Pod** est en état `Running` : 
  ```bash
  kubectl get pods
  ```
2. Consultez les logs pour confirmer la connexion à la BD : 
  ```bash
  kubectl logs -l app=ecommerce-frontend
  ```


### 3 - Test et Validation de l'infrastructure
C'est ici que nous vérifions si tout communique correctement. Puisque nous utilisons des services de type `NodePort`, Kubernetes a ouvert des ports aléatoires sur les *Worker Nodes*. Trouvez les ports assignés, puis vérifier que le frontend est disponible via un navigateur.

### 4 - Suppression des ressource
Supprimez les ressources créées :
```bash
kubectl delete -f ecommerce/ecommerce-api
kubectl delete -f ecommerce/ecommerce-frontend
```