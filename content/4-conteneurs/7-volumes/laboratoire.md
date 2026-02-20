+++
title = 'Laboratoire'
draft = false
weight = "451"
+++
-------------------

Laboratoire guidé – Tester la persistance avec un volume

## Objectif

Comprendre que :
+ Les données d’un conteneur sont perdues si on ne persiste rien
+ Un volume Docker permet de conserver les données même après suppression du conteneur

## 1 — Sans volume

1. Lancez un conteneur *MySQL* sans volume
```bash
docker run -d \
  --name db-test \
  -e MYSQL_ROOT_PASSWORD=secret \
  mysql
```
2. Connectez-vous au conteneur
```bash
docker exec -it db-test mysql -uroot -p
```
> Mot de passe : secret

3. Créez une base de données
```sql
CREATE DATABASE testdb;
SHOW DATABASES;
```

Vous devriez voir `testdb`.

4. Supprimez le conteneur
```bash
docker rm -f db-test
```
5. Recréez le conteneur
```bash
docker run -d \
  --name db-test \
  -e MYSQL_ROOT_PASSWORD=secret \
  mysql
```

Reconnectez-vous : La base `testdb` a disparu...

## 2 — volume
1. Créez un volume
```bash
docker volume create db-data
```
2. Lancez MySQL avec le volume
```bash
docker run -d \
  --name db-persist \
  -e MYSQL_ROOT_PASSWORD=secret \
  -v db-data:/var/lib/mysql \
  mysql
```
3. Créez une base de données
```bash
docker exec -it db-persist mysql -uroot -p
CREATE DATABASE persistentdb;
SHOW DATABASES;
```
4. Supprimez le conteneur
```bash
docker rm -f db-persist
```
5. Recréez le conteneur avec le même volume
```bash
docker run -d \
  --name db-persist \
  -e MYSQL_ROOT_PASSWORD=secret \
  -v db-data:/var/lib/mysql \
  mysql
```

Reconnectez-vous : La base `persistentdb` est toujours là.

6. Nettoyage
```bash
docker rm -f db-persist
docker volume rm db-data
```