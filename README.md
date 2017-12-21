# Distributed-work

This repo is a project about deploying automatically some service (here Apache Spark) on several nodes.
We are using Grid5000 mainly, and AWS here.

Scripts are organized as follows :

- "setup-XXX" (where "XXX" is a server provider, like Grid5000) : install Docker (17.09 recommanded) on every nodes, and setup docker-machine locally,

__important: the aliases of every nodes are in the "nodes-XXX.sh" script__, now, it is made for one master and n workers.
- "prepare-swarm" : setup a docker swarm between every nodes,
- "work" : deploy Spark on the swarm with a docker-compose file,
- "starter" : start a work (on Spark here).

Excepted the first script, they are platform-agnostic. With docker-machine, we basically doesn't care if the provider is OVH, AWS, Digital Ocean, or an other one. But the scripts are using "apt", so a Debian-like OS is recommanded. 

The easiest to test it is the "pyTest" project (approximation of Pi), as it doesn't require any dataset.

# Known issues :
- Support for n master nodes (quite straight forward)
- Replication of datasets if a docker service is scaled (not straight forward)
- AWS scripting is not done (but for Grid5000, it is done)
