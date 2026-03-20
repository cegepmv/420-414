+++
title = 'Pour aller plus loin'
draft = false
weight = "420"
+++
----------------
## Certificat HTTPS
Dans le précédent laboratoire, Traefik utilisait *Let's Encrypt* afin de générer automatiquement des certificats SSL/TLS et sécuriser nos services en HTTPS.

Pour délivrer un certificat, *Let's Encrypt* doit vérifier **que vous êtes bien propriétaire du domaine**. Cette vérification s’appelle un **challenge**.

## Types de challenge
### HTTP Challenge (*HTTP-01*)
**Fonctionnement :**
+ *Let's Encrypt* envoie une requête HTTP vers votre serveur
+ Votre serveur doit exposer un fichier spécifique à une URL donnée (`acme`)
+ Si le fichier est accessible, la validation est réussie
+ **Exemple :** http://votredomaine/.well-known/acme-challenge/...

**Avantages :**
+ Simple à mettre en place
+ Fonctionne sans configuration DNS

**Inconvénients :**
+ Nécessite que le serveur soit accessible publiquement sur le port 80
+ Ne permet pas les **wildcard certificates**

### TLS Challenge (*TLS-ALPN-01*)
**Fonctionnement :**
+ Validation via une connexion TLS (port 443)
+ Le serveur doit répondre avec un certificat temporaire spécial

**Avantages :**
+ Plus sécurisé que HTTP
+ Ne nécessite pas de port 80

**Inconvénients :**
+ Plus complexe à configurer
+ Peu utilisé en pratique

### DNS Challenge (DNS-01) (utilisé dans le labo)
**Fonctionnement :**
Cet méthode utilise des requêtes DNS pour prouver que vous possédez et contrôlez le domaine

**Avantages :**
+ Permet de **générer des certificats wildcard**
  + **Exemple :** `*.votredomaine.duckdns.org`
+ Ne nécessite pas que le serveur soit accessible publiquement
+ Compatible avec des infrastructures distribuées

## Explication du processus de Traefik
Dans le laboratoire précédent, Traefik utilisait un *DNS Challenge* pour générer un certificat HTTPS. Voici ce qui se passe concrètement :
1. Traefik détecte automatiquement les services grâce aux labels Docker
2. ***DNS Challenge* via *DuckDNS* -** Lors de son lancement, Traefik **identifie le domaine** utilisé et **déclenche une demande de certificat**. Grâce à cette configuration : `--certificatesresolvers.letsencrypt.acme.dnschallenge.provider=duckdns`, Traefik sait qu'il doit utiliser l’API de DuckDNS pour prouver à *Let's Encrypt* que vous contrôlez le domaine.
4. Ensuite, Let's Encrypt valide le certificat, vérifie l’enregistrement DNS puis valide la demande. 
5. Une fois validé, le certificat est généré et stocké dans `/letsencrypt/acme.json`
6. Enfin, Traefik applique le certificat et redirige le trafic HTTP vers HTTPS

<!-- ## Résumé du processus

+ Déploiement de Traefik en spécifiant le nom de domaine et le fournisseur utilisé  
+ Traefik demande un certificat à *Let's Encrypt*
+ Création d’un enregistrement DNS
+ Validation par *Let's Encrypt*
+ Certificat généré et appliqué -->

### Point important : *Wildcard certificate*

Grâce au DNS challenge, un seul certificat peut couvrir :
+ portainer.mondomaine.duckdns.org
+ nextcloud.mondomaine.duckdns.org
+ jellyfin.mondomaine.duckdns.org

### Limitations et bonnes pratiques
+ Les changements DNS peuvent prendre quelques secondes/minutes
+ Bien protéger le `DUCKDNS_TOKEN`
+ Ne pas exposer le fichier `acme.json`

