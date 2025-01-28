Structure du fichier docker-compose.yml
Version de Compose :

```shell

version: '3'
```
La version 3 est utilisée pour définir la syntaxe du fichier. Elle est compatible avec Docker Compose 1.13.0 et ultérieur.

Services :

Deux services sont définis : drupal et postgres.

Service drupal :
```shell

drupal:
  volumes:
    - drupal:/var/www/html
  image: drupal:8-apache
  ports:
    - "8080:80"
  networks:
    - net
Volumes :
```

Le volume nommé drupal est monté dans le conteneur au chemin /var/www/html. Cela permet de persister les données de Drupal (comme les modules, thèmes, fichiers de configuration) même après la suppression du conteneur.

Image :

L'image Docker utilisée est drupal:8-apache, qui est une version de Drupal 8 avec un serveur Apache intégré.

Ports :

Le port 80 du conteneur (utilisé par Apache) est exposé sur le port 8080 de la machine hôte. Ainsi, Drupal est accessible via http://localhost:8080.

Réseaux :

Le service est connecté au réseau net, ce qui permet une communication entre les services.

Service postgres :
```shell

postgres:
  image: postgres:10
  environment:
    POSTGRES_PASSWORD: example
  volumes:
    - $PWD/data:/var/lib/postgresql/data
  networks:
    - net
Image :
```

L'image Docker utilisée est postgres:10, une version spécifique de PostgreSQL.

Environment :

La variable d'environnement POSTGRES_PASSWORD est définie avec la valeur example. Cela configure le mot de passe pour l'utilisateur par défaut de PostgreSQL.

Volumes :

Un volume est monté pour stocker les données de la base de données. Le répertoire data du répertoire courant ($PWD/data) est lié à /var/lib/postgresql/data dans le conteneur. Cela permet de persister les données de la base de données.

Réseaux :

Le service est également connecté au réseau net, permettant à Drupal de communiquer avec PostgreSQL.

Volumes :

```shell

volumes:
  drupal:
  ```
Un volume nommé drupal est défini pour stocker les fichiers de Drupal. Ce volume est utilisé par le service drupal.

Réseaux :

```shell

networks:
  net:
  ```
Un réseau nommé net est créé pour permettre aux services drupal et postgres de communiquer entre eux.

Fonctionnement global
Drupal : Le service Drupal est accessible via le port 8080 de la machine hôte. Il utilise le volume drupal pour stocker ses fichiers et est connecté au réseau net.

PostgreSQL : Le service PostgreSQL stocke ses données dans un répertoire local (data) sur la machine hôte. Il est également connecté au réseau net pour permettre à Drupal d'accéder à la base de données.

Communication : Les deux services communiquent via le réseau net, ce qui permet à Drupal de se connecter à la base de données PostgreSQL.

Utilisation
Placez ce fichier docker-compose.yml dans un répertoire de projet.

Exécutez la commande suivante pour démarrer les services :

bash

docker-compose up -d
Accédez à Drupal via http://localhost:8080.

Pour arrêter les services, utilisez :

bash

docker-compose down
Cette configuration est idéale pour développer un site Drupal avec une base de données PostgreSQL, tout en assurant la persistance des données et une communication fluide entre les services.