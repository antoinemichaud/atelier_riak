curl -X PUT http://127.0.0.1:10018/riak/professional_users/boeuf_simon  -H "Content-Type: application/json" -d '{"nom" : "Boeuf","prenom" : "Simon","CV" : {"profession" : "la programmation. Il connait le java mais le php et le bigdata sont ses points forts.","passion" : "cuisiner les escargots à la tomate."}}' 

curl -X PUT http://127.0.0.1:10018/riak/professional_users/henri_alfred -H "Content-Type: application/json" -d '{"nom" : "Henri","prenom" : "Alfred","CV" : {"profession" : "Organiser les dîners mondains.","passion" : "Il cuisine souvent des hamburgers à 20 étages composés de 10 steaks chacuns qu''il passe son temps à manger devant la télé (oui, tout le monde a le droit à son péché mignon)"}}'

curl -X PUT http://127.0.0.1:10018/riak/professional_users/dubateau_christophe -H "Content-Type: application/json" -d '{"nom" : "Dubateau","prenom" : "Christophe","CV" : {"profession" : "Skipper chevronné, il programme aussi lui-même les programmes de navigation de son bâteau.","passion" : "L''équitation et respirer les embruns martimes."}}'

curl -X PUT http://127.0.0.1:10018/riak/professional_users/lagaffe_gaston -H "Content-Type: application/json" -d '{"nom" : "Lagaffe","prenom" : "Gaston","CV" : {"profession" : "Aide de bureau ultra-motivé.","passion" : "les mouettes, les chats et toute sorte d''objets insolites."}}'

curl -X PUT http://127.0.0.1:10018/riak/professional_users/eastwood_clint -H "Content-Type: application/json" -d '{"nom" : "Eastwood","prenom" : "Clint","CV" : {"profession" : "Chasser le bandit contre d''alléchantes primes.","passion" : "cuisiner les bandits aux petits oignons."}}'

curl -X PUT http://127.0.0.1:10018/riak/professional_users/lederniermousquetaire_albert -H "Content-Type: application/json" -d '{"nom" : "Lederniermousquetaire","prenom" : "Albert","CV" : {"profession" : "Acteur de dessin animé.","passion" : "Danseur de french cancan tous les samedis soirs au cabaret \"Le cardinal\"."}}'
 