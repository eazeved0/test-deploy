#!/bin/bash


MYSQL=`docker ps |grep mysql |awk -F " " '{print $1}'`
APACHE=`docker ps |grep apache |awk -F " " '{print $1}'`
LOGS=/var/log/containers

if [ ! -d $LOGS ]; then
       mkdir $LOGS

fi

docker cp $APACHE:/var/log/apache2 $LOGS
docker cp $MYSQL:/var/log/mysql $LOGS

aws s3 sync /var/log/containers/ s3://test-deploy-eazevedo --region us-east-1
