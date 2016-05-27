#!/bin/bash

set -e -x

# Needed so that the aptitude/apt-get operations will not be interactive
export DEBIAN_FRONTEND=noninteractive

add-apt-repository ppa:formorer/icinga --yes
apt-get --yes --quiet update && apt-get -y --quiet upgrade && apt-get -y --quiet install mysql-client htop git awscli

wget -qO- https://get.docker.com/ | sh

# pull the docker image
docker pull mysql

# run the container on top of the image
docker run -p 3900:3306 --name mysql -e MYSQL_ROOT_PASSWORD=toor -d mysql:latest

git clone https://github.com/eazeved0/test-deploy.git && cd test-deploy && docker build -t test-deploy/local:apache .

docker run -d -p 80:80 --name apache --link mysql:mysql -v /var/www/html:/var/www/html test-deploy/local:apache

cp db.php index.php logout.php /var/www/html/
cp cronlogs.sh /root && chmod +x /root/cronlogs.sh
echo '* 19 * * * /root/cronlogs.sh' | crontab -
