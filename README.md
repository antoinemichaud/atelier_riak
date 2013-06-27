Atelier Riak
============

Atelier d'initiation à Riak

## Installation de Riak

Tout d'abord, téléchargez Riak 1.3.2
```curl -O http://s3.amazonaws.com/downloads.basho.com/riak/1.3/1.3.2/riak-1.3.2.tar.gz
tar zxvf riak-1.3.2.tar.gz```

Installez Riak
```cd riak-1.3.2
make all```


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
]},```
              
Vous devez passer la valeur à "true"

Activez le backend leveldb : Dans app.config, vous trouverez une partie du fichier qui ressemble à :
```%% Riak KV config
 {riak_kv, [
{storage_backend, riak_kv_bitcask_backend},```

Remplacez riak_kv_bitcask_backend par riak_kv_eleveldb_backend

Démarrez le premier noeud :
```dev1/bin/riak start```

Vous risquez d'avoir un problème de ULimit : 
allez faire un tour sur http://docs.basho.com/riak/latest/cookbooks/Open-Files-Limit/ pour configurer votre système correctement

Démarrez les autres noeuds :
```dev2/bin/riak start
dev3/bin/riak start
dev4/bin/riak start```

Vérifiez que tout est bien démarré
```ps aux | grep beam```

Joignez les noeuds
```dev2/bin/riak-admin cluster join dev1@127.0.0.1
dev3/bin/riak-admin cluster join dev1@127.0.0.1
dev4/bin/riak-admin cluster join dev1@127.0.0.1```

Faites un cluster plan
```dev2/bin/riak-admin cluster plan```

Puis un cluster commit
```dev2/bin/riak-admin cluster commit```