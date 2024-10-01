#!/bin/bash

# Start Zookeeper
/kafka/bin/zookeeper-server-start.sh /kafka/config/zookeeper.properties &

# Wait for Zookeeper to start
sleep 5

# Start Kafka
/kafka/bin/kafka-server-start.sh /kafka/config/server.properties
