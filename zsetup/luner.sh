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
	echo 'Crash Dump Report:'; crsh; savcrsh; echo;

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
	gcc --version| grep "gcc " -A 1; echo;
#	g++ --version;
	gdb -v | grep "GNU gdb" -A 1; echo;
	python --version; python3 --version; echo;
	echo 'JDK Version: '; java --version; echo;
	perl --version | grep  "This\ is\ perl" -A 1; echo;
	ssh -V; echo;
	tar --version | grep -E tar; echo;
	git --version;
	# nginx -v;
	nmap -V; echo;
	echo 'Traceroute Version:'; traceroute -V; echo;

	echo '======= CPU ======='; echo;
	lscpu | grep Arch -A 23; echo;
#	getsn;

	echo '======= Hard Drive ======='; echo;
	df -H | grep Filesystem -A 6; echo ;

	echo '======= RAM ======='; echo;
	free -t; echo;
	pmem | grep MemTotal -A 5; echo;

	echo '======= PCI Devices ======='; echo;
	lspci -tv; echo; # Show tree structure verbose
	# lspci -k; echo; # Show kernel drivers

	echo '======= Ports and Processes ======='; echo;
	echo 'Listing active USB ports:';	getUSB;	echo;
	# echo 'Listing active Serial ports:';	getSER;	echo;
#	getTTy; echo;
#	ss -ltn; echo;
	sudo netstat -tulpn; echo;
	# sudo dmidecode -t 8; echo;
	# lsoi; echo;

	echo '======= Network Routing Information ======='; echo;
	getIP; echo;
	echo 'ARP Table:'; arp; echo;
	savzulu; echo; # HP-250 and Jetson Nano
	# savwpa; echo; # RaspberryPi
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
