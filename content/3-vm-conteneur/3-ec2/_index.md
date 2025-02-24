+++
title = 'Amazon EC2'
draft = false
weight = "303"
+++

*Amazon Elastic Compute Cloud (Amazon EC2)* est un service AWS qui permet de créer et gérer des machines virtuelles (appelées instances EC2) dans le cloud AWS.  

### Création d'une VM EC2
Les points les plus importants à configurer lorsque vous voulez lancer une instance EC2 :

1. **AMI**
2. **Type d'instance**
3. **Paramètres réseau**
4. **Données utilisateur**
5. **Options de stockage**
5. **Groupe de sécurité**
6. **Paire de clés**

#### AMI
+ *Amazon Machine Image (AMI)* est un **modèle** (ou **image**) utilisé.e pour créer une instance EC2
+ Contient un système d'exploitation Windows ou Linux
+ Certains logiciels sont souvent préinstallés
+ Il est aussi possible de créer une AMI pour ensuite l'utiliser comme *template*. (comme un `.ova` ou un *snapshot*)

#### Type d'instance
+ Le type d'instance que vous choisissez dépend de vos besoins en :
    + Mémoire RAM
    + Puissance de traitement (CPU)
    + Espace disque et type de disque (stockage)
    + Performances réseau

+ Dénomination des types d'instances
![Types d'instance EC2](/420-414/images/3-vm-conteneur/3-04-ec2.png?width=22rem)
+ Exemple : `t3.large`
    + `t` correspond au nom de la famille
    + `3` correspond au numéro de génération
    + `large` correspond à la taille

![Catégories d'instance EC2](/420-414/images/3-vm-conteneur/3-05-ec2.png?width=40rem)


#### Paramètres réseau
+ Pour lancer une instance EC2, il faut spécifier le **VPC** et le **sous-réseau** où elle sera déployée.
+ L'instance doit-elle avoir une adresse IP publique (pour la rendre accessible sur Internet) ? Si oui, il faut aussi le spécifier lors de la création.

#### Données utilisateur (*user-data*)
+ Vous pouvez (optionnellement) spécifier un script de **données utilisateur** (*user data*) au lancement de l'instance 
+ Le script s'exécute au **démarrage initial de l'instance** (avec les privilèges `root`)

#### Options de stockage
+ Il est nécessaire de configurer le **volume racine** (emplacement d'installation du système d'exploitation)
+ Il est possible d'attacher des **volumes de stockage supplémentaires** (facultatif)
+ Pour chaque volume, il est possible indiquez la taille du disque (en Go), le type de volume (SSD, HDD), si le volume doit être supprimé lorsque l'instance est détruite, si vous souhaitez **chiffrer** le volume

#### Groupe de sécurité
+ **Rappel :** Un groupe de sécurité est un ensemble de règles de pare-feu qui contrôlent le trafic entrant de l'instance.

#### Paire de clés
+ Au lancement de l'instance, vous devez indiquer une paire de clés existante ou en créer une
+ Une paire de clés comprend : 
    + Une **clé publique** stockée par AWS
    + Un fichier de **clé privée** que vous stockez
+ Elle permet de sécuriser les connexions à une instance (via SSH pour les instances Linux, RDP pour les instances Windows)

### Interface de ligne de commande (CLI)
+ Les instances EC2 (ainsi que d'autres services AWS) peuvent également être crées par programmation.

*Exemple de commande (suppose que la paire de clé et le groupe de sécurité existent déjà) :*
```bash
aws ec2 run-instances /
    --image-id ami-1a2b3c4d /
    --count 1 /
    --instance-type c3.large /
    --key-name MyKeyPair /
    --security-groups MySecurityGroup
    --region us-east-1
``` 

### Cycle de vie

![Cycle de vie EC2](/420-414/images/3-vm-conteneur/3-06-ec2.png)

+ Le redémarrage d'une instance ne modifie aucune adresse IP ni aucun nom de domaine
+ Lorsqu'une instance est arrêtée puis redémarrée :
    + L'adresse IPv4 publique et le nom de domaine externe changent.
    + L'adresse IPv4 privée et le nom de domaine interne ne change pas.

### Métadonnées
+ Les métadonnées d'une instance sont des données relatives à une instance
+ Vous pouvez les visualiser lorsque vous êtes connecté à l'instance :
    + Dans un navigateur : `http://169.254.169.254/latest/meta-data/`
    + Dans un terminal : `curl http://169.254.169.254/latest/meta-data/`
+ Exemples de données : Adresse IP publique, privée, nom de domaine public, ID de l'instance, groupes de sécurité, région, zone de disponibilité.
+ Les données utilisateur sont aussi accessibles : `http://169.254.169.254/latest/user-data`