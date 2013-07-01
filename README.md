Atelier Riak
============

Atelier d'initiation à Riak

## Installation de Riak

Tout d'abord, téléchargez Riak 1.3.2
```
curl -O http://s3.amazonaws.com/downloads.basho.com/riak/1.3/1.3.2/riak-1.3.2.tar.gz
tar zxvf riak-1.3.2.tar.gz
```

Installez Riak
```
cd riak-1.3.2
make all
```


Installez 4 noeuds
```make devrel DEVNODES=4```

Vous trouverez les 4 noeuds ainsi installés dans le répertoire dev :
```cd dev ; ls```

Configurez votre base : Les configurations doivent être effectuées dans chacun des noeuds. Le fichier de configuration est dans etc/app.config
Activez l'API Search : Dans app.config, vous trouverez une partie du fichier qui ressemble à :
```
%% Riak Search Config
{riak_search, [
{enabled, false}
]},
```
              
Vous devez passer la valeur à "true"

Activez le backend leveldb : Dans app.config, vous trouverez une partie du fichier qui ressemble à :
```
%% Riak KV config
 {riak_kv, [
{storage_backend, riak_kv_bitcask_backend},
```

Remplacez riak_kv_bitcask_backend par riak_kv_eleveldb_backend

Démarrez le premier noeud :
```dev1/bin/riak start```

Vous risquez d'avoir un problème de ULimit : 
allez faire un tour sur http://docs.basho.com/riak/latest/cookbooks/Open-Files-Limit/ pour configurer votre système correctement

Démarrez les autres noeuds :
```
dev2/bin/riak start
dev3/bin/riak start
dev4/bin/riak start
```

Vérifiez que tout est bien démarré
```ps aux | grep beam```

Joignez les noeuds
```
dev2/bin/riak-admin cluster join dev1@127.0.0.1
dev3/bin/riak-admin cluster join dev1@127.0.0.1
dev4/bin/riak-admin cluster join dev1@127.0.0.1
```

Faites un cluster plan
```dev2/bin/riak-admin cluster plan```

Puis un cluster commit
```dev2/bin/riak-admin cluster commit```



## Et maintenant, votre mission si vous l'acceptez...

sera d'alimenter correctement la base de données, puis d'essayer les différents types de requêtes que propose Riak.

*Les parties sont indépendantes les unes des autres ; n'hésitez pas à alterner si vous bloquez trop longtemps sur une question*

**NB : Les diverses parties vous redirigeront souvent vers la documentation de Basho. Il faudra veiller à indiquer le bon port dans les requêtes car dans la plupart de ses exemples, Basho indique le port 8091 tandis que le votre sera plus probablement 10018.

### Les bases - insérer, lire et supprimer

Pour cette partie, les informations utiles se trouvent dans [cette page](http://docs.basho.com/riak/1.3.2/tutorials/querying/Basic-Operations/)

1. Dans le répertoire basics, vous trouverez une image à insérer dans votre base de données. Elle devra être insérée dans le bucket "first_bucket" avec la clé "invalid"

2. Une fois insérée, ouvrez votre navigateur puis visualiser l'image depuis la base

3. Supprimez maintenant l'image

4. Vérifiez que l'image n'existe maintenant plus

### Les dettes dans le monde

Dans cette partie, nous allons insérer des données dans le bucket "debts_in_world". Ce bucket sera créé automatiquement à l'insertion de la première entrée : pas besoin de créer les bucket manuellement dans Riak.

Avant toute chose, il faut savoir que nous allons travailler avec l'API Search, qui nécessite :
- d'avoir correctement configuré le serveur comme expliqué plus haut
- d'avoir inséré un index sur le bucket "debts_in_world"

En effet, un index sur un bucket est en fait un hook qu'il faut avoir mis en place **avant** l'insertion de la **première donnée**, sans quoi vous risquez de vous retrouver face à des bugs assez énervants.
De cette manière, chaque nouvelle entrée dans la base sera interceptée par le hook et automatiquement indexée pour permettre une recherche sur la valeur contenue par l'entrée.

1. Insérez un index sur le bucket "debts_in_world" à l'aide du [lien suivant](http://docs.basho.com/riak/1.3.2/cookbooks/Riak-Search---Indexing-and-Querying-Riak-KV-Data/)

Dans le répertoire **sample-data** sont présents 3 fichiers : 
- **debt_stats_in_world.json** contient les données dont à envoyer vers la base de données.
- **insert_data.sh** est un script vous permettant d'ajouter un ensemble de données. Usage : ./insert_data.sh <input_file> <bucket_name>
- **delete_iter.sh** est un script vous permettant de supprimer un ensemble de données d'un bucket passé en argument. Ce script suppose donc que les clés du buckets à supprimer sont toutes des nombres compris entre 0 et la valeur passée en argument. Usage : ./delete_iter.sh <number_of_keys> <bucket_name>

2. Insérez toutes les données présentes dans debt_stats_in_world.json à l'aide du script insert_data.sh

**Une fois le script lancé, passez à la partie suivante le temps que les insertions se finissent (7.8MB de données à passer une par une en HTTP ça peut faire long...)**

3. Trouvez, avec Riak Search, les entrées qui ont pour IndicatorCode "DT.INT.DECT.GN.ZS" : [http://docs.basho.com/riak/1.3.2/cookbooks/Riak-Search---Querying/](http://docs.basho.com/riak/1.3.2/cookbooks/Riak-Search---Querying/)

*Les questions suivantes mettent en oeuvre des requêtes de type MapReduce dont vous trouverez un certain nombre d'exemples [ici](http://docs.basho.com/riak/1.3.2/tutorials/fast-track/Loading-Data-and-Running-MapReduce-Queries/)*

*Cette partie est aussi certainement la plus difficile, alors n'hésitez pas à revenir plus tard une fois les autres parties bien avancées*

5. Affichez toutes les dettes avec un Map/Reduce

6. Affichez tous les clés des pays supérieurs ayant une dette en 2011 à 1e13

7. Affichez tous les noms des pays ayant des dettes supérieures en 2011 à 1e12 et ayant une dette inférieure à celle de 2006

8. Comptez le nombre de pays ayant une dette supérieure à 1e11 en 2008 (toute dette confondue)

10. Challenge : Trouvez, pour chaque pays, le nom de l'indicateur et l'année (exprimée sous forme de 4 chiffres) pour laquelle la dette est la plus forte

### Réseau d'utilisateurs professionels

Les ressources relatives à cette partie sont situées dans le répertoire "search"

Vous trouverez comment requêter Riak avec l'API Search à [cette adresse](http://docs.basho.com/riak/1.3.2/cookbooks/Riak-Search---Querying/)


1. Placez un index dans le bucket "professional_users"

2. Insérez dans le bucket professional_users les 10 utilisateurs décrits dans le fichier "users.txt" avec comme clé nom_prenom. Les données seront au format JSon et la structure sera celle que laisse entendre la forme du fichier.

*N'oubliez pas que vous avez laissé la partie des dettes dans le monde tourner, ne laissez pas la crise détruire le monde, on compte sur vous !*

3. Cherchez tous les utilisateurs qui savent cuisiner

4. Cherchez tous les utilisateurs qui ont le langage "java" et "bigdata" dans leur cv à moins de 20 caractères d'espacement

*La suite de cette partie concerne le parcours de liens (link walking). Vous trouverez le nécessaire à la réalisation de ces points dans le répertoire "link_walking".*

5. Dans le répertoire link_walking se trouve un fichier professional_relationships.txt. Créer des liens entre les utilisateurs tels que décrits dans le fichier. Vous pouvez nommer vos liens comme vous le souhaitez.

6. Trouver tous les utilisateurs que suit Alfred.

7. Trouver tous les utilisateurs qui suivent Alfred.

**A cet endroit, vous risquez de rencontrer un problème absent des vraies bases de données orientées graphes, qui est la suffisance d'un lien unique. Il vous faudra sûrement recréer quelques liens une fois arrivés là... :-/**

8. Trouver les utilisateurs qui suivent les utilisateurs que suit Alfred.


### Vacances !!!

*Cette partie met en oeuvre les indexes secondaires dont vous trouverez la documentation [ici](http://docs.basho.com/riak/1.3.2/tutorials/Secondary-Indexes---Examples/)*

*Vous trouverez les ressources utiles à cette partie dans le répertoire 2i*

1. Insérez les images disponibles dans le répertoire correspondant à 6 pays et 2 types d'image, tout en mettant à chaque fois en place deux indexes secondaires : le type de photos (ville ou paysage) et le lieu. Le script utile à l'insertion des données est cette fois présent dans le répertoire 2i, mais il faudra cependant modifier légèrement ce script de manière à avoir les indexes attendus.

2. Récupérez les photos de type paysage.

3. Récupérez les photos de villes de Slovénie