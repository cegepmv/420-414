+++
title = 'Laboratoire'
draft = false
weight = "431"
+++
-------------------

## 1- Installation Docker
À partir de la [documentation de Docker](https://docs.docker.com/engine/install/).

{{%notice style="warning" title="Attention"%}}
Ces étapes décrites sont pour installer Docker sur une machine Ubuntu 24.04 LTS. Pour d'autres OS ou versions de Ubuntu, réferrez-vous à la documentation.
{{%/notice%}}


1. Supprimer les paquets qui pourraient possiblement causer des conflits :
    ```bash
    sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)
    ```  

2. Installer à partir de `apt`
    1. Configurer `apt`
    ```bash
    # Ajouter la clé GPG Docker officielle:
    sudo apt update
    sudo apt install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Ajouter le dépôt aux sources de apt:
    sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
    Types: deb
    URIs: https://download.docker.com/linux/ubuntu
    Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
    Components: stable
    Signed-By: /etc/apt/keyrings/docker.asc
    EOF

    # Mise à jour de la BD locales des paquets
    sudo apt update
    ```
    2. Installer la dernière version de docker
    ```bash
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    ```
    3. Vérifiez que l'installation s'est déroulée correctement en exécutant l'image `hello-world` :
    ```bash
    sudo docker run hello-world
    ```
{{%notice style="info" title="Note"%}}
Cette commande télécharge une image de test et l'exécute dans un conteneur. Lorsque le conteneur s'exécute, il affiche un message de confirmation et se ferme.
{{%/notice%}}

## 2 - Premier workflow Docker
*Suivez les étapes montrées par votre enseignant pour simuler un premier "workflow" docker. Votre enseignant se charge des étapes de build et de push. Vous pourrez par la suite pull l'image créee et la rouler dans votre propre environnement.*

**Étapes de l'enseignant :**

1. Cloner le code de l'application (git)
```bash
git clone https://github.com/gbenachour/e-portfolio.git
```
2. Build l'application
```bash
docker build -t e-portfolio:1.0 .
```
3. Lui donner le bon tag (format `<docker-username>/<registry>:<version>`)
```bash
docker tag e-portfolio:1.0 cmvghazi/e-portfolio:1.0
```
4. Se connecter à [Docker Hub](https://hub.docker.com/)
```bash
docker login -u cmvghazi 
# Puis fournir le mot de passe
```
5. Push l'image 
```bash
docker push cmvghazi/e-portfolio:1.0
```

**Étapes pour tout le monde:**
1. Pull l'image localement : 
```bash
docker pull cmvghazi/e-portfolio:1.0
docker images # vérifier le téléchargement de l'image 
```
2. Exécuter un conteneur 
```bash
docker run -d -p 8080:80 --name e-portfolio cmvghazi/e-portfolio:1.0
docker ps # vérifier que le conteneur a été exécuté
```
+ `-d` : exécution en mode détaché
+ `-p <port-hote>:<port-conteneur>`: mappage d'un port de l'hôte au port d'écoute du conteneur
+ `--name` : nom donné au conteneur
+ `<image>` : image à partir de laquelle on crée le conteneur

3. Vérifier que l'application est accessible (`http://<IP de l'hôte>:8080` sur un navigateur)
4. Nettoyage
```bash
docker stop <id-conteneur>
docker rm <id-conteneur>
docker rmi <id-image>
docker system prune
```