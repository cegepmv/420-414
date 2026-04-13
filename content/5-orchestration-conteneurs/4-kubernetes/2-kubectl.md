+++
title = "kubectl"
draft = false
weight = "542"
+++
--------------

Pour interagir avec Kubernetes, on utilise `kubectl`. C'est un outil de ligne de commande qui nous permet de communiquer avec l'API du cluster pour faire des opérations : Créer des ressources (pods, services, deployments, etc...), lister des ressources existantes ou les supprimer.

### Voir les ressources

Les commandes suivantes affichent la liste des ressources (pods, deployments, services) en cours d’exécution :

```bash
kubectl get pods
kubectl get deployments
kubectl get services # ou get svc
```

### Créer des ressources

#### Approche impérative (source d'erreurs)
On peut créer une ressource avec la commande `kubectl create <ressource> [options]`, mais ce n'est pas recommandé ()

**Exemple 1 - Création d'un Pod et d'un service pour exposer un serveur web nginx :** 
```bash
# Créer le pod
kubectl run nginx-pod --image=nginx --port=80

# Vérifier que le pod a été créé
kubectl get pods 

# Exposer le pod (en créant un service de type NodePort)
kubectl expose pod nginx-pod --port=80 --type=NodePort


# Vérifier que le service a été créé
kubectl get svc

# Vérifier les logs du pod
kubectl logs -f nginx-pod
```

Pour accéder au serveur nginx, récupérez le port que le service a exposé : 

```bash
root@cl-ghazi:~# kubectl get svc
NAME        TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
nginx-pod   NodePort   10.99.131.146   <none>        80:30840/TCP   5s
```

Dans l'exemple ci-dessus, le pod a été exposé sur le port `30840`. Allez sur votre navigateur et entrez `<adresse IP d'un des noeuds de travail>:30840`.

{{%notice style="info" title="Rappel: Fonctionnement d'un Service de type *NodePort*"%}}
Un *Service* de type *NodePort* expose nos ressources sur les ports de tous les noeuds de travail. Pour accéder à la ressource, il est possible de prendre l'IP de n'importe quel *Worker Node* (dans notre cas `10.10.0.61`, `10.10.0.62`, `10.10.0.63`, ou `10.10.0.64`,)
{{%/notice%}}


**Exemple 2 - Avec un deployment :** 
```bash
# Créer le deployment
kubectl create deployment nginx-server --image=nginx

# Vérifier que le pod et le deployment ont été créés
kubectl get pods 
kubectl get deployments

# Exposer le deployment
kubectl expose deployment nginx-server --port=80 --type=NodePort


# Vérifier que le service a été créé
kubectl get svc


```

#### Approche déclarative (recommandé)
On déclare un fichier YAML qui décrit la ressource. C'est ce qu'on appelle un **manifest**. Ensuite, on déploie/applique la ressource en utilisant la commande `kubectl apply -f <chemin vers le fichier YAML>` :


**Exemple 1 - Création d'un Pod et d'un service pour exposer un serveur web nginx :** 
```bash
kubectl apply -f nginx-pod.yaml
kubectl apply -f nginx-svc.yaml
```

**Contenu de `nginx-pod.yaml`:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
  - name: nginx-container
    image: nginx:latest
    ports:
    - containerPort: 80
```

**Contenu de `nginx-svc.yaml`:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-svc
  labels:
    app: nginx
spec:
  type: NodePort
  ports:
    - port: 80
      targetPort: 80
  selector:
    app: nginx
```

{{%notice style="tip" title="Astuce"%}}
Il est aussi possible d'appliquer tous les fichiers YAML d'un répertoire : 
```bash
kubectl apply -f nginx/
```
{{%/notice%}}



**Exemple 2 - Avec un deployment :** 
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-server
spec:
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:latest 
          ports:
            - containerPort: 80
```

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
{{%notice style="tip" title="Checker les logs de tous les Pods nginx"%}}
Il est possible de voir les logs de tous les pods ayant un label spécifique : 
```bash
kubectl logs -l app=nginx
```

Cela permet, lorsque nous avons plusieurs Pods (scaling), d'avoir les logs de tous les pods d'une même app/API .
{{%/notice %}}

### Observer en temps réel
```bash
kubectl get pods -w
```
Mode watch (temps réel)

## Exercice : déplooiement de l'app *Pokédex*
Déployez l'application Pokédex (conteneurisée au TP1) en suivant deux méthodes :
1. D'abord en utilisant l'approche impérative (`kubectl run`)
2. Puis en utilisant l'approche déclarative (`kubectl apply -f`)

Pour les deux méthodes, commencer par créer un Pod manuellement, puis en utilisant un Deployment 
