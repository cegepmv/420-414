+++
pre = '<b>2. </b>'
title = 'Infrastructure AWS'
draft = false
weight = "120"
+++

Amazon Web Services (AWS) repose sur l’une des infrastructures informatiques les plus vastes et les plus avancées au monde. Des centres de données sont déployés aux quatre coins du globe afin d’offrir des services performants, résilients et hautement disponibles.
AWS organise son infrastructure selon une **séparation logique et physique bien définie**, ce qui permet de limiter l’impact des pannes, d’assurer la redondance des données et de garantir une continuité de service optimale.

## Infrastructure AWS : vue d’ensemble
L’infrastructure mondiale d’AWS est structurée en plusieurs niveaux :
+ Régions
+ Zones de disponibilité (Availability Zones)
+ Centres de données
+ Edge Locations

Cette organisation hiérarchique permet aux architectes et ingénieurs cloud de concevoir des systèmes tolérants aux pannes et capables de s’adapter à une échelle mondiale.



### Les régions AWS
Une **région AWS** correspond à une zone géographique distincte (par exemple : Canada Central, Europe de l’Ouest, Asie-Pacifique).

**Caractéristiques des régions**
+ Vous **contrôlez la réplication des données** entre les régions.
+ La communication entre les régions s’effectue via le **réseau privé mondial d’AWS**.
+ Chaque région est conçue pour offrir une **redondance interne** et une connectivité complète avec l’infrastructure AWS.
+ Les régions sont **isolées les unes des autres**, ce qui permet de répondre à des exigences de conformité, de latence ou de souveraineté des données.

Une région AWS est composée d’au minimum **deux zones de disponibilité**, mais la plupart en comptent trois ou plus.

### Zones de disponibilité (*Availability Zones*)
Les **zones de disponibilité** (*AZs*) sont des partitions totalement isolées à l’intérieur d’une même région.

#### Caractéristiques des zones de disponibilité

+ Chaque zone de disponibilité est physiquement séparée des autres.
+ Une AZ regroupe un ou plusieurs centres de données (généralement trois).
+ Chaque zone possède sa propre alimentation électrique, son propre réseau et ses propres systèmes de refroidissement.
+ Elles sont conçues pour l’isolation des défaillances : une panne dans une AZ n’affecte pas les autres.
+ Les AZs sont interconnectées par des liens réseau privés à très haut débit et à faible latence, ce qui permet une réplication rapide (souvent synchrone) des données.

#### Bonnes pratiques
AWS recommande de déployer les applications critiques sur **au moins deux zones de disponibilité** afin d’assurer la résilience et la continuité de service.

Vous choisissez explicitement les zones de disponibilité utilisées lors du déploiement de vos ressources.


#### Exemple 

![Exemple Régions et Zones de disponibilité](/420-414/images/1-introduction/1-07-aws-regions-az.png)

La région Virginie du Nord possède 6 zones de disponibilité : *us-east-1a*, *us-east-1b*, *us-east-1c*, *us-east-1d*, *us-east-1e*, *us-east-1f*

Si une application est déployée sur les zones **1a, 1b et 1c**, et que la zone **1a** subit une panne, l’application continue de fonctionner normalement grâce aux zones **1b et 1c**.

### Centres de données
Les **centres de données** sont les installations physiques où les données sont stockées et où les traitements informatiques ont lieu.

#### Caractéristiques des centres de données
+ Conçus avec un **haut niveau de sécurité physique**.
+ Chaque centre dispose d’une alimentation, d’un réseau et d’une connectivité redondants.
+ Les centres de données sont hébergés dans des installations distinctes afin de limiter les risques communs.
+ Un centre de données AWS contient généralement entre 50 000 et 80 000 serveurs physiques.

Ces centres constituent la base matérielle sur laquelle reposent tous les services AWS.

### Les Edge Locations
Les *Edge Locations* sont des points de présence AWS répartis dans de nombreuses villes à travers le monde, souvent plus proches des utilisateurs finaux que les régions AWS.

#### À quoi servent les Edge Locations ?
Les Edge Locations ont pour objectif principal de **réduire la latence** et d’améliorer les performances pour les utilisateurs finaux.

Elles sont principalement utilisées par des services comme :
+ **Amazon CloudFront** (réseau de diffusion de contenu – CDN),
+ **AWS Shield** et **AWS WAF** (sécurité),
+ **Route 53** (résolution DNS).
#### Fonctionnement
+ Les contenus (images, vidéos, fichiers statiques, pages web) sont mis en cache dans les Edge Locations.
+ Lorsqu’un utilisateur fait une requête, celle-ci est traitée par le point de présence le plus proche géographiquement.
+ Cela permet de réduire le temps de réponse, la charge sur les régions AWS et la consommation de bande passante.

Les Edge Locations ne remplacent pas les régions ou les zones de disponibilité : elles les complètent en rapprochant les services des utilisateurs.


### Avantages de l'infrastructure AWS

![Caractéristiques de l'Infrastructure AWS](/420-414/images/1-introduction/1-09-caracteristiques-infra-aws.png)

#### Élasticité et mise à l’échelle (Scalability)
+ Infrastructure élastique : adaptation dynamique de la capacité selon la demande.
+ Infrastructure évolutive : accompagnement de la croissance des applications sans refonte majeure.
#### Tolérance aux pannes
+ Fonctionnement continu même en cas de défaillance matérielle ou logicielle.
+ Redondance intégrée à tous les niveaux de l’infrastructure.
#### Haute disponibilité
+ Haut niveau de performance opérationnelle.
+ Réduction significative des temps d’arrêt (downtime).
+ Automatisation avancée limitant les interventions humaines.


{{% notice style="debug" title="Références"%}}
+ [Carte interactive de l'infrastructure mondiale de AWS](https://apps.kaonadn.net/5181491956940800/index.html)
+ [Documentation Infrastructure mondiale AWS](https://aws.amazon.com/fr/about-aws/global-infrastructure/)
{{% /notice %}}



<!-- ### Régions
**Une région** AWS est un emplacement physique. AWS regroupe ses régions par emplacement géographique et peuvent inclure plusieurs régions au sein de chaque emplacement. Par exemple, la région Ohio et Virginie du Nord se trouvent toutes les deux dans l'emplacement géographique "US-East".

Les régions sont :
+ **Indépendantes et isolées :** si une région est touchée par un tremblement de terre par exemple, les autres ne le seront pas.
+ **Spécifiques en termes de ressources et de services :** Les ressources d'une région sont isolées et ne sont pas automatiquement répliquées dans d'autres régions.

{{% notice style="info" title="Note"%}}
AWS a lancé 36 régions jusque là !
{{% /notice %}}


### Zones de disponibilité (*AZ*)

Les régions AWS se composent de plusieurs **zones de disponibilités** (*Availability Zones* ou *AZ*). Les zones de disponibilité sont composées d'un ou de plusieurs centres de données physiquement séparés.

Bien qu'elles soient toutes hébergées séparément et disposent de leurs propres sources d'alimentation, les AZs sont toutes connectées par des liens à faible latence.
+ Elles sont **tolérantes aux pannes** : Si l'une d'entre elles tombe en panne, les autres ne devraient pas être affectées.
+ Elles permettent la **haute disponibilité** (*High Availability*)

![Exemple Régions et Zones de disponibilité](/420-414/images/1-introduction/1-07-aws-regions-az.png)

{{% notice style="info" title="Note"%}}
AWS a lancé 114 zones de disponibilité jusque là !
{{% /notice %}}

**Exemple**

+ La région Virginie du Nord possède 6 AZs : *us-east-1a*, *us-east-1b*, *us-east-1c*, *us-east-1d*, *us-east-1e*, *us-east-1f*
+ Une application s'exécute sur plusieurs AZ : 1a, 1b, 1c, mais 1a tombe en panne => votre application fonctionnera toujours dans les zones 1b et 1c. 
-->


