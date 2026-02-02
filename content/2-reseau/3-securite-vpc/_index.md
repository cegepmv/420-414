+++
title = 'Sécurité de VPC'
draft = false
weight = "213"
+++

AWS propose plusieurs couches de sécurité réseau.

## Groupe de sécurité (*Security Group/SG*)

+ Pare-feu/couche de sécurité **au niveau d'une instance** (spécifiquement au niveau de l'ENI).

+ Les groupes de sécurité ont des règles qui contrôlent le trafic d'instance **entrant** (*inbound*) et **sortant** (*outbound*).

+ Par défaut: 
    + tout le **trafic entrant est refusé**
    + tout le **trafic sortant est autorisé**.

### Caractéristique clé
+ Les groupes de sécurité sont **avec état** (*stateful*) : si le trafic entrant est autorisé, la réponse sortante l’est automatiquement.

## Liste de contrôle d'accès réseau (*Network ACLs* ou *NACL*)

![NACL Logo](/420-414/images/2-reseau/2-25-nacl-logo.png)


+ Pare-feu **au niveau du sous-réseau**
+ Contrôle le trafic entrant (*inbound*) **ET** sortant (*outbound*).
+ Une ACL réseau comporte des **règles entrantes et sortantes distinctes**.
+ Les ACL réseau par défaut **autorisent tout le trafic IPv4 entre et sortant**.
+ Les ACL réseau sont **sans état** (*stateless*) : Il n'enregistre pas les requêtes. Il faut donc définir des règles pour le trafic entrant **ET** sortant du sous-réseau.

### Règles d'un NACL par défaut
![NACL par défaut](/420-414/images/2-reseau/2-23-nacl-par-defaut.png)

<!--
+ **Exemple :** Si un *NACL* et un *SG* sont configurés pour autoriser le trafic web (HTTP), les requêtes HTTP seront autorisées dans le *subnet* et ensuite dans l'instance EC2. S'ils sont configurés pour refuser le trafic FTP, toute requête FTP sera bloquée.

 THINK ABOUT A BOUNCER 

![NACLs et SG exemple](/420-414/images/2-reseau/2-10.png)

![exemple](/420-414/images/2-reseau/2-13.png)

![NACLs et SG](/420-414/images/2-reseau/2-09.png)
-->

## SG vs NACL

![NACL vs SG](/420-414/images/2-reseau/2-24-nacl-vs-sg.png)