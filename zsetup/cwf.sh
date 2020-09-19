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

## First, use 'evproc' or 'netstat -tulp' to see all ports, 
## processes and services. 
## Then pick the process or service you want to start, stop or investigate.
evproc () {
	echo;
	netstat -tulp;
	sudo ufw status;
	## echo 'Open Internet Ports:'; lsoi; echo;
	# lsTTy; echo;
	getUSB;
	getSER; echo;
	# getnet; echo;	
	# cwShowpw; echo;
	savzulu; echo; # HP-250 and Jetson Nano
	# savxray; echo;
	# savwpa; echo; # RaspberryPi
	echo 'Available Commands:'
	echo 'cwdsabl $1     or   svkill $1          to disable or kill a process'
	echo 'cwenabl $1     or   svstart $1         to enable or start a process'
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
### Service Status
svtus () {
	sudo systemctl status $1
}
svall () {
	# echo 'Listing all running Services'
	service --status-all
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

######################
### wpa_supplicant ###
# http://www.linuxfromscratch.org/blfs/view/svn/basicnet/wpa_supplicant.html
# https://en.wikipedia.org/wiki/Supplicant_(computer)
# alias mtoo='cd ~/reports/wpa/; la'
alias mtwpa='cd /etc/wpa_supplicant/; la'
alias wpa='cat /etc/wpa_supplicant/wpa_supplicant.conf | grep ssid -A 1'

savwpa () {
	ssid=$( cat /etc/wpa_supplicant/wpa_supplicant.conf | grep ssid= )
	psk=$( cat /etc/wpa_supplicant/wpa_supplicant.conf | grep psk= )
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
##                /etc/shadow              ##
############\\\\\\\\\\|//////////############

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

##############################
#### vars, yars, and nars ####

DATE=`date`
blanktext=''
fmp='yar'
gmp='yar'
## root password ##
rtpw='testpw'

cwShowpw () {
	echo "fmp = $fmp"
	echo "gmp = $gmp"
	echo $rtpw
}

cwextpw () {
	you=$USER
	shdw=$( sudo cat /etc/shadow | grep $you )
	shdw="${shdw#*:}"
	shdw="${shdw%%:*}"
	echo $shdw
}

####>>>>>>>>>>>>>>>>>>>>>>>>####
#### OUT OF THE DANGER ZONE ####
####>>>>>>>>>>>>>>>>>>>>>>>>####

##########################
####### END OF CWF #######
##########################
