+++
title = 'Exercice'
draft = false
weight = "121"
+++

## Choix d’architecture AWS
Une entreprise souhaite déployer une application web destinée à des utilisateurs situés en Amérique du Nord et en Europe.

**Contraintes :**
+ L’application doit rester disponible même en cas de panne matérielle.
+ Les temps de réponse doivent être faibles pour les utilisateurs des deux continents.
+ Les coûts doivent rester raisonnables.

**Questions :**
1. Dans combien de régions AWS déploieriez-vous l’application ? Pourquoi ?
2. Combien de zones de disponibilité utiliseriez-vous par région ?
3. Quel rôle pourraient jouer les Edge Locations dans cette architecture ?
4. Que se passe-t-il si une zone de disponibilité tombe en panne ?

Expliquez vos choix en vous appuyant sur les concepts de régions, zones de disponibilité et Edge Locations.

{{% expand title="Solutions" %}}


1. Idéalement **deux régions** : une en Amérique du Nord et une en Europe.
+ **Justification :** Réduction de la latence pour les utilisateurs des deux continents, amélioration de la résilience globale, données gardées dans la région (plus adéquat pour la conformité et le respect de la gouvernance).

2. Au minimum **deux zones de disponibilité par région**.
+ **Justification :** Respect des bonnes pratiques AWS et tolérance aux pannes (si une zone tombe en panne, l’application reste disponible).


3. 
    Les Edge Locations permettent :
    + de réduire la latence pour les utilisateurs finaux,
    + de mettre en cache le contenu statique (images, vidéos, pages web),
    + de réduire la charge sur les régions AWS.

4. Les ressources déployées dans les autres zones de disponibilité continuent de fonctionner.
L’application reste accessible si elle est correctement architecturée (multi-AZ).

{{% /expand %}}
