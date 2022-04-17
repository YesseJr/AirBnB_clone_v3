#!/usr/bin/env bash
# Sets up webservers for deployment: (Run script on both servers)
# If not done, does the following:
#     installs Nginx; creates folders /data/, /data/web_static/,
#     /data/web_static/releases/, /data/web_static/shared,
#     /data/web_static/releases/test
#     /data/web_static/releases/test/index.html (with some content)

ADD_WEBSTATIC="\\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n"

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install nginx
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
echo "Test index.html file to test Nginx config" | sudo tee /data/web_static/releases/test/index.html
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -hR ubuntu:ubuntu /data/
sudo sed -i "35i $ADD_WEBSTATIC" /etc/nginx/sites-available/default
sudo service nginx start
