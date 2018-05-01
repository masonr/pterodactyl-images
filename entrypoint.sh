#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Variables to determine what or if a Module is currently installed
touch /installed
INSTALLED=`cat /installed` # Check what Module is currently installed

# Install server files if no modules are installed OR if a different module is currently installed
if [[ "$INSTALLED" != "$MODULE" ]] ; then
	rm -rf /home/container/* # Clear any existing installation

	if [[ -z "$MODULE" ]] ; then
		MODULE="Native"
	fi

	if [[ "$MODULE" == "Native" ]] ; then # M&B Warband Native Install
		wget -qO- https://files.rowe.sh/wineconsole/warband/native/nat-latest.tar.gz | tar xvz --strip-componenets=1
		cp -rf /home/container/Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "The Deluge" ]] ; then # The Deluge Mod Install
		wget -qO- https://files.rowe.sh/wineconsole/warband/native/nat-latest.tar.gz | tar xvz --strip-componenets=1
		wget -qO- https://files.rowe.sh/wineconsole/warband/native/td-latest.tar.gz | tar xvz --strip-componenets=1
		cp -rf /home/container/sample_config.txt /home/container/Config.txt
	elif [[ "$MODULE" == "Napoleonic Wars" ]] ; then # M&B Warband NW Install
		wget -qO- https://files.rowe.sh/wineconsole/warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/NW_Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "North and South First Manassas" ]] ; then # North and South Mod Install
		wget -qO- https://files.rowe.sh/wineconsole/warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/wineconsole/warband/nw/nas-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/NaS_Sample_Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "Whigs and Tories Final" ]] ; then # Whigs and Tories Mod Install
		wget -qO- https://files.rowe.sh/wineconsole/warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/wineconsole/warband/nw/wat-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/WaT_Sample/Team_Deathmatch.txt /home/container/Config.txt
	elif [[ "$MODULE" == "Blood and Iron Age of Imperialism" ]] ; then # Blood and Iron Mod Install
		wget -qO- https://files.rowe.sh/wineconsole/warband/nw/nw-latest.tar.gz | tar xvz --strip-components=1
		wget -qO- https://files.rowe.sh/wineconsole/warband/nw/bai-latest.tar.gz | tar xvz --strip-components=1
		cp -rf /home/container/bi_Sample_Team_Deathmatch.txt /home/container/Config.txt
	else
		exit 1
	fi

	echo "$MODULE" > /installed
fi

# Edit Server Name

# Edit Server Password

# Edit Server Welcome Message

# Edit Player Count

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
