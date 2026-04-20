+++
title = "Scaling et résilience"
draft = false
weight = "544"
+++
--------------

Jusqu’à présent, nous avons exploré les Pods, les Services et les Deployments : les Pods exécutent les conteneurs, les Services exposent les Pods et les Deployments gèrent le déploiement et les mises à jour.

Mais il manque une pièce importante dans ce puzzle : le **ReplicaSet**.

## Le rôle du ReplicaSet

Un **ReplicaSet** est une ressource Kubernetes dont la responsabilité est simple mais essentielle : s’assurer qu’un nombre précis de *Pods* identiques est toujours en cours d’exécution.

Concrètement :
1. On définit un modèle de Pod (template)
2. On indique un nombre de réplicas (ex : 2, 3, 5…)
3. Le ReplicaSet veille en permanence à respecter cet état

**Exemple :** Si on demande 2 Pods et qu’un Pod plante → le **ReplicaSet** en recrée automatiquement un nouveau.

C’est ce qui permet la **résilience** (*self-healing*).


## Relation entre Deployment, ReplicaSet et Pods

Même si on dit souvent que le **Deployment** gère les **Pods**, en réalité, ce n’est pas direct. La vraie chaîne est : 

**Deployment → ReplicaSet → Pods**

Le **Deployment** ne gère pas directement les Pods, il crée et gère un ou plusieurs **ReplicaSets** et chaque **ReplicaSet** gère ensuite les Pods. Cette couche supplémentaire est très importante, car elle permet la **mise à l’échelle** (*scaling*), les **déploiements progressifs** (*rolling updates*) et la **résilience** (*self-healing*) de nos applications.

## Réplication des Pods

Le **ReplicaSet** permet de dupliquer facilement un Pod : On définit le Pod une seule fois, on indique le nombre de copies souhaitées puis Kubernetes crée plusieurs **Pods** identiques.

**Exemple avec le deployment de l'application Pokedex:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pokedex-app
spec:
  replicas: 2 # C'est ici qu'on donne le nombre de Pods que le ReplicaSet va créer
  selector:
    matchLabels:
      app: pokedex
  template:
    metadata:
      labels:
        app: pokedex
    spec:
      containers:
        - name: pokedex-container
          image: cmvghazi/pokedex:1.0
          ports:
            - containerPort: 80

```

**Résultat :** 2 Pods avec exactement la même configuration. Cela permet de **répartir la charge** et d’assurer la **haute disponibilité**

## ReplicaSets et *rolling updates*

C’est ici que les **ReplicaSets** deviennent vraiment intéressants. Quand tu mets à jour une application (ex : nouvelle image Docker), le *Deployment* ne modifie pas directement les **Pods** existants : **il crée un nouveau ReplicaSet**.

Scénario typique : 
+ Tu as un ReplicaSet existant (version v1) avec 2 Pods en cours d’exécution
+ Tu décides de déployer une nouvelle version (v2)

**Le Deployment :**
1. Crée un nouveau ReplicaSet (v2) et démarre avec 1 Pod
2. Quand ce Pod devient *healthy*, le **Deployment** commence à recevoir du trafic via le Service
3. Progressivement, le **Deployment** diminue l’ancien **ReplicaSet** (v1) et augmente le nouveau (v2) jusqu'à arriver à 
    + v1 → 0 Pods
    + v2 → 2 Pods

**Résultat :** Mise à jour terminée sans interruption de service.

{{%notice style="tip" title="Coexistence des **ReplicaSets**"%}}
Même après la mise à jour, l’ancien **ReplicaSet** n’est pas supprimé, il est simplement à 0 Pods. Cela permet de faire des *rollbacks* facilement et de revenir à une version précédente si problème.
{{%/notice%}}

## Exemple : nouvelle version du Pokedex

Modifiez le manifeste du **Deployment** du pokedex : 
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pokedex-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: pokedex
  template:
    metadata:
      labels:
        app: pokedex
    spec:
      containers:
        - name: pokedex-container
          image: cmvghazi/pokedex:1.1 # Nouvelle version du pokedex
          ports:
            - containerPort: 80
```

Appliquez les changements puis observez le déploiement progressif que fait le **Deployment** :

```bash
kubectl apply -f pokedex
kubectl get replicasets -l app=pokedex --watch
```

**Résultat :** Le **Deployment** crée un nouveau **ReplicaSet** avec la nouvelle version, et gère la mise à jour de façon incrémentale !

## Exercice - Scaling et rolling update du frontend e-commerce
À partir du laboratoire 1, faites en sorte que le *Deployment* du frontend mette à l'échelle le Frontend à 2 replicas. Ensuite, faites une mise à jour du frontend avec la nouvelle version : `cmvghazi/ecommerce-frontend:1.6` puis observez le *rolling update*.

<!-- kubectl exec deployment/pokedex-app -- kill 1 -->