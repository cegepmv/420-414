+++
title = 'Laboratoire 2'
draft = false
weight = "420"
+++
--------------

Ce laboratoire détaille le déploiement d'un *Load Balancer* (ELB) pour assurer l'équilibrage des charges et la mise à l'échelle automatique d'instances EC2. Pour atteindre ces objectifs, nous allons explorer deux services : 

1. **Elastic Load Balancing (ELB) -** Ce service permet de répartir la charge du trafic entrant entre plusieurs instances EC2.
2. **Auto Scaling -** Ce service permet d'augmenter ou de diminuer automatiquement le nombre d'instances EC2 selon des conditions que l'on définit (pourcentage d'utilisation de CPU, de RAM, etc...)

![Architecture Laboratoire](../images/4-06.png)

À la fin de cet atelier, vous serez en mesure de :

+ Créer une *Amazon Machine Image (AMI)* à partir d'une instance en cours d'exécution ;
+ Créer un *Load Balancer* ;
+ Créer un *Launch Template* et un *Auto Scaling Group* ;
+ Mettre automatiquement à l'échelle de nouvelles instances.

## 0 - Création d'un VPC
Dans cette étape, nous allons créer un VPC pour y déployer nos services. Les spécifications du VPC :
+ **Nom du VPC :** `lab-elb-vpc`
+ **CIDR du VPC :** `10.0.0.0/16`
+ Sous-réseau 1 (public)
  + **Nom:** `lab-elb-subnet-public1`
  + **CIDR:** `10.0.1.0/24`
+ Sous-réseau 2 (privé)
  + **Nom:** `lab-elb-subnet-private1`
  + **CIDR:** `10.0.1.0/24`
+ Sous-réseau 3 (public)
  + **Nom:** `lab-elb-subnet-public2`
  + **CIDR:** `10.0.2.0/24`
+ Sous-réseau 4 (privé)
  + **Nom:** `lab-elb-subnet-private2`
  + **CIDR:** `10.0.3.0/24`
+ Internet Gateway (`lab-elb-igw`)
+ NAT Gateway (`lab-elb-nat`)

## 1 - Lancement d'une instance EC2
Créez une instance EC2 sur le premier sous-réseau public avec les spécifications suivantes: 
+ **Nom:** `PokedexInstance`
+ **AMI:** `Ubuntu 24.04 LTS`
+ **Type:** `t3.micro`
+ **Clé:** Crééez une nouvelle clé `pokedex-key` 
+ **VPC:** `lab-elb-vpc`
+ **Subnet-** `lab-elb-subnet-public1`
+ **Security Group-** Créez un nouveau groupe de sécurité, nommez-le `pokedex-sg` et autorisez `SSH` et `HTTP` (anywhere)
+ Activez l'assignation d'une IP publique

Dans la section *user-data*, insérez le code ci-dessous : 
```bash
#!/bin/bash

sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)

# Ajouter la clé GPG Docker officielle:
sudo apt update
sudo apt install -y ca-certificates curl 
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Ajouter le dépôt aux sources de apt:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# Mise à jour de la BD locales des paquets
sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run -p 80:80 -d --restart always manareale/2289804-pokedex:1.0
```

## 2 - Création d'une AMI
Dans cette étape, nous allons créer une AMI (*Amazon Machine Image*) à partir de l'instance de l'étape précédente. Dans la console EC2, sélectionnez l'instance et vérifiez qu'elle est en cours d'exécution. Attendez que *Contrôles des statuts*  affiche *3/3 checks passed*. 

Ensuite, dans le menu *Actions* , choisissez *Image et modèles* > *Créer une image*, puis configurez l'AMI avec les informations suivantes :
  + **Nom de l'image :** `PokedexAMI`
  + **Description de l'image :** AMI for Pokedex App

Nous utiliserons cette AMI plus tard lors du lancement de l'*Auto Scaling Group*.

## 3 - Création d'un *Load Balancer*
Nous allons d'abord créer un *Target Group*, puis un *Load Balancer* qui va équilibrer le trafic sur plusieurs instances EC2 (créées à partir de l'AMI de l'étape 2).

Dans le volet de navigation gauche de la console EC2, sélectionnez *Groupes cibles* (*Target Groups*).

{{%notice title=" " style="tip"%}}
Les *Target Groups* définissent où envoyer le trafic provenant du *Load Balancer*. Un *Load Balancer* peut envoyer du trafic vers plusieurs *Target Groups* en fonction de l'URL de la demande entrante (comme avec Traefik dans le laboratoire précédent). Dans notre cas, nous utiliserons qu'un seul *Target Group*.
{{%/notice%}}

1. Sélectionnez *Créer un groupe cible*.
    + **Type de cible-** *Instances*
    + **Nom du groupe cible-** `PokedexGroup`
    + **VPC-** `lab-elb-vpc`. 

Après avoir cliqué sur *Suivant*, l'écran *Enregistrer les cibles* apparaît. Nous n'avons pas encore d'instances Pokedex à cibler pour le moment, vous pouvez donc passer cette étape. Confirmez les paramètres et choisissez *Créer un groupe cible*.

{{%notice title=" " style="info"%}}
Les cibles (*targets*) sont les instances qui répondront aux demandes de l'équilibreur de charge.
{{%/notice%}}

2. Dans le volet de navigation gauche, sélectionnez *Équilibreurs de charge* (*Load Balancers*) puis cliquez sur *Créer un équilibreur de charge*.

Plusieurs types de *Load Balancers* s'affichent. Nous allons utiliser le type *Application Load Balancer* qui opère au niveau de la couche application (couche 7). Pour plus d'informations sur les types de Load Balancers, consultez la documentation AWS [Comparaison des équilibreurs de charge](https://aws.amazon.com/fr/elasticloadbalancing/features/#compare).

3. Sous *Application Load Balancer*, choisissez Créer.
  + **Nom de l'équilibreur de charge:** `PokedexALB`.
  + **Section *Mappage réseau* :** choisissez le VPC crée dans la première étape (`lab-elb-vpc`).

Vous devez à présent indiquer quels sous-réseaux doivent être utilisés par l'équilibreur de charge. L'équilibreur de charge étant accessible depuis Internet, vous allez sélectionner les deux sous-réseaux publics du VPC créé à l'étape 1 (`lab-elb-subnet-public1` et `lab-elb-subnet-public2`)

<!-- Choisissez la première zone de disponibilité affichée, puis sélectionnez Public Subnet 1 (Sous-réseau public 1) dans le menu déroulant Sous-réseau qui s'affiche en dessous.

Choisissez la deuxième zone de disponibilité affichée, puis sélectionnez Public Subnet 2 (Sous-réseau public 2) dans le menu déroulant Sous-réseau qui s'affiche en dessous. -->

4. **Groupes de sécurité :** le groupe de sécurité crée lors de la création de l'instance EC2 (`pokedex-sg`)
5. Pour la ligne *Listener HTTP:80*, définissez le transfert vers `PokedexGroup` comme action par défaut.
6. Faites défiler l'écran jusqu'au bas de la page et choisissez Créer un équilibreur de charge.
 
## 4 - Création d'un *Launch Template* et d'un *Auto Scaling Group*
Dans cette étape, nous allons créer un *Launch Templace* et un *Auto Scaling Group*. Un *Launch Templace* est un modèle utilisé par un *Auto Scaling Group* pour lancer des instances EC2. Lorsque vous créez un *Launch Template*, vous spécifiez des informations sur les instances à créer telles que l'AMI, le type d'instance, une paire de clés et un groupe de sécurité.

1. Dans le volet de navigation gauche, choisissez *Modèles de lancement* puis cliquez sur *Créer un modèle de lancement*.
2. Configurez les paramètres du *Launch Template* :
  + **Nom du modèle de lancement :** `PokedexTemplate`
  + Sous *Conseils Auto Scaling*, sélectionnez *Fournir des instructions pour vous aider à configurer un modèle que vous pouvez utiliser avec EC2 Auto Scaling.* (*Provide guidance to help me set up a template that I can use with EC2 Auto Scaling*).
  + Dans *Application and OS Images (Amazon Machine Image)*, choisissez *Mes AMI*, puis sélectionnez choisissez `PokedexAMI` (AMI créé précédemment)
  + **Type d'instance :** `t2.micro`
  + **Paire de clés :** `pokedex-key`
  + **Groupes de sécurité :** `pokedex-sg` (créé dans les étapes précédentes)
  + Dans la section *Détails avancés*, activer *Détails de surveillance de CloudWatch*. cela permet à *Auto Scaling* de réagir rapidement aux changements d'utilisation des ressources.

3. Confirmez les options puis créez le *Launch Template*.

Ensuite, nous devons créer un *Auto Scaling Group* qui utilise ce *Launch Template* :

1. Dans la section *Modèles de lancement*, sélectionnez le *Launch Template* nouvellement créé (`PokedexTemplate`).
2. Dans le menu *Actions*, choisissez *Créer un groupe Auto Scaling*.

  + **Étape 1 -** *Choisir le modèle de lancement ou la configuration* :
    + **Nom du groupe *Auto Scaling*:** `PokedexAutoScalingGroup`
    + **Modèle de lancement :** vérifiez que le modèle `PokedexTemplate` que vous venez de créer est sélectionné.
  + **Étape 2 -** *Choisir les options de lancement d'instance* :
    + **VPC :** `lab-elb-vpc` (VPC de l'atelier).
    + **Zones de disponibilité et sous-réseaux :** `lab-subnet-private1` et `lab-subnet-private2`.
  + **Étape 3 -** *Intégration avec d’autres services* :
    + Sélectionnez *Attacher à un équilibreur de charge existant*.
    + **Groupes cibles d'équilibreur de charge existants :** `PokedexGroup`.
    + Dans le volet *Surveillances de l'état*, sélectionnez *Activer les surveillances de l'état Elastic Load Balancing*. Des métriques sont alors capturées par intervalles de 300 secondes, ce qui permet à *Auto Scaling* de réagir rapidement en cas d'évolution dans les modèles d'utilisation. 
  + **Étape 4 -** *Configurer la taille du groupe et les politiques de mise à l'échelle* :
    + **Taille du groupe :** 
      + **Capacité souhaitée :** 2
      + **Capacité minimale :** 2
      + **Capacité maximale :** 4
{{%notice style="tip" title=" "%}}
Cela permet à *Auto Scaling* d'ajouter/de supprimer automatiquement des instances de sorte qu'il y ait toujours entre 2 et 4 instances en cours d'exécution.
{{%/notice%}}

    + *Mise à l'échelle automatique :* sélectionnez *Politique de suivi des objectifs et d'échelonnement*, puis configurez :
      + **Nom de politique de mise à l'échelle :** `PokedexScalingPolicy`
      + **Type de métrique :** Utilisation moyenne du processeur
      + **Valeur cible :** 60
{{%notice style="tip" title=" "%}}
*Auto Scaling* a ici la consigne de maintenir une utilisation moyenne du CPU de 60 % dans toutes les instances. Il ajoutera ou supprimera des instances automatiquement si la capacité est atteinte.
{{%/notice%}}
    + Dans le volet *Paramètres supplémentaires*, cochez *Activer la collecte des métriques de groupe dans CloudWatch*.
  + **Étape 5 -** *Ajouter des notifications* :
    + *Auto Scaling* peut envoyer une notification lorsqu'une mise à l'échelle se produit. Dans notre cas, nous n'allons configurer cette option.
  + **Étape 6 -** *Ajouter des identifications* :
    + Les identifications appliquées à l'*Auto Scaling Group* sont automatiquement propagées aux instances lancées.
    + Choisissez *Ajouter une identification*, puis configurez les paramètres suivants :
      + Clé : `Name`
      + Valeur : `PokedexInstance`
    + **Étape 7 -** *Vérification* : Passez en revue les détails de votre *Auto Scaling Group*, puis créez-le

{{%notice style="tip" titre=" "%}}
L' *Auto Scaling Group* va d'abord afficher un nombre d'instances égal à zéro, mais les nouvelles instances seront lancées de manière à atteindre le nombre souhaité de deux.
{{%/notice%}}

## 4 - Vérification du fonctionnement de l'équilibrage de charge
Dans cette étape, nous allons  vérifier le bon fonctionnement de l'équilibrage de charge.
1. Dans le volet de navigation gauche, choisissez *Instances*. Vous devez voir deux nouvelles instances nommées `PokedexInstance`. Celles-ci ont été lancées par *Auto Scaling*.
2. Dans le volet de navigation gauche, sélectionnez *Groupes cibles*, puis *LabGroup* et allez à l'onglet *Cibles*.
  + Deux instances cibles nommées `PokedexInstance` doivent être répertoriées dans le groupe cible.
  + Attendez que le paramètre *Statut* des deux instances prenne la valeur sain (*healthy*). 

{{%notice title="Remarque" style="tip"%}}
Sain indique qu'une instance a réussi le test de surveillance de l'état de l'équilibreur de charge. Cela signifie que ce dernier enverra du trafic à l'instance en question.
{{%/notice%}}

Vous pouvez désormais accéder à l'*Auto Scaling Group* via le *Load Balancer*.

3. Dans le volet de navigation gauche, cliquez sur *Équilibreurs de charge*, puis sélectionnez l'équilibreur de charge `PokedexALB`. Dans le l'onglet *Détails*, copiez le nom DNS de l'équilibreur de charge puis ouvrez un nouvel onglet de navigateur web et collez-le.

L'application devrait apparaître dans votre navigateur. Cela indique que l'équilibreur de charge a reçu la demande, l'a envoyée à l'une des instances EC2, avant de retourner le résultat.