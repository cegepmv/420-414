+++
title = 'Exercices'
draft = false
weight = "240"
+++

## 1 – Compréhension globale
*On vous demande de déployer une application web sur AWS.*

+ Le serveur web doit être accessible depuis Internet.
+ La base de données ne doit **pas** être accessible depuis Internet.
+ Les deux ressources doivent pouvoir communiquer entre elles.

1. Dans quel type de sous-réseau (public ou privé) placeriez-vous :
    + le serveur web ?
    + la base de données ?
2. Quels composants réseau AWS sont nécessaires pour permettre :
    + l’accès Internet au serveur web ?
    + l’accès Internet **sortant uniquement** pour la base de données (mises à jour, correctifs) ?
3. Expliquez brièvement votre raisonnement.

## 2 – Analyse de routage
On considère un VPC avec les éléments suivants :
+ Un sous-réseau public
+ Un sous-réseau privé
+ Une Internet Gateway (IGW)
+ Une NAT Gateway
1. Quelle route doit être présente dans la table de routage du sous-réseau public pour permettre l’accès à Internet ?
2. Quelle route doit être présente dans la table de routage du sous-réseau privé pour permettre l’accès Internet sortant ?
3. Pourquoi ne doit-on **pas** associer directement une Internet Gateway au sous-réseau privé ?

## 3 – Classement (sécurité)
Pour chaque affirmation suivante, indiquez si elle correspond à :
+ un **Groupe de sécurité (SG)**
+ une **ACL réseau (NACL)**

1. Fonctionne au niveau du sous-réseau
2. Est un pare-feu avec état (stateful)
3. Les règles entrantes et sortantes sont évaluées séparément
4. S’applique directement à une interface réseau
5. Autorise tout le trafic par défaut
6. Refuse tout le trafic entrant par défaut


## 4 – Mise en situation
Vous observez le comportement suivant :
+ Une instance EC2 dans un sous-réseau privé peut initier des connexions vers Internet.
+ Internet ne peut pas initier de connexion vers cette instance.

1. Quel composant AWS rend ce comportement possible ?
2. Dans quel sous-réseau ce composant doit-il être placé ?
3. Pourquoi ce comportement est-il souhaitable du point de vue de la sécurité ?

{{% expand title="Solutions" %}} 
#### Exercice 1

1. Placement des ressources :
    + Serveur web : sous-réseau public
    + Base de données : sous-réseau privé
2. Composants nécessaires :
    + Accès Internet au serveur web :
        + Internet Gateway (IGW)
        + Table de routage avec une route vers l’IGW
    + Accès Internet sortant pour la base de données :
        + NAT Gateway
        + Table de routage du sous-réseau privé pointant vers la NAT Gateway

3.
+ Le serveur web doit être accessible depuis Internet, donc placé dans un sous-réseau public.
+ La base de données doit être protégée et non exposée, donc placée dans un sous-réseau privé.
+ La NAT Gateway permet un accès sortant sans autoriser les connexions entrantes.

#### Exercice 2
1. Table de routage du sous-réseau public :
    + 0.0.0.0/0 → Internet Gateway (IGW)

2. Table de routage du sous-réseau privé :
    + 0.0.0.0/0 → NAT Gateway

2. Une Internet Gateway permet des connexions entrantes et sortantes. Associer une IGW à un sous-réseau privé exposerait les instances directement à Internet, ce qui va à l’encontre du principe de sécurité.

#### Exercice 3

1. Fonctionne au niveau du sous-réseau → NACL
2. Est un pare-feu avec état (stateful) → Groupe de sécurité.
3. Règles entrantes et sortantes distinctes → NACL
4. S’applique à une interface réseau → Groupe de sécurité
5. Autorise tout le trafic par défaut → NACL (par défaut)
6. Refuse tout le trafic entrant par défaut → Groupe de sécurité

#### Exercice 4

1. Composant utilisé : NAT Gateway

2. La NAT Gateway doit être placée dans un sous-réseau public avec une route vers une Internet Gateway.

3. Explications :
    + Les instances privées peuvent accéder à Internet pour les mises à jour.
    + Aucune connexion entrante depuis Internet n’est possible.
    + Cela réduit considérablement la surface d’attaque.
{{% /expand %}}
