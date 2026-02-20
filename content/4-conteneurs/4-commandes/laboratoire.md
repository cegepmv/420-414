+++
title = 'Laboratoire'
draft = false
weight = "441"
+++
-------------------

## 1 - Lancer le premier conteneur

```bash
docker run hello-world
```
Cette commande effectue les opérations suivantes : 
1. Recherche de l'image `hello-world` localement
2. Si l'image n'est pas trouvée, elle est téléchargée de *Docker Hub*
3. Crée un conteneur à partir de l'image
4. Exécute le conteneur, qui affiche un message d'accueil.
5. Quitte le conteneur

## 2 - Exécuter un conteneur Apache
Exécutons un serveur web Apache dans un conteneur :
1. Télécharger (*pull*) l'image :
```bash
docker pull httpd
```
2. Exécutez le conteneur :
```bash
docker run -d --name my-apache -p 8080:80 httpd
```
3. Vérifiez qu'il fonctionne :
```bash
docker ps
```
4. Accédez à la page par défaut en ouvrant un navigateur web et en naviguant vers
```bash
http://localhost:8080
```
5. Modifiez la page par défaut :
```bash
docker exec -it my-apache /bin/bash
echo "<h1>Hello from my Apache container!</h1>" > /usr/local/apache2/htdocs/index.html
exit
```
6. Rafraîchissez votre navigateur pour voir les changements.