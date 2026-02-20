+++
title = 'Réseau Docker'
draft = false
weight = "460"
+++

Par défaut, les conteneurs Docker sont **isolés** les uns des autres.
Le système de réseau Docker permet de :

+ Faire communiquer plusieurs conteneurs entre eux (ex: API ↔ Base de données)
+ Exposer un service vers l’extérieur (ex: port 80 vers un port de l'hôte )
+ Isoler certains services (ex: base de données non accessible depuis Internet)
+ Segmenter logiquement une application (frontend, backend, base de données)

Lorsque Docker est installé, un réseau bridge par défaut (mais pas seulement) est automatiquement créé.

**Pour lister les réseaux disponibles :**
```bash
docker network ls
```
## Le pilote bridge (défaut)

C’est le pilote par défaut et le plus utilisé, particulièrement dans les environnements d’apprentissage et les projets locaux.

### Fonctionnement

+ Chaque conteneur reçoit une adresse IP privée interne
+ Les conteneurs sur le même réseau peuvent communiquer entre eux
+ Docker gère la traduction d’adresses (NAT)
+ L’exposition vers l’extérieur se fait via `-p` (*port mapping*)

C’est le pilote à utiliser pour :
+ Applications multi-conteneurs
+ Développement local
+ Architectures frontend / backend / base de données

**Pourquoi créer un bridge personnalisé ?**

Même si un réseau bridge par défaut existe, il est fortement recommandé de créer son propre réseau.

Cela permet :

+ Une meilleure isolation
+ Une résolution DNS automatique par nom de conteneur
+ Une meilleure organisation des projets

**Créer un réseau bridge :**
```bash
docker network create mon-reseau
```
Ou explicitement :
```bash
docker network create --driver bridge mon-reseau
```

**Lancer un conteneur sur un réseau :**
```bash
docker run -d --name api --network mon-reseau nginx
```
**Connexion après création :**
```bash
docker network connect mon-reseau mon-conteneur
```
**Inspecter un réseau :**
```bash
docker network inspect mon-reseau
```
**Supprimer un réseau :**
```bash
docker network rm mon-reseau
```

{{%notice style="tip" title="Les autres pilotes"%}}
Il existe d’autres types de réseaux Docker que nous n'allons pas étudier dans ce cours. Je les présente si jamais vous désirez creuser un peu plus le sujet :

+ **host :** le conteneur partage directement le réseau de l’hôte (pas d’isolation)
+ **none :** aucun réseau (isolement total)
+ **overlay :** communication entre conteneurs sur plusieurs machines (*Docker Swarm*)
+ **macvlan :** le conteneur obtient une IP du réseau local réel
Pour un cours d’introduction et la majorité des projets locaux, **bridge** est largement suffisant.

[Lien vers la documentation Docker](https://docs.docker.com/engine/network/)
{{%/notice%}}
