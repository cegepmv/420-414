+++
title = 'Passerelles'
draft = false
weight = "212"
+++
----------------
### Passerelle Internet (*Internet Gateway* ou *IGW*)

<!-- ![IGW](/420-414/images/2-reseau/2-05.png) -->

**Définition simplifiée** 
+ Une combinaison de matériel et de logiciel qui fournit à votre *VPC* une **route** vers le monde extérieur (c'est-à-dire l'Internet).

**Définition AWS** 
+ *"Une passerelle Internet est un composant VPC **redondant** et **hautement disponible**, mis à l'echelle horizontalement, qui permet la **communication entre les instances de votre VPC et Internet**. Elle n'impose donc aucun risque de disponibilité ni aucune contrainte de bande passante à votre trafic réseau.*

![IGW](/420-414/images/2-reseau/2-21-passerelle-internet.png)

{{% notice style="info" title="Note"%}}
+ Votre VPC **par défaut** a déjà une passerelle internet **attachée**.
+ **On ne peut attacher qu'un IGW par VPC**.
{{% /notice %}}

### Passerelle NAT


**Définition AWS**
+ *"Une passerelle NAT est un service de traduction d'adresses réseau (NAT). Vous pouvez utiliser une passerelle NAT afin que les instances d'un **sous-réseau privé** puissent se **connecter à des services en dehors de votre VPC** (sur Internet), mais que les **services externes ne puissent pas initier une connexion** avec ces instances."*

![Passerelle NAT](/420-414/images/2-reseau/2-22-passerelle-nat.png)

<!--
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
![Subnet privé vs publique](/420-414/images/2-reseau/2-12.png) 

### Sécurité réseau

+ **Liste de contrôle d'accès (*Network ACLs* ou *NACL*) :** Un pare-feu/une couche de sécurité qui contrôle le trafic entrant (*inbound*) et sortant (*outbound*) pour un ou plusieurs *subnet* (**au niveau du *subnet***).

+ **Groupe de sécurité (*Security Group* ou *SG*) :** Un pare-feu/une couche de sécurité **au niveau d'une/d'un serveur**

+ **Exemple :** Si un *NACL* et un *SG* sont configurés pour autoriser le trafic web (HTTP), les requêtes HTTP seront autorisées dans le *subnet* et ensuite dans l'instance EC2. S'ils sont configurés pour refuser le trafic FTP, toute requête FTP sera bloquée.

![NACLs et SG](/420-414/images/2-reseau/2-09.png)
THINK ABOUT A BOUNCER

![NACLs et SG exemple](/420-414/images/2-reseau/2-10.png)

![exemple](/420-414/images/2-reseau/2-13.png)
-->