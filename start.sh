#!/bin/sh

/app/tailscaled --tun=userspace-networking --socks5-server=0.0.0.0:1055 &
until /app/tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=cloudrun --advertise-exit-node --advertise-tags=tag:cloudrun
do
    sleep 0.1
done
echo Tailscale started
ALL_PROXY=socks5://0.0.0.0:1055/ node --inspect index.js
