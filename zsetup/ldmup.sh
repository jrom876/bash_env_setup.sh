#!/bin/bash

# File Name:		ldmup.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876
#
################################################
####### PURPOSE: INSTALLING DEPENDENCIES #######
################################################

## This routine installs most of the dependencies required
## by this script and the system.
## It can be ran in the CLI on new systems for fast configuration,
## or it can be ran in our custom CLI environment.

####################
### INSTRUCTIONS ###
# In order to run this script on a given CLI in new systems, you 
# must be in the directory where ldmup.sh is located (usually the home directory)
# and run the following command:
#
#	. ./ldmup.sh	for GENTLE install
#		or
#	. ./lymup.sh	for FORCED install
#
# NOTE: Don't forget the important dot-space at the beginning of the
# command because this designates the current CLI as the target.
#

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

####################
### AUTOLOADERS ####
####################

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
### GENTLY, i.e. with user prompts
ldmup () {
## First we update, and upgrade
	sudo apt-get update
#	sudo apt-get install -f
	sudo apt-get upgrade -y
## Then we create several required directories
	#crtdirs
	cd ~/
	## Backup Directories
	mkdir bkups
	mkdir bkups/fbkups
	mkdir bkups/hp250_bkups
	mkdir bkups/jetsonbkups
	mkdir bkups/rpi12bkups
	mkdir bkups/rpi13bkups
	mkdir bkups/rpizerobkups
	mkdir bkups/sysbkups
	## System Directories
	mkdir _files
	mkdir mtr-reports
	mkdir reports
	mkdir sandbox
	mkdir skeeter
	mkdir tempo
	cd $OLDPWD
## Then we load some custom files
	#ldarray ${myfiles_array[@]}
## Then we run our package installers
	#ldlang
	sudo apt-get install gcc
	sudo apt-get install g++
	sudo apt-get install gdb
	sudo apt-get install perl
	sudo apt-get install check
	sudo apt-get install nodejs
	sudo apt-get install sqlite
	sudo apt-get install markdown
	sudo apt-get install default-jre
	sudo apt-get install default-jdk
	#ldpython
	sudo apt-get install python3
	sudo apt-get install calibre
	sudo apt-get install jupyter
	sudo apt-get install python3-tk
	sudo apt-get install python3-venv
	sudo apt-get install python3-flask
	sudo apt-get install python3-numpy
	sudo apt-get install python3-sympy
	sudo apt-get install python3-pandas
	sudo apt-get install python3-seaborn
	sudo apt-get install python3-matplotlib
	#ldedit
	sudo apt-get install meld
	sudo apt-get install geany
	sudo apt-get install gedit
	sudo apt-get install mousepad
	sudo apt-get install nautilus
	sudo apt-get install fdupes
	# sudo apt install fdupes
	#ldsec
	sudo apt-get install ufw
	sudo apt-get install fail2ban
#	sudo apt-get install rng-tools
	#ldnet
	sudo apt-get install nmap
	sudo apt-get install traceroute
	sudo apt-get install iptables
	#ldgit
	#sudo apt-get install git-all
	#ldiot
	#sudo apt-get install nginx
	#sudo apt-get install mosquitto mosquitto-clients	
	#ldrmt
	sudo apt-get install ssh
	sudo apt-get install remmina
	#ldsys
	sudo apt-get install inxi
	sudo apt-get install dmidecode
## After installing we fix, update, and upgrade again.
	sudo apt-get update
#	sudo apt-get install -f
	sudo apt-get upgrade -y
## If needed, we also reboot to finish the install.
#	sudo reboot
}

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
### FORCED, i.e. without user prompts, using -y option 
lymup () {
## First we fix, update, and upgrade
	sudo apt-get update
#	sudo apt-get install -f
	sudo apt-get upgrade -y
## Then we create several required directories
	#crtdirs
	cd ~/
	## Backup Directories
	mkdir bkups
	mkdir bkups/fbkups
	mkdir bkups/hp250_bkups
	mkdir bkups/jetsonbkups
	mkdir bkups/rpi12bkups
	mkdir bkups/rpi13bkups
	mkdir bkups/rpizerobkups
	mkdir bkups/sysbkups
	## System Directories
	mkdir _files
	mkdir mtr-reports
	mkdir reports
	mkdir sandbox
	mkdir skeeter
	mkdir tempo
	cd $OLDPWD
## Then we load some custom test files into the home directory (~/)
	#ldarray ${myfiles_array[@]}
	## CAUTION!! Use ldarray instead, unless you really have your bolts tightened!!
	### lyarray ${myfiles_array[@]} 
## Then we run our package installers with the -y option
	#lylang
	sudo apt-get install -y gcc
	sudo apt-get install -y g++
	sudo apt-get install -y gdb
	sudo apt-get install -y perl
	sudo apt-get install -y check
	sudo apt-get install -y nodejs
	sudo apt-get install -y sqlite
	sudo apt-get install -y markdown
	sudo apt-get install -y default-jre
	sudo apt-get install -y default-jdk
	#lypython
	sudo apt-get install -y python3
	sudo apt-get install -y calibre
	sudo apt-get install -y jupyter
	sudo apt-get install -y python3-tk
	sudo apt-get install -y python3-venv
	sudo apt-get install -y python3-flask
	sudo apt-get install -y python3-numpy
	#python3 -m pip install sympy
	sudo apt-get install -y python3-pandas
	sudo apt-get install -y python3-seaborn
	sudo apt-get install -y python3-matplotlib
	#lyedit
	sudo apt-get install -y meld
	sudo apt-get install -y geany
	sudo apt-get install -y gedit
	sudo apt-get install -y mousepad
	sudo apt-get install -y nautilus
	sudo apt-get install -y fdupes
	#lysec
	sudo apt-get install -y ufw
	sudo apt-get install -y fail2ban
	#sudo apt-get install -y rng-tools
	#lynet
	sudo apt-get install -y nmap
	sudo apt-get install -y traceroute
	sudo apt-get install -y iptables
	#lygit
	#sudo apt-get install -y git-all
	#lyiot
	#sudo apt-get install -y nginx
	#sudo apt-get install -y mosquitto mosquitto-clients
	#lyrmt
	sudo apt-get install -y ssh
	sudo apt-get install -y remmina	
	#lysys
	sudo apt-get install -y inxi
	sudo apt-get install -y dmidecode
## After installing we fix, update, and upgrade again.
	sudo apt-get update
#	sudo apt-get install -f
	sudo apt-get upgrade -y
## If needed, we also reboot to finish the install.
#	sudo reboot
}

##################################
####### PACKAGE INSTALLERS #######
##################################

##########################
### GENTLE INSTALLERS ####
##########################
## NOTE: sai = sudo apt install
## sw language packages
ldlang () {
	sudo apt-get install gcc
	sudo apt-get install g++
	sudo apt-get install gdb
	sudo apt-get install perl
	sudo apt-get install check
	sudo apt-get install nodejs
	sudo apt-get install sqlite
	sudo apt-get install markdown
	sudo apt-get install default-jre
	sudo apt-get install default-jdk
}

## python packages
ldpython () {
	sudo apt-get install python3
	sudo apt-get install calibre
	sudo apt-get install jupyter
	sudo apt-get install python3-tk
	sudo apt-get install python3-flask
	sudo apt-get install python3-numpy
	sudo apt-get install python3-sympy
	sudo apt-get install python3-pandas
	sudo apt-get install python3-seaborn
	sudo apt-get install python3-matplotlib
}

## text editors and file handlers
ldedit () {
	sudo apt-get install meld
	sudo apt-get install geany
	sudo apt-get install gedit
	sudo apt-get install mousepad
	sudo apt-get install nautilus
	sudo apt-get install fdupes
	# sudo apt install fdupes
}
## security
ldsec () {
	sudo apt-get install ufw
	sudo apt-get install fail2ban
#	sudo apt-get install rng-tools
}
## networking
ldnet () {
	sudo apt-get install nmap
	sudo apt-get install traceroute
	sudo apt-get install iptables

}
ldgit () {
	sudo apt-get install git-all
}
## edge devices
## https://www.arrow.com/en/research-and-events/articles/mqtt-tutorial
## https://mosquitto.org/man/mosquitto_sub-1.html
ldiot () {
	sudo apt-get install nginx
	sudo apt-get install mosquitto mosquitto-clients
}
## remote access
ldrmt () {
	sudo apt-get install ssh
	sudo apt-get install remmina
}
## system
ldsys () {
	sudo apt-get install inxi
	sudo apt-get install dmidecode
}

##########################
### FORCED INSTALLERS ####
##########################
## NOTE: syi = sudo apt install -y
## sw language packages
lylang () {
	sudo apt-get install -y gcc
	sudo apt-get install -y g++
	sudo apt-get install -y gdb
	sudo apt-get install -y perl
	sudo apt-get install -y check
	sudo apt-get install -y nodejs
	sudo apt-get install -y sqlite
	sudo apt-get install -y markdown
	sudo apt-get install -y default-jre
	sudo apt-get install -y default-jdk
}
## python packages
lypython () {
	sudo apt-get install -y python3
	sudo apt-get install -y calibre
	sudo apt-get install -y jupyter
	sudo apt-get install -y python3-tk
	sudo apt-get install -y python3-flask
	sudo apt-get install -y python3-numpy
	#sudo apt-get install -y python3-sympy
	#pip install sympy
	python3 -m pip install sympy
	sudo apt-get install -y python3-pandas
	sudo apt-get install -y python3-seaborn
	sudo apt-get install -y python3-matplotlib
}
## text editors and file handlers
lyedit () {
	sudo apt-get install -y meld
	sudo apt-get install -y geany
	sudo apt-get install -y gedit
	sudo apt-get install -y mousepad
	sudo apt-get install -y nautilus
	sudo apt-get install -y fdupes
}
## security
lysec () {
	sudo apt-get install -y ufw
	sudo apt-get install -y fail2ban
	sudo apt-get install -y rng-tools
}
## networking
lynet () {
	sudo apt-get install -y nmap
	sudo apt-get install -y traceroute
	sudo apt-get install -y iptables

}
lygit () {
	sudo apt-get install -y git-all
}
## edge devices
## https://www.arrow.com/en/research-and-events/articles/mqtt-tutorial
## https://mosquitto.org/man/mosquitto_sub-1.html
lyiot () {
	sudo apt-get install -y nginx
	sudo apt-get install -y mosquitto mosquitto-clients
}
## remote access
lyrmt () {
	sudo apt-get install -y ssh
	sudo apt-get install -y remmina
}
## system
lysys () {
	sudo apt-get install -y inxi
	sudo apt-get install -y dmidecode
}

###############################
####### FILE INSTALLERS #######
###############################

################
#### GENTLE ####

##	ldarray ${myfiles_array[@]}
ldarray () {
	declare -a load_array
	load_array="${@%/*}"
	load_array=($load_array)
	#echo $@
	#echo ${dir_array[@]} ## DBPRINT
	for dir in "${load_array[@]}"; do
		echo "$dir" ## DBPRINT
		if [[ -e ~/$dir ]]; then
			echo "$dir already exists. Should we overwrite it?"
			read answer
			if [ $answer != 'y' ]; then
				echo "Aborting backup. Goodbye."
			else
				sudo rm -rf ~/$dir
				mkdir ~/$dir
				cp -r ~/qsetup/$dir ~/$dir
				#echo "Overwrite and backup of ~/$dir completed" ## DBPRINT
			fi
		else
			cd ~/
			mkdir $dir
			cp -r ~/qsetup/$dir ~/$dir
		fi
	 done
}

ldmyfiles () {
	if [[ -e ~/laserDriver ]]; then
		echo 'laserDriver already exists. Should we overwrite it?'
		read answer
		if [ $answer != 'y' ]; then
			echo "Aborting backup. Goodbye."
		else
			rm -rf ~/laserDriver
			mkdir ~/laserDriver
			cp -r ~/qsetup/laserDriver ~/laserDriver
			#echo "Overwrite and backup of ~/laserDriver completed" ## DBPRINT
		fi
	else
		mkdir laserDriver
		cp -r ~/qsetup/laserDriver ~/laserDriver
	fi

	if [[ -e ~/my_flask_app ]]; then
		echo 'my_flask_app already exists. Should we overwrite it?'
		read answer
		if [ $answer != 'y' ]; then
			echo "Aborting backup. Goodbye."
		else
			rm -rf ~/my_flask_app
			mkdir ~/my_flask_app
			cp -r ~/qsetup/my_flask_app ~/my_flask_app
			#echo "Overwrite and backup of ~/my_flask_app completed" ## DBPRINT
		fi
	else
		mkdir my_flask_app
		cp -r ~/qsetup/my_flask_app ~/my_flask_app
	fi
}

################
#### FORCED ####

##	lyarray ${myfiles_array[@]}
lyarray () {
	declare -a load_array
	load_array="${@%/*}"
	load_array=($load_array)
	#echo $@
	#echo ${dir_array[@]} ## DBPRINT
	for dir in "${load_array[@]}"; do
		echo "$dir" ## DBPRINT
		if [[ -e ~/$dir ]]; then
			sudo rm -rf ~/$dir
			mkdir ~/$dir
			cp -r ~/qsetup/$dir ~/$dir
			#echo "Overwrite and backup of ~/$dir completed" ## DBPRINT
		else
			mkdir $dir
			cp -r ~/qsetup/$dir ~/$dir
		fi
	 done
}

lymyfiles () {
	if [[ -e ~/laserDriver ]]; then
		rm -rf ~/laserDriver
		mkdir ~/laserDriver
		cp -r ~/qsetup/laserDriver ~/laserDriver
		#echo "Overwrite and backup of ~/laserDriver completed" ## DBPRINT
	else
		mkdir laserDriver
		cp -r ~/qsetup/laserDriver ~/laserDriver
	fi

	if [[ -e ~/my_flask_app ]]; then
		rm -rf ~/my_flask_app
		mkdir ~/my_flask_app
		cp -r ~/qsetup/my_flask_app ~/my_flask_app
		#echo "Overwrite and backup of ~/my_flask_app completed" ## DBPRINT
	else
		mkdir my_flask_app
		cp -r ~/qsetup/my_flask_app ~/my_flask_app
	fi
}

myfiles_array=(
	_files \
	laserDriver \
	my_flask_app \
	sandbox )

#########################################
#########################################

## java
## https://www.hostinger.com/tutorials/install-java-ubuntu
ldjava () {
	## install using default package manager
	# sug
	sudo apt-get install default-jre
	sudo apt-get install default-jdk
	# sug
}

## vnc
ldvnc () {
## https://www.cyberciti.biz/faq/install-and-configure-tigervnc-server-on-ubuntu-18-04/
## https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-18-04
	sudo apt-get install xfce4 xfce4-goodies
	#sudo apt-get install tightvncserver
	#sudo apt-get install realvnc

	## Now perform the following steps:
	# vncserver
	# vncserver -kill :1
	# mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
	# sudo nano ~/.vnc/xstartup
	### Paste the following into ~/.vnc/startup, save and exit:

	# #!/bin/bash
	# xrdb $HOME/.Xresources
	# startxfce4 &

	# sudo chmod +x ~/.vnc/xstartup
	# vncserver
}

## To start|stop service
## systemctl (start|stop) vncserver-x11-serviced.service
## systemctl (start|stop) vncserver-virtuald.service

## To mark|unmark service to be started at boot time
## systemctl (enable|disable) vncserver-x11-serviced.service
## systemctl (enable|disable) vncserver-virtuald.service


####### SSH #######
### load ssh (ldssh)
## This routine loads ssh and remmina.
ldssh () {
## First we fix, update, and upgrade
	sug
## Then we use 'sudo apt install' to load and/or verify packages.
	### ssh tools
	sudo apt-get install ssh
	sudo apt-get install remmina

## To setup ssh keys follow the procedure in this link:
## https://linuxize.com/post/how-to-set-up-ssh-keys-on-ubuntu-1804/

## To complete sftp install follow the procedure in this link:
## https://linuxconfig.org/how-to-setup-sftp-server-on-ubuntu-18-04-bionic-beaver-with-vsftpd

## After installing we fix, update, and upgrade again.
## If needed, we also reboot to finish the install.
	sug
#	sudo reboot
}

#### SSH KEYS ####
## https://linuxize.com/post/how-to-set-up-ssh-keys-on-ubuntu-1804/
alias genSSHKey='ssh-keygen -t rsa -b 4096'
alias findSSHKey='ls -l ~/.ssh/id_*.pub'
# alias findSSHKey='ls -l ~/.ssh/authorized_keys'
alias extractSSHKey='cd ~/.ssh; \
		sudo nano id_*.pub'
# alias extractSSHKey='cd ~/.ssh; \
# 		sudo nano authorized_keys'
####### remmina: Ubuntu remote desktop #######
alias rem='remmina'

## arg $1 = remote user name, arg $2 = remote host_ip_address
ssconnHost () {
	#ssh;
	sudo ssh $1@$2;
}
ssrestart () {
	sudo service ssh restart
}

## https://www.webservertalk.com/troubleshoot-ssh-connection-refused
## https://linoxide.com/ubuntu-how-to/configure-static-ip-address-ubuntu/

ldaudio () {
	sai sound-juicer
}

#########################################
####### END OF PACKAGE INSTALLERS #######
#########################################

