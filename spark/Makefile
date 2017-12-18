SOURCE-GRID="grid5000/nodes-grid5000.sh"
SOURCE-AWS="aws/nodes-aws.sh"


# On l'appelle l'ovni celui-ci
singleNodePyspark:
	docker run -it --rm -p 4040:4040 -p 8080:8080 gettyimages/spark:2.2.0-hadoop-2.7 pyspark


# Provider specific
setup-grid5000:
	bash -C ./grid5000/setup-grid5000.sh $(SOURCE-GRID)

setup-aws:
	bash -C ./aws/setup-aws.sh $(SOURCE-AWS)


# General
prepare-swarm-grid5000:
	bash -C ./prepare-swarm.sh $(SOURCE-GRID)
prepare-swarm-aws:
	bash -C ./prepare-swarm.sh $(SOURCE-AWS)

work-grid5000:
	bash -C ./work.sh $(SOURCE-GRID)
work-aws:
	bash -C ./work.sh $(SOURCE-AWS)



# Final (!)
start-grid5000: setup-grid5000 prepare-swarm-grid5000 work-grid5000

start-aws: setup-aws prepare-swarm-aws work-aws


start-grid5000-pytest:
	bash -C ./grid5000/projets/pyTest/starter.sh $(SOURCE-GRID)
#swarmWork:
#./bin/spark-submit \
--master spark://master:7077 \
examples/src/main/python/pi.py \
1000