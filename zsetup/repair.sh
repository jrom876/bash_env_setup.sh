#!/bin/bash

# File Name:		repairs.sh
# Written by:		Jacob Romero
#					Creative Engineering Solutions, LLC
# Contact:			cesllc876@gmail.com
#					admin@jrom.io
# Github Page:		www.github.com/jrom876
#
#####################################################
### PURPOSE: SYSTEM REPAIRS, UPDATES AND UPGRADES ###
#####################################################

## This file contains commands for system repairs, updates, and upgrades.
## It includes antivirus scanners such as clamav and lynis. 

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

##################################
shopt -s expand_aliases
##################################

##############################
### REFERENCES AND CREDITS ###
##############################

## Linux Directory Structure
## https://www.howtogeek.com/117435/htg-explains-the-linux-directory-structure-explained/
## https://itsfoss.com/free-up-space-ubuntu-linux/

## https://www.linux.com/topic/desktop/cleaning-your-linux-startup-process/
## https://askubuntu.com/questions/804946/systemctl-how-to-unmask
## https://unix.stackexchange.com/questions/533933/systemd-cant-unmask-root-mount-mount
## https://www.golinuxcloud.com/boot-in-single-user-mode-rhel-centos-8-linux/
## https://linuxconfig.org/how-to-boot-ubuntu-18-04-into-emergency-and-rescue-mode
## https://askubuntu.com/questions/1057300/ubuntu-fails-to-boot-fully-stuck-in-log-screen-ppp-link-was-shut-down

## https://askubuntu.com/questions/1280944/gnome-shell-crashes-intermittently-sends-me-back-to-login
## https://askubuntu.com/questions/346953/how-to-read-and-use-crash-reports
## https://stackoverflow.com/questions/35010922/apache-crash-report-is-closing-session-no-dbus-session-bus-address-in-envir
## https://forums.kali.org/showthread.php?31257-No-Boot-system-hang-on-quot-
## Started-Update-UTMP-about-System-Runlevel-Changes-quot

#### https://askubuntu.com/questions/1280944/gnome-shell-crashes-intermittently-sends-me-back-to-login/1287443#1287443

### APPORT -- AUTOMATIC ERROR REPORTING ###
## https://websetnet.net/how-to-disable-or-enable-automatic-error-reporting-in-ubuntu/

## To install apport
## sudo apt update
## sudo apt install apport
## sudo systemctl start apport

## To stop apport
## sudo service apport stop

#sudo nano /var/log/apport.log.1

#ERROR: apport (pid 22117) Tue Oct 27 08:41:35 2020: this executable already crashed 2 times, ignoring
#ERROR: apport (pid 22141) Tue Oct 27 08:41:37 2020: called for pid 22124, signal 31, core limit 0, dump mode 1
#ERROR: apport (pid 22141) Tue Oct 27 08:41:37 2020: executable: /usr/lib/tracker/tracker-extract (command line "/usr/li$
#ERROR: apport (pid 22141) Tue Oct 27 08:41:37 2020: debug: session gdbus call: (true,)

#ERROR: apport (pid 7005) Mon Oct 26 21:17:04 2020: apport: report /var/crash/_usr_lib_tracker_tracker-extract.1000.cras$
#ERROR: apport (pid 7027) Mon Oct 26 21:17:06 2020: called for pid 7009, signal 31, core limit 0, dump mode 1
#ERROR: apport (pid 7027) Mon Oct 26 21:17:06 2020: executable: /usr/lib/tracker/tracker-extract (command line "/usr/lib$
#ERROR: apport (pid 7027) Mon Oct 26 21:17:06 2020: debug: session gdbus call: (true,)


## https://askubuntu.com/questions/1119167/slow-boot-issue-due-to-plymouth-quit-wait-service-ubuntu-18-04
## systemctl list-dependencies --reverse plymouth-quit-wait.service
## systemctl list-dependencies plymouth-quit-wait.service
## systemd-analyze plot > ~/SystemdAnalyzePlot.svg

## Having trouble with ufw being disabled at boot?
## Try disabling firewalld.service, which interferes with ufw
## e.g.:	sudo systemctl disable firewalld.service

###########################
#### TABLE OF CONTENTS ####
###########################
ecrepairs () {
	echo
	echo 'WELCOME TO UPDATE AND REPAIR UTILITY'; echo
	echo 'UPDATE AND UPGRADE'
	echo 'sai	syi		sudo apt install (-y)'
	echo 'sau	say		sudo apt update (-y)'
	echo 'sag	syg		sudo apt upgrade (-y)'
	echo 'suf			sudo apt full-upgrade'
	echo 'sug			sau && saf && sag'
	echo 'suu			syi && saf && suf'; echo	
	echo 'FIX AND REBOOT'
	echo 'saf			sudo apt install -f'
	echo 'san			sudo apt --fix-broken install'
	echo 'sureboot		sudo apt reboot'
	echo 'bye 			clear; exit'
	echo 'saremove $1		sudo apt remove $1'; echo	
	echo 'SYSTEM INTERROGATORS'	
	echo 'luner			comprehensive system interrogator'
	echo 'gtblame			systemd-analyze blame'
	echo 'gtunitfiles		systemctl list-unit-files'
	echo 'gtsvcs			systemctl list-unit-files --type=service'
	echo 'gtenabled		systemctl list-unit-files --type=service | grep enabled'
	echo 'gtnonstatic		systemctl list-unit-files --type=service | grep -v static'; echo	
	echo 'FAN SPEED UTILITY'
	echo 'fanmod $1		To modify Jetson Nano cooling fan speed setting'
	echo '			Call:	fanmod <arg> (password required)'
	echo '			The suggested <arg> range is 100-125. Default is 120'; echo
	echo 'fanstatus		Display Fan and CPU Temperature Status'
	echo 'gtfanspeed		Display Fan Speed'
	echo 'sensors			Display CPU Temperatures'
	echo "extemp 			Display CPU fan temp in $degrees F"
	echo 'ctof			Convert Celsius to Fahrenheit'
	echo 'ftoc			Convert Fahrenheit to Celsius';	echo 
	echo 'CRASH DUMP UTILITY'
	echo 'crsh			ls /var/crash	get crash dumps'
	echo 'rcrsh			delete old crash dumps'
	echo 'savcrsh()		save crash dump list in report'
	echo 'dltcrsh()		delete crash dumps from report'
	echo 'storecrash()		store complete crash dumps in ~/bkups/crash_dumps/'
	echo 'clrcrash()		clear all crash dumps from ~/bkups/crash_dumps/'; echo
	echo 'PACKAGE REPAIRS'
	echo 'atomdsofe_repair	For atom_disable_shelling_out_for_environment=false'
	echo 'dccfg_repair		For Error loading config file: /home/jrom/.docker/config.json: '
	echo 'diversions_dpkg_repair	For too-long line or missing new line in /var/lib/dpkg/diversions'
	echo 'initramfs_repair	For initramfs-tools crash reports and errors'
	echo 'sadfig			For dpkg: error: front end is locked by another process'
	echo 'daereload		daemon reload'; echo
}

#########################################
#### LYNIS SECURITY ANALYSIS UTILITY ####
#########################################

## lynis
## https://github.com/CISOfy/lynis
## https://opensource.com/article/20/5/linux-security-lynis

alias mtlynis='cd /usr/sbin; ls -la ly*'

rnlynis () {
	cd /usr/sbin;
	sudo ./lynis audit system;
	cd $OLDPWD
}

##	./lynis -h
##	./lynis show version
##	./lynis show commands
##	./lynis audit system
##	
##	ls -l /var/log/lynis.log

##	./lynis show details TEST-ID
##	e.g.	./lynis show details SSH-7408
##	
##	

## iftop
## https://www.cyberciti.biz/tips/top-linux-monitoring-tools.html

##################################
#### CLAMAV ANTIVIRUS UTILITY ####
##################################

##	PURPOSE:	
##	MALWARE SCANNER TASK AUTOMATION
##		Allows the sysadmin to:

##			-- scan for malware manually or automatically

##			-- update the clam definitions database 

##			-- edit /etc/clamav/freshclam.conf

##	clamav
##	https://www.clamav.net/
##	https://askubuntu.com/questions/114000/how-to-update-clamav-definitions-database
##	https://opensource.com/article/21/4/securing-linux-servers?utm_medium=Email&utm_campaign=weekly&sc_cid=7013a000002w4C4AAI&elqTrackId=a9ba809928aa4ac5b3c56eb0804b1ff1&elq=37f88420d43d4c0db3de1e5b9b171ed5&elqaid=619&elqat=1&elqCampaignId=460

##	sudo clamscan -r --bell -i /
##	sudo freshclam

rnclamscan () {
	sudo clamscan -r
}

##############################
#### UPDATES AND UPGRADES ####
##############################
function sai () {
	sudo apt-get install
}
function syi () {
	sudo apt-get install -y
}
function sau () {
	sudo apt-get update
}
function syu () {
	sudo apt-get update -y
}
function sag () {
	sudo apt-get upgrade
}
function syg () {
	sudo apt-get upgrade -y
}
function suf () {
	sudo apt-get full-upgrade
}

####################
### SIMPLE FIXES ###
####################
function saf () {
	sudo apt-get install -f
}
function san () {
	sudo apt-get --fix-broken install
}

#######################
### AUTOMATED FIXES ###
#######################
function sug () {
	sau && saf && syg
}
function suu () {
	say && saf && suf
}

##############
### REBOOT ###
##############
function sureboot () {
	sudo reboot
}

########################
### CLEAN AND REMOVE ###
########################

## Uninstall unneeded apps
function saaremove () {
	sudo apt autoremove
}
function saremove () {
	sudo apt remove $1
}
function sapurge () {
	sudo apt remove --purge $1
}

######## APT Cache ##########
## get, clean or delete apt cache
function gtaptcache () {
	sudo du -sh /var/cache/apt
}
function clnaptcache () {
	sudo apt-get autoclean
}

function dltaptcache () {
	sudo apt-get clean
}

######### System Journal Logs ##########
## Clear System Journal Logs
gtsysjournal () {
	journalctl --disk-usage
}

## e.g.: sudo journalctl --vacuum-time=3d
## arg $1 = days of logs to clear
clnsysjournal () {
	sudo journalctl --vacuum-time=$1
}

########## Snap #########
gtsnap () {
	du -h /var/lib/snapd/snaps
}

## dltsnap () MUST BE RAN AS ROOT IN HOME DIRECTORY
## CLOSE ALL SNAPS BEFORE RUNNING THIS
## EXAMPLE ONLY!!
## RUN dltsnp() FILE IN ~/

# dltsnap () {
# #!/bin/bash
# ## Removes old revisions of snaps
# set -eu
# snap list --all | awk '/disabled/{print $1, $3}' |
#     while read snapname revision; do
#         snap remove "$snapname" --revision="$revision"
#     done
# }

######## Thumbnail Cache #########

gtthmb () {
	du -sh ~/.cache/thumbnails
}
dltthmb () {
	rm -rf ~/.cache/thumbnails/*
}

####### Linux Kernels #######
### CAUTION ###
## List all installed Linux Kerenels
gtkernels () {
	sudo dpkg --list 'linux-*'
}

## Delete specific Linux version from above command
## arg $1 = Linux Version
## e.g.:	sudo apt-get remove linux-image-VERSION
dltlnxver () {
	sudo apt-get remove linux-image-$1
}
#######################
### PACKAGE REMOVAL ###
#######################

### INSTALLING ARDUINO ON JESTON NANO
## https://www.jetsonhacks.com/2019/10/04/install-arduino-ide-on-jetson-dev-kit/

### REMOVING ARDUINO 
## https://askubuntu.com/questions/1108373/how-do-i-remove-arduino-completely

#~ sudo apt-get remove arduino
#~ sudo apt-get remove --auto-remove arduino
#~ sudo apt-get purge arduino
#~ sudo apt-get purge --auto-remove arduino

#~ If that doesnt work:

#~ apt can only remove packages that youve installed via apt itself.
#~ Since youve downloaded the IDE from the Arduino website, 
#~ you will have to remove Arduino IDE manually. 
#~ So whatever folder it is in, just delete the folder directly

#~ or:
#~ Since you downloaded and installed it without using apt you 
#~ cannot remove it using apt, but instead need to use the 
#~ uninstall.sh script that was provided with the Arduino download.

## INSTALLING OR REINSTALLING ARDUINO 



#######################
### PACKAGE REPAIRS ###
#######################
## Having trouble with ufw being disabled at boot?
## Try disabling firewalld.service, which interferes with ufw
## e.g.:	sudo systemctl disable firewalld.service

## current problem: gdm not initializing
## https://askubuntu.com/questions/1050672/gdm3-does-not-start-in-ubuntu-18-04
## https://askubuntu.com/questions/1230053/how-to-repair-a-broken-gnome
## https://ostechnix.com/how-to-fix-broken-ubuntu-os-without-reinstalling-it/
#### https://www.maketecheasier.com/fix-broken-packages-ubuntu/

## See: https://phoenixnap.com/kb/fix-sub-process-usr-bin-dpkg-returned-error-code-1
## https://www.howtogeek.com/423709/how-to-see-all-devices-on-your-network-with-nmap-on-linux/

## https://phoenixnap.com/kb/fix-could-not-get-lock-error-ubuntu

## For flash-kernel errors
## https://itsfoss.com/dpkg-returned-an-error-code-1/

## For initramfs-tools crash reports and errors
## http://linux-commands-examples.com/update-initramfs
## I used 'update-initramfs -d' to delete the current version (which had errors)
## and then I ran 'update-initramfs -c' to create a new version from scratch.
## Then I ran sau && sag to update and upgrade.
## This fixed it.

initramfs_repair () {
	sudo update-initramfs -d
	update-initramfs -c
	sau && sag
}

## https://www.binarytides.com/ubuntu-fix-system-program-problem-error/

## For dpkg: error: front end is locked by another process
sadfig () {
	sudo dpkg --configure -a
}

################
## For : too-long line or missing new line in /var/lib/dpkg/diversions
## https://raspberrypi.stackexchange.com/questions/53478/apt-get-error-while-installing-software
diversions_dpkg_repair () {
	sudo mv /var/lib/dpkg/diversions ./diversions.backup
	sudo touch /var/lib/dpkg/diversions
	sudo dpkg --configure -a
}

#sudo dpkg --configure -a
#sudo apt-get clean
#sudo dpkg-divert --list
#sudo apt-get check
#sudo apt-get install -f

################
## For the following error:
## WARNING: Error loading config file: /home/jrom/.docker/config.json:
##	stat /home/jrom/.docker/config.json: permission denied
## See: https://askubuntu.com/questions/747778/docker-warning-config-json-permission-denied

dccfg_repair () {
	sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
	sudo chmod g+rwx "/home/$USER/.docker" -R
}
## Or try:
## https://stackoverflow.com/questions/32698389/docker-non-root-access-error-
## loading-config-filestat-home-wu-docker-config-j
# sudo chown $USER:docker ~/.docker
# sudo chown $USER:docker ~/.docker/config.json
# sudo chmod g+rw ~/.docker/config.json

################################

## For atom_disable_shelling_out_for_environment=false

## https://stackoverflow.com/questions/62681150/atom-opens-a-new-file-called-atom-disable-shelling-out-for-environment-false
atomdsofe_repair () {
	sudo sed -i 's/Exec=env BAMF_DESKTOP_FILE_HINT=\/var\/lib\/snapd\/desktop\/applications\/atom_atom.desktop \/snap\/bin\/atom ATOM_DISABLE_SHELLING_OUT_FOR_ENVIRONMENT=false \/usr\/bin\/atom %F/Exec=env BAMF_DESKTOP_FILE_HINT=\/var\/lib\/snapd\/desktop\/applications\/atom_atom.desktop ATOM_DISABLE_SHELLING_OUT_FOR_ENVIRONMENT=false \/snap\/bin\/atom %F/' /var/lib/snapd/desktop/applications/atom_atom.desktop
}

##	Creating custom Atom version for arm64/aarch64
##	https://github.com/atom/atom/issues/15881

####################################
### Sound Settings -- Pulseaudio ###
####################################
## If the sound setting on a new Gnome Desktop keeps defaulting annoyingly
## to the 'Analog Audio Output' and you want it to be on HDMI, or rather
## to stop Unity Desktop sound setting from defaulting to 'Analog Audio Output'
## and allow the user to designate the output, use the following command:
## pulseaudio -k

###############
## https://germaniumhq.com/2019/02/19/2019-02-19-Fixing-Virtual-Desktops-on-Multiple-Monitors-in-Ubuntu-18.04/

## sudo apt install dconf-editor

########################
#### END OF REPAIRS ####
########################
## https://www.makeuseof.com/tag/alt-f2-ultimate-linux-keyboard-shortcut/
