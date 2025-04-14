+++
title = 'Réseau'
draft = false
weight = "345"
+++

La mise en réseau Docker permet aux conteneurs de communiquer entre eux et avec le monde extérieur.

### Pilotes réseau Docker
Docker propose plusieurs pilotes de réseau :

1. Bridge : Le pilote réseau par défaut. Il convient aux conteneurs autonomes qui ont besoin de communiquer.
2. Host (hôte) : Supprime l'isolation réseau entre le conteneur et l'hôte Docker.
3. Overlay (superposition) : Permet la communication entre les conteneurs sur plusieurs hôtes de démon Docker.
4. MacVLAN : Attribue une adresse MAC à un conteneur, le faisant apparaître comme un périphérique physique sur le réseau.
5. None (Aucun) : Désactive toute mise en réseau pour un conteneur.
6. Network plugins (plugins réseau) : Permet d'utiliser des pilotes réseau tiers.

### Travailler avec les réseaux Docker

#### Lister les réseaux
```bash
docker network ls
```
Cette commande affiche l'ID, le nom, le pilote et la portée de chaque réseau. 

#### Inspecter les réseaux
Pour obtenir des informations détaillées sur un réseau :
```bash
docker network inspect <nom_du_réseau>
```
Cette commande fournit des informations telles que le sous-réseau du réseau, la passerelle, les conteneurs connectés et les options de configuration.

#### Création d'un réseau
Pour créer un nouveau réseau :
```bash
docker network create --driver <driver> <nom_du_réseau>
```
Exemple :
```bash
docker network create --driver bridge my_custom_network
```
Vous pouvez spécifier des options supplémentaires comme le sous-réseau, la passerelle, la plage IP, etc :
```bash
docker network create --driver bridge --subnet 172.18.0.0/16 --gateway 172.18.0.1 my_custom_network
```

#### Connecter un conteneur à un réseaux
Lors de l'exécution d'un conteneur, vous pouvez spécifier le réseau auquel il doit se connecter :
```bash
docker run --network <nom_du_réseau> <image>
```
Exemple :
```bash
docker run --network my_custom_network --name container1 -d nginx
```
Vous pouvez également connecter un conteneur en cours d'exécution à un réseau :
```bash
docker network connect <nom_du_réseau> <nom_du_conteneur>
```
#### Déconnecter un conteneur d'un réseau
Pour déconnecter un conteneur d'un réseau :
```bash
docker network disconnect <nom_du_réseau> <nom_du_conteneur>.
```

#### Supprimer un réseau
Pour supprimer un réseau :
```bash
docker network rm <nom_du_réseau>
```