+++
title = 'Passerelles'
draft = false
weight = "212"
+++
----------------
## Passerelle Internet (*Internet Gateway* ou *IGW*)

Une **Passerelle Internet (*Internet Gateway* ou *IGW*)** permet la communication entre les ressources d’un VPC et Internet.


**Définition AWS :** *Une passerelle Internet est un composant VPC redondant, hautement disponible et mis à l’échelle horizontalement*.

![IGW](/420-414/images/2-reseau/2-21-passerelle-internet.png)

### Points clés
+ Le VPC **par défaut** a déjà une passerelle internet **attachée**.
+ Indispensable pour les sous-réseaux publique.
+ **On ne peut attacher qu'un IGW par VPC**.

## Passerelle NAT

Une **NAT Gateway** permet aux instances situées dans un **sous-réseau privé** d’accéder à Internet **sans être accessibles depuis Internet**.

![Passerelle NAT](/420-414/images/2-reseau/2-22-passerelle-nat.png)

### Fonctionnement

+ Les instances privées initient la connexion.
+ Les connexions entrantes depuis Internet sont bloquées.

Ce mécanisme est essentiel pour :
+ les mises à jour système,
+ l’accès à des API externes,
+ la sécurité des instances privées.