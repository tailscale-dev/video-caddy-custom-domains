#!/bin/bash
# downloads the caddy binary with the cloudflare plugin enabled
# must be run as root

caddy_path="/usr/local/bin/caddy"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -f "$caddy_path" ]; then
    echo "$caddy_path exists..."
    echo "Nothing to do. Exiting."
    exit 1
else
    curl "https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com%2Fcaddy-dns%2Fcloudflare" -o $caddy_path
    chmod +x $caddy_path
fi

cp caddy.service /etc/systemd/system/caddy.service
systemctl daemon-reload
mkdir -p /etc/caddy
useradd caddy
mkdir /home/caddy
chown -R caddy:users /home/caddy

echo "You'll want to modify you Caddyfile next..."
echo "Then copy it to `/etc/caddy/Caddyfile`"
