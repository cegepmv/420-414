+++
title = 'Laboratoire'
draft = false
weight = "320"
+++
# Exploration de EC2
---------------

## 1 – Lancement et connexion

**Objectif :**
+ Lancer une instance EC2 Ubuntu
+ Configurer un groupe de sécurité
+ Se connecter via SSH

**Travail demandé :**
1. Créer une instance t3.micro
2. Autoriser le port 22
3. Se connecter via SSH
4. Installer `nginx`
5. Tester l’accès HTTP

**Questions :** 
1. Avez-vous accès à la page *nginx* par défaut via votre navigateur? Pourquoi?
2. Essayez de *troubleshoot* le problème.
3. Pouvez-vous faire un *ping* à votre instance? Pourquoi?
4. Configurez votre instance de telle sorte à ce qu'elle réponde aux pings envoyés.

## 2 – User Data

**Objectif :** automatiser le déploiement.

**Travail demandé :**
1. Lancer une nouvelle instance
2. Ajouter un script User Data qui installe `nginx` 
3. Vérifier que la page est accessible sans configuration manuelle

## 3 – Cycle de vie

**Objectif :** observer les changements d’IP.

**Travail demandé :**
1. Noter l’IP publique et privée
2. Arrêter puis redémarrer l'instance
3. Comparer les changements
<!-- 
## 4 – Métadonnées

**Objectif :** explorer l’environnement interne.

**Travail demandé :**
1. Se connecter à l’instance
2. Utiliser curl pour consulter les métadonnées
3. Identifier :
    + L’ID de l’instance
    + La zone de disponibilité
    + L’adresse IP privée

## 5 – Création d’une AMI personnalisée

**Objectif :**
+ Comprendre l’intérêt des AMI personnalisées
+ Créer un modèle réutilisable d’instance
+ Déployer une nouvelle instance à partir de cette AMI

**Contexte :** Vous devez standardiser le déploiement d’un serveur web afin d’éviter de répéter les mêmes configurations manuelles.

**Travail demandé :**
1. Lancer une instance EC2 Ubuntu.
2. Installer et configurer :
    + Nginx
    + Une page HTML personnalisée
3. Vérifier que le serveur web fonctionne correctement.
4. Créer une AMI à partir de cette instance :
    + Donner un nom explicite
    + Ajouter une description claire
5. Lancer une nouvelle instance en utilisant l’AMI créée.

6. Vérifier que :
    + Le serveur web est déjà installé
    + La page personnalisée est présente

**Questions :**
1. Quel est l’avantage d’utiliser une AMI personnalisée plutôt qu’un script User Data ?
2. Dans quel contexte professionnel l’utilisation d’AMI personnalisées devient-elle essentielle ?
3. Que se passe-t-il si vous modifiez l’instance originale après la création de l’AMI ? -->