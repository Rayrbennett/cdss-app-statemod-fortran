#!/bin/sh
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required
# The above line ensures that the script can be run on Cygwin/Linux even with Windows CRNL
#
# git-clone-all-statemod - clone all StateMod repositories for new development environment setup
# - this script calls the general git utilities script

# Get the location where this script is located since it may have been run from any folder
scriptFolder=`cd $(dirname "$0") && pwd`

# Git utilities folder is relative to the user's files in a standard development files location
# - determine based on location relative to the script folder
# Specific repository folder for this repository
repoFolder=`dirname ${scriptFolder}`
# Want the parent folder to the specific Git repository folder
gitReposFolder=`dirname ${repoFolder}`

# StateMod GitHub repo URL root
githubRootUrl="https://github.com/OpenCDSS"

# Main StateMod repository
mainRepo="cdss-app-statemod-fortran"

# Run the general script
${scriptFolder}/git-util/git-clone-all.sh -m "${mainRepo}" -g "${gitReposFolder}" -u "${githubRootUrl}" $@
