#!/bin/bash

# File Name:		systm.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876
#
###############################################
####### PURPOSE: SYSTEM SERVICE UTILITY #######
###############################################

## This file contains scripts for handling system services and processes

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
## https://opensource.com/article/21/4/sysadmins-love-systemd?utm_medium=Email&utm_campaign=weekly&sc_cid=7013a000002w4C4AAI&elqTrackId=0384f6ab12de4f19b22bd587343fa262&elq=37f88420d43d4c0db3de1e5b9b171ed5&elqaid=619&elqat=1&elqCampaignId=460

## Killing a Process: https://www.linux.com/training-tutorials/how-kill-process-command-line/
## https://askubuntu.com/questions/565255/how-to-uninstall-teamviewer
## wpa_supplicant:	http://www.linuxfromscratch.org/blfs/view/svn/basicnet/wpa_supplicant.html
## https://en.wikipedia.org/wiki/Supplicant_(computer)
## For info on parsing bash script, see:
## https://unix.stackexchange.com/questions/531938/parse-a-string-in-bash-script
## See: https://askubuntu.com/questions/907246/how-to-disable-systemd-resolved-in-ubuntu

## Linux Directory Structure
## https://www.howtogeek.com/117435/htg-explains-the-linux-directory-structure-explained/

###############################################################
# Change History

# 5/12/2021 Jacob Romero 		Original code 

###############################################################
##################################
shopt -s expand_aliases
##################################

###################
####### UFW #######
## Having trouble with ufw being disabled at boot?
## Try disabling firewalld.service, which interferes with ufw
## e.g.:	sudo systemctl disable firewalld.service

## https://www.cyberithub.com/setup-ufw-firewall-rule/

ecufw () {
	echo
	echo 'Welcome to UFW UTILITY -- Uncomplicated Firewall'; echo
	echo 'COMMANDS	EXPLANATION'; echo
	echo 'STATUS AND GENERAL'
	echo 'uftus		sudo ufw status'
	echo 'ufreload	sudo ufw reload'
	echo 'ufapp		sudo ufw app list'
	echo 'ufversion	sudo ufw version'; echo
	echo 'ENABLE/DISABLE AND DELETE'
	echo 'ufenable	sudo ufw enable'
	echo 'ufdisable	sudo ufw disable'
	echo 'ufnum		sudo ufw status numbered'
	echo 'ufdel		sudo ufw delete $1'; echo
	echo 'DENY COMMANDS'
	echo 'ufdny 		sudo ufw deny $1'
	echo 'ufdfrom		sudo ufw deny from $1 to $2'
	echo 'ufdout 		sudo ufw deny out $1'
	echo 'ufdin 		sudo ufw deny in $1'; echo 
	echo 'ALLOW COMMANDS'
	echo 'ufallow		sudo ufw allow $1'
	echo 'ufafrom		sudo ufw allow from $1 to $2'
	echo 'ufaout		sudo ufw allow out $1'
	echo 'ufain		sudo ufw allow in $1'; echo
}

uftus () {
	sudo ufw status
}

ufreload () {
	sudo ufw reload
}

ufapp () {
	sudo ufw app list
}

ufversion () {
	sudo ufw version
}

ufenable () {
	sudo ufw enable
}

ufdisable () {
	sudo ufw disable
}

ufnum () {
	sudo ufw status numbered
}

ufdel () {
	sudo ufw delete $1
}

ufdny () {
	sudo ufw deny $1
}

ufdfrom () {
	sudo ufw deny from $1 to $2
}

ufdout () {
	sudo ufw deny out $1
}

ufdin () {
	sudo ufw deny in $1
}

ufallow () {
	sudo ufw allow $1
}

ufafrom () {
	sudo ufw allow from $1 to $2
}

ufaout () {
	sudo ufw allow out $1
}

ufain () {
	sudo ufw allow in $1
}

## https://phoenixnap.com/kb/configure-firewall-with-ufw-on-ubuntu
## sudo nano /etc/default/ufw

#########################
####### SYSTEMCTL #######
gtunitfiles () {
	systemctl list-unit-files
}
gtfunit () {
	sudo systemctl --failed
}

####### SERVICES #######
## https://www.linux.com/topic/desktop/cleaning-your-linux-startup-process/
gtsvcs () {
	systemctl list-unit-files --type=service
}
gtenabled () {
	systemctl list-unit-files --type=service | grep enabled
	## systemctl list-unit-files --type=service | grep -E "(enabled|disabled)"
}
gtnonstatic () {
	systemctl list-unit-files --type=service | grep -v static
}

## MASKING A SERVICE
## https://itectec.com/ubuntu/ubuntu-systemctl-how-to-unmask/
## e.g. sudo systemctl mask bluetooth.service
masksvc () {
	sudo systemctl mask $1
}

#umasksvc () {
	#sudo systemctl unmask $1
#}
## systemctl list-unit-files --type=service | grep enabled

#### Disabling/Enabling a Service ####
svdsabl () {
	sudo systemctl disable $1
}
svenabl () {
	sudo systemctl enable $1
}
svkill () {
	sudo service $1 stop
}
svstart () {
	sudo service $1 start
}
svrestart () {
	sudo service $1 restart
}
### Service Status
svtus () {
	sudo systemctl status $1
}
svall () {
	# echo 'Listing all running Services'
	service --status-all
}

#####################
### DAEMON RELOAD ###
#####################
function daereload () {
	sudo systemctl daemon-reload
}

#############
### BLAME ###
#############
## Shows which services are taking the longest to start up
function gtblame () {
	systemd-analyze blame
}

### APPORT -- AUTOMATIC ERROR REPORTING ###
## https://websetnet.net/how-to-disable-or-enable-automatic-error-reporting-in-ubuntu/

## To install apport
## sudo apt update
## sudo apt install apport
## sudo systemctl start apport

## To stop apport
## sudo service apport stop

#################
### PS Search ###
## Search current running processes for given keyword,
## returning line number, and ignoring caps
psrch () {
	ps -ef | grep -ni $1
}

###########################
#### Killing a Process ####
# https://www.linux.com/training-tutorials/how-kill-process-command-line/
## Structure for kill command:
## kill  SIGNAL  PID
pk9_signal () {
	sudo kill -9 $1  ## 9 = Kill signal
}

#### EXAMPLE ####
## https://askubuntu.com/questions/565255/how-to-uninstall-teamviewer
# -deb-v10-0-036281-from-ubuntu-14-04
## First, use the command

# dpkg -l | grep team
#
# The full package name should show up in the
# output on the list of installed applications.
# Find it and use the name listed.
# I believe it should look like this:
#
# sudo apt-get purge teamviewer
#
# or, if you want to use a wild card, you can use something like this instead:
#
# sudo apt-get remove teamv*
#### END OF EXAMPLE ####

## https://askubuntu.com/questions/804946/systemctl-how-to-unmask

###############################
####### END OF SERVICES #######
###############################
