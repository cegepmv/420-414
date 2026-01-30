+++
title = 'Virtual Private Cloud'
draft = false
weight = "211"
+++
-----------------------------------------

### Définitions

![Logo VPC](/420-414/images/2-reseau/2-16-vpc-logo.png?width=8rem)


**Définition simplifiée :** 
+ Un VPC (Virtual Private Cloud) est une section privée et logiquement isolée du cloud AWS dans laquelle vous pouvez déployer des ressources (instances EC2, bases de données, services, etc.).

Vous avez un contrôle total sur :
+ l’adressage IP,
+ le routage,
+ l’accès réseau,
+ les mécanismes de sécurité.



**Définition d'AWS :**
+ *Amazon Virtual Private Cloud (VPC)* permet de mettre en service une section **logiquement isolée** du cloud AWS où vous pouvez lancer des ressources dans un **réseau virtuel** que **vous** définissez. 

Amazon VPC permet notamment :
+ la sélection d’une plage d’adresses IP (CIDR),
+ la création de sous-réseaux,
+ la configuration des tables de routage,
+ l’utilisation de passerelles réseau,
+ la mise en place de plusieurs couches de sécurité.

<!-- 
![VPC-analogie](/420-414/images/2-reseau/2-01.png) 
-->

{{% notice style="info" title="Note"%}}
+ Lorsque vous créez un compte AWS, un VPC "par défaut" est créé pour vous.
+  Chaque VPC a une plage d'adresse définie. Chaque sous-réseau ou instance déployée dans le VPC aura une adresse IP incluse dans cette plage.
{{% /notice %}}

<!-- 
(toutes les maisons situées dans la même rue d'un quartier constitueraient un sous-réseau. les maisons représentent les ordinateurs) 
-->
### VPC et sous-réseaux

![VPC et sous-réseaux](/420-414/images/2-reseau/2-17-vpc-sous-reseaux.png)

#### VPC
+ Un VPC :
    + est logiquement isolé des autres VPC,
    + est dédié à un compte AWS,
    + appartient à une seule région AWS,
    + peut s’étendre sur plusieurs zones de disponibilité.

#### Sous-réseaux (Subnets)
Les sous-réseaux sont des subdivisions du VPC.
+ Ils correspondent à des plages d’adresses IP.
+ Chaque sous-réseau appartient à une seule zone de disponibilité.
+ Ils sont généralement classés comme :
    + sous-réseaux publics
    + sous-réseaux privés

La distinction public / privé dépend principalement de la **table de routage** associée au sous-réseau.


### Adressage IP

![Adressage IP dans un VPC](/420-414/images/2-reseau/2-18-adressage-ip.png?width=30rem)


Lors de la création d’un VPC, vous devez lui attribuer un **bloc CIDR IPv4 privé**.
#### Règles importantes
+ La plage d’adresses du VPC ne peut pas être modifiée après sa création.
+ Taille maximale du bloc IPv4 : /16
+ Taille minimale du bloc IPv4 : /28
+ Les blocs CIDR des sous-réseaux ne peuvent pas se chevaucher.
+ IPv6 est également pris en charge.


#### Adresses réservées

![Adresses IP réservées](/420-414/images/2-reseau/2-19-vpc-ip-reservees.png)


**Exemple :** 
+ Un VPC avec un bloc d'adresse CIDR IPv4 de `10.0.0.0/16` a **65 536** (2^16) adresses IP au total. 

+ Le VPC possède 4 sous-réseaux
    + `10.0.0.0/24`
    + `10.0.1.0/24`
    + `10.0.2.0/24`
    + `10.0.3.0/24`

+ **251** adresses IP sont disponibles par sous réseau (**2^8 - 5 adresses réservées**).

#### Types d'adresses IP publiques

**Adresse IP privées :**
+ Attribuées automatiquement à chaque instance dans un sous-réseau.
+ Incluses dans la plage CIDR du sous-réseau.
+ Utilisées pour la communication interne au VPC.


**Adresse IPv4 publique :**
+ Permettent l’accès direct depuis Internet.
+ Peuvent être :
    + attribuées automatiquement,
    + associées manuellement via une **Elastic IP**.

**Adresse IP *Elastic***
+ Adresse IPv4 publique statique.
+ Associée à un **compte AWS**.
+ Peut être remappée vers une autre instance à tout moment.


### Interface réseau Elastic
Une **Elastic Network Interface (ENI)** est une interface réseau virtuelle.

Elle peut être :
+ attachée à une instance,
+ détachée puis rattachée à une autre instance.

Ses attributs (adresse IP, groupes de sécurité) sont conservés lors du rattachement.

Chaque instance possède au minimum **une ENI par défaut**.

### Tables de routage et routes

![Route par défaut](/420-414/images/2-reseau/2-20-table-de-routage.png)


Une **table de routage** contient un ensemble de règles (routes) qui déterminent où le trafic réseau est dirigé.

Chaque route définit :
+ une **destination** (CIDR),
+ une **cible** (IGW, NAT Gateway, etc.).
+ Chaque sous-réseau doit être associé à **une table de routage**.
Par défaut, une route locale permet la communication interne au VPC.


{{% notice style="info" title="Note"%}}
+ Pensez une table de routage comme un **GPS** : Elle redirige les données vers la destination (adresse IP de destination). 
+ Votre VPC **par défaut** a déjà une table de routage **principale**.
{{% /notice %}}

<!--

### Passerelle Internet (*Internet Gateway* ou *IGW*)

![IGW](/420-414/images/2-reseau/2-05.png)

![IGW](/420-414/images/2-reseau/2-21-passerelle-internet.png)

+ **Définition simplifiée :** Une combinaison de matériel et de logiciel qui fournit à votre *VPC* une **route** vers le monde extérieur (c'est-à-dire l'Internet).

+ **Définition d'AWS :** "Une passerelle Internet est un composant VPC **redondant** et **hautement disponible**, mis à l'echelle horizontalement, qui permet la **communication entre les instances de votre VPC et Internet**. Elle n'impose donc aucun risque de disponibilité ni aucune contrainte de bande passante à votre trafic réseau.

{{% notice style="info" title="Note"%}}
+ Votre VPC **par défaut** a déjà une passerelle internet **attachée**.
+ **On ne peut attacher qu'un IGW par VPC**.
{{% /notice %}}

![IGW](/420-414/images/2-reseau/2-06.png)


![Table de routage exemple](/420-414/images/2-reseau/2-08.png)

 #### Sous-réseaux
+ **Définition simplifiée :** un *subnet* (abréviation de *subnetwork*) est une sous-section d'un réseau.
+ **Définition AWS :** Lorsque vous créez un VPC, il s'étend sur toutes les zones de disponibilité d'une région. Après avoir créé un VPC, **vous pouvez ajouter un ou plusieurs sous-réseaux dans chaque zone de disponibilité** disponible dans cette région. Chaque sous-réseau doit résider entièrement dans une zone de disponibilité et ne peut pas s'étendre à d'autres zones".

+ Nos services sont déployés (VMs, Bases de données etc...) **à l'intérieur de *subnets*** :

![Services dans un sous-réseau](/420-414/images/2-reseau/2-03.png)


{{% notice style="info" title="Note"%}}
+ Votre VPC **par défaut** a déjà un *subnet* par zone de disponibilité crées par défaut.
{{% /notice %}}

![Communication](/420-414/images/2-reseau/2-11.png)


#### Privé (*Private Subnet*) vs publique (*Public Subnet*)
![Subnet privé vs publique](/420-414/images/2-reseau/2-12.png) -->

<!-- ### Sécurité réseau

+ **Liste de contrôle d'accès (*Network ACLs* ou *NACL*) :** Un pare-feu/une couche de sécurité qui contrôle le trafic entrant (*inbound*) et sortant (*outbound*) pour un ou plusieurs *subnet* (**au niveau du *subnet***).

+ **Groupe de sécurité (*Security Group* ou *SG*) :** Un pare-feu/une couche de sécurité **au niveau d'une/d'un serveur**

+ **Exemple :** Si un *NACL* et un *SG* sont configurés pour autoriser le trafic web (HTTP), les requêtes HTTP seront autorisées dans le *subnet* et ensuite dans l'instance EC2. S'ils sont configurés pour refuser le trafic FTP, toute requête FTP sera bloquée.

![NACLs et SG](/420-414/images/2-reseau/2-09.png)

![NACLs et SG exemple](/420-414/images/2-reseau/2-10.png)

![exemple](/420-414/images/2-reseau/2-13.png) 
-->
