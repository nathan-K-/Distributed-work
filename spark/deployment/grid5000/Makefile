singleNodePyspark: # :2.2.0-hadoop-2.7
	docker run -it --rm -p 4040:4040 -p 8080:8080 gettyimages/spark:2.2.0-hadoop-2.7 pyspark

deploySwarm:
	docker stack deploy --compose-file docker-compose.yml sparkstack

setupSwarm:
	bash -C ./setup-grid5000.sh

#swarmWork:
#./bin/spark-submit \
--master spark://master:7077 \
examples/src/main/python/pi.py \
1000