curl -XPUT -H "content-type:application/json" http://localhost:10018/riak/debts_in_world \
-d '{"props":{"precommit":[{"mod":"riak_search_kv_hook","fun":"precommit"}]}}'