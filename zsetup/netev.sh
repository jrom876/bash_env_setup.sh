#!/bin/bash

# File Name:		netev.sh
# Written by:		Jacob Romero
#					Creative Engineering Solutions, LLC
# Contact:			cesllc876@gmail.com
#					admin@jrom.io
# Github Page:		www.github.com/jrom876
#
#############################################################
####### PURPOSE: LOCAL AND REMOTE NETWORK EVALUATION ########
#############################################################

## These scripts provide utilities for: 
##		-- nmap reporting
##		-- port control
##		-- ip table control
##		-- arp cache control

## NMAP REPORT UTILITY
## 0. 	provide varying levels of nmap function calls (from simple 
##		device mapping to full network device interrogation) 
## 1. 	place the nmap data in various reports 
## 2. 	provide cat calls for easy retreival of the reports

## COMMANDS UTILITIES
## 3.	port commands
## 4.	ip table commands
## 5.	arp cache 

####################
#### REFERENCES ####
####################

## for device MAC lookup
## https://www.wireshark.org/tools/oui-lookup
## http://sqa.fyicenter.com/1000208_MAC_Address_Validator.html
## http://sqa.fyicenter.com/1000194_Test_MAC_Address_Generator.html

## for ip address lookup
## https://www.lookip.net/ip/

## Linux Directory Structure
## https://www.howtogeek.com/117435/htg-explains-the-linux-directory-structure-explained/

## https://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/

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

########################
### GLOBAL VARIABLES ###
########################
## None

###########################
#### TABLE OF CONTENTS ####
###########################
ecnet () {
	echo
	echo 'COMMAND LIST FOR:	netev.sh'; echo
	echo 'NETWORK EVALUATION'; echo
	echo 'COMMANDS	EXPLANATION'
	echo 'ssta		show all listening ports and processes'
	echo 'getnet		simple network evaluation'
	echo 'evnet		specific network evaluation'
	echo 'fevnet		full network evaluation'
	echo 'ntlup		display open ports, sudo netstat -tlup'
	echo 'wirsh		opens wireshark'
	echo 'lkport $1	see if port $1 is available'; echo
	echo 'IP ADDRESS METHODS'
	echo 'gtiptables	to see iptables rule set'
	echo 'getIP		returns my IP Address ($myip)'
	echo 'gtmip		puts $myip into ~/reports/myip-list'
	echo 'dltmip		deletes $myip from ~/reports/myip-list'; echo
	echo 'CAT CALLS	FILE DISPLAYED'
	echo 'ctssrep		ss_reports'
	echo 'ctnmapl		nmap-list'
	echo 'ctgw		Gateway-list'
	echo 'cthp250		HP250-list'
	echo 'ct12		RPi12-list'
	echo 'ct13		RPi13-list'
	echo 'ctjetson	Jetson-list'
	echo 'ctzero		PiZero_W-list'
	echo 'ctcrsh		crash_dump_report'; echo
}

getnet () {
## Provides simple device mapping of all network devices, and prints
## only the first two lines of the nmap output for each device
	sudo nmap -sn 192.168.0.0/24 | grep 192.168.0. -A 2
}

fevnet () {
## Provides full interrogation of all network devices, and
## prints the output in a report (~/reports/nmap-list.txt)
## Use ctnmapl to view nmap-list.txt
	echo;
	echo 'Creating nmap report'; echo;
	sudo nmap -A -T4 -Pn 192.168.0.0/24 > ~/reports/nmap-list.txt;
	# echo 'See ~/reports/nmap-list.txt for nmap report'; echo;
	echo 'Use ctnmapl to view nmap-list.txt'; echo;
}

evnet () {
## Evaluates individual network devices, and prints the output 
## in various reports (e.g.: ~/reports/<report name>-list.txt)
## Uncomment the sections you want to run.
		# echo 'Evaluating Gateway:';
		# sudo nmap -v -sn -Pn 192.168.0.1;  # ping scan
		# # sudo nmap -sS -Pn -O -v 192.168.0.1;  # script scan
		# sudo nmap -A -T4 -Pn 192.168.0.1 > ~/reports/Gateway-list.txt; echo; # full interrogation
		# echo 'See ~/reports/Gateway-list.txt for nmap report'
		# echo 'Use ctgw to access Gateway nmap report'; echo;
		#
		# echo 'Evaluating HP-250 Notebook:';
		# sudo nmap -v -sn -Pn 192.168.0.4;  # ping scan
		# sudo nmap -sS -Pn -O -v 192.168.0.4;  # script scan
		# sudo nmap -A -T4 -Pn 192.168.0.4 > ~/reports/HP250-list.txt; echo; # full interrogation
		# echo 'See ~/reports/HP250-list.txt for nmap report'
		# echo 'Use cthp250 to access HP-250 nmap report'; echo;
		#
		# echo 'Evaluating Rpi router 12:';
		# # sudo nmap -v -sn -Pn 192.168.0.12;  # ping scan
		# # sudo nmap -sS -Pn -O -v 192.168.0.12;  # script scan
		# sudo nmap -A -T4 -Pn 192.168.0.12 > ~/reports/RPi12-list.txt; echo; # full interrogation
		# echo 'See ~/reports/RPi12-list.txt for nmap report'
		# echo 'Use ct12 to access RPi12 nmap report'; echo;
		#
		# echo 'Evaluating Rpi router 13:';
		# sudo nmap -v -sn -Pn 192.168.0.13;  # ping scan
		# # sudo nmap -sS -Pn -O -v 192.168.0.13;  # script scan
		# # sudo nmap -A -T4 -Pn 192.168.0.13 > ~/reports/RPi13-list.txt; echo; # full interrogation
		# echo 'See ~/reports/RPi13-list.txt for nmap report'
		# echo 'Use ct13 to access RPi13 nmap report'; echo;
		#
		# echo 'Evaluating Roku 1:';
		# sudo nmap -v -sn -Pn 192.168.0.20;  # ping scan
		# # sudo nmap -sS -Pn -O -v 192.168.0.20;  # script scan
		# # sudo nmap -A -T4 -Pn 192.168.0.20; # full interrogation
		# echo;
		#
		# echo 'Evaluating Roku 2:';
		# sudo nmap -v -sn -Pn 192.168.0.21;  # ping scan
		# # sudo nmap -sS -Pn -O -v 192.168.0.21;  # script scan
		# # sudo nmap -A -T4 -Pn 192.168.0.21; # full interrogation
		# echo;

		echo 'Evaluating Jetson Nano Network Connection (30):';
		# # sudo nmap -v -sn -Pn 192.168.0.30;  # ping scan
		# # sudo nmap -sS -Pn -O -v 192.168.0.30;  # script scan
		sudo nmap -A -T4 -Pn 192.168.0.30 > ~/reports/Jetson-list.txt;
		# echo 'See ~/reports/Jetson-list.txt for Jetson nmap report'; echo; # full interrogation
		echo 'Use ctjetson to access Jetson nmap report'
		echo;
		#
		# echo 'Evaluating Pi Zero W (31):';
		# sudo nmap -v -sn -Pn 192.168.0.31;  # ping scan
		# # sudo nmap -sS -Pn -O -v 192.168.0.31;  # script scan
		# # sudo nmap -A -T4 -Pn 192.168.0.31 > ~/reports/PiZero_W-list.txt; echo; # full interrogation
		# echo 'See ~/reports/PiZero_W-list.txt for nmap report'
		# echo 'Use ctzero to access PiZero nmap report'; echo;

		# echo 'Evaluating Docker:';
		# sudo nmap -v -sn 172.17.0.1;  # ping scan
		# # sudo nmap -sS -Pn -O -v 172.17.0.1;  # script scan
		# echo;
}
###################
#### CAT CALLS ####
## cat calls to display reports generated by this script
alias ctsprl='cat ~/reports/nmap_super_list.txt | grep 192.168.0. -A 30'
alias ctnmapl='cat ~/reports/nmap-list.txt | grep 192.168.0. -A 30'
alias ctgw='cat ~/reports/Gateway-list.txt | grep 192.168.0. -A 30'
alias cthp250='cat ~/reports/HP250-list.txt | grep 192.168.0. -A 30'
alias ct12='cat ~/reports/RPi12-list.txt | grep 192.168.0. -A 30'
alias ct13='cat ~/reports/RPi13-list.txt | grep 192.168.0. -A 30'
alias ctjetson='cat ~/reports/Jetson-list.txt | grep 192.168.0. -A 30'
alias ctzero='cat ~/reports/PiZero_W-list.txt | grep 192.168.0. -A 30'
alias ctcrsh='cat ~/reports/crash_dump_report.txt'
alias ctssrep='cat ~/reports/ss_reports'

################
#### NETCAT ####
## The TCP/IP swiss army knife
## https://www.commandlinux.com/man-page/man1/nc.1.html
## https://helpmanual.io/man1/nc/
## Look for an open port ##

lkport () {
	sudo nc localhost $1 < /dev/null; \
	echo $?
}

###################
### IP COMMANDS ###
###################
## https://wiki.debian.org/nftables
## https://wiki.nftables.org/wiki-nftables/index.php/Moving_from_iptables_to_nftables
## /etc/nftables.conf

## https://www.tothenew.com/blog/basics-of-iptables/
## To see iptables rule set
gtiptables () {
	sudo iptables -L
}
## sudo iptables -L
################
### fail2ban ###
## Configuring fail2ban
## https://www.howtogeek.com/675010/how-to-secure-your-linux-computer-with-fail2ban/
\
#### fail2ban setup and test commands in a nutshell:
## install and setup:
## sudo apt-get install fail2ban
## sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
## sudo gedit /etc/fail2ban/jail.local
## sudo systemctl enable fail2ban
## sudo systemctl start fail2ban

## test:
## sudo systemctl status fail2ban.service
## sudo fail2ban-client status
## sudo fail2ban-client status sshd

################
## https://linoxide.com/ubuntu-how-to/configure-static-ip-address-ubuntu/

## https://linuxconfig.org/how-to-turn-on-off-ip-forwarding-in-linux

## To get current IP forwarding status
## sysctl net.ipv4.ip_forward
## or
## cat /proc/sys/net/ipv4/ip_forward

## To disable IP forwarding
## sysctl -w net.ipv4.ip_forward=0
## or
## echo 0 > /proc/sys/net/ipv4/ip_forward

## To make disable persistent on reboot
## sudo nano /etc/sysctl.conf
## and add the line 'net.ipv4.ip_forward = 0' 

## To enable IP forwarding
## sysctl -w net.ipv4.ip_forward=1
## or
## echo 1 > /proc/sys/net/ipv4/ip_forward

## To make enable persistent on reboot
## sudo nano /etc/sysctl.conf
## and add the line 'net.ipv4.ip_forward = 1'

alias ipa='ip a'
alias ipn='ip neigh' # show system arp table
alias ipl='ip -s link show' # this shows a list of the number of packets
# transmitted and received, along with collisions
alias ipk='ip link'
alias ips='ip route show' # provides info on the system's routing table
alias ipt='ip tunnel show' # provides info on the system's tunnels over IP
getIP () { # no input args; returns my IP address ($myip)
	 myip="$( dig +short myip.opendns.com @resolver1.opendns.com )"
	 echo "My WAN/Public IP address: ${myip}"
	 echo $myip > ~/reports/myip-list
	 chmod 600 ~/reports/myip-list	
	 #echo 'Use gtmip to see My WAN/Public IP address'
	 #echo $myip
}

gtmip () { 
	myvar=$( cat ~/reports/myip-list )
	if [[ -z $myvar ]]; then
		echo 'myip-list is empty'
	else
		read -sp 'Enter Special Password: ' passvar
		echo
		if [[ $fmp = $passvar ]]; then
			echo 'My WAN/Public IP address is: '
			echo
			cat ~/reports/myip-list; echo
		else 
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}

dltmip () {
	dmvar=$( cat ~/reports/myip-list )
	if [[ -z $dmvar ]]; then
		echo 'Sorry, myip-list is already empty'
	else
		read -sp 'Enter Special Password to delete myip-list: ' passvar
		echo
		if [[ $fmp = $passvar ]]; then
			echo
			echo $blanktext > ~/reports/myip-list
			echo 'myip-list deleted'
		else 
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}

getCurl () {
	 com=$( curl ifconfig.me )
	 echo "My WAN/Public IP address: ${com}"
	 #curl ifconfig.me; echo ""
}

#################
### ARP Cache ###
# for arp cache poisoning info:
# https://www.thegeekstuff.com/2012/01/arp-cache-poisoning/
alias arpe='arp -e' # show arp cache entries in default linux style
alias arpa='arp -a' # all
alias arpv='arp -v' # verbose
alias pnarp='cat /proc/net/arp' # show arp cache
alias enarp='cat /etc/networks'
alias eharp='cat /etc/hosts'
arpF () { # manually create an ARP address mapping entry
	arp -f $1
}

#################
### Wireshark ###
alias wirsh='sudo wireshark'
# For the following problem:
# couldn't run /usr/bin/dumpcap in child process: permission denied
# open a terminal and type:
# sudo dpkg-reconfigure wireshark-common
# then press the right arrow and enter for yes; then type:
# sudo chmod +x /usr/bin/dumpcap

#####################
### PORT COMMANDS ###
#####################
## https://askubuntu.com/questions/320121/simple-port-forwarding
## Note: port list is located in /etc/services
ls1usb () {
		lsusb -s :1
}
ls2usb () {
		lsusb -s 1:
}
lstusb () {
		lsusb -t
}
alias getPList='cat /etc/services' # lists all available ports
alias lsou='lsof -U'
alias lsoi='lsof -i' # display open ports; lists all Internet
# and x.25 (HP-UX) network files
lsonP () { # search all output files
	lsof -n -P | grep -i $1
}
lsoU () { # searches the current list of UNIX domain socket files
	lsof -U | grep -i $1
}

#############
### tty ports
getTTy (){
	dmesg | grep tty
}
lsTTy (){
	ls /dev/tty*
}
getUSB (){
	ls /dev/ttyUSB*
}
getSER (){
	ls /dev/ttyS*
}
################################
## show serial port for arg only
getserial_ag (){
	setserial -ag /dev/ttyS$1
}
## show all serial ports
showAllSrPorts () {
	setserial -ag /dev/ttyS*
}
## to see which ports are available
setSerial_bg (){
	setserial -bg /dev/ttyS*
}
#############################################
## pprobe is an nping tcp port probe function
# arg1 = port number (e.g port 22)
# arg2 = host (e.g 192.168.0.1, or google.com)
pprobe () { #@@@@@@@@@@@
	sudo nping --tcp -p $1 --flags syn --ttl 2 $2
}
#################################
## Port Manipulation Functions ##
getport () { # searches port list for input arg
	cat /etc/services | grep -i $1
}
getstatus () { # searches port list for input arg
	sudo netstat -nap | grep : $1
}
openTCPPort () {
	iptables -A INPUT -p tcp -dport $1 -j ACCEPT
}
openUDPPort () {
	iptables -A INPUT -p udp -sport $1 -j ACCEPT
}
allowPort () {
	sudo ufw allow $@
}
denyPort () {
	sudo ufw deny $@
}

### PORT FORWARDING ####
## ICMP redirects
## http://www.itsyourip.com/security/how-to-disable-icmp-
## redirects-in-linux-for-security-redhatdebianubuntususe-tested/

#############################################
#############################################
