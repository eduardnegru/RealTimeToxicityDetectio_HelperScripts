#!/bin/bash

if [ "$EUID" -ne 0 ]
    then echo "Error: Please run the script as root"
    exit
fi

LOG_PATH="/var/log/realtimetoxicitydetection"

echo "Starting MongoDB service"
systemctl start mongod.service

echo "Starting MySQL service"
systemctl start mysql.service

echo "Starting Zookeeper"
systemctl start zookeeper.service

echo "Wait Zookeeper to start"
sleep 10

echo "Starting Kafka"
systemctl start kafka.service

sleep 5

echo "Starting Producers"
#./start_kafka_producer.sh > $LOG_PATH/kafka_producer.log 2>&1 &

echo "Starting Spark consumer - MongoDB"
systemctl start spark.service

echo "Starting UI"
cd ./UserInterface
docker-compose up -d
docker-compose logs > ui.log
cd ..

echo "Starting API Server"
cd ./Server
docker-compose up -d
docker-compose logs > api.log
cd ..


