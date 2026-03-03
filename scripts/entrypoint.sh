#!/bin/sh
set -e

# If SSL certs are mounted, use HTTPS config (replace default so only one is active)
if [ -f /etc/nginx/ssl/fullchain.pem ] && [ -f /etc/nginx/ssl/privkey.pem ]; then
	cp /etc/nginx/conf.d/nginx-ssl.conf /etc/nginx/conf.d/default.conf
	rm /etc/nginx/conf.d/nginx-ssl.conf
fi

exec nginx -g "daemon off;"
