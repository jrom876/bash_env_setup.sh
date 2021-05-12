#!/bin/bash

# File Name:		bkups.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
#			jrom876@gmail.com
# Contact:		cesllc876@gmail.com
# Github Page:		www.github.com/jrom876
#
################################
### PURPOSE: BACKUP HANDLERS ###
################################

## This file contains automated backup scripts with date code concatenation
## for saving files, directories, and multiple mixed inputs in ~/bkups.

## It has automated backups, setters, getters, movers, deleters, and LUTs
## which handle all aspects of our backup files.

##############################
### REFERENCES AND CREDITS ###
## https://ryanstutorials.net/linuxtutorial/scripting.php
## https://unix.stackexchange.com/questions/531938/parse-a-string-in-bash-script
## https://linuxconfig.org/how-to-use-arrays-in-bash-script
## https://www.tutorialkart.com/bash-shell-scripting/bash-split-string/
## https://ss64.com/bash/declare.html

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

###########################
shopt -s expand_aliases
###########################

########################
### GLOBAL VARIABLES ###
########################
date=`date +%F`

#### BACKUP LUTs ####

hp250_bkups=(
	Arduino \
	bookshelf \
	coding_challenge \
	projects \
	_python \
	reports \
	sandbox \
	zsetup \
	setup.sh )

## My full backup array for the Jetson Nano
jetson_bkups=(
	reports \
	sandbox \
	zsetup \
	setup.sh )

## Test backup array
test_bkups=(
	reports \
	sandbox \
	zsetup \
	setup.sh )

############################
#### DIRECTORY CREATORS ####
############################

## Create All Required Directories
## These must be specific to your system, and should be modified accordingly
crtdirs () {
	cd ~/
	## Backup Directories
	mkdir bkups
	mkdir bkups/fbkups
	mkdir bkups/hp250_bkups
	mkdir bkups/jetsonbkups
	mkdir bkups/sysbkups
	## System Directories
	mkdir _files
	mkdir mtr-reports
	mkdir reports
	mkdir sandbox
	mkdir skeeter
	mkdir tempo
}

## Create Backup Directories Only
crtbkdir () {
	cd ~/
	mkdir bkups
	mkdir bkups/fbkups
	mkdir bkups/hp250_bkups
	mkdir bkups/jetsonbkups
	mkdir bkups/sysbkups
}

###########################
#### AUTOMATED BACKUPS ####
###########################

## Saving files in ~/bkups/fbkups directory
autofbkups () {
	echo ${test_bkups[@]} ## DBPRINT
#	echo ${hp250_bkups[@]} ## DBPRINT
#	echo ${jetson_bkups[@]} ## DBPRINT
#	echo ${rpi12_bkups[@]} ## DBPRINT
#	echo ${rpi13_bkups[@]} ## DBPRINT
#	echo ${rpizero_bkups[@]} ## DBPRINT
	cd ~/
	echo; echo 'Running autofbkups. This may take a while'
	echo
	bkflist ${test_bkups[@]}
#	bkflist ${hp250_bkups[@]}
#	bkflist ${jetson_bkups[@]}
	echo
	echo 'Backups are complete.'
	echo 'Use lsfbkups to see the non-recursive list'
	echo 'Use lszbkups to see the recursive list'
	echo 'Use ecbkups to see a list of backup commands'
}

## Saving files in ~/bkups/sysbkups directory
autozbkups () {
## Uncomment the LUT you want to backup
#	echo ${test_bkups[@]} ## DBPRINT
#	echo ${hp250_bkups[@]} ## DBPRINT
	echo ${jetson_bkups[@]} ## DBPRINT
	cd ~/
	echo; echo 'Running autozbkups. This may take a while'
	echo
## Uncomment the LUT you want to backup
#	bksyslist ${test_bkups[@]}
#	bksyslist ${hp250_bkups[@]}
	bksyslist ${jetson_bkups[@]}
	echo
	echo 'Backups are complete.'
	echo 'Use lssysbkups to see the non-recursive list'
	echo 'Use lsybkups to see the recursive list'
	echo 'Use ecbkups to see a list of backup commands'
}

#################
#### SETTERS ####
#################

## Recursively backs up multiple mixed files and concatenates today's date onto 
## the backups' new pathnames.
bkflist () {
	date=`date +%F`
	declare -a dir_array
	dir_array="${@%/*}"
	dir_array=($dir_array)
	#echo $@ ## DBPRINT
	#echo ${dir_array[@]} ## DBPRINT

	for  dir in "${dir_array[@]}"; do 
		echo "$dir" ## DBPRINT
## If the file is a directory, we append a date directly to the new pathname
		if [ -d $dir ]; then
		## When we already have a backup folder for this file, we must remove it
		## and copy the new file in its place.
			if [ -d ~/bkups/fbkups/$dir$date ]; then
				rm -rf ~/bkups/fbkups/$dir$date
				for loc in $dir; do
				    cp -bR $dir ~/bkups/fbkups/$dir$date/
				done
				#echo "Overwrite and backup of $dir completed" ## DBPRINT
		## When we don't already have a backup folder, we have to create one 
		## for the backup.
			else
			    #echo "Backing up all files from directory $dir into ~/bkups/fbkups/$dir$date" ## DBPRINT
				for loc in $dir; do		    	
				    cp -bR $dir ~/bkups/fbkups/$dir$date
				    #echo "Backup of $dir completed" ## DBPRINT
				done
			fi
## If the file is not a directory, it probably has a .* suffix which
## must be stripped off and appended to the end of the new dated pathname.
		else 
			suff=".${dir#*.}"
			# echo "suff = $suff" ## DBPRINT
## The prefix must also be stripped off and prepended to the new dated pathname.
			pref="${dir%.*}"
			# echo "pref = $pref" ## DBPRINT
		## Do we already have a backup folder for this file?
			if [ -e ~/bkups/fbkups/$pref$date$suff ]; then
				rm -f ~/bkups/fbkups/$pref$date$suff
				cp -b $dir ~/bkups/fbkups/$pref$date$suff
				#echo "Overwrite and backup of $dir completed" ## DBPRINT
		## Since we don't already have a backup folder, we create one 
		## and do the backup.
			else
			    #echo "Backing up all files from directory $dir into ~/bkups/fbkups/$pref$date$suff" ## DBPRINT
				for loc in $dir; do		    	
				    cp -bR $dir ~/bkups/fbkups/$pref$date$suff
				    #echo "Backup of $dir completed" ## DBPRINT
				done
			fi
		fi
	done
}

## Recursively backs up multiple mixed files and concatenates today's date onto 
## the backups' new pathnames. 
bksyslist () {	
	declare -a dir_array
	dir_array="${@%/*}"
	dir_array=($dir_array)
	#echo $@
	#echo ${dir_array[@]} ## DBPRINT

	for  dir in "${dir_array[@]}"; do 
		echo "$dir" ## DBPRINT
## If the file is a directory, we append a date directly to the new pathname
		if [ -d $dir ]; then
		## Do we already have a backup folder for this file?
			if [ -d ~/bkups/sysbkups/$dir$date ]; then
				rm -rf ~/bkups/sysbkups/$dir$date
				for loc in $dir; do
				    cp -bR $dir ~/bkups/sysbkups/$dir$date/
				done
				#echo "Overwrite and backup of $dir completed" ## DBPRINT
		## If we don't already have a backup folder, we create one 
		## and do the backup.
			else
			    #echo "Backing up all files from directory $dir into ~/bkups/sysbkups/$dir$date" ## DBPRINT
				for loc in $dir; do		    	
				    cp -bR $dir ~/bkups/sysbkups/$dir$date
				    #echo "Backup of $dir completed" ## DBPRINT
				done
			fi
## If the file is not a directory, it probably has a .* suffix which
## must be stripped off and appended to the end of the new dated pathname.
		else 
			suff=".${dir#*.}"
			# echo "suff = $suff" ## DBPRINT
## The prefix must also be stripped off and prepended to the new dated pathname.
			pref="${dir%.*}"
			# echo "pref = $pref" ## DBPRINT
		## Do we already have a backup folder for this file?
			if [ -e ~/bkups/sysbkups/$pref$date$suff ]; then
				rm -f ~/bkups/sysbkups/$pref$date$suff
				cp -b $dir ~/bkups/sysbkups/$pref$date$suff
				#echo "Overwrite and backup of $dir completed" ## DBPRINT
		## If we don't already have a backup folder, we create one 
		## and do the backup.
			else
			    #echo "Backing up all files from directory $dir into ~/bkups/sysbkups/$pref$date$suff" ## DBPRINT
				for loc in $dir; do		    	
				    cp -bR $dir ~/bkups/sysbkups/$pref$date$suff
				   #echo "Backup of $dir completed" ## DBPRINT
				done
			fi
		fi
	done
}

###############
### GETTERS ###
###############

alias lsbkups='ls -la ~/bkups/'
alias lssysbkups='ls -la ~/bkups/sysbkups/'
alias lsybkups='ls -la ~/bkups/sysbkups/*'

alias lsfbkups='ls -la ~/bkups/fbkups/'
alias lsgbkups='ls -la ~/bkups/fbkups/*'

##############
### MOVERS ### 
##############

alias mtzbkups='cd ~/bkups/sysbkups/'
alias mtfbkups='cd ~/bkups/fbkups/'

################
### DELETERS ###
################

## Recursively deletes all contents of fbkups, which is a test file for now
clrflist () {
	echo 'WARNING: THIS WILL REMOVE ALL FILES IN ~/bkups/fbkups/'
	read -p 'Do you want to proceed?  ' answer
	if [ $answer != 'y' ]; then
		echo 'Exiting clrlist utility'
	else
		read -sp 'Enter Special Password to overwrite: ' passvar
		if [[ $fmp = $passvar ]]; then 
			rm -rf ~/bkups/fbkups/*
			echo; echo 'All fbkups have been cleared'
			ls -d ~/bkups/fbkups/*
		else
			echo
			echo 'Wrong password. Exiting clrlist utility'
		fi
	fi
}

## Deletes specific files or directories from fbkups.
## You must be in ~/bkups/fbkups/ to run this script because that makes you use an
## absolute pathname so you don't accidentally remove files from another directory.
clritems () {
	declare -a dir_array
	dir_array="${@%/*}"
	dir_array=($dir_array)
	echo ${dir_array[@]} ## DBPRINT
	for  dir in "${dir_array[@]}"; do 
		if [ -d $dir ]; then
			rm -rf ~/bkups/fbkups/$dir
			echo "$dir has been cleared from ~/bkups/fbkups/"
			ls -d ~/bkups/fbkups/* | grep $dir
		elif [ -e $dir ]; then		
			rm -f ~/bkups/fbkups/$dir
			echo "$dir has been cleared from ~/bkups/fbkups/"
			ls ~/bkups/fbkups/* | grep $dir
		else
			echo "Unable to remove $dir"
		fi
	done
}

## Recursively deletes all contents of sysbkups, which is a real file, so CAUTION!!
clrzlist () {
	echo 'WARNING: THIS WILL REMOVE ALL FILES IN ~/bkups/sysbkups/'
	read -p 'Do you want to proceed?  ' answer
	if [ $answer != 'y' ]; then
		echo 'Exiting clrlist utility'
	else
		read -sp 'Enter Special Password to overwrite: ' passvar
		if [[ $fmp = $passvar ]]; then 
			rm -rf ~/bkups/sysbkups/*
			echo; echo 'All sysbkups have been cleared'
			ls -d ~/bkups/sysbkups/*
		else
			echo
			echo 'Wrong password. Exiting clrlist utility'
		fi
	fi
}

## Deletes specific files or directories from sysbkups.
## You must be in ~/bkups/sysbkups/ to run this script because that makes you use an
## absolute pathname so you don't accidentally remove files from another directory.
clrvitems () {
	declare -a dir_array
	dir_array="${@%/*}"
	dir_array=($dir_array)
	echo ${dir_array[@]} ## DBPRINT
	for  dir in "${dir_array[@]}"; do 
		if [ -d $dir ]; then
			rm -rf ~/bkups/sysbkups/$dir
			echo "$dir has been cleared from ~/bkups/sysbkups/"
			ls -d ~/bkups/sysbkups/* | grep $dir
		elif [ -e $dir ]; then		
			rm -f ~/bkups/sysbkups/$dir
			echo "$dir has been cleared from ~/bkups/sysbkups/"
			ls ~/bkups/sysbkups/* | grep $dir
		else
			echo "Unable to remove $dir"
		fi
	done
}

################################
### INFORMATION AND EXAMPLES ###
#id='{"name":"john"}'
#id="${id#*\{}"  # remove everything through the first '{'
#echo $id
#"name":"john"}
#id="${id%\}*}"  # remove everything starting with the last '}'
#echo $id
#"name":"john"
#name="${id%:*}" # take everything before the ':'
#name="${name//\"/}"  # remove quotes
#echo $name
#name
#value="${id#*:}" # take everything after the ':'
#value="${value//\"/}" # remove quotes
#echo $value
#john

# declare -a my_array
# echo ${my_array[@]}
# echo ${my_array[*]}
# for i in "${my_array[@]}"; do echo "$i"; done
# for i in "${my_array[*]}"; do echo "$i"; done
# my_array=(foo bar)
# my_array+=(baz)

########################
#### END OF BACKUPS ####
########################
