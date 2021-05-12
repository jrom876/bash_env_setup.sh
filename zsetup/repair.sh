#!/bin/bash

# File Name:		repairs.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
#			jrom876@gmail.com
# Contact:		cesllc876@gmail.com
# Github Page:		www.github.com/jrom876
#
#####################################################
### PURPOSE: SYSTEM REPAIRS, UPDATES AND UPGRADES ###
#####################################################

# This file contains commands for system repairs, updates, and upgrades.

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

##################################
shopt -s expand_aliases
##################################

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

########################
### CLEAN AND REMOVE ###
########################
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

### APPORT -- AUTOMATIC ERROR REPORTING ###
## https://websetnet.net/how-to-disable-or-enable-automatic-error-reporting-in-ubuntu/

## To install apport
## sudo apt update
## sudo apt install apport
## sudo systemctl start apport

## To stop apport
## sudo service apport stop

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
	sudo dpkg --list 'linux-image*'
}

## Delete specific Linux version from above command
## arg $1 = Linux Version
## e.g.:	sudo apt-get remove linux-image-VERSION
dltlnxver () {
	sudo apt-get remove linux-image-$1
}
#######################
### PACKAGE REPAIRS ###
#######################
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
