#!/bin/bash

# File Name:		indet.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876
#
###########################################################
####### PURPOSE: INTRUSION PREVENTION AND DETECTION #######
###########################################################

## These network and device evaluation routines do four main things:

## 0.	provide custom functions for Intrusion and Detection Control on 
# 	local and remote hosts, devices and systems
## 1. 	provide various nmap, netstat, ss and mtr function calls  
## 2. 	place some of the extracted data in reports 
## 3. 	provide cat calls for easy retreival of the reports

####################
#### REFERENCES ####
####################

## Man page: https://nmap.org/book/man.html
## For more information on nmap see: https://tools.kali.org/information-gathering/nmap

## For info on using zombie scans
## https://security.stackexchange.com/questions/169953/how-to-find-a-zombie-candidate-for-zombie-scanning
## sudo nmap -sA -O -v <IP>

## WOW!!
## https://nmap.org/book/man-bypass-firewalls-ids.html
## https://nmap.org/book/idlescan.html
## https://packetpushers.net/ip-fragmentation-in-detail/

## for device MAC and OUI lookup
## https://www.wireshark.org/tools/oui-lookup
## http://sqa.fyicenter.com/1000208_MAC_Address_Validator.html
## http://sqa.fyicenter.com/1000194_Test_MAC_Address_Generator.html

## for ip address lookup
## https://www.lookip.net/ip/

## https://linuxconfig.org/how-to-use-arrays-in-bash-script
## https://linuxconfig.org/generating-random-numbers-in-bash-with-examples
## https://www.cyberciti.biz/faq/unix-linux-iterate-over-a-variable-range-of-numbers-in-bash/
## https://www.linux.com/topic/networking/introduction-ss-command/

## IMPORTANT FOR PYTHON-TO-BASH SCRIPTING!!
## https://stackoverflow.com/questions/14155669/call-python-script-from-bash-with-argument

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

########################
### GLOBAL VARIABLES ###
########################
date=`date +%F`

## MY DEVICE MAC ADDRESSES
feedbeefface_MAC='FE:ED:BE:EF:FA:CE'
beeffeedface_MAC='BE:EF:FE:ED:FA:CE'

device_array=(
	'FE:ED:BE:EF:FA:CE' \
	'BE:EF:FE:ED:FA:CE' )

## ZOMBIE HEADS (OUI LIST) (OUI == Organizational Unique Identifier)
pi_head='B8:27:EB' 	## Raspberry Pi's OUI
gw_head='20:76:00' 	## Actiontec Gateway OUI
hua_head='D8:29:18' 	## HUAWEI TECHNOLOGIES CO.,LTD
jt_head='00:04:4B'	## NVIDIA, Jetson Nano
sam0_head='D0:D0:03' 	## Samsung Electronics Co.,LTD
azw_head='5C:96:56'	## AzureWave Technology (Sony PS4)

ventus_head='00:15:37' 	## Ventus Networks
raster_head='00:40:3E' 	## RASTER OPS CORPORATION
optica_head='00:16:0E' 	## Optica Technologies Inc.
edimax_head='00:0E:2E' 	## Edimax Technology Co. Ltd.
quanta_head='34:99:71' 	## Quanta Storage Inc.
zao_head='A8:24:EB' 	## ZAO NPO Introtest
honhai_head='E4:D5:3D' 	## Hon Hai Precision Ind. Co.,Ltd.
xiaomi_head='64:B4:73' 	## Xiaomi Communications Co Ltd
sam1_head='D8:E0:E1' 	## Samsung Electronics Co.,Ltd
ieee_head='A0:C5:F2' 	## IEEE Registration Authority
intel_head='00:AA:00' 	## Intel Corporation
lynuc_head='C0:C5:69' 	## SHANGHAI LYNUC CNC TECHNOLOGY CO
huizou_head='34:F1:50'	## 中華人民共和国 Hui Zhou Gaoshengda Technology Co.,LTD

zombie_array=(
	'B8:27:EB' \
	'20:76:00' \
	'D8:29:18' \
	'00:04:4B' \
	'D0:D0:03' \
	'5C:96:56' \
	'00:15:37' \
	'00:40:3E' \
	'00:16:0E' \
	'00:0E:2E' \
	'34:99:71' \
	'A8:24:EB' \
	'E4:D5:3D' \
	'64:B4:73' \
	'D8:E0:E1' \
	'A0:C5:F2' \
	'00:AA:00' \
	'C0:C5:69' \
	'34:F1:50' )

###########################
#### TABLE OF CONTENTS ####
###########################
ecindet () {
	echo
	echo 'COMMAND LIST FOR:	indet.sh'; echo
	echo 'INTRUSION DETECTION AND PREVENTION'; echo
	echo 'Contains custom functions for Intrusion and Detection Control'
	echo 'on local and remote hosts, devices and systems'; echo
	echo 'CREATING ZOMBIES'
	echo 'gnxng $1 $2	create user-generated, non-conflicting zombie list'
	echo '		Requires 2 args:'
	echo '			$1 = zombie head from OUI list'
	echo '			$2 = number of zombies to create'; echo
	echo 'prs_input $1	This embedded python code takes complete or incomplete '
	echo '		user input and converts it to a mac address format, '
	echo '		inserting random hex numbers for any missing digits.';echo
	echo 'supernet	Special Network Evaluation'
	echo 'cxdarray	shows and reloads Excluded Device List'
	echo 'cxzarray	shows and reloads Complete Zombie List'; echo
	echo 'DEVICE AND HOST INTERROGATORS'
	echo 'nmA $1		service/version scan, OS, version, script scan, traceroute, verbose'
	echo 'nmV $1		service/version scan, OD detection, skip host discovery'
	echo 'nmC $1		script scan, OD detection, skip host discovery'
	echo 'nmS $1		script scan, OD detection, skip host discovery'
	echo 'nmP $1		ARP ping, OD detection, skip host discovery'
	echo 'nmN $1 		finds all the wireless devices connected to host'; echo
	echo 'NETSTAT AND MTR'
	echo 'ntlup		display open ports, sudo netstat -tlup'
	echo 'mtr $1 $2 $3	$1=site name, $2=domain, $3=num pings'
	echo '		mtr -rwb -c $3 $1$2 >~/mtr-reports/mtr-report-$1; cat ~/mtr-reports/mtr-report-$1'; echo
	echo 'CAT CALLS	FILE DISPLAYED'
	echo 'cxpi		cat ~/reports/gnxng/pi'
	echo 'cxazw		cat ~/reports/gnxng/azw'
	echo 'cxgw		cat ~/reports/gnxng/gw'
	echo 'cxhua		cat ~/reports/gnxng/hua'
	echo 'cxjt		cat ~/reports/gnxng/jt'
	echo 'cxsam		cat ~/reports/gnxng/sam'
	echo 'ctdarray	cat ~/reports/indet_cx_lists/darray'
	echo 'ctzarray	cat ~/reports/indet_cx_lists/zarray'; echo
}

#################################
#### INTRUSION AND DETECTION ####
#################################

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## prs_input():	This embedded python code takes complete or incomplete 
## 		user input and converts it to a mac address format, 
## 		inserting random hex numbers for any missing digits
## Call:		prs_input $1
## Requires:		$1 = complete or incomplete mac address input
## Dependencies:	parser()
##			genrandhex()
##			insert()
##			makemac()

function prs_input {
PARSE_ARG1="$1" python3 - <<END
import os
import random 

inmac = os.environ['PARSE_ARG1']
#print('Input MAC address = ',inmac)

def parser(a):
	barg = ''
	for i in range(len(a)):
		if (a[i].isalnum()):
			if (a[i].isalpha()):
				if ord(a[i]) in range(ord('a'), ord('f')+1):
					barg += a[i]
				elif ord(a[i]) in range(ord('A'), ord('F')+1):
					barg += a[i]
			elif (a[i].isnumeric()):
				barg += a[i]
	#print('barg = ',barg)
	return barg
#parser('3:;R:4a:5A:D0b:g0')
#parser('0:$:aagd;fbcq :7727')
#parser('D0:D0:03:')

def genrandhex():
	return list(hex(random.randrange(0, 16)))[2:][0]

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## insert(mac):		Strips input down to alphanumeric chars, 
##			and inserts random hex values where needed 
##			to fill the 12-hex mac address number requirement
## Call:		insert $1
## Requires:		$1 = partial or complete input mac address
## Dependencies:	parser(), genrandhex()

def insert(mac):
	res = parser(mac)
	lengo = len(res)
	result = ''
	if lengo >= 12:
		res = list(res)
		for j in range(12):
			result += res[j]
	if lengo < 12:
		result = res
		for i in range(len(result),12) :
			result += genrandhex()
	#print('insert = ',result.upper())
	return result.upper()
#insert(parser('0:$:aagd;fbcq :7727'))

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## makemac(res):	Takes partial or complete user input and
##			converts it to a mac address format, with
## 			random hex numbers for any missing digits
## Call:		makemac $1
## Requires:		$1 = partial or complete input mac address
## Dependencies:	parser(), genrandhex(), insert()

def makemac(res):
	res = list(insert(res))
	#print('res = ',res)
	#res = list(res)
	yar = ''
	count = 0
	lengo = len(res)
	while(count<lengo):
		yar += res[count]
		if ((count+1)%2== 0) and (len(yar)!=17):
			yar += ':'
		count += 1
	print(yar)
	#return yar
makemac(inmac)
	
END
	
}

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	gnxng(): 	Generates user-defined, non-conflicting zombie lists 
##			for the nmap -sI Idle Scan Zombie Host options
##	Call:		gnxng $1 $2
##	Requires:	$1 = zombie head from list
#			$2 = number of zombies to create
##	Dependencies:	~/reports/gnxng/*
##			prs_input()
#			genHexRand()
#			srch_devs()
#			device_array
#			zombie head list (or array)
#			cx-- cat calls

gnxng () { 	
	START=1
	END=$2		
	date=`date +%F`
	## Prepare the appropriate text file to hold our new zombies
	if [ $1 == $pi_head ]; then
		echo '' > ~/reports/gnxng/pi$date
	elif [ $1 == $gw_head ]; then
		echo '' > ~/reports/gnxng/gw$date
	elif [ $1 == $hua_head ]; then
		echo '' > ~/reports/gnxng/hua$date
	elif [ $1 == $jt_head ]; then
		echo '' > ~/reports/gnxng/jt$date
	elif [ $1 == $sam0_head ]; then
		echo '' > ~/reports/gnxng/sam0$date
	elif [ $1 == $azw_head ]; then
		echo '' > ~/reports/gnxng/azw$date
	else
		echo
	fi
	
	## Generate formatted random zombies from complete or incomplete
	## user input, and see if they are on the device list.
	## If they are not on the list, and if a tracking report exists
	## for this zombie head type, we append them to that report.
	## Otherwise, we just return the new formatted random zombies.
	
	for (( c=$START; c<=$END; c++ )); do
		
		result=$( prs_input $1 )	
		#echo "result num 1 = $result" ## DBPRINT
		
	####/////////|||\\\\\\\\\####
	#### SAVE THIS SECTION!! ####
	
	## 	Comment the above call -- result=$(prs_input $1) -- and 
	##	uncomment this section to bypass prs_input() and achieve 
	##	much faster execution. 
	
	##	This is useful if speed or scaling becomes an issue, but it 
	##	does not have the input error handling of the python script, 
	##	so it requires the input headers to be properly formatted.
	 
	##	Therefore, it is best to use an input <arg $1> from the 
	##	Zombie Heads list or zombie_array for this section.	
	##	e.g.	enter 'gnxng $pi_head <num>' on the command line
	
		#VAR1=$(genHexRand)
		#VAR2=$(genHexRand)	
		#VAR3=$(genHexRand)
		#VAR4=$(genHexRand)	
		#VAR5=$(genHexRand)
		#VAR6=$(genHexRand)
		#result=$1$VAR1$VAR2':'$VAR3$VAR4':'$VAR5$VAR6
		
	#### END OF SAVED SECTION ####
	####\\\\\\\\\||||/////////####
	
		testo=$(srch_devs $result)
		if [ -z $testo ]; then
			#echo 'Good to go' ## DBPRINT
			case $1 in
				$pi_head)
				echo $result
				echo $result >> ~/reports/gnxng/pi$date
				;;
				$gw_head)
				echo $result
				echo $result >> ~/reports/gnxng/gw$date
				;;
				$hua_head)
				echo $result
				echo $result >> ~/reports/gnxng/hua$date		
				;;
				$jt_head)
				echo $result
				echo $result >> ~/reports/gnxng/jt$date		
				;;
				$sam0_head)
				echo $result
				echo $result >> ~/reports/gnxng/sam0$date		
				;;
				$azw_head)
				echo $result
				echo $result >> ~/reports/gnxng/azw$date	
				;;
				*)
				echo $result
			esac
		elif [ -n $testo ]; then
			#echo "testo = $testo" ## DBPRINT
			echo 'this device is on the do not use list'
			break
		fi
	done
	if [ $1 == $pi_head ]; then
		#uniq ~/reports/gnxng/pi
		echo; echo "use cxpi to see ~/reports/gnxng/pi$date"
	elif [ $1 == $gw_head ]; then
		#uniq ~/reports/gnxng/gw	
		echo; echo "use cxgw to see ~/reports/gnxng/gw$date"
	elif [ $1 == $hua_head ]; then
		#uniq ~/reports/gnxng/hua
		echo; echo "use cxhua to see ~/reports/gnxng/hua$date"
	elif [ $1 == $jt_head ]; then
		#uniq ~/reports/gnxng/jt
		echo; echo "use cxjt to see ~/reports/gnxng/jt$date"
	elif [ $1 == $sam0_head ]; then
		#uniq ~/reports/gnxng/sam0
		echo; echo "use cxsam to see ~/reports/gnxng/sam0$date"
	elif [ $1 == $azw_head ]; then
		#uniq ~/reports/gnxng/azw
		echo; echo "use cxazw to see ~/reports/gnxng/azw$date"
	fi
}
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	genHexRand(): 	Generates a random decimal num between 0 and 16,
##			formats it as a hex number string, and converts
##			all a-f digits in it to upper case for consistency
##	Call:		genHexRand 
##	Requires:	0 args
##	Dependencies:	None

genHexRand () {
	rando=$(( $RANDOM % 16 )) ## generate a random decimal num between 0 and 16
	printf -v result1 "%x" "$rando" ## format it as a hex number string
	echo "$result1" | sed 's/[^ _-]*/\u&/g' ## convert to upper case if a-f
}

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	srch_devs(): 	Compares input zombie arg against device list and 
##			returns error if a match exists
##	Call:		srch_devs $1
##	Requires:	$1 = zombie head to be checked against device list
##	Dependencies:	device_array

srch_devs () {
	declare -a comp_array
	comp_array="${device_array[@]%\*}"
	comp_array=($comp_array)
	#echo 'comp array'; echo ${comp_array[@]} ## DBPRINT
	for comp in "${comp_array[@]}"; do			
		if [ $comp == $1 ]; then
			echo 1
		fi
	done
}

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	clrhead():	Recursively deletes the filepath argument provided 
##	Call:		clrhead $1
##	Requires:	$1 = filepath to be deleted
##	Dependencies:	None
 
clrhead () {
	if [ -s $1 ]
	then
		rm -rf $1
		echo 'File has been cleared'
	else
		echo 'The file you wish to erase does not exist or is empty.'
	fi
	#ls ~/$1
}

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	cxdarray():	Displays Excluded Device List  and reloads it into
##			its report location, ~/reports/indet_cx_lists/darray
##	Call:		cxdarray
##	Requires:	None
##	Dependencies:	None

cxdarray () {
	echo 'EXCLUDED DEVICE ARRAY'; echo
	declare -a shwdev_array
	shwdev_array="${device_array[@]%\*}"
	shwdev_array=($shwdev_array)
	#echo 'codevice array'; echo ${shwdev_array[@]} ## DBPRINT	
	echo '' > ~/reports/indet_cx_lists/darray
	for shwdev in "${shwdev_array[@]}"; do
		echo $shwdev
		echo $shwdev >> ~/reports/indet_cx_lists/darray
	done
	#echo $( cat ~/reports/indet_cx_lists/darray ) ## DBPRINT
}

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	cxzarray():	Displays Complete Zombie List and reloads it into
##			its report location, ~/reports/indet_cx_lists/zarray
##	Call:		cxzarray
##	Requires:	None
##	Dependencies:	None

cxzarray () {
	echo 'ZOMBIE ARRAY'; echo
	declare -a shwzomb_array
	shwzomb_array="${zombie_array[@]%\*}"
	shwzomb_array=($shwzomb_array)
	#echo 'zombie array'; echo ${shwzomb_array[@]} ## DBPRINT
	echo '' > ~/reports/indet_cx_lists/zarray
	for shwzomb in "${shwzomb_array[@]}"; do
		echo $shwzomb
		echo $shwzomb >> ~/reports/indet_cx_lists/zarray
	done
	#echo $( cat ~/reports/indet_cx_lists/zarray ) ## DBPRINT
}
	
###################
#### CAT CALLS ####
###################
alias cxpi="cat ~/reports/gnxng/pi$date"
alias cxazw="cat ~/reports/gnxng/azw$date"
alias cxgw="cat ~/reports/gnxng/gw$date"
alias cxhua="cat ~/reports/gnxng/hua$date"
alias cxjt="cat ~/reports/gnxng/jt$date"
alias cxsam="cat ~/reports/gnxng/sam0$date"
alias cxazw="cat ~/reports/gnxng/azw$date"
alias ctdarray='cat ~/reports/indet_cx_lists/darray'
alias ctzarray='cat ~/reports/indet_cx_lists/zarray'

####################################
#### NETWORK EVALUATION ROUTINE ####
####################################

## REMOTE NETWORK ROUTINE ##
#(0) 'mtrHost $1 $2 $3' : *** This command is VERY USEFUL (see below) ***
# Do this command to find network hops/routers connecting remote host,
# then create a report showing these connections and display the report.
# mtr -rw -c 10 <whatever.com or IPvx address> >mtr-report-whatever | cat mtr-report-whatever
# mtr -rw -c 10 google.com >mtr-report-google; cat mtr-report-google
# mtr -rwb -c 10 google.com >mtr-report-google; cat mtr-report-google
# e.g. 'mtr google .com 10' : this pings and reports on google.com 10 times

#(1) Do nmS to force a script scan on any of the hosts/routers on the mtr-report
# nmS <arg1> : sudo nmap -sS -Pn -O -v $1

#(2) Do nmtop to search the top ports on remote or local hosts
# nmtop <arg1> <arg2> : nmap --top-ports 10 192.168.0.1
# nmtop $1 $2 : search top (int $1) ports of host ($2)

#(3) Do pprobe to probe specific ports on remote or local routers
# pprobe <arg1> <arg2> : sudo nping --tcp -p $1 --flags syn --ttl 2 $2
# pprobe <arg1:port num, e.g. 22> <arg2:host (e.g 192.168.0.1, or google.com)>

#############################
#### MTR (My Traceroute) ####
#############################
# mtr -rwb -c 10 google.com >mtr-report-google | cat mtr-report-google
# $1 = site name; $2 = domain; $3 = num pings 
# -b = both IPaddr and hostname; -rw = report-wide; -c = count (num pings)
mtrHost () { # e.g. <arg1:google> <arg2:.com> < arg3:10 pings>
	mtr -rwb -c $3 $1$2 >~/mtr-reports/mtr-report-$1; cat ~/mtr-reports/mtr-report-$1
}
alias rt='route'
alias rtn='sudo route -n'
alias trv='traceroute -V' # shows traceroute version

## https://www.lookip.net/ip/
##############
#### NMAP ####
##############
## Man page: https://nmap.org/book/man.html
## For more information on nmap see: https://tools.kali.org/information-gathering/nmap

## For info on using zombie scans
## https://security.stackexchange.com/questions/169953/how-to-find-a-zombie-candidate-for-zombie-scanning
## sudo nmap -sA -O -v <IP>

## WOW!!
## https://nmap.org/book/man-bypass-firewalls-ids.html
## https://nmap.org/book/idlescan.html
## https://packetpushers.net/ip-fragmentation-in-detail/

## paranoid (0), sneaky (1), polite (2), normal (3), aggressive (4), and insane (5)

## nmN finds all the wireless devices connected to host
# This is very useful to find all the set wireless devices on my network
nmN () { # detect open TCP ports on hoste.g. 192.168..0/24, or localhost
	sudo nmap -v -sn $1
}
## nmP does ARP Ping on specified host(s)
nmP () { # ARP Ping on specified host(s)
	sudo nmap -PR -O -v $1
}

alias nmpe='sudo nmap -sP -PE -PA21,22,23,25,53,80,3389,5900,5939,8080 192.168.0.*'

## nmsd runs script scan on local or remote host in debug mode, skipping
# host discovery (i.e accesses blocked hosts), in verbose/debug mode;
# user sets debug level, funct takes 0 - 9 as <arg1>, default is 0
# <arg2> is address, e.g. 192.168.0.-
nmsd () {
	sudo nmap -sC -Pn -v -d$1 $2
}
## nmC runs script scan on local or remote host, skipping
# host discovery, using OD Detection, in verbose/debug mode
nmC () {
	sudo nmap -sC -Pn -O -v $1
}
## nmT runs scan on open TCP hosts, skipping host discovery,
# using OD Detection, running in verbose mode
nmT () {
	sudo nmap -sT -Pn -O -v $1
}
## nmS performs TCP SYN scan on host (e.g, localhost, 192.168.0.1, etc.)
# Use this to script scan open ports on a remote or local host
# using OD Detection while skipping host discovery;
# arg must be a host designator
nmS () {
	sudo nmap -sS -Pn -O -v $1
}
## nmV performs service/version scan on host (e.g, localhost, 192.168.0.1, etc.)
# Use this to scan open ports on a remote or local host using OD Detection 
## while skipping host discovery in verbose mode;
# arg must be a host designator
nmV () {
	sudo nmap -sV -Pn -O -v $1
}

## nmA performs service/version scan on host, skip discovery, verbose, 
## enable OS detection, version detection, script scanning, and traceroute.
nmA () {
	sudo nmap -sV -Pn -A -v $1
}

# --top-ports
# arg1 = number of ports to show, e.g. 20 = the top 20 ports
# arg2 = a host name or IPvx address (e.g. google.com or 192.168.0.1)
nmtop () {
	nmap -Pn --top-ports $1 $2
}

#################
#### NETSTAT ####
#################
alias nt='netstat'
alias ntg='netstat -g' # Display group connections
alias nti='netstat -i' # Display interfaces
alias ntm='netstat -M' # Display a list of masqueraded connections
alias nts='netstat -s' # Display summary statistics
alias ntr='netstat -r' # Display the kernel routing tables
alias ntt='netstat -t' # Display a list of tcp connections
alias ntu='netstat -u' # Display udp group connections
alias ntatu='netstat -atu' # Show all sockets, TCP and UDP connections
alias ntntu='netstat -ntu' # Display numerical tcp/udp addresses

alias ntlup='sudo netstat -tlup' # Display open ports
alias nttlpn='sudo netstat -t -u -l -p -n' # Too much to name
# -t = TCP
# -u = UDP
# -l = listening ports only
# -n = don't look up service and host names, just display numbers
# -p = show process information (requires root privilege)
# -r = display kernal routing tables

#####################
#### SS COMMANDS ####
#####################
## https://www.linux.com/topic/networking/introduction-ss-command/
ssta () {
	ss -lta
}
## to save ssta output in a file, ~/reports/ss_reports
sssav () {
	ss -lta > ~/reports/ss_reports
	echo 'use ctssrep to see ~/reports/ss_reports'
}
## To show connected sockets from specific address, i.e. to  
## find out if/how a machine at IP address $1 has connected to your server
ssdst () {
	ss dst $1
}
#####################

##########################################################
####### END OF INTRUSION PREVENTION AND DETECTION ########
##########################################################
