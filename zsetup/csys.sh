#!/bin/bash

# File Name:		csys.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876
#
################################################
####### PURPOSE: GENERAL SYSTEM COMMANDS #######
################################################

##	This file contains general system commands for things such as: 

##		-- viewing computer status
##		-- group and user control 
##		-- modifying file permissions

###############################################################

# Change History

# 5/12/2021 Jacob Romero 		Original code 

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
###############################################################
###############################################################
###############################################################

####################
#### REFERENCES ####
####################
## https://github.com/pradeesi/Store_MQTT_Data_in_Database/blob/master/initialize_DB_Tables.py

## https://www.howtogeek.com/117435/htg-explains-the-linux-directory-structure-explained/
## https://www.tutorialkart.com/bash-shell-scripting/bash-split-string/
## https://ryanstutorials.net/linuxtutorial/scripting.php
## https://unix.stackexchange.com/questions/531938/parse-a-string-in-bash-script
## https://linuxconfig.org/how-to-use-arrays-in-bash-script
## See: https://askubuntu.com/questions/1160113/system-program-problem-detected
## For info on apport, see: https://wiki.ubuntu.com/Apport
## See: https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-18-04
## See: https://net2.com/how-to-switch-users-on-linux-ubuntu/
## https://www.cyberciti.biz/open-source/command-line-hacks/compgen-linux-command/
## https://unix.stackexchange.com/questions/151118/understand-compgen-builtin-command
## https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html
## see: https://www.binarytides.com/linux-check-processor/
## for more info on hwloc / lstopo utility
## https://www.open-mpi.org/projects/hwloc/tutorials/20120702-POA-hwloc-tutorial.html
## https://hackaday.com/2017/11/02/what-is-entropy-and-how-do-i-get-more-of-it/#raspberry-pi-and-the-hw-rng
## For CPU MEMORY USAGE See: cyberciti.biz
## https://dottheslash.wordpress.com/2011/11/29/deleting-all-partitions-on-a-usb-drive/

## Linux Directory Structure
## https://www.howtogeek.com/117435/htg-explains-the-linux-directory-structure-explained/

#######################
shopt -s expand_aliases
#######################

########################
### GLOBAL VARIABLES ###
export degrees
degrees="°"
########################

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

#################################
### GENERAL C COMPILER SCRIPT ###
#################################

## These commands allow the user to compile C/C++ programs and explicitly create:
##		-- pre-processed files (.i extension)
##		-- assembly files (.s extension)
##		-- object files (.o extension)
##		-- posistionally independent executable files (.pie extension)
##		-- hex files (.hex extension)

## Basic C Compiler Script 
## Call:	gncomp $1

gnccomp () {
	gcc -o $1 $1.c -lm -lrt;
	./$1
}

## Full C Compiler Script 
## 		Creates ELF, pre-processed, asm, object, and hex files
##		from a given .c file and shows the ELF header information
## Call:	gnfccomp $1

gnfccomp () {
	gcc -o $1 $1.c -lm -lrt;
	gcc -E $1.c -o $1.i; \
	gcc -S $1.c -fverbose-asm -o $1.s; \
	gcc -c $1.c -o $1.o; \
	gcc -pie $1.c -o $1.pie; \
	readelf -h $1; \
	objcopy -O ihex $1 $1.hex; \
	echo; \
	./$1
}

## Full C++ Compiler Script 
## 		Creates ELF, pre-processed, asm, object, and hex files
##		from a given .cpp file and shows the ELF header information
## Call:	gnpcomp $1

gnpcomp () {
	g++ -o $1 $1.c -lm -lrt;
	g++ -E $1.c -o $1.i; \
	g++ -S $1.c -fverbose-asm -o $1.s; \
	g++ -c $1.c -o $1.o; \
	g++ -pie $1.c -o $1.pie; \
	readelf -h $1; \
	objcopy -O ihex $1 $1.hex; \
	echo; \
	./$1
}

########################################
### END OF GENERAL C COMPILER SCRIPT ###
########################################

########################
### GENERAL COMMANDS ###
########################
alias c='clear'
alias f='file *'
alias h='history'
alias p='pwd'
alias la='ls -la'
##alias whe='whereami'
alias wh='whereis'
alias hn='hostname'
alias ifc='ifconfig -a'
alias bye='clear; exit'
#alias ifp='ifplugstatus'
# alias ifcwlan='ifconfig wlan0'
# alias ifceth='ifconfig eth0'
# alias ifclo='ifconfig lo'

##################################
#### Show my Jetson Nano Info ####
alias jtv='dpkg-query --show nvidia-l4t-core'
##################################
#### Show my Ubuntu Info ####
alias ubv='cat /etc/os-release'
##################################

####################
### USER CONTROL ###
####################

#### See: https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-18-04
#### See: https://net2.com/how-to-switch-users-on-linux-ubuntu/
#alias who='whoami'
alias usid='id -nu'
alias wami='whoami > ~/reports/users; wc -l ~/reports/users; cat ~/reports/users'
# alias wded='who -d'	# print dead processes
# alias wq='who -q'

swuser () {  # Switch user
	sudo su $1;
	cd /home/$1
}

### Group Info ###
alias grpid='id -nG' # Returns all groups the user belongs to
alias grpad='id -ng'

## https://www.cyberciti.biz/open-source/command-line-hacks/compgen-linux-command/
## https://unix.stackexchange.com/questions/151118/understand-compgen-builtin-command
## https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html
## List linux users
alias lusers='compgen -u'

## $1 = username whose passwd we are trying to retrieve/verify
gtupw () {
	getent passwd | grep $1
}

##############
### Shells ###
alias getshells='cat /etc/shells'
########################
### Environment Vars ###
alias getpush="printenv | grep -wE 'PATH|USER|SHELL|LANG|TERM|PWD|OLDPWD'"
alias getfans="printenv | grep -wE 'MY_FAN_SPEED|ILWIFI_TEMP_C|ILWIFI_TEMP_F|THERMAL_FAN_TEMP_C|THERMAL_FAN_TEMP_F'"
##############
### python ###
alias p2='python'
alias p3='python3'

###################
## search zsetup ##
srzsetup () {
	cd zsetup/; 
	grep -rni $1;
	cd $OLDPWD
}

######################################
####### COMPUTER HARDWARE INFO #######
######################################
# see: https://www.binarytides.com/linux-check-processor/
alias ul='ulimit -a' # ulimit = obsolete, but still works
alias lsc='lscpu'
alias lshw='sudo lshw -C CPU'
##alias cid='cpuid -1'
alias inxi='inxi -F'
alias hwi='hardinfo' # info about system hardware
alias gsm='gnome-system-monitor'
## nproc = number of available processors
alias dmid='sudo dmidecode -t 4'
## useful /proc/cpuinfo functions ##
alias pcpu='cat /proc/cpuinfo'

## Displays real-time CPU speeds
cpuGet () {
	cat /proc/cpuinfo | grep -i $1
}
wCPUspeed () {
	watch -n 0.1 "cat /proc/cpuinfo | grep -i mhz"
}

## hwloc / lstopo utility ##
# Provides cpu info at a glance
# https://www.open-mpi.org/projects/hwloc/tutorials/20120702-POA-hwloc-tutorial.html
# for more info on hwloc / lstopo utility
alias ltv='lstopo - -v --no-io'
# Run the following code to open lstopo
optopo () {
	lstopo -
	lstopo
}
#########################################
### Get your computer's serial number ###
alias getsn='sudo dmidecode -t system'
alias getssn='sudo dmidecode -s system-serial-number'
##########################
### Find linux version ###
alias linv='cat /proc/version'
alias uno='uname -o'
alias una='uname -a'
##########################
#### FIND MY ENTROPY #####
#### https://hackaday.com/2017/11/02/what-is-entropy-
#### and-how-do-i-get-more-of-it/#raspberry-pi-and-the-hw-rng
alias entropy='cat /proc/sys/kernel/random/entropy_avail'
alias wentropy='watch -n 1 cat /proc/sys/kernel/random/entropy_avail'
##########################
#### CPU MEMORY USAGE ####
#### See: cyberciti.biz
alias pmem='cat /proc/meminfo'
alias vms='vmstat'
alias lsm='lsmem'
#top
#atop
#htop
#gnome-system-monitor
#free -t -m
#free -m
#vmstat
#cat /proc/meminfo
#less /proc/meminfo
#more /proc/meminfo
#ps -aux

#################################
### MISCELLANEOUS FUNCTIONS ###
#################################
md () {		## make directory, and go to it
    mkdir -p $1 # -p = make parent directories as needed
    cd $1
}
### Setting file permssions ###
mfx () {	## make file(s) executable for everyone
	  chmod +x $@
}
mfa () {	## make file(s) read/execute for everyone
	  chmod 755 $@
}
rfx () {	## remove file(s) execute/write permissions for all but owner
	  chmod 744 $@
}
rfa () {	## remove all file permissions for everyone but owner
	  chmod 600 $@
}
rfz () {	## as above, but with executability
	  chmod 700 $@
}
## countItems $1 takes a text string as its only argument and counts
## the number of occurrences of this string in the current directory
countItems () {
	  grep -i $1 * | wc -l
}
currDate () {		## show current date
	DATE=`date`
	echo "Date and Time: $DATE"
}

################################################################
#### VERY USEFUL for deleting and creating USB partitions!! ####
################################################################
## https://dottheslash.wordpress.com/2011/11/29/deleting-all-partitions-on-a-usb-drive/
# First we need to delete the old partitions that remain on the USB key.
#     Open a terminal and type sudo su
#     Type fdisk -l and note your USB drive letter.
#     Type fdisk /dev/sdx (replacing x with your drive letter)
#     Type d to proceed to delete a partition
#     Type number 1 to select the 1st partition and press enter
#     Type d to proceed to delete another partition (fdisk should automatically select the second partition)

# Next we need to create the new partition.
#     Type n to make a new partition
#     Type p to make this partition primary and press enter
#     Type 1 to make this the first partition and then press enter
#     Press enter to accept the default first cylinder
#     Press enter again to accept the default last cylinder
#     Type w to write the new partition information to the USB key
#     Type umount /dev/sdx (replacing x with your drive letter)

# The last step is to create the fat filesystem.
#     Type mkfs.vfat -F 32 /dev/sdx1 (replacing x with your USB key drive letter)
#
# That’s it, you should now have a restored USB key with a single fat 32 partition
# that can be read from any computer.

################
## don't forget:
# dir
# df -k
# mount
# dmesg
# finger
# ping
# top
# pr, lp, lpr, lpstat, and lpstat -o
# traceroute # https://www.javatpoint.com/linux-traceroute
# mtr
# ps
# sed
# sort
# tty
# who

##########################################
### END OF GENERAL SYSTEM COMMAND SIDE ###
##########################################

################################
###  End of csys.sh  ###
################################
