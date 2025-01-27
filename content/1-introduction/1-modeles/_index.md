+++
pre = '<b>1. </b>'
title = 'Modèles Infonuagiques'
draft = false
weight = "11"
+++

#### Les modèles "as-a-Service"

![as-a-Service](/420-414/images/1-introduction/1-03-iaas-paas-saas.png)

L'expression *"as-a-Service"* signifie généralement qu'un tiers se charge de vous fournir un service de cloud computing pour que vous puissiez vous concentrer sur des aspects plus importants (développement, relation client etc...).

#### Infrastructure sur-site (*On-Site*)
Une infrastructure informatique sur site est la solution qui met le plus de responsabilités entre les mains de l'utilisateur et du responsable. Lorsque l'intégralité du matériel et des logiciels se trouve sur site, vous et votre équipe devez gérer, mettre à jour et, si nécessaire, remplacer chaque composant vous-mêmes.Le cloud computing vous permet d'externaliser la gestion d'un, de plusieurs ou de tous les composants de votre infrastructure en vue de vous faire gagner du temps que vous pourrez consacrer à d'autres tâches.

#### PaaS

![PaaS](/420-414/images/1-introduction/1-04-paas.png?width=700px)

Avec le modèle **PaaS, ou *Platform-as-a-Service***, le fournisseur héberge le matériel et les logiciels sur sa propre infrastructure et met à disposition de l'utilisateur une plateforme via Internet, sous la forme d'une solution intégrée, d'une pile de solutions ou d'un service.

Destiné aux spécialistes du développement et de la programmation : Vous écrivez le code, créez et gérez vos applications, le tout sans avoir à vous préoccuper des mises à jour logicielles ou de la maintenance du matériel. L'environnement de développement et de déploiement vous est fourni. 

**Exemples :**
+ **Amazon Elastic Beanstalk (AWS) :** service d'orchestration pour le déploiement d'applications qui orchestre divers services AWS
+ **Google App Engine (GCP) :** Une plate-forme pour le développement et l'hébergement d'applications web dans des centres de données gérés par Google.

#### SaaS

En utilisant un produit SaaS (*Software as a Service*), tout est déjà géré pour vous : Application, Données, Durée d'exécution, Intergiciel, OS, Virtualisation, Serveurs, Stockage et le réseau.

![SaaS](/420-414/images/1-introduction/1-05-saas.png?width=700px)


**Exemples :**
+ **Zoom**
+ **Dropbox :**  Service de stockage de fichiers.
+ **Slack :** Service de communication par messagerie instantanée
+ **Mailchimp :** Service de marketing par courriel, 

#### IaaS

![IaaS](/420-414/images/1-introduction/1-06-iaas.png?width=700px)


Avec l'infrastructure en tant que service, en tant qu'utilisateur, vous êtes responsable de la gestion l'application, les données, le moteur d'exécution, l'intergiciel, et le système d'exploitation, tandis que le fournisseur de services gère la virtualisation, les serveurs, le stockage et le réseau.

**Exemples :**
+ **AWS**
+ **Google Cloud (GCP)**
+ **Microsoft Azure**

#### Modèles de déploiement

![Modèles de déploiement](/420-414/images/1-introduction/1-08-modele-deploiement.png?width=700px)


+ **Le modèle privé (*Private Cloud*):** Pour les organisations qui possèdent un réseau/architecture privé. Les ressources
(serveurs, bases de données etc...) sont toutes sur place (**on-premise**). Un nuage privé ne présente aucun des avantages du nuage
discutés plus haut, mais offre plus de sécurité à vos données (elles ne transitent pas par un espace public et ne sont pas partagées avec d'autres organisations)
+ **Le modèle public (*Public Cloud*):** L'infrastructure appartient à un fournisseur de service (*Cloud Service Provider* ou *CSP*) comme Amazon ou Google ou même Microsoft. Ils fournissent une infrastructure pour des particuliers. Il n'y a aucune responsabilité en matière de matériel (ils fournissent tout le matériel).
+ **Le modèle hybride (*Hybrid Cloud*) :** Une combinaison de cloud privé et de cloud public. les données sensibles sont généralement
stockées localement et se connectent à l'infrastructure infonuagique publique à l'aide de services comme un VPN.