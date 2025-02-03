+++
title = 'Sécurité de VPC'
draft = false
weight = "213"
+++

### Groupe de sécurité (*Security Group* ou *SG*)

+ Pare-feu/couche de sécurité **au niveau d'une instance** (spécifiquement au niveau de l'interface/carte réseau).

+ Les groupes de sécurité ont des règles qui contrôlent le trafic d'instance entrant (*inbound*) et sortant (*outbound*).

+ Les groupes de sécurité par défaut **refusent tout trafic entrant** et **autorisent tout le trafic sortant**.

+ Les groupes de sécurité sont **avec état** (*stateful*) : On ne définit que le trafic entrant, le trafic sortant est toujours autorisé.

### Liste de contrôle d'accès réseau (*Network ACLs* ou *NACL*)

![NACL Logo](/420-414/images/2-reseau/2-25-nacl-logo.png)


+ Pare-feu/couche de sécurité qui **contrôle le trafic entrant** (*inbound*) et **sortant** (*outbound*) pour un ou plusieurs *subnet(s)* (**au niveau du *subnet***).

+ Les ACL réseau agissent **au niveau du sous-réseau**

+ Une ACL réseau comporte des **règles entrantes et sortantes distinctes**.

+ Les ACL réseau par défaut **autorisent tout le trafic IPv4 entre et sortant**.

+ Les ACL réseau sont **sans état** (*stateless*) : Il n'enregistre pas les requêtes. Il faut donc définir des règles pour le trafic entrant **ET** sortant du sous-réseau.

**Règles de l'ACL réseau par défaut :**
![NACL par défaut](/420-414/images/2-reseau/2-23-nacl-par-defaut.png)

<!--
+ **Exemple :** Si un *NACL* et un *SG* sont configurés pour autoriser le trafic web (HTTP), les requêtes HTTP seront autorisées dans le *subnet* et ensuite dans l'instance EC2. S'ils sont configurés pour refuser le trafic FTP, toute requête FTP sera bloquée.

 THINK ABOUT A BOUNCER 

![NACLs et SG exemple](/420-414/images/2-reseau/2-10.png)

![exemple](/420-414/images/2-reseau/2-13.png)

![NACLs et SG](/420-414/images/2-reseau/2-09.png)
-->

### Groupe de sécurité vs ACL réseau

![NACL vs SG](/420-414/images/2-reseau/2-24-nacl-vs-sg.png)