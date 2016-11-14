#!/bin/bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update
sudo apt-get install -y mongodb-org

FILE="/etc/systemd/system/mongodb.service"
sudo cat <<EOM >$FILE
[Unit]
Description=High-performance, schema-free document-oriented database
After=network.target

[Service]
User=mongodb
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

[Install]
WantedBy=multi-user.target
EOM

echo "Starting service..."

sudo systemctl start mongodb
sudo systemctl status mongodb
sudo systemctl enable mongodb

echo -e "Mongo admin password: \c"
read PASS
echo ""

mongo --eval 'db.createUser({user:"admin", pwd:"$PASS", roles:[{role:"root", db:"admin"}]})'

echo "admin user created."

sudo cat <<EOM >$FILE
[Unit]
Description=High-performance, schema-free document-oriented database
After=network.target

[Service]
User=mongodb
ExecStart=/usr/bin/mongod --quiet --auth --config /etc/mongod.conf

[Install]
WantedBy=multi-user.target
EOM

sudo systemctl daemon-reload

echo "MongoDB installed."
