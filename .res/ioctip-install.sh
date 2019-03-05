#!/usr/bin/env bash
# Used on Ubuntu 16.04.6 LTS (xenial)
# assuming that /iocoin exists and contains:
# * iocoin.conf
# * iocoind (daemon, binary)
# * config.json
# * this script

# Prepare daemon
mkdir /iocoin/daemon
mkdir /iocoin/data
mv iocoin.conf /iocoin/data/iocoin.conf
mv iocoind /iocoin/daemon/iocoind

# Download the bot
cd /iocoin
git clone https://github.com/DarthJahus/ioctip-telegram
mv config.json /iocoin/ioctip-telegram/

# start daemon service
cd /iocoin/ioctip-telegram/.res
cp ./iocoind.service /lib/systemd/system/iocoind.service
chmod 644 /lib/systemd/system/iocoind.service
systemctl daemon-reload
systemctl enable iocoind.service
systemctl start iocoind.service
systemctl status iocoind.service

# Start bot service
cd /iocoin/ioctip-telegram/
cp ./ioctip.service /lib/systemd/system/iocoind.service
chmod 644 /lib/systemd/system/ioctip.service
systemctl daemon-reload
systemctl enable ioctip.service
systemctl start ioctip.service
systemctl status ioctip.service
