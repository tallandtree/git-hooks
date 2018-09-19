#!/bin/bash
# Description:
#    Simple bash script to copy hooks to .git/hooks folder.
# Syntax:
#    cm-git/install-hooks.sh [git-repo]
# Notes:
# If [git-repo] is supplied, the hooks are copied to the git-repo,
# else the hooks are copied to all git-repositories found below the
# current directory.
# Note that if one of the repositories contains read-only hooks,
# the script will fail.
repo=$1
script_dir=`dirname $0`

if [[ ! -z ${repo} ]]
then
	if [[ -d ${repo}/.git/hooks ]]
	then
		echo Info: git repo exists, hooks copied
		cp ${script_dir}/hooks/* ${repo}/.git/hooks
		exit 0
	else
		echo Error: git repo does not exist
		exit 1
	fi
else
	find . -name ".git" -type d -exec cp ${script_dir}/hooks/* {}/hooks \; $dir -printf "Info: hooks copied to %p/hooks\n"
fi
