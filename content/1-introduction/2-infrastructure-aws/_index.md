+++
pre = '<b>2. </b>'
title = 'Infrastructure AWS'
draft = false
weight = "12"
+++

AWS possède une infrastructure immense, avec des centres de données (*data centers*) déployés sur les quatre coins du globe. AWS a une façon spécifique de séparer logiquement et physiquement son infrastructure pour permettre une disponibilité et une redondance optimale.

### Régions
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


{{% notice style="debug" title="Références"%}}
+ [Carte interactive de l'infrastructure mondiale de AWS](https://apps.kaonadn.net/5181491956940800/index.html)
+ [Documentation Infrastructure mondiale AWS](https://aws.amazon.com/fr/about-aws/global-infrastructure/)
{{% /notice %}}