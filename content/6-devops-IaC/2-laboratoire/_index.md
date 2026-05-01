+++
title = 'Laboratoire'
draft = false
weight = "520"
+++

# Introduction à Terraform

Ce laboratoire a pour but de vous introduire à Terraform et son *Workflow* en déployant une machine simple machine EC2 sur AWS. 

## 0 - Pré-requis
### 0.1 - Installation de AWS CLI

Afin de pouvoir communiquer avec l'API d'AWS, il faut d'abord installer l'interface de ligne de commande d'AWS (*AWS CLI*), qui est un client qui nous permet de nous authentifier à notre compte AWS, lister les ressources déployées, déployer de nouvelles ressources etc...

1. Installez AWS CLI en vous basant sur la [documentation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

2. Confirmez l'installation : 
```bash
aws --version
```

#### Exemple d'utilisation d'AWS CLI
```bash
aws ec2 describe-instances \
    --query 'Reservations[*].Instances[*].{Instance:InstanceId,Subnet:SubnetId}' \
    --output json
```
{{%notice style="tip" title="Documentation de AWS CLI"%}}
AWS CLI propose de nombreuses commandes. Toutes les ressources disponibles sur AWS peuvent être listées/créées/modifiées via la ligne de commandes. Pour plus d'informations sur les commandes disponibles, explorez la [documentation des commandes AWS CLI](https://awscli.amazonaws.com/v2/documentation/api/2.1.29/index.html)
{{%/notice%}}

### 0.2 - Installation de Terraform
1. Installez Terraform en vous basant sur la [documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2. Confirmez l'installation : 
```bash
terraform --version
```

## Laboratoire 1 - Déployer une instance EC2

### 1 - Connexion à AWS
+ Sur la page AWS Academy, démarrez votre environnement puis naviguez à l'onglet `AWS Details`.
+ Dans la section `AWS CLI`, copiez les identifiants puis collez les dans un fichier `~/.aws/credentials`.

### 2 - Création d'un fichier de configuration
```terraform
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.43.0"
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

### 3 - Initialisation du répertoire projet

Dans votre répertoire tapez la commande suivante pour initialiser le projet Terraform : 
```bash
terraform init
```

### Formater et valider la configuration
```bash
terraform fmt
```

```bash
terraform validate
```
### 4 - Planifier le provisionnement
```bash
terraform plan
```

### 5 - Appliquer le provisionnement
```bash
terraform apply
```

Après avoir validé puis reçu un message de succès, naviguez sur votre console EC2 AWS, vous verrez que l'instance a bien été déployée

### 6 - Détruire l'infrastructure
```bash
terraform destroy
```

### Changer l'infrastructure

### Variables
```terraform
variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}
```
### Outputs
```terraform
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
## Pour aller plus loin
[Explorez la documentation du *provider* d'AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs), et observez la liste des ressources que l'on peut configurer avec Terraform.


