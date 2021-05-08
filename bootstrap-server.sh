#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root/with sudo"
  exit
fi

URI="https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/650/downloads/paper-1.16.5-650.jar"

useradd -r -m -U -d /opt/mc-server -s /sbin/nologin minecraft

yum install java -y

cat >/etc/systemd/system/mc-server.service <<EOL
[Unit]
Description=Minecraft Server Service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
WorkingDirectory=/opt/mc-server/
Restart=always
RestartSec=1
User=minecraft
ExecStart=/usr/lib/jvm/java-11-amazon-corretto.aarch64/bin/java -Xms2G -Xmx2G -jar /opt/mc-server/server.jar

[Install]
WantedBy=multi-user.target
EOL

systemctl daemon-reload

cd /opt/mc-server/

curl $URI > /opt/mc-server/server.jar

java -Xmx1024M -Xms1024M -jar /opt/mc-server/server.jar nogui
chown -R minecraft:minecraft /opt/mc-server/
sed -i 's/=false/=true/g' /opt/mc-server/eula.txt

echo "Run 'sudo systemctl start mc-server' to start your server"