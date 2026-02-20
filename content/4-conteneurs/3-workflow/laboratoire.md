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