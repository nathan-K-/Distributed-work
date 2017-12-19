source $1
docker-machine scp -r /home/nathan/DEV/Distributed-work/spark/projets/ $MANAGER:/root/
PROJET="pyTest/docker-compose.yml"

# Setup and start the work
for NODE in ${NODES[*]}; do
        #docker-machine ssh $NODE "docker pull $DOCKER_IMAGE"
        docker-machine ssh $NODE "mkdir -p spark/conf/worker && mkdir -p spark/conf/master && mkdir -p spark/data"
done

# images should be downloaded automatically

docker-machine scp -r ./projets/ $MANAGER:/root/
docker-machine ssh $MANAGER "docker stack deploy --compose-file /root/projets/$PROJET sparkstack"

# docker-machine ssh $MANAGER "docker stack rm sparkstack"