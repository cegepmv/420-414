+++
title = 'Workflow Docker'
draft = false
weight = "430"
+++
-------------

## Vue globale DevOps
![Conteneurs](/420-414/images/3-vm-conteneur/docker-workflow.png)

Le cycle classique :
1. **Build**
2. **Push**
3. **Pull**
4. **Run**

## Build – construire l’image
On transforme un *Dockerfile* en image.

Exemple :  
```bash
docker build -t monapp:1.0 .
```
Explication :
+ `-t` : tag (nom:version)
+ `.` : contexte de build (répertoire courant)

Docker lit le *Dockerfile* et crée une image composée de couches (*layers*).

## Push – envoyer vers un registre

On téléverse l’image vers un registre.

Exemple (*Docker Hub*) :
```bash
docker tag monapp:1.0 ghazi/monapp:1.0
docker push ghazi/monapp:1.0
```
Explication :
+ `tag` : associe l’image à un dépôt distant
+ `push` : envoie l’image vers le registre

## Pull – télécharger l’image
Sur une autre machine :
```bash
docker pull ghazi/monapp:1.0
```
Cela garantit que l’on exécute **exactement la même image** que celle construite.

## Run – exécuter le conteneur
```bash
docker run -d -p 8080:3000 monapp:1.0
```
Explication (expliqué plus en détail dans les prochaines sections) :
+ `-d` : mode détaché
+ `-p 8080:3000` : mapping port hôte → conteneur

Cela crée un conteneur en tant que processus isolé à partir de l’image téléchargée.




