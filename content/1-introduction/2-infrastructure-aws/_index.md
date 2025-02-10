+++
pre = '<b>2. </b>'
title = 'Infrastructure AWS'
draft = false
weight = "120"
+++

AWS possède une infrastructure immense, avec des centres de données (*data centers*) déployés sur les quatre coins du globe. AWS a une façon spécifique de séparer logiquement et physiquement son infrastructure pour permettre une disponibilité et une redondance optimale.

### Régions
+ Une **région** AWS est une zone géographique.
    + **Vous** contrôlez la réplication des données entre les régions.
    + La communication entre les régions s'effecture par le biais de l'infrastructure réseau de AWS.

+ Chaque région AWS assure une **redondance** et une **connectivité** complète au réseau AWS.

+ Une région se compose de deux **zones de disponibilité** ou plus.

### Zones de disponibilité
+ Chaque **région** compte plusieurs zones de disponibilité (*Availability Zones* ou *AZs*).

+ Chaque **zone de disponibilité** est une partition entièrement isolée de l'infrastructure mondiale AWS.
    + Les zones de disponibilité consistent en un ou plusieurs centres de données (typiquement 3).
    + Elles sont **isolées** et conçues pour l'isolation des défaillances : Chaque zone de disponibilité a sa propre source d'alimentation et est physiquement séparée des autres zones de disponibilités.
    + Elles sont i**nterconnectées avec d'autres zones de disponibilité** via des **réseaux privés à haut débit** : permet d'avoir une réplication syncrone et rapide des données (très peu de latence). 
    + **Vous** choisissez vos zones de disponibilité.

+ **AWS recommande de répliquer les données et les ressources dans minimum 2 zones de disponibilité** pour garantir la résilience de vos services.


**Exemple**

![Exemple Régions et Zones de disponibilité](/420-414/images/1-introduction/1-07-aws-regions-az.png)

+ La région Virginie du Nord possède 6 zones de disponibilité : *us-east-1a*, *us-east-1b*, *us-east-1c*, *us-east-1d*, *us-east-1e*, *us-east-1f*
+ Une application s'exécute sur plusieurs zones : *1a*, *1b* et *1c*, mais la zone *1a* tombe en panne => votre application fonctionnera toujours dans les zones 1b et 1c.

### Centres de données
+ Les centres de données AWS sont conçus pour la **sécurité**.

+ Les centres de données sont l'emplacement où les données sont hébergées et où le traitement des données a lieu.

+ Chaque centre de données dispose d'une alimentation, d'un réseau et d'une connectivité redondants et est hébergé dans une installation distincte des autres centres de données.

+ Un centre de données compte généralement entre 50 000 et 80 000 serveurs physiques !


### Avantages de l'infrastructure AWS

![Caractéristiques de l'Infrastructure AWS](/420-414/images/1-introduction/1-09-caracteristiques-infra-aws.png)

+ **Élasticité et mise à l'échelle (*scalability*) :**
    + Infrastructure élastique, adaptation dynamique de la capacité
    + Infrastructure évolutive, adaptation à la croissance

+ **Tolérance aux pannes :**
    + Fonctionnement continu en cas de panne
    + Redondance intégrée des composants

+ **Haute disponibilité :**
    + Haut niveau de performances opérationnelles
    + Temps d'arrêt réduit (*down time*)
    + Aucune intervention humaine nécessaire

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


