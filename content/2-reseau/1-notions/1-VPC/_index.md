+++
title = 'Virtual Private Cloud'
draft = false
weight = "211"
+++
-----------------------------------------

### Définitions

![Logo VPC](/420-414/images/2-reseau/2-16-vpc-logo.png?width=8rem)


**Définition simplifiée :** 
+ Un VPC (Virtual Private Cloud) est une sous-section privée d'AWS que vous contrôlez et dans laquelle vous pouvez placer des ressources AWS (telles que des instances EC2 et des bases de données). Vous avez un **contrôle total** sur l'accès aux ressources AWS que vous déployez dans votre VPC.

**Définition d'AWS :**
+ *Amazon Virtual Private Cloud (VPC)* permet de mettre en service une section **logiquement isolée** du cloud AWS où vous pouvez lancer des ressources dans un **réseau virtuel** que **vous** définissez. 

+ Amazon VPC vous permet de **contrôler vos ressources de réseau virtuel**, notamment : 
    + la sélection d'une plage d'adresses IP
    + la création de **sous-réseaux**
    + la configuration de **tables de routage** et de **passerelles réseau**.

+ Vous permet de **personnaliser la configuration réseau** de votre VPC.

+ Vous permet d'utiliser **plusieurs couches de sécurité**.

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


+ **VPC :**
    + **Logiquement isolées** des autres VPC.
    + **Dédiés** à votre compte AWS.
    + Appartiennent à **une seule région AWS** et peuvent s'étendre sur **plusieurs zones de disponibilité**.

+ **Sous-réseaux :**
    + **Plages d'adresses IP** qui divient un VPC.
    + Appartiennent à **une seule zone de disponibilité**.
    + Classés comme **publics** ou **privé**


### Adressage IP

![Adressage IP dans un VPC](/420-414/images/2-reseau/2-18-adressage-ip.png?width=30rem)


+ Lorsque vous créez un VPC, vous l'affectez à un **bloc d'adresse CIDR** IPv4 (plage d'adresses IPv4 **privées**).

+ Une fois que vous avez crée le VPC, nous **ne pouvez plus modifier la plage d'adresses**.

+ La **plus grande** taille de bloc d'adresse CIDR IPv4 est **/16**.

+ La **plus petite** taille de bloc d'adresse CIDR IPv4 est **/28**.

+ IPv6 est également pris en charge.

+ Les blocs d'adresses CIDR des sous-réseaux **ne peuvent pas se chevaucher**.


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
+ On attribue une adresse IP privée à ahaque machine déployée dans un sous-réseau. Cette adresse IP est inclue dans la plage d'adresses du sous-réseau.

**Adresse IPv4 publique :**
+ Attribuée manuellement via une adresse IP *Elastic*
+ Attribuée automatiquement

**Adresse IP *Elastic***
+ Associée à un compte AWS
+ Peut être allouée et remappée à tout moment

### Interface réseau Elastic
+ Une interface réseau Elastic est une **interface réseau virtuelle** que vous pouvez :
    + Attacher à une instance
    + Détacher de l'instance et attacher à une autre instance pour rediriger le trafic réseau

+ Ses attributs sont conservés lorsqu'elle est rattachée à une nouvelle instance.

+ Chaque instanbce de votre VPC possède une interface réseau par défaut à laquelle est attribuée une adresse IPv4 à partir de la plage d'adresses IPv4 de votre VPC.

### Tables de routage et routes

![Route par défaut](/420-414/images/2-reseau/2-20-table-de-routage.png)


+ Une **table de routage** contient un ensemble de règles (ou **routes**) que vous pouvez configurer pour **déterminer où le trafic réseau doit être dirigé** depuis votre sous-réseau.

+ Chaque route spécifie une destination et une cible.

+ Par défaut, chaque table de routage contient la route locale pour la communication au sein du VPC.

+ Chaque sous-réseau **doit être associé à une table de routage** (au plus une).

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
