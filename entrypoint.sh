#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Get external IP address
export EXTERNAL_IP=`hostname -i`

# Update Source Server
if [ ! -z ${SRCDS_APPID} ]; then
    ./steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_update ${SRCDS_APPID} +quit
fi

# Spawn a virtual frame buffer
Xvfb :0 -screen 0 1024x768x16 -ac &

# Edit Server Name ($SERVER_NAME)
sed -i 's/.*server_name.*/server_name '"$SERVER_NAME"'/g' /home/container/serverconfig.txt

# Edit Player Count ($PLAYERS)
sed -i 's/.*maximum_players.*/maximum_players '"$PLAYERS"'/g' /home/container/serverconfig.txt

# Edit Server Welcome Message ($MOTD)
sed -i 's/.*server_welcome_message.*/server_welcome_message '"$MOTD"'/g' /home/container/serverconfig.txt

# Edit Server Region ($REGION)
sed -i 's/.*server_region.*/server_region '"$REGION"'/g' /home/container/serverconfig.txt

# Edit Server Admin Password ($ADMIN_PASS)
sed -i 's/.*server_admin_password.*/server_admin_password '"$ADMIN_PASS"'/g' /home/container/serverconfig.txt

# Edit Server Password ($SERVER_PASS)
sed -i 's/.*server_password.*/server_password '"$SERVER_PASS"'/g' /home/container/serverconfig.txt

# Edit Server Port ($SERVER_PORT)
sed -i 's/.*server_port.*/server_port '"$SERVER_PORT"'/g' /home/container/serverconfig.txt

# Edit Server Communications Port ($SERVER_COMM_PORT)
sed -i 's/.*steam_communications_port.*/steam_communications_port '"$SERVER_COMM_PORT"'/g' /home/container/serverconfig.txt

# Edit Server Query Port ($SERVER_QUERY_PORT)
sed -i 's/.*steam_query_port.*/steam_query_port '"$SERVER_QUERY_PORT"'/g' /home/container/serverconfig.txt

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
