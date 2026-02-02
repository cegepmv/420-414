+++
pre = '<b>1. </b>'
title = "Introduction"
weight = "100"
+++



### Qu'est-ce que le Cloud ?
Le Cloud est une **plateforme qui permet d’accéder à des ressources informatiques virtualisées, à la demande**, pour un usage personnel ou professionnel, via Internet.

Ces ressources peuvent inclure :
+ des serveurs (puissance de calcul),
+ du stockage,
+ des réseaux,
+ des bases de données,
+ des outils de sécurité,
+ des services applicatifs.

L’utilisation du Cloud repose sur un **modèle de paiement à l’utilisation** (*pay-as-you-go*) : vous ne payez que pour les ressources réellement consommées.

Lorsque vous utilisez des services cloud, **vous ne possédez pas physiquement l’infrastructure**. Celle-ci appartient à un fournisseur de services qui la met à votre disposition sous forme de location.

**Le *"Cloud"* est une plate-forme qui permet d'avoir une disponibilité à la demande de ressources informatiques virtuelles pour un usage personnel ou professionnel.**

### Exemples de services cloud
Les services cloud permettent, entre autres, de :
+ créer et gérer des réseaux complets,
+ héberger des applications web,
+ tester et déployer des logiciels,
+ stocker et analyser de grandes quantités de données,
+ mettre en place des environnements temporaires ou permanents.

En pratique, tout ce qui peut être fait dans un centre de données traditionnel peut être réalisé dans le nuage, souvent plus rapidement et avec davantage de flexibilité.


### Les avantages de l'infonuagique

<!-- ![Avantages du Cloud](/420-414/images/1-introduction/1-02-avantages-cloud.png) -->

L’infonuagique offre de nombreux avantages, tant pour les organisations que pour les individus.
#### Déploiement rapide et mondial

***Go global in minutes :*** il est possible de déployer des applications dans différentes régions du monde en quelques clics et en quelques minutes.
#### Réduction des coûts d’infrastructure
Aucune dépense liée à l’achat, à l’entretien ou à la gestion d’un centre de données physique. Les équipes peuvent se concentrer sur le développement et l’innovation plutôt que sur le matériel.
#### Économies d’échelle
Les grands fournisseurs (AWS, Azure, GCP) exploitent des infrastructures massives, ce qui leur permet de réduire les coûts unitaires et d’en faire bénéficier leurs clients.
#### Scalabilité et élasticité
Il n’est plus nécessaire d’estimer la capacité requise à l’avance. Les ressources peuvent être augmentées ou réduites dynamiquement selon les besoins.
#### Haute disponibilité
Les services cloud sont conçus pour être hautement disponibles. Les pannes sont atténuées grâce à la redondance, à la réplication et à la gestion automatique des défaillances.
#### Durabilité des données
Les données sont stockées de manière redondante sur plusieurs systèmes, ce qui réduit les risques de perte ou de corruption à long terme.

### Les inconvénients et limites du Cloud
Malgré ses nombreux avantages, l’infonuagique présente aussi des inconvénients et des défis importants qu'il est essentiel de comprendre.

#### Gouvernance et contrôle
L’un des principaux enjeux du Cloud est la perte de contrôle direct sur l’infrastructure. Les organisations doivent mettre en place des règles claires concernant :

+ la gestion des accès,
+ la création des ressources,
+ le suivi des coûts,
+ la conformité aux politiques internes.

Sans une gouvernance adéquate, le Cloud peut rapidement devenir complexe et difficile à maîtriser.

#### Coûts imprévus
Le modèle pay-as-you-go est flexible, mais il peut entraîner des dépassements de budget si les ressources ne sont pas surveillées correctement (services oubliés, surdimensionnement, trafic réseau élevé).

#### Dépendance au fournisseur (*Vendor Lock-in*)
Chaque fournisseur cloud propose ses propres services, outils et technologies. Migrer d’un fournisseur à un autre peut être complexe, coûteux et chronophage.
#### Sécurité et responsabilité partagée
Contrairement à une idée répandue, le Cloud n’élimine pas les risques de sécurité. La sécurité repose sur un modèle de responsabilité partagée :
+ le fournisseur sécurise l’infrastructure,
+ le client est responsable de la configuration, des accès et des données.

Une mauvaise configuration peut entraîner des failles importantes.
#### Conformité et localisation des données
Certaines organisations doivent respecter des réglementations strictes (ex. données de santé, données personnelles). La localisation des données et la conformité légale peuvent représenter un défi dans le Cloud.


#### Gouvernance des données (*Data Governance*)

La gouvernance des données est l’un des enjeux majeurs du cloud.

Lorsque vous utilisez des services infonuagiques, **vos données ne sont plus hébergées physiquement dans vos propres locaux**, mais dans les centres de données d’un fournisseur externe. Cela soulève plusieurs questions critiques :

+ **Localisation des données:**
Où les données sont-elles stockées (pays, région) ? Certaines lois exigent que les données demeurent dans une zone géographique précise.

+ **Conformité réglementaire:**
Respect des lois et normes comme le RGPD, les lois canadiennes sur la protection des renseignements personnels, ou les exigences sectorielles (santé, finance, éducation).

+ **Contrôle et accès aux données:**
Qui peut accéder aux données ? Comment sont gérés les droits d’accès, les journaux (logs) et les audits ?

+ **Responsabilité en cas d’incident:**
En cas de fuite, de perte ou de corruption des données, **le client demeure responsable**, même si l’infrastructure appartient au fournisseur.

+ **Cycle de vie des données:**
Gestion de la création, de la conservation, de l’archivage et de la suppression des données.

Bien que les fournisseurs cloud offrent des outils pour gérer ces aspects, **la responsabilité de la gouvernance des données incombe toujours à l’organisation cliente**.


#### Dépendance à la connectivité Internet
L’accès aux services cloud dépend fortement d’une connexion Internet fiable. Une interruption réseau peut rendre les services temporairement inaccessibles.


### Les principaux fournisseurs de services cloud

#### Fournisseurs publics majeurs (par popularité)
+ Amazon Web Services (AWS)
+ Microsoft Azure
+ Google Cloud Platform (GCP)

#### Autres fournisseurs et solutions d’infrastructure privée
+ Red Hat
+ Dell
+ VMware
+ OpenStack

Ces solutions sont souvent utilisées pour créer des infrastructures cloud privées ou hybrides.


### Emplois dans le domaine du Cloud
Le Cloud ouvre la porte à de nombreux rôles professionnels, notamment :

+ **Architecte de solutions (*Solution Architect*) :** conçoit des architectures cloud adaptées aux besoins d’affaires.
+ **Ingénieur Cloud (*Cloud Engineer*) :** met en place et gère les infrastructures cloud.
+ **Cloud Operations Engineer :** rôle souvent accessible en début de carrière, axé sur l’exploitation et la maintenance.
+ **Sales Engineer :** fait le lien entre les équipes techniques et commerciales.
+ **Ingénieur DevOps (*DevOps Engineer*) :** automatise les déploiements et la gestion des services en adoptant une méthodologie DevOps.
+ **Support Cloud :** support technique basé sur les tickets, en interaction avec de nombreux services cloud.