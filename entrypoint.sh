#!/bin/bash

start_zookeeper()
{
	mkdir -p /tmp/zookeeper/
	echo $zookeeper_id > /tmp/zookeeper/myid
	echo initLimit=100 >> /opt/kafka/config/zookeeper.properties
	echo tickTime=2000 >> /opt/kafka/config/zookeeper.properties
	echo initLimit=100 >> /opt/kafka/config/zookeeper.properties
	echo syncLimit=2   >> /opt/kafka/config/zookeeper.properties

	arr=(`echo $zookeeper_node | tr "," "\n"`)
	count=1

	for i in "${arr[@]}"
		{
			echo server.$count=${i::-5}:2888:3888 >> /opt/kafka/config/zookeeper.properties
			count=$(( $count + 1 ))
		}
	echo /opt/kafka/bin/zookeeper-server-start.sh -daemon /opt/kafka/config/zookeeper.properties
}

start_broker()
{
	sed -i -e 's/broker.id=0/broker.id='"$broker_id"'/g' /opt/kafka/config/server.properties
	sed -i -e 's/zookeeper.connect=localhost:2181/zookeeper.connect='"$zookeeper_node"'/g' /opt/kafka/config/server.properties
	echo /opt/kafka/bin/kafka-server-start.sh -daemon /opt/kafka/config/server.properties
}

if [ -z "$mode"   ] || [ -z "$zookeeper_node" ] 
then
	echo "Please define ENV variable mode as zookeeper,kafka or broker along with zookeeper_node which contain comma seprated list of zookeeper:port"
	
elif [ $mode = "zookeeper" ] || [ -z "$zookeeper_id" ]
then
	start_zookeeper
    
elif [ $mode = "kafka" ]
then
	start_zookeeper
	start_broker

elif [ $mode = "broker" ]
then
	start_broker
fi

while true; do sleep 1000; done
