#!/bin/bash

# Default values
dir="$(pwd)"
pull=false
push=false

# Function to display usage information
usage() {
	echo "Usage: $0 --dir <directory> [--pull] [--push]"
	exit 1
}

# Parse command line options
ARGS=$(getopt -o "" -l "dir:,pull,push" -n "$0" -- "$@")

eval set -- "$ARGS"

while true; do
	case "$1" in
	--dir)
		dir="$2"
		shift 2
		;;
	--pull)
		pull=true
		shift
		;;
	--push)
		push=true
		shift
		;;
	--)
		shift
		break
		;;
	*)
		usage
		;;
	esac
done

# Perform actions based on options
echo "git_auto_commit Directory: $dir"

if $pull; then
	git -C "$dir" pull
fi

git -C "$dir" add -A

current_datetime=$(date '+%Y-%m-%d %H:%M:%S')
git -C "$dir" commit -m "$current_datetime"

if $push; then
	git -C "$dir" push
fi
