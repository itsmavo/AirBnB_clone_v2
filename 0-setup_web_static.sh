#!/usr/bin/env bash
# sets up server for web static

sudo apt-get -y update
sudo apt-get -y install nginx
sudo mkdir -p /data/
sudo mkdir -p /data/web_static/
sudo mkdir -p /data/web_static/releases/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/
sudo echo -e "<html>
<head></head>
<body>
 Holberton School
</body>
</html>" | sudo tee /data/web_static/releases/test/index.html
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -R ubuntu:ubuntu /data/
file=/etc/nginx/sites-available/default
printf %s "server {
	listen 80 default_server;
	listen [::]:80 default_server;
	server_name _;
	add_header X-Served-By $HOSTNAME;
	root   /var/www/html;
	index  index.html index.htm;

	location /hbnb_static {
		alias /data/web_static/current;
		index index.html index.htm;
	}

	location /redirect_me {
		return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
	}
	error_page 404 /404.html;
     	location = /404.html{
     		internal;
     	}
}" > $file


sudo service nginx restart
