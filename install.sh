#!/bin/bash
# Holdfast Installation Script
#
# Server Files: /mnt/server
apt -y update
apt -y install wget ca-certificates bsdtar

mkdir -p /mnt/server/steamcmd
cd /mnt/server/steamcmd
wget -qO- http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar xvz

# SteamCMD fails otherwise for some reason, even running as root.
# This is changed at the end of the install process anyways.
chown -R root:root /mnt

export HOME=/mnt/server
./steamcmd.sh +@sSteamCmdForcePlatformType windows +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /mnt/server +app_update ${SRCDS_APPID} +quit

cd /mnt/server
wget -qO- https://www.dropbox.com/sh/ppkfny3r9kcnz8x/AADiIXOrlAWPh-XbhPpimw0ja?dl=1 | bsdtar -xvf-
cp serverconfig_server1_armybattlefield.txt serverconfig.txt
chmod 755 /mnt/server/*
