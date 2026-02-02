+++
title = 'Laboratoire'
draft = false
weight = "250"
+++

## Création d'un VPC et déploiement d'un serveur web

### Présentation et objectifs
Dans cet atelier, vous allez utiliser *Amazon Virtual Private Cloud (VPC)* pour créer votre propre *VPC* et y ajouter des composants pour obtenir un réseau personnalisé. Ensuite, vous allez créer un *groupe de sécurité*, configurer et personnaliser une instance *EC2* pour y exécuter un serveur web et lancer l'exécution de cette instance *EC2* dans un sous-réseau du *VPC*.

***Amazon Virtual Private Cloud (Amazon VPC)*** vous permet de lancer des ressources *Amazon Web Services (AWS)* dans un réseau virtuel que vous définissez. Ce réseau virtuel ressemble beaucoup à un réseau classique que vous utiliseriez dans votre propre centre de données (*data center*), avec en plus l'avantage d'utiliser l'infrastructure d'AWS.

À la fin de cet atelier, vous saurez :
+ Créer un VPC ;
+ Créer des sous-réseaux ;
+ Configurer un groupe de sécurité ;
+ Lancer une instance EC2 dans un VPC.
 

### Scénario
Dans cet atelier, vous allez créer l'infrastructure suivante :

![Architecture](/420-414/images/2-reseau/2-14-lab-architecture.png)
 

### Étape 1 : Création d'un VPC
Dans cette étape, vous allez utiliser la console *VPC* pour créer plusieurs ressources, notamment :
+ Un **VPC** ;
+ Une **passerelle Internet (IGW)**
+ Un **sous-réseau public** et un **sous-réseau privé** dans une **zone de disponibilité**, 
+ Deux **tables de routage**
+ Une **passerelle NAT**.


1. Dans la zone de recherche à droite de {{% icon icon="fa-solid fa-table-cells" %}} **Services**, recherchez et choisissez **VPC** pour ouvrir la console VPC.

2. Commencez la création d'un VPC :

    + En haut à droite de l'écran, vérifiez que la région est **Virginie du Nord (*us-east-1*)**. 
    + Choisissez le lien **Tableau de bord du VPC**, qui se trouve également dans la partie supérieure gauche de la console.
    + Choisissez ensuite {{% button style="orange" %}}Créer un VPC{{% /button %}}. 

3. Configurez les détails du VPC dans le volet *Paramètres VPC* à gauche :

    + Choisissez **VPC et plus encore**.
    + Sous **Génération automatique d'identifications de noms**, conservez l'option *Génération automatique* sélectionnée, mais remplacez la valeur project par `lab`.
    + Conservez le **bloc d'adresse CIDR IPv4** défini sur `10.0.0.0/16`.
    + Pour **Nombre de zones de disponibilité**, choisissez **1**.
    + Pour **Nombre de sous-réseaux publics**, conservez **1**
    + Pour **Nombre de sous-réseaux privés**, conservez **1**.
    + Développez la section **Personnaliser les blocs d'adresse CIDR des sous-réseaux**.
        + Remplacez **Public subnet CIDR block in us-east-1a** (Bloc d'adresse CIDR du sous-réseau public dans us-east-1a) par `10.0.0.0/24`.
        + Remplacez **Private subnet CIDR block in us-east-1a** (Bloc d'adresse CIDR du sous-réseau privé dans us-east-1a) par `10.0.1.0/24`.
        + Définissez **Passerelles NAT** sur **In 1 AZ** (Dans 1 AZ).
        + Définissez **Points de terminaison d'un VPC** sur **Aucun**.
        + Conservez les options ***Noms d'hôte DNS*** et ***Résolution DNS*** *activées*.

4. Dans le volet *Aperçu* à droite, confirmez les paramètres que vous avez configurés :
    + **VPC :** `lab-vpc`
    + **Sous-réseaux :**
        + us-east-1a
            + Nom du sous-réseau ***public*** : `lab-subnet-public1-us-east-1a`
            + Nom du sous-réseau ***privé*** : `lab-subnet-private1-us-east-1a`
    + **Tables de routage**
        + `lab-rtb-public`
        + `lab-rtb-private1-us-east-1a`
    + **Connexions réseau**
        + `lab-igw`
        + `lab-nat-public1-us-east-1a` 

5. En bas de l'écran, choisissez {{% button style="orange" %}}Créer un VPC{{% /button %}}.

    Les ressources VPC sont créées. L'activation de la passerelle NAT prend quelques minutes. 

    Attendez que toutes les ressources soient créées avant de passer à l'étape suivante.

6. Une fois l'opération terminée, choisissez {{% button style="orange" %}}Afficher le VPC{{% /button %}}.
  
    L'Assistant a mis en service un VPC avec un sous-réseau public et un sous-réseau privé dans une zone de disponibilité, avec des tables de routage pour chaque sous-réseau. Il a également créé une passerelle Internet et une passerelle NAT. 

    Pour afficher les paramètres de ces ressources, parcourez les liens de la console VPC qui affichent les détails des ressources. Par exemple, choisissez **Sous-réseaux** pour afficher les détails des sous-réseaux et choisissez **Tables de routage** pour afficher les détails des tables de routage. Le diagramme ci-dessous résume les ressources VPC que vous venez de créer et leur configuration :

![Etape 1](/420-414/images/2-reseau/2-15-lab-etape1.png)

#### Rappels et résumé 
+ Une *passerelle Internet (IGW)* est une *ressource VPC* qui autorise la communication entre les instances *EC2* de votre *VPC* et Internet. 
+ Le sous-réseau public `lab-subnet-public1-us-east-1a` possède le bloc d'adresses CIDR `10.0.0.0/24`, ce qui signifie qu'il contient toutes les adresses IP commençant par `10.0.0.x`. Ce sous-réseau est public car la table de routage qui lui est associée achemine le trafic réseau 0.0.0.0/0 vers la passerelle Internet.
+ Une *passerelle NAT* est une ressource VPC utilisée pour fournir une connectivité Internet aux instances EC2 exécutées dans les sous-réseaux privés du VPC sans que ces instances EC2 aient besoin d'une connexion directe à la passerelle Internet.
+ Le sous-réseau privé `lab-subnet-private1-us-east-1a` possède le bloc d'adresses CIDR `10.0.1.0/24`, ce qui signifie qu'il contient toutes les adresses IP commençant par `10.0.1.x`.

 
### Étape 2 : Création de sous-réseaux supplémentaires
Dans cette étape, vous allez créer deux sous-réseaux supplémentaires pour le *VPC* dans une **deuxième zone de disponibilité**. Il est utile d'avoir des sous-réseaux dans plusieurs zones de disponibilité d'un VPC pour déployer des solutions qui fournissent une *haute disponibilité*. 

Dans l'étape précédente, vous avez crée un *VPC*, mais vous pouvez encore le configurer davantage, par exemple en ajoutant des sous-réseaux supplémentaires.

1. Dans le volet de navigation gauche, sélectionnez **Sous-réseaux**.
    
    Tout d'abord, vous allez créer un deuxième sous-réseau *public*.

2. Choisissez {{% button style="orange" %}}Créer un sous-réseau{{% /button %}}, puis configurez les éléments suivants :
    + **ID de VPC :**  `lab-vpc` (sélectionnez-le dans le menu).
    + **Nom du sous-réseau :** `lab-subnet-public2`
    + **Zone de disponibilité :** Sélectionnez une zone de disponibilité différente de la première (par exemple, `us-east-1b`).
    + **IPv4 CIDR block** (Bloc d'adresse CIDR IPv4) : `10.0.2.0/24`
      
    Toutes les adresses IP du sous-réseau commenceront par `10.0.2.x`.

3. Sélectionnez {{% button style="orange" %}}Créer un sous-réseau{{% /button %}}

    Le deuxième sous-réseau *public* a été créé. Vous allez maintenant créer un deuxième sous-réseau *privé*.

4. Choisissez {{% button style="orange" %}}Créer un sous-réseau{{% /button %}}, puis configurez les éléments suivants :
    + **ID de VPC :** `lab-vpc`
    + **Nom du sous-réseau :** `lab-subnet-private2`
    + **Zone de disponibilité :** sélectionnez la même zone de disponibilité que dans **2.** (par exemple `us-east-1b`).
    + **IPv4 CIDR block** (Bloc d'adresse CIDR IPv4) : `10.0.3.0/24`
    
    Toutes les adresses IP du sous-réseau commenceront par `10.0.3.x`.

5. Sélectionnez {{% button style="orange" %}}Créer un sous-réseau{{% /button %}}
    
    Le deuxième sous-réseau *privé* a été créé. 
    
    Vous allez maintenant configurer ce nouveau sous-réseau *privé* pour router le trafic lié à Internet vers la passerelle NAT, afin que les ressources du deuxième sous-réseau *privé* puissent se connecter à Internet, tout en conservant les ressources privées. Pour ce faire, vous devez configurer une table de routage.

    Une *table de routage* contient un ensemble de règles, appelées *acheminements*, qui permettent de déterminer la direction du trafic réseau. Chaque sous-réseau d'un VPC doit être associé à une table de routage. Cette table de routage contrôle le routage pour le sous-réseau.

6. Dans le volet de navigation gauche, sélectionnez **Tables de routage**.

7. Sélectionnez la table de routage {{% icon icon="fa-regular fa-square-check" %}} **lab-rtb-private1-us-east-1a**.

7. Dans le volet inférieur, choisissez l'onglet **Routes**.

    Notez que l'option **Destination 0.0.0.0/0** est configurée sur **Cible nat-xxxxxxxx**. Cela signifie que le trafic destiné à Internet (0.0.0.0/0) sera envoyé à la passerelle NAT. La passerelle NAT transférera ensuite le trafic vers Internet.

    Cette table de routage est donc utilisée pour acheminer le trafic à partir de sous-réseaux privés. 

8. Sélectionnez l'onglet **Associations de sous-réseau**.

    Vous avez créé cette table de routage dans l'étape 1 lorsque vous avez choisi de créer un VPC et plusieurs ressources dans ce VPC. Cette action a également créé `lab-subnet-private-1` et associé ce sous-réseau à cette table de routage. 

    Maintenant que vous avez créé un autre sous-réseau privé, `lab-subnet-private-2`, vous allez également lui associer cette table de routage.
 

9. Dans le volet Associations de sous-réseau explicites, choisissez {{% button %}}Modifier les associations de sous-réseau{{% /button %}}.

10. Laissez `lab-subnet-private1-us-east-1a` sélectionné, mais sélectionnez également   {{% icon icon="fa-regular fa-square-check" %}} **lab-subnet-private2**. 

11. Sélectionnez {{% button %}}Enregistrer les associations{{% /button %}}.

    Vous allez maintenant configurer la table de routage utilisée par les sous-réseaux publics.

12. Sélectionnez la table de routage {{% icon icon="fa-regular fa-square-check" %}} **lab-rtb-public** (et désélectionnez tout autre sous-réseau).

13. Dans le volet inférieur, choisissez l'onglet **Routes**.

    Notez que l'option **Destination 0.0.0.0/0** est configurée sur Cible **igw-xxxxxxxx**, qui est une passerelle Internet. Cela signifie que le trafic lié à Internet sera envoyé à Internet via cette passerelle Internet.

    Vous allez maintenant associer cette table de routage au deuxième sous-réseau public que vous avez créé.

14. Sélectionnez l'onglet **Associations de sous-réseau**.

15. Dans la zone Associations de sous-réseau explicites, choisissez {{% button %}}Modifier les associations de sous-réseau{{% /button %}}.

16. Laissez `lab-subnet-public1-us-east-1a` sélectionné, mais sélectionnez également   {{% icon icon="fa-regular fa-square-check" %}} **lab-subnet-public2**.

 
17. Sélectionnez {{% button style="orange" %}}Enregistrer les associations{{% /button %}}.

Votre VPC dispose désormais de sous-réseaux publics et privés configurés dans deux zones de disponibilité. Les tables de routage que vous avez créées dans l'étape 1 ont également été mises à jour pour router le trafic réseau pour les deux nouveaux sous-réseaux.

![Etape 2](/420-414/images/2-reseau/2-16-lab-etape2.png)

 

#### Étape 3 : Création d'un groupe de sécurité
Dans cette étape, vous allez créer un *groupe de sécurité* qui agit comme un pare-feu virtuel. Lorsque vous démarrez une instance (VM), vous lui associez un ou plusieurs *groupes de sécurité*. Vous pouvez ajouter des règles à chaque groupe de sécurité pour autoriser le trafic vers ou depuis ses instances associées.

1. Dans le volet de navigation gauche, sélectionnez **Groupes de sécurité**.

2. Choisissez {{% button style="orange" %}}Créer un groupe de sécurité{{% /button %}}, puis configurez les paramètres suivants :
    + **Nom du groupe de sécurité :** `Web Security Group`
    + **Description :** `Enable HTTP access`
    + **VPC :** choisissez le symbole X pour supprimer le VPC actuellement sélectionné, puis choisissez `lab-vpc` dans la liste déroulante. 

3. Dans le volet **Règles entrantes**, choisissez {{% button %}}Ajouter une règle{{% /button %}}.

4. Configurez les paramètres suivants :
    + **Type :** *HTTP*
    + **Source :** *Anywhere-Ipv4*
    + **Description :** `Permit Web Requests`

5. Faites défiler l'affichage jusqu'au bas de la page, puis choisissez {{% button style="orange" %}}Créer un groupe de sécurité{{% /button %}}.

Vous utiliserez ce groupe de sécurité dans le cadre de la prochaine étape, lors du lancement d'une instance *Amazon EC2*.
 
### Étape 4 : Déploiement un serveur web
Dans cette étape, vous allez lancer une instance *Amazon EC2* dans le *VPC* configuré dans les étapes précédentes. Vous allez configurer l'instance pour qu'elle fonctionne en tant que serveur web.

1. Dans la zone de recherche, à droite de  {{% icon icon="fa-solid fa-table-cells" %}} **Services**, recherchez et choisissez **EC2** pour ouvrir la console EC2.

2. Dans le menu {{% button style="orange" %}}Lancer une instance{{% /button %}}, choisissez **Lancer l'instance**.

3. Nommez l'instance :
    + Attribuez-lui le nom `Web Server 1`.

      Lorsque vous nommez l'instance, AWS crée une identification et l'associe à l'instance. Une identification est une paire clé-valeur. La clé de cette paire est ****Nom**** et la valeur est le nom que vous saisissez pour votre instance EC2.

4. Choisissez une AMI à partir de laquelle créer l'instance :
    + Dans la liste des AMI *Quick Start* disponibles, conservez la sélection par défaut d'**Amazon Linux**. 

5. Conservez également la sélection par défaut de l'**AMI Amazon Linux 2023**.
    Le type d'*Amazon Machine Image (AMI)* que vous choisissez détermine le système d'exploitation qui sera exécuté sur l'instance EC2 que vous lancez.

6. Choisissez un *type d'instance* :
    + Dans le volet *Type d'instance*, conservez la valeur par défaut **t2.micro** sélectionnée.

      L'option *Type d'instance* définit les ressources matérielles affectées à l'instance.

7. Sélectionnez la paire de clés à associer à l'instance :

    + Dans le menu Nom de la paire de clés, sélectionnez **vockey**.

    La paire de clés `vockey` que vous avez sélectionnée vous permettra de vous connecter à cette instance via SSH après son lancement. Bien qu'il ne soit pas nécessaire d'exécuter cette opération dans ce laboratoire, vous devez toujours identifier une paire de clés existante, en créer une nouvelle ou choisir de continuer sans paire de clés lors du lancement d'une instance.

8. Configurez les paramètres réseau :
    + Dans la section *Paramètres réseau*, choisissez **Modifier**, puis configurez : 
        + **Réseau :** `lab-vpc` 
        + **Sous-réseau :** *lab-subnet-public2* (non privé !)
        + **Attribuer automatiquement l'adresse IP publique** : *Activer*

    + Vous allez ensuite configurer l'instance de manière à utiliser le *Groupe de sécurité web* que vous avez créé précédemment.
        + Sous Pare-feu (groupes de sécurité), choisissez  {{% icon icon="fa-regular fa-circle-dot" %}} **Sélectionner un groupe de sécurité existant**.
        + Pour **Groupes de sécurité courants**, sélectionnez  {{% icon icon="fa-regular fa-square-check" %}} **Groupe de sécurité web**.
        
          Ce groupe de sécurité permettra un accès HTTP à l'instance.

9. Dans la section *Configurer le stockage*, conservez les paramètres par défaut.

    **Remarque :** les paramètres par défaut indiquent que le *volume racine* de l'instance, qui hébergera le système d'exploitation invité *Amazon Linux* que vous avez spécifié précédemment, s'exécutera sur un disque dur SSD polyvalent (*gp3*) de 8 Gio. Vous pouvez également ajouter des volumes de stockage supplémentaires, mais cela n'est pas nécessaire dans cet atelier.

10. Configurez un script pour qu'il s'exécute sur l'instance à son lancement : 
    + Développez le volet **Détails avancés**.
    + Faites défiler la page jusqu'en bas, puis copiez et collez le code ci-dessous dans la zone **Données utilisateur** :
```bash
#!/bin/bash

# Install Apache Web Server and PHP
dnf install -y httpd wget php mariadb105-server

# Download Lab files
wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-ACCLFO-2/2-lab2-vpc/s3/lab-app.zip
unzip lab-app.zip -d /var/www/html/

# Turn on web server
chkconfig httpd on
service httpd start
```

Ce script s'exécutera avec des autorisations d'administrateur sur le système d'exploitation de l'instance. Il sera exécuté automatiquement lorsque l'instance sera lancée pour la première fois. Le script installe un serveur web, une base de données et des bibliothèques PHP, puis télécharge et installe une application web PHP sur le serveur web.

11. En bas du volet **Résumé**, à droite de l'écran, choisissez {{% button style="orange" %}}Lancer l'instance{{% /button %}}.

    Un message de réussite s'affiche.

12. Sélectionnez {{% button style="orange" %}}Afficher toutes les instances{{% /button %}}.

13. Attendez que **Web Server 1** affiche *2/2 checks passed* (2/2 contrôles réussis) dans la colonne **Contrôles des statuts**.

    Vous allez maintenant vous connecter au serveur web s'exécutant sur l'instance EC2.

14. Sélectionnez  {{% icon icon="fa-regular fa-square-check" %}} **Web Server 1**.

15. Copiez la valeur de **Public IPv4 DNS** (DNS IPv4 public) indiquée dans l'onglet **Détails** au bas de la page.

16. Ouvrez un nouvel onglet de navigateur web, collez la valeur **DNS public** et appuyez sur Entrée.

    Vous devriez alors voir une page web afficher le logo AWS et les valeurs de métadonnées d'instance.


Félicitation, vous venez de déployer votre première infrastructure réseau et votre premier serveur Web sur le Cloud ! L'architecture complète que vous avez déployée est la suivante :

![Architecture](/420-414/images/2-reseau/2-14-lab-architecture.png)


{{% notice style="info" title="Conseils"%}}
Pour vous assurer de maitriser les méthodes vues dans ce laboratoire, n'hésitez pas à le refaire **sans l'aide de ce guide** (la meilleure façon d'apprendre, c'est de répéter de façon autonome).
{{% /notice %}}