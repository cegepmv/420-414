+++
pre = '<b>3. </b>'
title = 'Virtualisation'
draft = false
weight = "300"
+++
------------

## Contexte et historique

À l’origine, les serveurs fonctionnaient comme des ordinateurs classiques :

![Virtualisation](/420-414/images/3-vm-conteneur/3-01-virtualisation.png)

+ Une machine physique
+ Un système d’exploitation installé directement sur le matériel
+ Des applications installées par-dessus

Ce modèle est appelé **serveur bare-metal**, car rien ne s’interpose entre le matériel et le système d’exploitation.

Ces serveurs étaient généralement **dédiés à un usage précis**. Bien que simples à gérer, ils présentaient plusieurs limites :

+ Coûts élevés
+ Sous-utilisation fréquente des ressources
+ Difficulté à faire évoluer l’infrastructure

Avec la croissance des entreprises, il fallait multiplier les serveurs physiques, ce qui augmentait rapidement les coûts et la complexité.

### Principe
La virtualisation (popularisée au début des années 2000, bien que conceptuellement plus ancienne) introduit une couche logicielle entre le matériel et les systèmes d’exploitation.

Cette couche permet d’exécuter **plusieurs machines virtuelles (VM)** sur un même serveur physique.

Chaque machine virtuelle :

+ Possède son propre système d’exploitation
+ Dispose de ressources allouées (CPU, RAM, stockage)
+ Fonctionne de manière isolée des autres VMs

#### Apports de la virtualisation

+ **Réduction des coûts :** meilleure exploitation du matériel
+ **Optimisation des ressources :** moins de gaspillage
+ **Flexibilité :** création et suppression rapide de VMs
+ **Haute disponibilité :** migration entre hôtes physiques
+ **Reprise après sinistre facilitée**

{{%notice style="info" title="Note"%}}
La virtualisation est l’un des fondements techniques ayant permis l’émergence du *cloud computing*.
{{%/notice%}}


## Le rôle de l'hyperviseur

La virtualisation ne serait pas possible sans *hyperviseurs* - une couche logicielle qui permet à plusieurs machines virtuelles/systèmes d'exploitation de coexister tout en partageant les ressources d'un seul hôte matériel. 

L'hyperviseur sert d'**intermédiaire entre les machines virtuelles et le matériel** sous-jacent.

Il alloue dynamiquement les ressources de l'hôte telles que la mémoire, le CPU, le stockage et les ressources réseau à chacune des VMs.

### Types d'hyperviseurs

Il existe deux principaux types d'hyperviseurs : 

![Hyperviseurs](/420-414/images/3-vm-conteneur/3-02-virtualisation.png)

**Hyperviseur de type 1** (*bare-metal*)
+ S’exécute directement sur le matériel
+ Plus performant
+ Utilisé en production et en cloud
+ **Exemples :** *VMware ESXi*, *Microsoft Hyper-V*, *Proxmox*

**Hyperviseur de type 2** (hébergé)
+ S’exécute au-dessus d’un système d’exploitation
+ Plus simple à installer
+ Principalement utilisé en environnement de test ou développement
+ **Exemples :** *VMware Workstation*, *Oracle VirtualBox* etc...

## Limites de la virtualisation
+ **Surcharge potentielle des performances** (couche supplémentaire)
+ **Complexité accrue** (gestion physique + virtuelle)
+ Coûts logiciels possibles (licences hyperviseur)