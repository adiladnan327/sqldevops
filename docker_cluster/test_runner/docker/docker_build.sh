#!/bin/bash

rm -rf git
mkdir git
git clone https://github.com/rbenv/rbenv.git ./git/rbenv 
git clone https://github.com/rbenv/ruby-build.git ./git/rbenv/plugins/ruby-build 

cd git 

curl ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.27.tar.gz -o freetds-1.00.27.tar.gz && tar -xzf freetds-1.00.27.tar.gz 
rm freetds-1.00.27.tar.gz
cd ..

docker build . --rm -t slackerbuild:temp

docker run --name slackerbuild_temp -d slackerbuild:temp
docker export slackerbuild_temp | docker import - slackerbuild:latest

docker rm -f slackerbuild_temp
docker rmi slackerbuild:temp

docker rmi -f $(docker images -f "dangling=true" -q)