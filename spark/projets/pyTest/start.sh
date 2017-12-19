
NUM=$(docker service ps -f 'name=sparkstack_master.1' sparkstack_master -q)
MASTER_ID=
MASTER_ID=$(docker ps -aqf "name=$(sparkstack_master.1.$NUM)")

docker exec $MASTER_ID ./bin/spark-submit --master spark://master:7077 examples/src/main/python/pi.py 1000