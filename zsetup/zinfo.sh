#!/bin/bash

# File Name:		zinfo.sh
# Written by:		Jacob Romero
#					Creative Engineering Solutions, LLC
#					jrom876@gmail.com
# Contact:			cesllc876@gmail.com
# Github Page:		www.github.com/jrom876
#
##################################
### PURPOSE: TABLE OF CONTENTS ###
##################################

# This table of contents provides quick navigation through the aliases,
## functions, arrays, vars, and environment variables created by our
## custom bash environment.

## It basically lists all the ec- and ev- functions, which in turn
## list many important methods contained in the scripts.

############################
shopt -s expand_aliases
############################

#########################
#### COMMAND LISTERS ####
#########################
eclist () {
	echo
	echo 'WELCOME TO TABLE OF CONTENTS'; echo
	echo 'Entering one of these ec- commands opens an instruction dialog which '
	echo 'explains certain functions, aliases and arrays used in that file'; echo
	echo 'COMMAND		FILE		EXPLANATION'; echo
	echo 'ecbkups		bkups.sh	backup methods'
	echo 'ecfan		csys.sh		fan speed utility'
	echo 'ecsys		csys.sh		most csys.sh methods'
	echo 'ecusr		csys.sh		user control methods'
	echo 'ecxustom 	custom.sh	custom commands'
	echo 'ecwriter	fwriter.sh	custom text document handlers'
	echo 'ecindet		indet.sh	intrusion detection and prevention'
	echo 'ecldmup		ldmup.sh	autoloader methods'
	echo 'ecnet		netev.sh	network evaluation and security methods'
	echo 'ecrepairs	repairs.sh	repairs, updates and upgrades'
	echo 'ecmem		repairs.sh	memory management'
#	echo 'ecupdates	repairs.sh	show updates and upgrades'
	echo 'ecdocker	rmt.sh		Docker functions'
	echo 'ecflask		rmt.sh		Flask functions'
	echo 'ecscreen	rmt.sh		Screen functions'; echo
	echo '================================================'; echo
	# echo ''
	echo 'COMMON METHODS'
	echo 'sau 		csys.sh		sudo apt update'
	echo 'sag 		csys.sh		sudo apt upgrade'
	echo 'bye 		csys.sh		clear; exit'
	echo 'fanmod $1	csys.sh		modify cooling fan setting, between 100-125'
	echo 'fanstatus	csys.sh		display fan and CPU temperature status'
	echo 'gtfanspeed	cys.sh		display fan speed setting'
	echo 'sensors		builtin		display CPU temperatures'
	echo 'ufenable	cwf.sh 		sudo ufw enable'
	echo 'lssysbkups	bkups.sh	list primary backups'
	echo 'srzsetup $1	csys.sh 	search zsetup for $1'
	echo 'lkport $1	netev.sh	see if port $1 is available'; echo

	echo 'NETWORK AND SECURITY METHODS'
	echo 'evproc		cwf.sh		process interrogator'
	echo 'evedge		cwf.sh		network password methods'
	echo 'evDZone		cwf.sh		The Danger Zone, enter with care and passwords in hand'
	echo 'evsec		cwf.sh		security interrogator'
	echo 'fevnet		netev.sh	full network evaluation > nmap-list.txt'
	echo 'evnet		netev.sh	specific network evaluation'
	echo 'getnet		netev.sh	simple network evaluation'
	echo 'ctnmapl		netev.sh 	cat nmap-list.txt'
	echo 'gtiptables	netev.sh	to see iptables rule set'
	echo 'nmV $1		netev.sh	service scan, OD detection, skip host discovery'; echo
	
	echo 'SYSTEM INTERROGATORS'	
	echo 'env		builtin		show environment variables'
	echo 'luner		luner.sh	comprehensive system interrogator'
	echo 'ssta		indet.sh	show all listening ports and processes'
	echo 'svtus $1  	cwf.sh 		to get status of a service'
	echo 'svall     	cwf.sh 		to list all running services'
	echo 'psrch $1  	cwf.sh    	to search current running processes for given keyword'
	echo 'gtblame		repair.sh	systemd-analyze blame'
	echo 'gtunitfiles	repair.sh	systemctl list-unit-files'
	echo 'gtsvcs		repair.sh	systemctl list-unit-files --type=service'
	echo 'gtenabled	repair.sh	systemctl list-unit-files --type=service | grep enabled'
	echo 'gtnonstatic	repair.sh	systemctl list-unit-files --type=service | grep -v static'; echo

}

ecbkups () {
	echo
	echo 'COMMAND LIST FOR:	bkups.sh'; echo
	echo 'COMMANDS		EXPLANATION'
	echo 'crtbkdir		Create Backup Directories'
	echo 'autofbkups		Saving files in ~/bkups/fbkups directory'
	echo 'autozbkups		Saving files in ~/bkups/sysbkups directory'
	echo 'bkflist $@		Backup files in ~/bkups/fbkups directory'
	echo 'bksyslist $@		Backup files in ~/bkups/sysbkups directory'
	echo 'clrflist		Deletes all contents of ~/bkups/fbkups'
	echo 'clritems $@		Deletes specific files from ~/bkups/fbkups'
	echo 'clrzlist		Deletes all contents of ~/bkups/sysbkups'
	echo 'clrvitems $@		Deletes specific items from ~/bkups/ysbkups'; echo
	echo 'GETTERS'
	echo 'lsbkups			ls -la ~/bkups/'
	echo 'lssysbkups		ls -la ~/bkups/sysbkups/'
	echo 'lsybkups		ls -la ~/bkups/sysbkups/*'
	echo 'lsfbkups		ls -la ~/bkups/fbkups/'
	echo 'lsgbkups		ls -la ~/bkups/fbkups/*'; echo
	echo 'MOVERS'
	echo 'mtzbkups		cd ~/bkups/sysbkups/'
	echo 'mtfbkups		cd ~/bkups/fbkups/'; echo
	echo 'BACKUP ARRAYS'
	echo 'jetson_bkups'
	echo 'rpi13_bkups'
	echo 'rpizero_bkups'
	echo 'test_bkups'; echo
}

ecsys () {
	echo
	echo 'COMMAND LIST FOR:	csys.sh'; echo
	echo 'COMMANDS	EXPLANATION'
	echo 'c		clear'
	echo 'f		file *'
	echo 'h		history'
	echo 'p		pwd'
	echo 'la		ls -la'
	echo 'w		whereis'
	echo 'h		hostname'
	echo 'ifc		ifconfig -a'
	echo 'bye 		clear; exit'; echo
	echo 'SHELLS'
	echo 'getshells	cat /etc/shells'
	echo 'getpush		show path, user, shell, pwd'; echo
	echo 'COMPUTER INFORMATION'
	echo 'ul		ulimit -a'
	echo 'lsc		lscpu'
	echo 'lshw		sudo lshw -C CPU'
	echo 'inxi		inxi -F'
	echo 'gsm		gnome-system-monitor'
	echo 'pmem		cat /proc/meminfo'
	echo 'lsmem		list memory block info'
	echo 'wCPUspeed	watch CPU speed in real time'; echo
	echo 'FAN SPEED UTILITY'
	echo 'gtfanspeed	display fan speed setting'
	echo 'fanmod $1	modify jetson cooling fan setting, between 100-125'
	echo 'sensors		display device temperatures'; echo
	echo 'CRASH DUMP UTILITY'
	echo 'crsh		ls /var/crash	get crash dumps'
	echo 'rcrsh		delete old crash dumps'
	echo 'savcrsh()	save crash dump list in report'
	echo 'dltcrsh()	delete crash dumps from report'
	echo 'storecrash()	store complete crash dumps in ~/bkups/crash_dumps/'
	echo 'clrcrash()	clear all crash dumps from ~/bkups/crash_dumps/'; echo
	echo 'PACKAGE VERSIONS'
	echo 'jtv		show my Jetson Nano info'
	echo 'ubv		show my Ubuntu info'; echo
	echo 'USER CONTROL'
	echo 'usid		id -nu'
	echo 'wami		whoami > ~/reports/users; wc -l ~/reports/users; cat ~/reports/users'
	echo 'grpid		id -nG'
	echo 'lusers		compgen -u ## List linux users ##'
	echo 'swuser ()	Switch user'
	echo 'gtupw $1	arg 1 = username whose passwd we are trying to retrieve/verify'
}

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

ecmem () {
	echo
	echo 'WELCOME TO MEMORY CACHE MANAGEMENT UTILITY'; echo
	echo 'CACHE SUMMARY'	
	echo 'gtaptcache			sudo du -sh /var/cache/apt'
	echo 'gtsysjournal		journalctl --disk-usage'
	echo 'gtthmb			du -sh ~/.cache/thumbnails'
	echo 'gtkernels		sudo dpkg --list linux-image*'; echo
	
	echo '### CAUTION USING ALL OF THE FOLLOWING FUNCTIONS ###'; echo
	
	echo 'APT CACHE'
	echo 'gtaptcache			sudo du -sh /var/cache/apt'
	echo 'dltaptcache		sudo apt-get autoclean'
	echo 'clnaptcache		sudo apt-get clean'; echo
	
	echo 'SYSTEM JOURNAL LOGS'
	echo 'gtsysjournal		journalctl --disk-usage'; echo
	echo 'clnsysjournal	$1	sudo journalctl --vacuum-time=$1'
	echo '			arg $1 = days of logs to clear'
	echo '			e.g.: sudo journalctl --vacuum-time=3d'; echo

	echo 'SNAP'
	echo 'gtsnap		du -h /var/lib/snapd/snaps'
	echo 'dltsnap () 	MUST BE RAN AS ROOT IN HOME DIRECTORY
		CLOSE ALL SNAPS BEFORE RUNNING THIS
		EXAMPLE ONLY!!
		RUN dltsnp() FILE IN ~/

		dltsnap () {
		# #!/bin/bash
		# ## Removes old revisions of snaps
		# set -eu
		# snap list --all | awk /disabled/{print $1, $3} |
		#     while read snapname revision; do
		#         snap remove "$snapname" --revision="$revision"
		#     done
		# }'; echo	
	
	echo 'THUMBNAIL CACHE'
	echo 'gtthmb		du -sh ~/.cache/thumbnails'
	echo 'dltthmb		rm -rf ~/.cache/thumbnails/*'; echo

	echo 'LINUX KERNELS'
	echo '### CAUTION ###'
	echo 'List all installed Linux Kerenels'
	echo 'gtkernels()	sudo dpkg --list linux-image*'; echo
	
	echo 'Delete specific Linux version from above command'
	echo '		arg $1 = Linux Version'
	echo '		e.g.:	sudo apt-get remove linux-image-VERSION'
	echo 'dltlnxver	sudo apt-get remove linux-image-$1';echo
	
}

ecupdates () {
	echo
	echo 'UPDATES AND UPGRADES'; echo
	echo 'COMMANDS	EXPLANATION'
	echo 'sai	syi	sudo apt install (-y)'
	echo 'sau	say	sudo apt update (-y)'
	echo 'sag	syg	sudo apt upgrade (-y)'
	echo 'suf		sudo apt full-upgrade'
	echo 'sug		sau && saf && sag'
	echo 'suu		syi && saf && suf'; echo
}

ecusr () {
	echo
	echo 'USER CONTROL'; echo
	echo 'COMMANDS	EXPLANATION'
	echo 'usid		id -nu'
	echo 'wami		whoami > ~/reports/users; wc -l ~/reports/users; cat ~/reports/users'
	echo 'grpid		id -nG'
	echo 'lusers		compgen -u ## List linux users ##'
	echo 'swuser ()	Switch user'
	echo 'gtupw $1	arg 1 = username whose passwd we are trying to retrieve/verify'; echo
}

evedge () {
	echo
	echo 'NETWORK PASSWORD METHODS'; echo
	echo 'COMMANDS	EXPLANATION'
	echo 'savzulu		save network passwd to zulu-list (HP-250 and Jetson Nano)'
	echo 'gtzulu		show network passwd'
	echo 'dltzulu		delete network passwd'
	echo 'savsupp		save network passwd to supp-list (Raspberry Pi)'
	echo 'gtsupp		show network passwd'
	echo 'dltsupp		delete network passwd'
	echo
}

ecldmup () {
	echo
	echo 'COMMAND LIST FOR:	ldmup.sh'; echo
	echo 'NOTE:	use ld- for gentle		use ly- for forced'
	echo 'e.g.	ldmup = gentle multi-load	lymup = forced multi-load'
	echo 'e.g.	ldsec = gentle security tools	lysec = forced security tools'; echo
	echo 'COMMANDS	EXPLANATION'
	echo 'ldmup 		gently run mutiple autoloader scripts'
	echo 'lymup 		forcefully run mutiple autoloader scripts'
	echo 'crtdirs		create Required Directories'
	echo 'ldlang		loads several required programming languages and tools'
	echo 'ldpython	loads python tools'
	echo 'ldedit		loads text editors'
	echo 'ldsec		loads security tools'
	echo 'ldnet		loads networking tools'
	echo 'ldgit		loads git'
	echo 'ldiot		loads IoT server tools'
	echo 'ldrmt		loads Docker, Flask, Screen and other remote tools'
	echo 'ldsys		loads system tools such as inxi and dmidecode'
	echo 'ldarray		loads an array of files from zsetup/ into ~/'; echo
}
