+++
title = 'Images'
draft = false
weight = "343"
+++

### Concepts clés

1. **Couches (*layers*) :** Les images sont composées de plusieurs couches, chacune représentant un ensemble de modifications du système de fichiers.
modifications du système de fichiers.
2. **Image de base (*Base Image*) :** La base d'une image, généralement un système d'exploitation minimal.
3. **Image parent (*Parent Image*) :** Une image sur laquelle votre image est construite.
4. **Tags d'images :** Étiquettes utilisées pour la version et l'identification des images.
5. **ID de l'image** : Identifiant unique pour chaque image.

### Travailler avec des images Docker

+ Pour voir toutes les images disponibles sur votre système local :
```bash
docker images
```
+ Ou utilisez la commande la plus verbeuse :
```bash
docker image ls
```
+ Pour télécharger (*pull*) des images de *Docker Hub*
```bash
docker pull <nom_image>:<tag>
```
+ Exemple :
```bash
docker pull ubuntu:20.04
```

Si aucun tag n'est spécifié, Docker téléchargera la dernière version (*latest*) par défaut.

+ Exécution de conteneurs à partir d'images
```bash
docker run <nom_image>:<tag>
```
+ Exemple :
```bash
docker run -it ubuntu:20.04 /bin/bash
```

+ Informations sur l'image
Pour obtenir des informations détaillées sur une image :
```bash
docker inspect <nom_image>:<tag>
```
+ Pour supprimer une image :
```bash
docker rmi <nom_image>:<tag>
```
ou 
```bash
docker image rm <nom_image>:<tag>
```
+ Pour supprimer toutes les images inutilisées :
```bash
docker image prune
```

### Construire des images personnalisées

#### En utilisant un `Dockerfile`

1. Créer un fichier nommé `Dockerfile` (sans extension).
2. Définir les instructions pour construire votre image.

Exemple :
```dockerfile
FROM ubuntu:20.04

RUN apt-get update && apt-get install -y nginx

COPY ./my-nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off ;"]
```
3. Build l'image :
```bash
docker build -t my-nginx:v1 .
```
#### À partir d'un conteneur en cours d'exécution
1. Apportez des modifications à un conteneur en cours d'exécution.
2. Créer une nouvelle image à partir du conteneur :
```bash
docker commit <container_id> my-new-image:tag
```

### Tags d'images

+ Pour tagger une image existante
```bash
docker tag <image_source>:<tag> <image_cible>:<tag>
```
+ Exemple : 
```bash
docker tag my-nginx:v1 my-dockerhub-username/my-nginx:v1
```

### Téléverser des images sur Docker Hub
1. Se connecter à *Docker Hub*
```bash
docker login
```
2. Téléverser (*push*) l'image
```bash
docker push my-dockerhub-username/my-nginx:v1
```

#### Couches et mise en cache
Il est essentiel de comprendre les couches pour optimiser la création d'images :
1. Chaque instruction d'un `Dockerfile` crée une nouvelle couche.
2. Les couches sont mises en cache et réutilisées dans les prochains build.
3. Le fait d'ordonner les instructions du moins au plus souvent modifiées peut accélérer les *builds*.

+ Exemple de mise en cache :
```dockerfile
FROM ubuntu:20.04

RUN apt-get update && apt-get install -y nginx

COPY ./static-files /var/www/html

COPY ./config-files /etc/nginx
```

### Analyse d'images et sécurité
Docker offre des fonctionnalités intégrées pour analyser vos images et identifier les vulnérabilités :
```bash
docker scan <nom_image>:<tag>
```