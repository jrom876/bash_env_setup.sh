#!/bin/bash

# File Name:		luner.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		https://github.com/jrom876/bash_env_setup.sh/blob/master/zsetup/luner.sh
#
#############################################
####### PURPOSE: SYSTEM INTERROGATION #######
#############################################

## This automated test routine displays a broad range
## of pertinent system information in a coherent format
## for the convenience of the System Administrator.
## It must be modified for each system.

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

### local user network evaluation routine (luner)
luner () {
	echo; currDate; echo;
	echo '======= Users and Groups ======='; echo;
	wami; echo;
	echo 'Groups:'; grpid; echo;
	echo "Hostname:"; hn; echo;
	# echo 'Linux Users:'; lusers; echo;

	echo '======= UFW ======='; echo;
	sudo ufw status;
	echo 'Available Entropy:'; entropy; echo;
	echo 'Crash Dump Report:'; crsh; 
	savcrsh; echo;

	echo '======= Environment ======='; echo;
#	printenv;
	getpush; echo;
#	printenv | grep -wE 'PATH|USER|SHELL|LANG|TERM'; echo;
#	printenv | grep -wE 'PATH|USER|SHELL|TERM|ROS_ROOT|ROS_MASTER_URI|ROS_IP'; echo;
	getshells; echo;

	echo '======= SW Package Versions ======='; echo;
	linv; echo;
	echo 'Jeston Nano NVIDIA Version'; jtv; echo;
	echo 'Ubuntu Version'; ubv; echo;
	gcc --version| grep -F "gcc " -A 1; echo;
	g++ --version;
	gdb -v | grep -F "GNU gdb" -A 1; echo;
	python --version; python3 --version;
	jpyv=$( jupyter --version ); echo "jupyter $jpyv"; echo;
	njsv=$( node --version ); echo "node.js $njsv"; echo;
	java --version; echo;
	perl --version | grep  "This\ is\ perl"; echo;
	ssh -V; echo;
	tar --version | grep -E tar; echo;
	git --version; echo;
	docker --version; echo;
	shwflask; echo;
#	flask --version; echo;
#	nginx -v;
	nmap -V | grep -F "Nmap " -A 1; echo;
	traceroute -V; echo;

	echo '======= Fan and Temperature Status ======='; echo;
	#gtfanspeed; echo
	#sensors
	fanstatus; echo
	
	echo '======= CPU ======='; echo;
	lscpu | grep Arch -A 23; echo;
#	getsn;
	inxi -F; echo;

	echo '======= Hard Drive ======='; echo;
	df -H | grep Filesystem -A 6; echo ;

	echo '======= RAM ======='; echo;
	free -t -h B; echo;
#	pmem | grep MemTotal -A 5; echo;

	echo '======= PCI Devices ======='; echo;
	lspci -tv; echo; # Show tree structure verbose
	# lspci -k; echo; # Show kernel drivers

	echo '======= Systemctl Failures ======='; echo;
	gtfunit; echo
	
	echo '======= Ports and Processes ======='; echo;
#	echo 'Listing active USB ports:';	getUSB;	echo;
	echo 'Listing active Serial ports:';	getSER;	echo;
#	getTTy; echo;
#	ss -ltn; echo;
	sudo netstat -tulp; echo;
#	sudo dmidecode -t 8; echo;
#	lsoi; echo;

	echo '======= Network Routing Information ======='; echo;
	getIP; echo;
	echo 'ARP Table:'; arp; echo;
	savzulu; echo; # HP-250 and Jetson Nano
#	savsupp; echo; # RaspberryPi
	# echo 'System ARP cache:'; pnarp; echo;
	# echo 'System ARP table:'; ipn;	echo;
	echo 'System Routing table:'; ip route show; echo;
	sudo netstat -i; echo; # Kernel interface table
#	sudo netstat -r; echo; # Kernel routing table
#	echo 'Socket Statistics:'; ss -s;

	echo '======= Network Device Detection ======='; echo;
	getnet; echo;
#	fevnet;
#	evnet;
	currDate; echo;
}
