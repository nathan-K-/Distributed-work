###########################
# This will setup n nodes in a docker swarm, over Grid5000
###########################

MANAGER='lyon-0'
WORKERS=(
        'lyon-1'
        'lyon-2'
)
NODES=(
	'lyon-0'
	'lyon-1'
	'lyon-2'
)

DOCKER_IMAGE="gettyimages/spark:2.2.0-hadoop-2.7"

echo -n "Password: "
read -s PWD
echo

docker-g5k create-cluster --g5k-username "nkienlen" --g5k-password "$PWD" --g5k-image "jessie-x64-base" --g5k-reserve-nodes "lyon:${#NODES[@]}"

for NODE in ${NODES[*]}; do
        docker-machine ssh $NODE "sudo apt update && sudo apt install -y --force-yes docker-ce=17.09.1~ce-0~debian"
done

docker-machine ssh $MANAGER "docker swarm init"

JOIN_TOKEN=$(docker-machine ssh $MANAGER "docker swarm join-token worker --quiet")
MANAGER_IPS=$(docker-machine ssh $MANAGER "hostname -I")
MANAGER_IP=$(echo $MANAGER_IPS  | cut -d" " -f1)

for NODE in ${WORKERS[*]}; do
        docker-machine ssh $NODE "docker swarm join --token $JOIN_TOKEN $MANAGER_IP:2377"
done

for NODE in ${NODES[*]}; do
        #docker-machine ssh $NODE "docker pull $DOCKER_IMAGE"
        docker-machine ssh $NODE "mkdir -p spark/conf/worker && mkdir -p spark/conf/master && mkdir -p spark/data"
done

# images should be downloaded automatically

docker-machine scp /home/nathan/DEV/SRGETGMD/spark/docker-compose.yml $MANAGER:/root/docker-compose.yml
docker-machine ssh $MANAGER "docker stack deploy --compose-file docker-compose.yml sparkstack"

# docker-machine ssh $MANAGER "docker stack rm sparkstack"