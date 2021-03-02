#!/bin/bash

# File Name:		cwf.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876
#
####################
### PURPOSE: DFA ###
####################
##### IYHTAYNK #####
####################

####################
#### REFERENCES ####
####################
## Killing a Process: https://www.linux.com/training-tutorials/how-kill-process-command-line/
## https://askubuntu.com/questions/565255/how-to-uninstall-teamviewer
### wpa_supplicant:	http://www.linuxfromscratch.org/blfs/view/svn/basicnet/wpa_supplicant.html
# https://en.wikipedia.org/wiki/Supplicant_(computer)
## For info on parsing bash script, see:
## https://unix.stackexchange.com/questions/531938/parse-a-string-in-bash-script
## See: https://askubuntu.com/questions/907246/how-to-disable-systemd-resolved-in-ubuntu

##################################
shopt -s expand_aliases
##################################

## First, use 'evproc' or 'netstat -tulp' to see all ports,
## processes and services.
## Then pick the process or service you want to start, stop or investigate.
evproc () {
	echo;
	sudo netstat -tulp; echo
	lsoi; echo;
	sudo ufw status;
	echo 'Available Entropy:'; entropy; echo;
	echo 'Crash Dump Report:'; crsh; savcrsh; echo;
	## echo 'Open Internet Ports:'; lsoi; echo;
	# lsTTy; echo;
	# getUSB;
	# getSER; echo;
	# getnet; echo;
	# cwShowpw; echo;
	# savzulu; echo; # HP-250 and Jetson Nano
	# savxray; echo;
	savsupp; echo; # RaspberryPi
	echo 'Available Commands:'
	echo 'cwdsabl $1     or   svkill $1          to disable or kill a process'
	echo 'cwenabl $1     or   svstart $1         to enable or start a process'
	echo 'ufenable                               to enable firewall'
	echo 'svrestart $1                           to restart a service'
	echo 'kusb $1        or   kport $1           to kill a USB or other port'
	echo 'denyPort $1    or   sudo ufw deny $1   to deny a port, process, or address'
	echo 'allowPort $1   or   sudo ufw allow $1  to allow a port, process, or address'
	echo 'pk9_signal $1                          to kill a signal'
	echo 'svtus $1                               to get status of a service'
	echo 'svall                                  to list all running services'
	echo 'psrch $1                               to search current running processes for given keyword'
}

evsec () {
	echo; currDate; echo;
	echo '======= Users ======='; echo;
	wami; echo;
	echo "Hostname:"; hn; echo;
#	echo 'Groups:'; grpid; echo;
#	echo 'Linux Users:'; lusers; echo;
	echo '======= UFW ======='; echo;
	sudo ufw status;
	echo 'Available Entropy:'; entropy; echo;
#	echo 'Crash Dump Report:'; crsh; savcrsh; echo;

<<COMMENT
	echo '======= CPU ======='; echo;
	inxi -F; echo;
COMMENT

	echo '======= Ports and Processes ======='; echo;
#	echo 'Listing active USB ports:';	getUSB;	echo;
	echo 'Listing active Serial ports:';	getSER;	echo;
#	getTTy; echo;
#	ss -ltn; echo;
	sudo netstat -tulp; echo;
	# sudo dmidecode -t 8; echo;
	lsoi; echo;

	echo '======= Network Information ======='; echo;
	getIP
#	echo 'ARP Table:'; arp; echo;
	# savzulu; echo; # HP-250 and Jetson Nano
	savsupp; echo; # RaspberryPi
	sudo netstat -i; echo; # Kernel interface table
#	sudo netstat -r; echo; # Kernel routing table
#	getnet; echo;
	echo '================ Useful Commands ================'
	echo 'COMMON COMMANDS'
	echo 'eclist		Table of Contents'
	echo 'luner		comprehensive system evaluation'
	echo 'lusers		show all linux system users'
	echo 'ufenable	sudo ufw enable'
	echo 'lssysbkups	list primary backups'
	echo 'getnet		simple network evaluation'
	echo 'evnet		specific network evaluation'
	echo 'fevnet		full network evaluation'
	echo 'gtzulu		show network passwd (HP-250 and Jetson Nano)'
	echo 'gtsupp		show network passwd (Raspberry Pi)'; echo

	echo 'CAT CALLS	FILE DISPLAYED'
	echo 'ctnmapl		nmap-list'
	echo 'ctgw		Gateway-list'
	echo 'cthp250		HP250-list'
	echo 'ct12		RPi12-list'
	echo 'ct13		RPi13-list'
	echo 'ctjetson	Jetson-list'
	echo 'ctzero		PiZero_W-list'
	echo 'ctcrsh		crash_dump_report'; echo

	echo 'PROCESS CONTROL COMMANDS'
	echo 'cwdsabl $1     or   svkill $1          to disable or kill a process'
	echo 'cwenabl $1     or   svstart $1         to enable or start a process'
	echo 'svrestart $1                           to restart a service'
	echo 'kusb $1        or   kport $1           to kill a USB or other port'
	echo 'denyPort $1    or   sudo ufw deny $1   to deny a port, process, or address'
	echo 'allowPort $1   or   sudo ufw allow $1  to allow a port, process, or address'
	echo 'pk9_signal $1                          to kill a signal'
	echo 'svtus $1                               to get status of a service'
	echo 'svall                                  to list all running services'
	echo 'psrch $1                               to search current running processes for given keyword'

}

#### Disabling/Enabling a Service ####
cwdsabl () {
	sudo systemctl disable $1
}
cwenabl () {
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

ufenable () {
	sudo ufw enable
}

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

############/////////\\\\\\\\\\\############
######          THE IOT EDGE          ######
############\\\\\\\\\///////////############

##############################
####### Get Network PW #######
alias mtNMsc='ls /etc/NetworkManager/system-connections; \
		cd /etc/NetworkManager/system-connections'
opNMsc () {
	name=$( ls /etc/NetworkManager/system-connections  )
	sudo nano /etc/NetworkManager/system-connections/$name
}
savzulu () {
	name=$( ls /etc/NetworkManager/system-connections  )
	ssid=$( sudo cat /etc/NetworkManager/system-connections/$name |  grep ssid= )
	psk=$( sudo cat /etc/NetworkManager/system-connections/$name | grep psk= )
	ssid="${ssid#*=}"
	psk="${psk#*=}"
	echo $ssid > ~/reports/zulu-list
	echo $psk >> ~/reports/zulu-list
	chmod 600 ~/reports/zulu-list
	echo 'Use gtzulu to see zulu-list'
}

gtzulu () {
	gzvar=$( sudo cat ~/reports/zulu-list )
	if [[ -z $gzvar ]]
	then
		echo 'zulu-list is empty'
	else
		read -sp 'Enter Special Password: ' passvar
		if [[ $fmp = $passvar ]]
		then
			echo 'Correct! Here is zulu-list'
			echo
			cat ~/reports/zulu-list
		else
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}

dltzulu () {
	dzvar=$( sudo cat ~/reports/zulu-list )
	if [[ -z $dzvar ]]
	then
		echo 'Sorry, zulu-list is already empty'
	else
		read -sp 'Enter Special Password to delete zulu-list: ' passvar
		echo
		if [[ $fmp = $passvar ]]
		then
			echo
			echo $blanktext > ~/reports/zulu-list
			echo 'zulu-list deleted'
		else
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}

savNpw () {
	name=$( ls /etc/NetworkManager/system-connections  )
	ssid=$( sudo cat /etc/NetworkManager/system-connections/$name |  grep ssid= )
	psk=$( sudo cat /etc/NetworkManager/system-connections/$name | grep psk= )
	ssid="${ssid#*=}"
	psk="${psk#*=}"
	echo $ssid > ~/reports/npw-list.txt
	echo $psk >> ~/reports/npw-list.txt
	chmod 600 ~/reports/npw-list.txt
	echo 'Use gtpwl to see npw-list.txt'
}

gtpwl () {
	gpwvar=$( sudo cat ~/reports/npw-list.txt )
	if [[ -z $gpwvar ]]
	then
		echo 'Sorry, npw-list.txt is empty'
	else
		read -sp 'Enter Special Password: ' passvar
		if [[ $fmp = $passvar ]]
		then
			echo 'Correct! Here is npw-list'
			echo
			cat ~/reports/npw-list.txt
		else
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}

dltpwl () {
	dpwvar=$( sudo cat ~/reports/npw-list.txt )
	if [[ -z $dpwvar ]]
	then
		echo 'Sorry, npw-list.txt is already empty'
	else
		read -sp 'Enter Special Password to delete npw-list: ' passvar
		echo
		if [[ $fmp = $passvar ]]
		then
			echo
			echo $blanktext > ~/reports/npw-list.txt
			echo 'npw-list deleted'
		else
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}

gpsk () {
	name=$( ls /etc/NetworkManager/system-connections  )
	ssid=$( sudo cat /etc/NetworkManager/system-connections/$name | grep ssid= )
	psk=$( sudo cat /etc/NetworkManager/system-connections/$name | grep psk= )
	psk="${psk#*=}"
	echo $psk > ~/reports/mk-list
	chmod 600 ~/reports/mk-list
	# echo 'Use ctmk to see mk-list'
}

######################
### wpa_supplicant ###
# http://www.linuxfromscratch.org/blfs/view/svn/basicnet/wpa_supplicant.html
# https://en.wikipedia.org/wiki/Supplicant_(computer)
# alias mtoo='cd ~/reports/wpa/; la'
alias mtwpa='cd /etc/wpa_supplicant/; la'
alias wpa='cat /etc/wpa_supplicant/wpa_supplicant.conf | grep ssid -A 1'

savsupp () {
	ssid=$( sudo cat /etc/wpa_supplicant/wpa_supplicant.conf | grep ssid= )
	psk=$( sudo cat /etc/wpa_supplicant/wpa_supplicant.conf | grep psk= )
	ssid="${ssid#*=}"
	psk="${psk#*=}"
	echo $ssid > ~/reports/supp-list
	echo $psk >> ~/reports/supp-list
	chmod 600 ~/reports/supp-list
	echo 'Use gtsupp to see supp-list'

}

gtsupp () {
	supvar=$( sudo cat ~/reports/supp-list )
	if [[ -z $supvar ]]
	then
		echo 'Sorry, supp-list is empty'
	else
		read -sp 'Enter Special Password: ' passvar
		if [[ $gmp = $passvar ]]
		then
			echo 'Correct! Here is supp-list'
			echo
			cat ~/reports/supp-list
		else
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}

dltsupp () {
	dwpavar=$( sudo cat ~/reports/supp-list )
	if [[ -z $dwpavar ]]
	then
		echo 'Sorry, supp-list is already empty'
	else
		read -sp 'Enter Special Password to delete supp-list: ' passvar
		echo
		if [[ $gmp = $passvar ]]
		then
			echo
			echo $blanktext > ~/reports/supp-list
			echo 'supp-list deleted'
		else
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}

###########################################################################
## For info on parsing bash script, see:
## https://unix.stackexchange.com/questions/531938/parse-a-string-in-bash-script
###########################################################################

############//////////|\\\\\\\\\\############
######         THE DANGER ZONE         ######
##           sudo nano /etc/shadow         ##
############\\\\\\\\\\|//////////############


###########################
#### TABLE OF CONTENTS ####
###########################
evDZone () {
	echo
	echo 'COMMAND LIST FOR:	cwf.sh'; echo
	echo 'ENTER THE DANGER ZONE -- COMPUTER WARFARE, ELINT, PSYOPS AND ASSORTED NASTY SCRIPTS'
	echo 'PROCEED WITH CAUTION!!'; echo
	echo 'COMMANDS	EXPLANATION'; echo
	echo 'savxray		saves encrypted user password to file'
	echo 'gtxray		gets encrypted user password from file'
	echo 'dltxray		deletes encrypted user password from file'
	echo 'cwShowpw	displays special passwords'
	echo 'cwextpw $1 	gets encrypted user password from file, with delay'; echo
	echo 'cwnfb		Five Alarm Nuclear Fireball -- disables user mitigation and runs cwf payload(s)'
	echo '			1) disables user mitigation capabilities'
	echo '			2) at the end of which it runs one or more cwf payloads'; echo
	echo 'cwTB		Timed Root Removal -- The most heinous time bomb of them all'
	echo '			1) extracts your password without your permission'
	echo '			2) runs a user-programmed delay'
	echo '			3) at the end of which it deletes the root directory'; echo
	echo 'cwSRTD		SR Timed Disable -- A less drastic time bomb attack which stops systemd-resolved'
	echo '			Call: cwSRTD <arg1 = time delay before cwksr>'
	echo '			Example: cwSRTD 1h ==> would stop systemd-resolved in 1 hour'
	echo '			1) extracts your password without your permission'
	echo '			2) runs a user-programmed delay'
	echo '			3) at the end of which it stops systemd-resolved'; echo
	echo 'cwpartBomb	Zeroing All Partitions -- '
	echo '			Running this as root will zero all your partitions,'
	echo '			all your hard drives, and every single thing that’s mounted as'
	echo '			/dev/sdx will be zeroed including stick drives plugged and mounted.'
	echo '			It is highly recommended to run cwDisable before running this script.'; echo
	echo 'cwDisable	Disable User Mitigation -- '
	echo '			This will disable the users ability to stop an attack'
	echo '			by aliasing mitigation commands into useless functions'
	echo '			and by disabling systemd-resolved and the firewall.'; echo
	echo 'cwModall	Root Protection Removal -- '
	echo '			A script that removes all file protections and '
	echo '			then makes all files in a system executable.'; echo 
	echo 'cwRmx		Root Executability Removal -- '
	echo '			A script that removes executability for all files in a system.'
	echo '			This will disable the system and is difficult to repair.'; echo
	echo 'cwCdfku		CD Land Mine -- This is beyond dangerous. Its Trumpian psyops.'
	echo '			This plants a software land mine that will destroy a system'
	echo '			when the unsuspecting user enters the cd command.'; echo
	echo 'cwksr		Stop systemd-resolved -- This is a disruptive script that stops systemd-resolved'
	echo 'cwssr		Start systemd-resolved -- This allows you to quickly restart systemd-resolved'; echo
}

savxray () {
	you=$USER
	shdw=$( sudo cat /etc/shadow | grep $you )
	shdw="${shdw#*:}"
	shdw="${shdw%%:*}"
	echo $shdw > ~/reports/shadow-list
	chmod 600 ~/reports/shadow-list
	# echo 'Use gtxray to see shadow-list'
}

gtxray () {
	shdwvar=$( sudo cat ~/reports/shadow-list )
	if [[ -z $shdwvar ]]
	then
		echo 'Sorry, shadow-list is empty'
	else
		read -sp 'Enter Special Password: ' passvar
		if [[ $gmp = $passvar ]]
		then
			echo 'Correct! Here is shadow-list'
			echo
			cat ~/reports/shadow-list
		else
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}

dltxray () {
	dshdwvar=$( sudo cat ~/reports/shadow-list )
	if [[ -z $dshdwvar ]]
	then
		echo 'Sorry, shadow-list is already empty'
	else
		read -sp 'Enter Special Password to delete shadow-list: ' passvar
		echo
		if [[ $gmp = $passvar ]]
		then
			echo
			echo $blanktext > ~/reports/shadow-list
			echo 'shadow-list deleted'
		else
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}

########################
### GLOBAL VARIABLES ###
########################
DATE=`date`
blanktext=''
#export blanktext
fmp='mypass'
gmp='mypass'
#### It's the end of the world as we know it ####
iteotwawki=boom
## root password ##
rtpw='root'
########################

cwShowpw () {
	read -sp 'Enter Special Password to see Special Password list (ironic, huh?): ' pwvar	
	echo
	if [[ $gmp = $pwvar ]] || [[ $iteotwawki = $pwvar ]]
	then
		echo "fmp = $fmp"
		echo "gmp = $gmp"
		echo "rtpw = $rtpw"
		echo "iteotwawki = $iteotwawki"
	else
		echo 'Wrong Password'
		echo 'Access Denied'
	fi
}

############################################################
#### COMPUTER WARFARE AND OTHER DOWNRIGHT NASTY SCRIPTS ####
############################################################

#########################################
## FIVE ALARM NUCLEAR FIREBALL (cwnfb) ##
## DANGER!! NEVER USE THIS!!! ##
## The simple command -- 'sudo rm -rf /' -- will erase a computer's file system, kernel and all!!
## Use only in case of ..... well, never really.

cwnfb () {
	read -sp 'Enter Super-special Password to do this dastardly deed: ' passvar
	echo
	if [[ $iteotwawki = $passvar ]] ## It's the end of the world as we know it
	then
		echo 'Are you absolutely sure?'
		read -sp 'Enter special password to proceed, or anything else to just run away.' answer
		echo
		if [[ $answer = $gmp ]]
		then
			### Disable the user's ability to stop the attack: ###
			
			##### POSSIBLE CWF PAYLOADS #####
			
			##### END OF CWF PAYLOADS #####

			## Test Script
			echo
			echo 'BOOM!!'
			echo
			echo 'This was only a test of the cwnfb Computer Warfare System.'
			echo 'If this had been real, you would be screaming at your computer right now.'
			echo
			echo 'And you are a total jerk for selecting yes.'
		else
			echo 'Thanks for not using the nuclear option'
		fi

	else
		echo 'Wrong Password'
		echo 'Access Denied'
	fi
}

##################################################
##--------<<<<< TIMED ROOT REMOVAL >>>>>--------##
## The most heinous time bomb of them all:
## 1) it extracts your password without your permission
## 2) it runs a user-programmed delay
## 3) at the end of which it deletes the root directory

## Format: 'cwTB <arg1 = time delay before cwnfb>'
## Example: 'cwTB 1h' ==> would remove the root directory in 1 hour
## sleep <arg> can be 1s, 1m, 1h, 1d, etc. (default = ms)


##############################################
##-------<<<<< SR TIMED DISABLE >>>>>-------##
## A less drastic time bomb attack which stops systemd-resolved,
## thus disrupting important functions like Internet connections.
## Format: 'cwSRTD <arg1 = time delay before cwksr>'
## Example: 'cwSRTD 1h' ==> would stop systemd-resolved in 1 hour
## sleep <arg> can be 1s, 1m, 1h, 1d, etc. (default = ms)


####################################################
##-------<<<<< ZEROING ALL PARTITIONS >>>>>-------##
# Running this as root will zero all your partitions,
# all your hard drives, and every single thing that’s mounted as
# /dev/sdx will be zeroed including stick drives plugged and mounted.

## but it will take a really long time depending on the disk size and could
## easily be aborted at any point in time only damaging the
## first sectors of the first disk. it should delete all
## mechanisms of stopping it first, kill, pkill, init, systemd,
## reboot, deleting all available shells, and spawn the dd processes
## in parallel damaging everything at once. nice idea though :)

#####################################################
##-------<<<<< DISABLE USER MITIGATION >>>>>-------##
## This will disable the user's ability to stop an attack
## by aliasing mitigation commands into useless functions
## and by disabling systemd-resolved and the firewall.

#####################################################
##-------<<<<< ROOT PROTECTION REMOVAL >>>>>-------##
## A script that removes all file protections and
# makes all files in a system executable.


########################################################
##-------<<<<< ROOT EXECUTABILITY REMOVAL >>>>>-------##
## A script that removes executability for all files in a system.
## This will disable the system and is difficult to repair.

##########################################
##-------<<<<< CD Land Mine >>>>>-------##
## This is beyond dangerous. 
## This plants a software land mine that will destroy a system
## when the unsuspecting user enters the 'cd' command.
## Install this on a system and casually head for the door.

###########################################################
##-------<<<<< MESSING WITH SYSTEMD-RESOLVED >>>>>-------##
## See: https://askubuntu.com/questions/907246/how-to-disable-systemd-resolved-in-ubuntu

########################################
#### END OF DOWNRIGHT NASTY SCRIPTS ####
########################################

####>>>>>>>>>>>>>>>>>>>>>>>>####
#### OUT OF THE DANGER ZONE ####
####>>>>>>>>>>>>>>>>>>>>>>>>####

##########################
####### END OF CWF #######
##########################
