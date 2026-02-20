+++
title = 'Amazon EC2'
draft = false
weight = "310"
+++
----------------
*Amazon Elastic Compute Cloud* (EC2) est le service AWS permettant de **créer et gérer des machines virtuelles dans le cloud AWS**.

Une machine virtuelle EC2 est appelée **instance**.

## Création d’une instance EC2

Lors du lancement d’une instance, plusieurs paramètres essentiels doivent être configurés.

### AMI (*Amazon Machine Image*)

Une AMI est un **modèle d’image système** utilisé pour créer une instance.

Elle contient :

+ Un système d’exploitation (Linux ou Windows)
+ Des logiciels préinstallés (optionnel)

{{%notice style="info" title="Note"%}}
Il est possible de créer sa propre AMI afin de réutiliser une configuration standardisée.
{{%/notice%}}


### Type d’instance

Le type d’instance définit la puissance de la machine virtuelle.

**Critères principaux :**
+ Mémoire (RAM)
+ CPU
+ Performance réseau
+ Capacité et type de stockage

**Exemple :** `t3.large`
+ t → famille
+ 3 → génération
+ large → taille


### Paramètres réseau

Il faut spécifier :
+ Le VPC
+ Le sous-réseau
+ L’attribution d’une adresse IP publique (si nécessaire)

### Données utilisateur (*User Data*)

Il est possible d’ajouter un script exécuté au **premier démarrage** de l’instance.

Utilisation typique :
+ Installation automatique de logiciels
+ Configuration initiale
+ Déploiement d’une application

### Options de stockage

Chaque instance possède :
+ Un **volume racine** (OS)

Il est possible d’ajouter :
+ Des volumes supplémentaires
+ Du chiffrement
+ Une configuration de suppression automatique

### Groupe de sécurité

**Rappel:** Un groupe de sécurité agit comme un pare-feu virtuel.

### Paire de clés

Permet l’authentification sécurisée :

+ Clé publique stockée par AWS
+ Clé privée conservée par l’utilisateur

Utilisée pour :
+ SSH (Linux)
+ RDP (Windows)

### Création via AWS CLI

Les instances EC2 peuvent être créées par ligne de commande.

Exemple simplifié :
```bash
aws ec2 run-instances \
  --image-id ami-xxxxxxxx \
  --count 1 \
  --instance-type t3.micro \
  --key-name MyKeyPair \
  --security-groups MySecurityGroup \
  --region us-east-1
```

### Cycle de vie d’une instance

États principaux :
+ Pending
+ Running
+ Stopping
+ Stopped
+ Terminated

**Important :**

+ Un redémarrage ne change pas les adresses IP.
+ Un arrêt puis redémarrage change l’IP publique.
+ L’IP privée reste identique.

### Métadonnées d’instance (*meta-data*)

Chaque instance EC2 possède des métadonnées accessibles localement.

Adresse :
```bash
http://169.254.169.254/latest/meta-data/
```
Permet d’obtenir :
+ ID de l’instance
+ Adresse IP privée
+ Adresse IP publique
+ Zone de disponibilité
+ Groupes de sécurité

Les données utilisateur sont accessibles via :
```bash
http://169.254.169.254/latest/user-data
```