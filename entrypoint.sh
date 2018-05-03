#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Variables to determine what or if a Module is currently installed
INSTALLED=`ls /home/container/Modules | grep "$MODULE"` # Check if Module is currently installed

# Install server files if no modules are installed OR if a different module is currently installed
if [[ -z "$INSTALLED" ]] ; then
	if [[ -z "$MODULE" ]] ; then
		MODULE="Native"
	fi

	if [[ "$MODULE" == "Native" ]] ; then # M&B Warband Native Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/native/nat-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "The Deluge" ]] ; then # The Deluge Mod Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/native/nat-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/native/td-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/sample_config.txt /home/container/Config.txt
	elif [[ "$MODULE" == "FI2 Amber 2.0" ]] ; then # Full Invasion 2 Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/native/nat-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/native/fi2-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/fi2.txt /home/container/Config.txt
	elif [[ "$MODULE" == "MoR_2.5" ]] ; then # Mount & Gladius/March of Rome Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/native/nat-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/native/mor-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/MoRconfig.txt /home/container/Config.txt
	elif [[ "$MODULE" == "PW_4.5" ]] ; then # Persistent World Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/native/nat-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/native/pw-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/PW_server_cfg.txt /home/container/Config.txt
	elif [[ "$MODULE" == "Napoleonic Wars" ]] ; then # M&B Warband NW Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/NW_Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "AZW Reloaded" ]] ; then # Anglo-Zulu War Reloaded Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/azw-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/ZULUconfig.txt /home/container/Config.txt	
	elif [[ "$MODULE" == "Bello Civili" ]] ; then # Bello Civili Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/bc-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/BelloCivili_Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "Blood and Iron Age of Imperialism" ]] ; then # Blood and Iron Mod Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/bai-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/bi_Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "Iron Europe" ]] ; then # Iron Europe Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/ie-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/ie_config.txt /home/container/Config.txt
	elif [[ "$MODULE" == "North and South First Manassas" ]] ; then # North and South Mod Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nas-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/NaS_Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "PikeShotte" ]] ; then # Pike & Shotte Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/ps-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "Red and Blue 1936 v2.1" ]] ; then # Red and Blue 1936 Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/rab-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/RaB_Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "War of 1812" ]] ; then # War of 1812 Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/wo1812-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/Wo1812_Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "Whigs and Tories Final" ]] ; then # Whigs and Tories Mod Install
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/pterodactyl/mb-warband/nw/wat-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/WaT_Sample_Team_Deathmatch.txt /home/container/Config.txt
	else
		exit 1
	fi

	echo "$MODULE" > /installed
fi

# Edit Server Name ($SERVER_NAME)
sed -i 's/.*set_server_name.*/set_server_name '"$SERVER_NAME"'/g' /home/container/Config.txt

# Edit Server Admin Password ($ADMIN_PASSWORD)
sed -i 's/.*set_pass_admin.*/set_pass_admin '"$ADMIN_PASS"'/g' /home/container/Config.txt

# Edit Server Password
sed -i 's/.*set_pass .*/set_pass '"$SERVER_PASS"'/g' /home/container/Config.txt

# Edit Server Welcome Message ($MOTD)
sed -i 's/.*set_welcome_message.*/set_welcome_message '"$MOTD"'/g' /home/container/Config.txt

# Edit Player Count ($PLAYERS)
sed -i 's/.*set_max_players.*/set_max_players '"$PLAYERS"' '"$PLAYERS"'/g' /home/container/Config.txt

# Edit Server Port
sed -i 's/.*set_port.*/set_port '"$SERVER_PORT"'/g' /home/container/Config.txt

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
