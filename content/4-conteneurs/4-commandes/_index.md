+++
title = 'Commandes'
draft = false
weight = "440"
+++
-------------------

## Lister les conteneurs
+ Pour voir tous les conteneurs en cours d'exécution :

```bash
docker ps
```

+ Pour lister tous les conteneurs (même ceux arrêtés):
```bash
docker ps -a
```

### Lancer/arrêter des conteneurs

+ Arrêter un conteneur 
```bash
docker stop <id_ou_nom_du_conteneur>
```

+ Démarrer un conteneur arrêté 
```bash
docker start <id_ou_nom_du_conteneur>
```

+ Redémarrer un conteneur 
```bash
docker restart <id_ou_nom_du_conteneur>
```
### Supprimer des conteneurs

+ Supprimer un conteneur arrêté
```bash
docker rm <id_ou_nom_du_conteneur>
```

+ Forcer la suppression d'un conteneur (en cours d'exécution)
```bash
docker rm  -f <id_ou_nom_du_conteneur>
```

### Modes de démarrage d'un conteneur

#### Mode détaché (*Detached Mode*)

+ Pour rouler un conteneur en arrière-plan :
```bash
docker run -d <image>
```

#### Mode interactif (*Interactive Mode*)
+ Pour rouler un conteneur et interagir avec (entrer dans le conteneur)
```bash
docker run -it <nom_image> /bin/bash
```

### Mappage de port
Pour mapper le port d'un conteneur à celui de l'hôte :
```bash
docker run -p <port_hote>:<port_conteneur> <image>
```

**Exemple :** 
```bash
docker run -d -p 80:80 nginx
```
**Explications :**
+ `-d` : mode détaché
+ `80:80`: le port 80 de l'hôte est mappé au port 80 du conteneur.


### Journaux des conteneurs (logs)
+ Accéder aux journal d'un conteneur
```bash
docker logs <id_ou_nom_conteneur>
```

+ Suivre les logs d'un conteneur en temps-réel
```bash
docker logs -f <id_ou_nom_conteneur>
```

### Exécuter des commandes dans un conteneur
+ Exécuter une commande dans un conteneur en cours d'exécution :
```bash
docker exec -it <id_ou_nom_conteneur> <commande>
```
+ Exemple : 
```bash
docker exec -it my_container /bin/bash
```

### Mise en réseau des conteneurs

+ Lister les réseaux
```bash
docker network ls
```
+ Créer un réseau
```bash
docker create network my_network
```
+ Attacher un conteneur à un réseau
```bash
docker run -d --network my_network --name my_container <image>
```

## Persistence des données avec les volumes
+ Créer un volume
```bash
docker volume create my_volume
```
+ Exécuter un conteneur avec un volume
```bash
docker run -d -v my_volume:/path/in/container <image_name>
```

## Nettoyage
+ Supprimer tous les conteneurs arrêtés
```bash
docker container prune
```
+ Supprimer toutes les ressources inutilisées (conteneurs, réseaux, images):
```bash
docker system prune
```