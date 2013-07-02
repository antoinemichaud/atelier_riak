curl -XPUT http://localhost:10018/riak/travel_pictures/australia1 \
-H "type_bin: city" \
-H "x-riak-index-country_bin: australia" \
-H "Content-Type: image/jpeg" --data-binary @../australia_city.jpg

curl -XPUT http://localhost:10018/riak/travel_pictures/australia2 \
-H "x-riak-index-type_bin: landscape" \
-H "x-riak-index-country_bin: australia" \
-H "Content-Type: image/jpeg" --data-binary @../australia_landscape.jpg

curl -XPUT http://localhost:10018/riak/travel_pictures/hungary1 \
-H "x-riak-index-type_bin: city" \
-H "x-riak-index-country_bin: hungary" \
-H "Content-Type: image/jpeg" --data-binary @../hungary_city.jpg

curl -XPUT http://localhost:10018/riak/travel_pictures/hungary2 \
-H "x-riak-index-type_bin: landscape" \
-H "x-riak-index-country_bin: australia" \
-H "Content-Type: image/jpeg" --data-binary @../hungary_landscape.jpg

curl -XPUT http://localhost:10018/riak/travel_pictures/mexico1 \
-H "x-riak-index-type_bin: landscape" \
-H "x-riak-index-country_bin: mexico" \
-H "Content-Type: image/jpeg" --data-binary @../mexican_landscape.jpg

curl -XPUT http://localhost:10018/riak/travel_pictures/mexico2 \
-H "x-riak-index-type_bin: city" \
-H "x-riak-index-country_bin: mexico" \
-H "Content-Type: image/jpeg" --data-binary @../mexico_city.jpg

curl -XPUT http://localhost:10018/riak/travel_pictures/slovenia1 \
-H "x-riak-index-type_bin: city" \
-H "x-riak-index-country_bin: slovenia" \
-H "Content-Type: image/jpeg" --data-binary @../slovenia_city.jpg

curl -XPUT http://localhost:10018/riak/travel_pictures/slovenia2 \
-H "x-riak-index-type_bin: city" \
-H "x-riak-index-country_bin: slovenia" \
-H "Content-Type: image/jpeg" --data-binary @../slovenia_city2.jpg

curl -XPUT http://localhost:10018/riak/travel_pictures/slovenia3 \
-H "x-riak-index-type_bin: landscape" \
-H "x-riak-index-country_bin: slovenia" \
-H "Content-Type: image/jpeg" --data-binary @../slovenia_landscape.jpg
