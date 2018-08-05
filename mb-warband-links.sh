#!/bin/bash
# Initial: 4 May 2018
# Last Updated: 5 Aug 2018
# Maintained by Mason Rowe <mason@rowe.sh>
#
# mb-warband-links.sh
# 	Serves the most up to date download links for Modules for Mount and Blade: Warband game servers.
#	Link to download the correct files will be stored in the env var: DL_LINK
#

# Environment variable to hold the URL of the correct files to download
MB_WB_DL_LINK=""
# Command to run
MB_WB_CMD=$1
# Name of the Mount and Blade Warband Module
MB_WB_MODULE=$2
# Type of link to generate (either "base" or "mod")
# 	base = the base files needed to run the modded instance (i.e. Native files are a prereq for Deluge)
#		Note: can return null if no base files are needed (i.e. Native or Napoleonic Wars modules)
#	mod = the modded files to install over top of the base server files
MB_WB_DL_TYPE=$3

# Supported Native Modules
MB_WB_NATIVE_MODS=( "The Deluge" "FI2 Amber 2.0" "MoR_2.5" "PW_4.5" )
# Supported Napoleonic Wars Mods
MB_WB_NW_MODS=( "AZW Reloaded" "Bello Civili" "Blood and Iron Age of Imperialism" "Iron Europe" \
	"North and South First Manassas" "PikeShotte" "Red and Blue v3" "War of 1812" \
	"Whigs and Tories Final" )

# Build link array
declare -A MB_WB_LINKS
MB_WB_LINKS["Native"]="https://files.rowe.sh/pterodactyl/mb-warband/native/nat-latest.tar.gz"
MB_WB_LINKS["The Deluge"]="https://files.rowe.sh/pterodactyl/mb-warband/native/td-latest.tar.gz"
MB_WB_LINKS["FI2 Amber 2.0"]="https://files.rowe.sh/pterodactyl/mb-warband/native/fi2-latest.tar.gz"
MB_WB_LINKS["MoR_2.5"]="https://files.rowe.sh/pterodactyl/mb-warband/native/mor-latest.tar.gz"
MB_WB_LINKS["PW_4.5"]="https://files.rowe.sh/pterodactyl/mb-warband/native/pw-latest.tar.gz"
MB_WB_LINKS["Napoleonic Wars"]="https://files.rowe.sh/pterodactyl/mb-warband/nw/nw-latest.tar.gz"
MB_WB_LINKS["AZW Reloaded"]="https://files.rowe.sh/pterodactyl/mb-warband/nw/azw-latest.tar.gz"
MB_WB_LINKS["Bello Civili"]="https://files.rowe.sh/pterodactyl/mb-warband/nw/bc-latest.tar.gz"
MB_WB_LINKS["Blood and Iron Age of Imperialism"]="https://files.rowe.sh/pterodactyl/mb-warband/nw/bai-latest.tar.gz"
MB_WB_LINKS["Iron Europe"]="https://files.rowe.sh/pterodactyl/mb-warband/nw/ie-latest.tar.gz"
MB_WB_LINKS["North and South First Manassas"]="https://files.rowe.sh/pterodactyl/mb-warband/nw/nas-latest.tar.gz"
MB_WB_LINKS["PikeShotte"]="https://files.rowe.sh/pterodactyl/mb-warband/nw/ps-latest.tar.gz"
MB_WB_LINKS["Red and Blue v3"]="https://files.rowe.sh/pterodactyl/mb-warband/nw/rab-latest.tar.gz"
MB_WB_LINKS["War of 1812"]="https://files.rowe.sh/pterodactyl/mb-warband/nw/wo1812-latest.tar.gz"
MB_WB_LINKS["Whigs and Tories Final"]="https://files.rowe.sh/pterodactyl/mb-warband/nw/wat-latest.tar.gz"

if [[ "$MB_WB_CMD" == "link" ]] ; then
	if [[ -z "$MB_WB_MODULE" ]] ; then
		echo "No Module specified. Run './mb-warband-links.sh help' for script usage."
		exit 1
	fi

	if [[ "$MB_WB_DL_TYPE" == "base" ]] ; then
		if [[ "$MB_WB_MODULE" == "Native" || "$MB_WB_MODULE" == "Napoleonic Wars" ]] ; then
			# No base server files are needed for the Module
			exit 0
		fi

		for i in "${MB_WB_NATIVE_MODS[@]}"
		do
			if [[ "$MB_WB_MODULE" == "$i" ]] ; then
				# Native-based module identified. Base server files are saved to MB_WB_DL_LINK env var.
				echo -e "${MB_WB_LINKS["Native"]}"
				exit 0
			fi
		done

		for i in "${MB_WB_NW_MODS[@]}"
		do
			if [[ "$MB_WB_MODULE" == "$i" ]] ; then
				# Napoleonic Wars-based module identified. Base server files are saved to MB_WB_DL_LINK env var.
				echo -e "${MB_WB_LINKS['Napoleonic Wars']}"
				exit 0
			fi
		done

		echo -e "ERROR: The module you entered is not a valid module."
		echo -e "Run './mb-warband-links.sh modules' to list all supported modules."
		exit 1
	elif [[ "$MB_WB_DL_TYPE" == "mod" ]] ; then
		MB_WB_DL_LINK=${MB_WB_LINKS["$MB_WB_MODULE"]}

		if [[ -z "$MB_WB_DL_LINK" ]] ; then
			# The module entered is not a valid module.
			exit 1
		fi

		echo -e "$MB_WB_DL_LINK"
	else
		echo -e "ERROR: Unrecognized download type. Please use either:"
		echo -e "	'base': to get the link to the base server files necessary for the module"
		echo -e "	'mod': to get the link to the module's server files"
		exit 1
	fi
elif [[ "$MB_WB_CMD" == "modules" ]] ; then
	echo -e "Printing supported modules:"
	echo -e "\nNative"
	echo -e "Native-based Modules:"
	for i in "${MB_WB_NATIVE_MODS[@]}"
	do
		echo -e "\t$i"
	done
	echo -e "\nNapoleonic Wars"
	echo -e "Napoleonic Wars-based Modules:"
	for i in "${MB_WB_NW_MODS[@]}"
	do
		echo -e "\t$i"
	done
elif [[ "$MB_WB_CMD" == "base" ]] ; then
	if [[ -z "$MB_WB_MODULE" ]] ; then
		echo "No Module specified. Run './mb-warband-links.sh help' for script usage."
		exit 1
	fi

	if [[ "$MB_WB_MODULE" == "Native" || "$MB_WB_MODULE" == "Napoleonic Wars" ]] ; then
		# No base server files are needed for the Module
		exit 0
	fi

	for i in "${MB_WB_NATIVE_MODS[@]}"
	do
		if [[ "$MB_WB_MODULE" == "$i" ]] ; then
			# Native-based module identified. Base server files are saved to MB_WB_DL_LINK env var.
			echo -e "Native"
			exit 0
		fi
	done

	for i in "${MB_WB_NW_MODS[@]}"
	do
		if [[ "$MB_WB_MODULE" == "$i" ]] ; then
			# Napoleonic Wars-based module identified. Base server files are saved to MB_WB_DL_LINK env var.
			echo -e "Napoleonic Wars"
			exit 0
		fi
	done

	echo -e "ERROR: The module you entered is not a valid module."
	echo -e "Run './mb-warband-links.sh modules' to list all supported modules."
	exit 1
elif [[ "$MB_WB_CMD" == "help" ]] ; then
	echo -e "\nUsage: ./mb-warband-links.sh command [options]"
	echo -e "    link [module] [type]    generates download links for mount and blade warband server files"
	echo -e "        module              name of the warband module (ex. 'Napoleonic Wars')"
	echo -e "        type                'base' to get the link for the base server files needed for the game server"
	echo -e "                                null if no base files are needed for that specific module"
	echo -e "                            'mod' to get the link for the module's server files"
	echo -e "    modules                 prints all supported modules"
	echo -e "    base [module]           prints the name of the base Module that the module depends on"
	echo -e "        module              name of the warband module (ex. 'North and South First Manassas')"
	echo -e "    help                    prints this usage summary"
	echo -e "\nNote: if the Module name contains spaces, then it must be wrapped in quotation marks."
	echo -e "\nExamples:"
	echo -e "\t./mb-warband-links.sh link 'North and South First Manassas' base"
	echo -e "\t./mb-warband-links.sh link 'Napoleonic Wars' mod"
	echo -e "\t./mb-warband-links.sh modules"
	echo -e "\nDeveloped and maintained by Mason Rowe <mason@rowe.sh>. Open a GitHub issue for any" \
			"problems or mod requests at https://github.com/masonr/pterodactyl-images/tree/mb-warband.\n"
	exit 0
else
	echo -e "Command not recognized. Run './mb-warband-links.sh help' to see all available commands."
	exit 0
fi
