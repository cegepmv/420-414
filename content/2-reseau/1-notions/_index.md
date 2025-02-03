 +++
title = 'Notions'
draft = false
weight = "210"
+++
<!--
### VPC
+ **Définition simplifiée :** Un VPC (Virtual Private Cloud) est une sous-section privée d'AWS que vous contrôlez et dans laquelle vous pouvez placer des ressources AWS (telles que des instances EC2 et des bases de données). Vous avez un **contrôle total** sur l'accès aux ressources AWS que vous déployez dans votre VPC.

+ **Définition d'AWS :** "*Amazon Virtual Private Cloud (VPC)* vous permet de provisionner une section **logiquement isolée** du cloud AWS où vous pouvez lancer des ressources dans un **réseau virtuel** que **vous** définissez. **Vous avez un contrôle total sur votre environnement réseau virtuel**, y compris la sélection de votre propre plage d'adresses IP, la création de **sous-réseaux** et la configuration de **tables de routage** et de **passerelles réseau**."

![VPC-analogie](/420-414/images/2-reseau/2-01.png)

{{% notice style="info" title="Note"%}}
+ Lorsque vous créez un compte AWS, un VPC "par défaut" est créé pour vous.
+  Chaque VPC a une plage d'adresse définie. Chaque sous-réseau ou instance déployée dans le VPC aura une adresse IP incluse dans cette plage.

{{% /notice %}}


(toutes les maisons situées dans la même rue d'un quartier constitueraient un sous-réseau. les maisons représentent les ordinateurs) 


#### Laboratoire



### Passerelle Internet (*Internet Gateway* ou *IGW*)

![IGW](/420-414/images/2-reseau/2-05.png)


+ **Définition simplifiée :** Une combinaison de matériel et de logiciel qui fournit à votre *VPC* une **route** vers le monde extérieur (c'est-à-dire l'Internet).

+ **Définition d'AWS :** "Une passerelle Internet est un composant VPC **redondant** et **hautement disponible**, mis à l'echelle horizontalement, qui permet la **communication entre les instances de votre VPC et Internet**. Elle n'impose donc aucun risque de disponibilité ni aucune contrainte de bande passante à votre trafic réseau.

{{% notice style="info" title="Note"%}}
+ Votre VPC **par défaut** a déjà une passerelle internet **attachée**.
+ **On ne peut attacher qu'un IGW par VPC**.
{{% /notice %}}

![IGW](/420-414/images/2-reseau/2-06.png)


### Table de routage (*Routing Table*)
![Table de routage](/420-414/images/2-reseau/2-07.png)

+ **Définition d'AWS :** "Une table de routage contient un **ensemble de règles**, appelées **routes** ou **acheminements**, qui sont utilisées pour **déterminer où le trafic du réseau doit être dirigé**."

{{% notice style="info" title="Note"%}}
+ Pensez une table de routage comme un **GPS** : Elle redirige la "data" vers la destination. 
+ Votre VPC **par défaut** a déjà une table de routage **principale**.
{{% /notice %}}

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
<!-- THINK ABOUT A BOUNCER

![NACLs et SG exemple](/420-414/images/2-reseau/2-10.png)

![exemple](/420-414/images/2-reseau/2-13.png) -->
