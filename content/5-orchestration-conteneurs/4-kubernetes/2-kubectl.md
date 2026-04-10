+++
title = "kubectl"
draft = true
weight = "542"
+++
--------------

Pour interagir avec Kubernetes, on utilise `kubectl`. C'est un outil de ligne de commande qui nous permet de communiquer avec l'API du cluster pour faire des opérations : Créer des ressources (pods, services, deployments, etc...), lister des ressources existantes ou les supprimer.

### Voir les ressources

Les commandes suivantes affichent la liste des ressources (pods, deployments, services) en cours d’exécution :

```bash
kubectl get pods
kubectl get deployments
kubectl get services # ou kubectl get svc
```

### Créer des ressources

#### Approche impérative (source d'erreurs)
On peut créer une ressource avec la commande `kubectl create <ressource> [options]`, mais ce n'est pas recommandé ()

**Exemple 1 : Création d'un deployment et d'un service pour exposer un simple serveur web nginx:** 
```bash
# Créer le deployment
kubectl create deployment nginx-server --image=nginx

# Exposer le deployment (en créant un service)
kubectl expose deployment nginx-server --port=80 --type=NodePort
```

#### Approche déclarative (recommandé)
On déclare un fichier YAML qui décrit la ressource. C'est ce qu'on appelle un **manifest**. Ensuite, on déploie/applique la ressource en utilisant la commande `kubectl apply -f <chemin vers le fichier YAML>` :

```bash
kubectl apply -f nginx-pod.yaml
```

{{%notice style="tip" title="Astuce"%}}
Il est aussi possible d'appliquer tous les fichiers YAML d'un répertoire : 
```bash
kubectl apply -f nginx/
```
{{%/notice%}}


### Obtenir les détails d'une ressource
`kubectl describe <ressource> <nom de la ressource>` donne des informations détaillées sur une ressource:

```bash
kubectl describe pod <nom>
kubectl describe deployment <nom>
kubectl describe service <nom>
```
On peut y trouver des informations utiles tel que l'état, les événements, si une erreur etc...

### Supprimer une ressource
```bash
kubectl delete -f fichier.yaml
# ou
kubectl delete pod <nom>
```

### Voir les logs
```bash
kubectl logs <nom-du-pod>
```
Très utile pour le debug

### Observer en temps réel
```bash
kubectl get pods -w
```
Mode watch (temps réel)