#!/bin/bash

######## Variables ########
SRC="/home/vcharly/test_dir/src_dir/"			# Source directory to backup (Ex. "/opt/application/etc/")
DST="/home/vcharly/test_dir/backup_dir/"		# Destination directory to store backup (Ex. "/opt/backups/")
BACKUP_PREFIX="test_backup"						# Prefix used for backup file name (Ex. "app-backup-")
LOGGING_LEVEL="DEBUG"							# Minimal logging level for messages to be printed (Ex. "INFO")

######## Functions ########
#### Logging####
log () {
	echo "[$(date '+%F %T')] [$1] $2"
}

#### Check for Permissions ####

#### Clean Variable ####
clean_variables () {
	[ -d "$SRC" ] || (log ERROR "The source directory '$SRC' does not exist."; exit 1)
	SRC=$(sed "s/\/$//" <<< $SRC )
	SRC_PARENT=$(sed "s/\(.*\/\).*/\1/" <<< $SRC )
	SRC_DIR=$(sed "s/\(.*\/\)//" <<< $SRC )
	log DEBUG "SRC = '$SRC'"
	log DEBUG "SRC_PARENT = '$SRC_PARENT'"
	log DEBUG "SRC_DIR = '$SRC_DIR'"
}

#### Take Backup #####
take_backup () {
	log INFO "Making backup location $DST"
	mkdir -p $DST
	log DEBUG "Starting backup from '$SRC' to '$DST/$BACKUP_PREFIX-$(date +%s).tar.gz'"
	(tar -zcvf $DST/$BACKUP_PREFIX-$(date +%s).tar.gz -C $SRC_PARENT $SRC_DIR && log INFO "Backup successful!") || log ERROR "Backup existed with an error: $?"
}

#### Rotate Backup ####

#### Print Menu ####
print_help () {
cat <<EOF

Simple Bash Backup Utility
	
Option				Description
-h|--help			Prints this help menu.
-b|--backup			Starts backup based on configuration. (Work-in-Progress)
-r|--rotate-backup		Rotates backup based on configuration. (Work-in-Progress)
-v|--validate			Validates that requirements are met. (Work-in-Progress)
-d|--dry-run [backup|rotate]	Starts dry-run of backup or rotate functions. (Work-in-Progress)

EOF
}

#### Argument Parsing ####
# Resource: https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
MAKE_BACKUP=0
ROTATE_BACKUP=0

while (( "$#" )); do
	case "$1" in
		-h|--help)
			print_help
			exit 0
			;;
		-b|--backup)
			MAKE_BACKUP=1
			shift
			;;
		-r|--rotate-backup)
			ROTATE_BACKUP=1
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

######## Main Functions ########
backup () {
	clean_variables
	take_backup
}

rotate_backup () {
	log DEBUG "Rotate Backup TODO"
}

validate () {
	log DEBUG "Validate TODO"
}

dry_run () {
	log DEBUG "Dry Run TODO"
}

######## Run Main Script ########
if [[ MAKE_BACKUP -eq 1 ]]; then
	backup
elif [[ ROTATE_BACKUP -eq 1 ]]; then
	rotate_backup
else 
	print_help
fi

#[[ MAKE_BACKUP -eq 1 ]] && ( backup; exit )
#[[ ROTATE_BACKUP -eq 1 ]] && ( rotate_backup; exit )
