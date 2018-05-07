#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Variables to determine what or if a Module is currently installed
INSTALLED=`ls /home/container/Modules | grep "$MODULE"` # Check if Module is currently installed

# Install server files if the module selected is not currently installed
if [[ -z "$INSTALLED" ]] ; then
	# Backup existing configs, logs, and ban list
	DATE=`date '+%Y-%m-%d %H:%M:%S'`
	mkdir -p "/home/container/Backups/$DATE"
	cp /home/container/Config.txt "/home/container/Backups/$DATE/"
	cp -r /home/container/Logs/ "/home/container/Backups/$DATE/"
	cp /home/container/ban_list.txt "/home/container/Backups/$DATE/"

	if [[ -z "$MODULE" ]] ; then
		MODULE="Native"
	fi

	# Download helper script with all server file links
	wget "https://files.rowe.sh/pterodactyl/mb-warband/mb-warband-links.sh"
	chmod +x mb-warband-links.sh

	# Generate links for server files
	MODULE_BASE_LINK=`./mb-warband-links.sh link "$MODULE" base`
	MODULE_LINK=`./mb-warband-links.sh link "$MODULE" mod`

	# Ensure module files link has been obtained, exit if not
	if [[ -z "$MODULE_LINK" ]] ; then
		echo "ERROR: Module name was mistyped or is not currently supported."
		echo "Available modules:"
		./mb-warband-links.sh modules
		exit 1
	fi

	# Install base server files, if needed
	if [[ ! -z "$MODULE_BASE_LINK" ]] ; then
		BASE_INSTALLED=`ls /home/container/Modules | grep $(./mb-warband-links.sh base "$MODULE")`
		if [[ ! -z "$BASE_INSTALLED" ]] ; then
			wget -qO- $MODULE_BASE_LINK | tar xvz --strip-components=1
		fi
	fi

	# Install module files
	wget -qO- $MODULE_LINK | tar xvz --strip-components=1
	cp -rf /home/container/"$MODULE"_Sample_Config.txt /home/container/Config.txt
	dos2unix /home/container/Config.txt

	echo "Module: $MODULE has been sucessfully installed."
	rm mb-warband-links.sh
fi

# Edit Server Name ($SERVER_NAME)
sed -i 's/.*set_server_name.*/set_server_name '"$SERVER_NAME"'/g' /home/container/Config.txt

# Edit Server Admin Password ($ADMIN_PASSWORD)
sed -i 's/.*set_pass_admin.*/set_pass_admin '"$ADMIN_PASS"'/g' /home/container/Config.txt

# Edit Server Password ($SERVER_PASS)
sed -i 's/.*set_pass .*/set_pass '"$SERVER_PASS"'/g' /home/container/Config.txt
sed -i 's/.*set_pass$/set_pass '"$SERVER_PASS"'/g' /home/container/Config.txt

# Edit Server Welcome Message ($MOTD)
sed -i 's/.*set_welcome_message.*/set_welcome_message '"$MOTD"'/g' /home/container/Config.txt

# Edit Player Count ($PLAYERS)
sed -i 's/.*set_max_players.*/set_max_players '"$PLAYERS"' '"$PLAYERS"'/g' /home/container/Config.txt

# Edit Server Port ($SERVER_PORT)
sed -i 's/.*set_port.*/set_port '"$SERVER_PORT"'/g' /home/container/Config.txt

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
