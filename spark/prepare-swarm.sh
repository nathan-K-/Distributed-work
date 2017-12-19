source $1

# Init the docker swarm
docker-machine ssh $MANAGER "docker swarm init"

JOIN_TOKEN=$(docker-machine ssh $MANAGER "docker swarm join-token worker --quiet")
#MANAGER_IPS=$(docker-machine ssh $MANAGER "hostname -I")
#MANAGER_IP=$(echo $MANAGER_IPS  | cut -d" " -f1)

MANAGER_IP=$(docker-machine ip $MANAGER)

for NODE in ${WORKERS[*]}; do
        docker-machine ssh $NODE "docker swarm join --token $JOIN_TOKEN $MANAGER_IP:2377"
done