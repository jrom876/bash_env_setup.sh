#!/bin/bash
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
## This autoloader installs most of the dependencies required 
## by zsetup scripts and the system.

## load em up (ldmup)
ldmup () { 
## First we fix, update, and upgrade using the alias 'sug'.
	sug
## Then we run our package installers.
## Uncomment the ones you want to run.
	ldlang
	ldedit
	ldsec
	ldnet
	#ldgit
	#ldiot
	ldrmt
	ldsys
## After installing we fix, update, and upgrade again.
	sug
## If needed, we also reboot to finish the install.
#	sudo reboot
}

##################################
####### PACKAGE INSTALLERS #######
##################################
## sw languages
ldlang () {
	sai gcc
	sai g++
	sai check
	sai gdb
	sai python3
	sai python3-tk
	sai default-jre
	sai default-jdk
	sai perl
}
## text editors and file handlers
ldedit () {
	sai geany
	sai gedit
	sai mousepad
	sai nautilus
}
## security
ldsec () {
	sai ufw
	sai fail2ban
	sai rng-tools
}
## networking
ldnet () {
	sai nmap
	sai traceroute
	sai iptables
	
}
ldgit () {
	sai git-all
}
## edge devices
## https://www.arrow.com/en/research-and-events/articles/mqtt-tutorial
## https://mosquitto.org/man/mosquitto_sub-1.html
ldiot () {	
	sai nginx
	sai mosquitto mosquitto-clients
}
## remote access
ldrmt () {
	sai ssh
	sai remmina
}
## system
ldsys () {
	sai inxi
	sai dmidecode
}
#########################################
#########################################

## java
## https://www.hostinger.com/tutorials/install-java-ubuntu
ldjava () {
	## install using default package manager
	# sug
	sai default-jre
	sai default-jdk
	# sug
}
## vnc
ldvnc () {
## https://www.digitalocean.com/community/
## tutorials/how-to-install-and-configure-vnc-on-ubuntu-18-04
	sai xfce4 xfce4-goodies
	sai tightvncserver

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

####### SSH #######
### load ssh (ldssh)
## This routine loads ssh and remmina.
ldssh () {
## First we fix, update, and upgrade
	sug
## Then we use 'sudo apt install' to load and/or verify packages.
	### ssh tools
	sai ssh
	sai remmina

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
#alias findSSHKey='ls -l ~/.ssh/id_*.pub'
alias findSSHKey='ls -l ~/.ssh/authorized_keys'
alias extractSSHKey='cd ~/.ssh; \
				sudo nano authorized_keys'
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
#########################################
####### END OF PACKAGE INSTALLERS #######
#########################################
