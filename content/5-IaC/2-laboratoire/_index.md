+++
title = 'Laboratoire'
draft = false
weight = "520"
+++

# Initiation à Terraform

Ce laboratoire a pour but de vous introduire à Terraform et son *Workflow* en déployant une machine simple machine EC2 sur AWS. 

### Pré-requis
#### Installation de AWS CLI

Afin de pouvoir communiquer avec l'API d'AWS, il faut d'abord installer l'interface de ligne de commande d'AWS (*AWS CLI*), qui est un client qui nous permet de nous authentifier à notre compte AWS, lister les ressources déployées, déployer de nouvelles ressources etc...

Étapes d'installation d'AWS CLI (récupérée de la documentation d'AWS) :

```bash
# Téléchargement du script d'installation vers le répertoire /opt
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/opt/awscliv2.zip"
# Décompression du fichier zip
sudo unzip /opt/awscliv2.zip
# Lancement du script d'installation
sudo /opt/aws/install
```

Confirmez l'installation en éxécutant la commande suivante : 
```bash
aws --version
```

##### Exemple d'utilisation d'AWS CLI
```bash
aws ec2 describe-instances \
    --query 'Reservations[*].Instances[*].{Instance:InstanceId,Subnet:SubnetId}' \
    --output json
```

#### Installation de Terraform

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```

```bash
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

```
```bash
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```
```bash
sudo apt update
```
```bash
sudo apt install terraform
```

### Laboratoire 1 : Déployer une instance EC2

#### Étape 1 - Connexion à AWS
+ Sur la page AWS Academy, démarrez votre environnement puis naviguez à l'onglet `AWS Details`.

+ Dans la section `AWS CLI`, copiez les identifiants puis collez les dans le fichier `~/.aws/credentials`.

#### Étape 2 - Création d'un fichier de configuration
```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"

  tags = {
    Name = "AppServer"
  }
}
```

#### Étape 3 - Initialisation du répertoire projet

Dans votre répertoire tapez la commande suivante pour initialiser le projet Terraform : 
```bash
terraform init
```

#### Formater et valider la configuration
```bash
terraform fmt
```

```bash
terraform validate
```

#### Étape 4 - Planifier le provisionnement
```bash
terraform plan
```

#### Étape 5 - Appliquer le provisionnement
```bash
terraform apply
```

Après avoir validé puis reçu un message de succès, naviguez sur votre console EC2 AWS, vous verrez que l'instance a bien été déployée

#### Étape 6 - Détruire l'infrastructure
```bash
terraform destroy
```

### Changer l'infrastructure

### Variables
```
variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}
```
### Outputs
```
output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Adresse IP publique de l'instance EC2"
  value       = aws_instance.app_server.public_ip
}


```
```bash
terraform output
```
#### Pour aller plus loin
[Explorez la documentation du "Provider" d'AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs), et observez la liste des ressources que l'on peut configurer avec Terraform les ressources AWS que l'on peut 


