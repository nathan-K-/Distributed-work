###########################
# This will setup n nodes in a docker swarm, over Grid5000
###########################

#MANAGER=$(echo "$1" | tr -d '"') # remove quote

source $1

DOCKER_IMAGE="gettyimages/spark:2.2.0-hadoop-2.7"

echo -n "Password: "
read -s PWD
echo

docker-g5k create-cluster --g5k-username "nkienlen" --g5k-password "$PWD" --g5k-image "jessie-x64-base" --g5k-reserve-nodes "lyon:${#NODES[@]}" --g5k-walltime "4:00:00"

for NODE in ${NODES[*]}; do
    docker-machine ssh $NODE "sudo apt update && sudo apt install -y --force-yes git docker-ce=17.09.1~ce-0~debian"
    docker-machine ssh $NODE "docker pull $DOCKER_IMAGE"
done
