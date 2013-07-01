#!/bin/bash
if [ $# -ne 2 ]
then
  echo "You must pass the number of keys to delete, then the name of the concerned bucket"
else 
  number_of_entries=$1
  bucket_name=$2
  for ((i=0; i<=$number_of_entries; i++))
  do
    echo "Line "\'$i\'" gona be removed"
    curl -X DELETE http://127.0.0.1:10018/riak/$bucket_name/$i
    echo "Line correctly removed"
  done
fi