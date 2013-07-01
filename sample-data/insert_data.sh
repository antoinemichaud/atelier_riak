#!/bin/sh
if [ $# -ne 2 ]
then
  echo "You must pass as arguments the input file, then the name of the bucket to fill"
else 
  input_file=$1
  bucket_name=$2
  i=0
  if [ -f $input_file ]
  then
    while read line
    do
      echo "La ligne "\'$line\'" va être insérée"
      curl -X PUT http://127.0.0.1:10018/riak/$bucket_name/$i -d "$line" -H 'content-type: application/json'
      echo "La ligne a correctement été insérée"
      i=$(($i + 1))
    done < $input_file
  else
    echo "Le fichier indiqué n'existe pas"
  fi
fi