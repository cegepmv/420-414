+++
title = 'Virtualisation'
draft = true
weight = "310"
+++

Autrefois, les serveurs physiques fonctionnaient comme un ordinateur ordinaire. Vous disposiez d'un boîtier physique, vous installiez un système d'exploitation, puis vous installiez des applications par-dessus. 

Ces types de serveurs sont appelés "serveurs *bare-metal*" (n'y a rien entre la machine physique et le système d'exploitation). 

Ces serveurs étaient **dédiés à un usage spécifique**. La gestion était simple et les problèmes plus faciles à traiter mais les coûts étaient élevés : Il fallait de plus en plus de serveurs au fur et à mesure qu'une entreprise se développait. 

La virtualisation existe depuis les années 1960, mais a commencé se développer au début des années 2000. Plutôt que de faire fonctionner le système d'exploitation directement sur le matériel physique, une couche de virtualisation supplémentaire est ajoutée entre les deux, ce qui permet de déployer plusieurs *serveurs virtuels*, chacun avec son propre système d'exploitation, le tout sur une seule machine physique. 

Cela permet de réaliser des économies et une optimisation des ressources matérielles considérables, et a finalement conduit à l'existence du *cloud computing*. 

![Virtualisation](/420-414/images/3-vm-conteneur/3-01-virtualisation.png)

### Le rôle d'un hyperviseur

La virtualisation ne serait pas possible sans *hyperviseurs* - une couche logicielle qui permet à plusieurs machines virtuelles/systèmes d'exploitation de coexister tout en partageant les ressources d'un seul hôte matériel. L'hyperviseur sert d'**intermédiaire entre les machines virtuelles et le matériel** sous-jacent, en allouant les ressources de l'hôte telles que la mémoire, le processeur et le stockage à chacune des VMs.

#### Types d'hyperviseurs

Il existe deux principaux types d'hyperviseurs : 

![Hyperviseurs](/420-414/images/3-vm-conteneur/3-02-virtualisation.png)


+ **Hyperviseurs de type 1 ou *"bare-metal"* :** Ils s'exécutent directement sur le matériel de l'hôte et sont responsables de la gestion des ressources matérielles et de l'exécution des machines virtuelles. Comme ils s'exécutent directement sur le matériel, ils sont souvent plus efficaces que les hyperviseurs de type 2. 
    + **Exemples :** *VMware ESXi*, *Microsoft Hyper-V*, *Proxmox* etc... 

+ **Hyperviseurs de type 2 ou hébergés :** Ils s'exécutent au-dessus d'un système d'exploitation hôte et s'appuient sur celui-ci pour fournir les ressources matérielles nécessaires. Comme ils s'exécutent au-dessus d'un système d'exploitation, ils sont souvent plus faciles à installer et à utiliser que les hyperviseurs de type 1, mais sont en général moins efficaces. 
    + **Exemples :** *VMware Workstation*, *Oracle VirtualBox* etc...

##### Avantages
+ **Réduction des coûts :** En faisant tourner plusieurs machines virtuelles sur un seul serveur physique, on économise de l'argent et de l'espace.
+ **Meilleure utilisation des ressources et plus grande flexibilité** : La possibilité d'exécuter plusieurs machines virtuelles sur un seul serveur permet d'éviter de gaspiller les capacités matérielles des serveurs. 
+ Facilite l'**évolution**, la **gestion des ressources** et les **plans de reprise après une catastrophe** : Il est possible de créer, détruire et migrer facilement des machines virtuelles entre hôtes.
    
##### Inconvénients
+ Peut créer une **surcharge des performances** : Introduit une couche supplémentaire entre l'hôte et le système d'exploitation.
+ **Ajoute un niveau de complexité** : Il faut gérer et entretenir des instances physiques ET virtuelles.