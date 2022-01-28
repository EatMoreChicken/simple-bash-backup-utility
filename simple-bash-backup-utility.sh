#!/bin/bash

######## Variables ########

######## Functions ########
#### Logging####

#### Take Backup #####

#### Rotate Backup ####

#### Print Menu ####
print_help () {
cat <<EOF
Simple Bash Backup Utility
	
Option				Description
-h|--help			Prints this help menu.
-b|--backup			Starts backup based on configuration.
-r|--rotate-backup		Rotates backup based on configuration.
-v|--validate			Validates that requirements are met.
-d|--dry-run [backup|rotate]	Starts dry-run of backup or rotate functions.
EOF
}
#### Argument Parsing ####
# Resource: https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
while (( "$#" )); do
	case "$1" in
		-h|--help)
			print_help
			exit 0
			;;
		-b|--backup)
			shift
			;;
		-r|--rotate-backup)
			if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
				shift 2
			else
				# [TODO] Implement Logging Here
				echo "Missing argument for: $1" >&2
				exit 1
			fi
			;;
		-v|--validate)
			shift
			;;
		-d|--dry-run)
			if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                                shift 2
                        else
                                # [TODO] Implement Logging Here
                                echo "Missing argument for: $1" >&2
                                exit 1
                        fi
                        ;;
		-*|--*=) # unsupported flags
			echo "Error: Unsupported flag $1. Please use '$0 --help' for assitance." >&2
			exit 1
			;;
	esac
done

######## Main Script ########

