#!/bin/bash

apt-get update

apt-get install -y nginx

echo "balancer" > /var/www/html/index.html

echo """

upstream backend {
   server 192.168.100.2;
   server 192.168.100.3;
}

server {
  listen 80;

  location /worker {
    rewrite ^/worker(.*) /$1 break;
    proxy_pass http://backend;
  }
}

""" > /etc/nginx/sites-available/default

service nginx restart