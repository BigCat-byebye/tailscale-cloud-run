#!/bin/sh

/app/tailscaled --tun=userspace-networking &
until /app/tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=cloudrun --advertise-exit-node --advertise-tags=tag:cloudrun
do
    sleep 0.1
done
echo Tailscale started
node --inspect index.js
