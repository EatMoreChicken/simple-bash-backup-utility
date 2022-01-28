# 🗃 Simple Bash Backup Utility ⚒
A simple bash script used to create and rotate backups.

## Features
### ✔ Complete

### ⚒ To-Do
- [ ] Tar `source` directory to a `destination` directory
- [ ] Flag to rotate backups
- [ ] Check system space for backups
- [ ] Check file and directory permissions
- [ ] Selective Backup Flags
	- [ ] `--include-dir` flag to only backup directories matching a pattern
	- [ ] `--include-file` flag to only backup files matching a pattern
	- [ ] `--exclude-dir` flag to exclude directories matching a pattern from the backup
	- [ ] `--excluce-file` flag to exclude files matching a pattern from the backup
- [ ] Logging
	- [ ] Logging format
	- [ ] Logging levels
	- [ ] Log export
- [ ] Source config files for file-based configs (Users can use this instead of flags)
- [ ] `--initialize` flag to check for dependencies
- [ ] `--dry-run` flag to run a test backup without writing the backup
- [ ] Add warnings when backing up large files (Ex. A warning for if a large `.log` file was tarred incase the user isn't aware of that.)