+++
title = 'Docker Compose'
draft = false
weight = "480"
+++
------------
## Utilité 

Jusqu’à présent, nous avons créé des réseaux, volumes et conteneurs manuellement, lancé plusieurs conteneurs avec des commandes qui deviennent de plus en plus longues. Cela fonctionne… mais devient vite long, répétitif, difficile à maintenir et source d’erreurs. 

*Docker Compose* permet de définir toute l’infrastructure dans un seul fichier YAML et permet de :
+ Définir plusieurs conteneurs (*stack*)
+ Configurer des réseaux
+ Configurer des volumes
+ Définir des variables d’environnement
+ Gérer les dépendances

Le tout dans un seul fichier :
```bash
docker-compose.yml
# ou (version moderne):
compose.yaml
```

Puis on démarre tout avec :
```bash
docker compose up
```



## Structure du fichier compose.yaml
Exemple minimal :
```yaml
services:
  api:
    image: nginx
    ports:
      - "3000:80"
```

## Concepts clés
### services
Chaque conteneur est défini comme un **service**.
```yaml
services:
  db:
    image: mysql
```
### ports
```yaml
ports:
  - "3000:3000"
```
Format: `port_hôte:port_conteneur`

### volumes
```yaml
volumes:
  - db-data:/var/lib/mysql
```

### networks

*Docker Compose* crée automatiquement un réseau bridge interne pour les services.

Les services peuvent communiquer par leur **nom** :
```bash
http://db:3306
```

Pas besoin d’IP.

## Commandes utiles
Lancer le stack : 
```bash
docker compose up -d
```

Arrêter :
```bash
docker compose down
```

Arrêter et supprimer volumes :
```bash
docker compose down -v
```

Voir les logs :
```bash
docker compose logs
```
Reconstruire (rebuild) :
```bash
docker compose up --build
```
Push : 
```bash
docker compose push <service>
```

## Résumé 
Sans Docker Compose, plusieurs commandes, plusieurs erreurs possibles :
```bash
docker network create app-network
docker volume create db-data
docker run ...
docker run ...
```

Avec Docker Compose, un seul fichier, une seule commande : 
```bash
docker compose up -d
```