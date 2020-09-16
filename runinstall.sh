#!/bin/bash

# File Name:		runinstall.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876
#
###############
### PURPOSE ### 
# An improved method to setup the Linux/Unix terminal environment 
# with custom aliases and bash scripts for quicker function calls,
# efficient file navigation, and better system control.
####################
### INSTRUCTIONS ###
# In order to run this script on a given CLI: 
# -- you must be in the home directory 
# -- you must have runinstall.sh and /zsetup loaded in the home directory
# -- you must run the following command:
#
#	. ./ungawa.sh
#
# NOTE: Don't forget the important dot-space at the beginning of the
# command because this designates the current CLI as the target.
###################

# First things first.
# We must set the variable 'maindir' to the path where the .sh setup 
# files are located, and then (maybe) export it for the other scripts to use. 
maindir=~/zsetup
#export maindir

# Now we can proceed with the auto-setup
shopt -s expand_aliases
runinstall () {
	cd $maindir
	for dir in $maindir/*.sh   # list scripts in the form "~/<maindir>/file.sh"
##	cd ~/zsetup
##	for dir in ~/zsetup/*.sh   # list scripts in the form "~/zsetup/file.sh"
	do
		chmod 755 $dir		# make sure the script is executable
		dir=${dir##*/}    	# keep everything after the final "/"
		. ./$dir		# run each script in the current CLI  
#		sleep .1		# give the script a chance to load if needed
	done
	cd ~/
	PS1="==> @@~\w ==>:\$ " ## when runinstall is called, the view changes
}
runinstall 

###################




