#!/bin/bash

if [ "$EUID" -ne 0 ]
    then echo "Error: Please run the script as root"
    exit
fi


echo "Stopping MongoDB"
systemctl stop mongod.service

echo "Stopping MySQL"
systemctl stop mysql.service

echo "Stopping UI"
sudo docker stop userinterface_web_1

echo "Stopping Server"
sudo docker stop server_web_1

echo "Stopping Spark"
systemctl stop spark.service

echo "Stopping Kaka"
systemctl stop kafka.service

echo "Stopping Zookeeper"
systemctl stop zookeeper.service

echo "Stopping Kafka Producers"
pid="$(ps -ef | grep Producer | awk '{ print $2 }')"
kill -9 $pid
