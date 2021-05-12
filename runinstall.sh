#!/bin/bash

# File Name:		runinstall.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876
# URL:			https://github.com/jrom876/bash_env_setup.sh/blob/master/runinstall.sh
#
###############
### PURPOSE ### 
# An improved method to setup the Linux/Unix terminal environment 
# with custom aliases and bash scripts for quicker function calls,
# efficient file navigation, and better system control.

###############################################################
###############################################################
###############################################################
#
# Copyright (C) 2019, 2021 
# Jacob Romero, Creative Engineering Solutions, LLC
# cesllc876@gmail.com
# admin@jrom.io 
#
# This program is free software; you can redistribute it
# and/or modify it under the terms of the GNU General Public 
# License as published by the Free Software Foundation, version 2.
#
# This program is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied 
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# 
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public
# License along with this program; if not, write to:
# The Free Software Foundation, Inc.
# 59 Temple Place, Suite 330
# Boston, MA 02111-1307 USA
#
#
###############################################################
###############################################################
###############################################################

####################
### INSTRUCTIONS ###
# In order to run this script in a given CLI: 
# -- you must be in the home directory 
# -- you must have runinstall.sh and /zsetup loaded in the home directory
# -- you must run the following command:
#
#	. ./runinstall.sh
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
	for dir in $maindir/*.sh   	# list scripts in the form "~/<maindir>/file.sh"
	do
		chmod 755 $dir		# make sure the script is readable and executable
		dir=${dir##*/}    	# keep everything after the final "/"
		. ./$dir		# run each script in the current CLI  
	done
	cd ~/
	PS1="==> @@~\w ==>:\$ " 	## when runinstall is called, the environment changes
}

# Now we run the function we just defined, and watch the magic happen
runinstall 

###################

###########################
### ENVIRONMENT OPTIONS ###
## Choose desired CLI environment by commenting/uncommenting
## one of the options below
# PS1="\w ==>:\$ "
# PS1="==> \w ==>:\$ "
# PS1="==> \t \w ==>:\$ "
# PS1="\u@\h:\w\$ " ## default
# PS1="\u@\t:\w\$ "
# PS1="\u \s \t \w:\$ "
# \u = user; \s = shell; \t = time; \h = host; \w = working directory
# \$ = shows '$' if logged in as user; shows '#' if logged in as root
# For more info on setting environment variables
# see: https://ss64.com/bash/syntax-prompt.html
# and: https://www.tutorialspoint.com/unix/unix-environment.htm
#




