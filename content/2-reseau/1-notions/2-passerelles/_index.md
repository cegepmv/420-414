+++
title = 'Passerelles'
draft = false
weight = "212"
+++
----------------
### Passerelle Internet (*Internet Gateway* ou *IGW*)

<!-- ![IGW](/420-414/images/2-reseau/2-05.png) -->



+ Une **Internet Gateway** permet la communication entre les ressources d’un VPC et Internet.

+ **Définition AWS :** *Une passerelle Internet est un composant VPC redondant, hautement disponible et mis à l’échelle horizontalement*.

![IGW](/420-414/images/2-reseau/2-21-passerelle-internet.png)

{{% notice style="info" title="Note"%}}
+ Votre VPC **par défaut** a déjà une passerelle internet **attachée**.
+ **On ne peut attacher qu'un IGW par VPC**.
{{% /notice %}}

### Passerelle NAT

Une **NAT Gateway** permet aux instances situées dans un **sous-réseau privé** d’accéder à Internet **sans être accessibles depuis Internet**.

#### Fonctionnement

+ Les instances privées initient la connexion.
+ Les connexions entrantes depuis Internet sont bloquées.

Ce mécanisme est essentiel pour :
+ les mises à jour système,
+ l’accès à des API externes,
+ la sécurité des instances privées.


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