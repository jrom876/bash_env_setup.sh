#!/bin/bash

# File Name:		csys.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876
#
########################################
### PURPOSE: GENERAL SYSTEM COMMANDS ### 
########################################
# This file contains very useful and commonly used system commands 
# for things such as viewing computer status, performing updates/upgrades, 
# group and user control, and modifying file permissions.

###################
### Most Common ###
alias c='clear'
alias f='file *'
alias h='history'
alias p='pwd'
alias la='ls -la'
##alias whe='whereami'
alias wh='whereis'
alias hn='hostname'
alias ifc='ifconfig -a'
#alias ifp='ifplugstatus'
# alias ifcwlan='ifconfig wlan0'
# alias ifceth='ifconfig eth0'
# alias ifclo='ifconfig lo'

##########################
### Install and Update ###
alias sai='sudo apt install'
alias sau='sudo apt update'
alias say='sudo apt update -y'
alias sag='sudo apt upgrade'
alias suf='sudo apt full-upgrade'
######################
### Repair Actions ###
alias saf='sudo apt install -f'
alias sad='sudo dpkg --configure -a'
alias san='sudo apt --fix-broken install'
### Drastic Repair Actions
alias sug='sau && saf && sag'
alias suu='say && saf && suf'
alias saa='sudo apt autoremove'

sapurge () {
	sudo apt remove --purge $1
}
## See: https://phoenixnap.com/kb/fix-sub-process-usr-bin-dpkg-returned-error-code-1
## https://www.howtogeek.com/423709/how-to-see-all-devices-on-your-network-with-nmap-on-linux/

## For flash-kernel errors
## https://itsfoss.com/dpkg-returned-an-error-code-1/

####################
### User Control ###

#### See: https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-18-04
#### See: https://net2.com/how-to-switch-users-on-linux-ubuntu/
alias who='whoami'
alias usid='id -nu'
alias wami='whoami > ~/reports/users; wc -l ~/reports/users; cat ~/reports/users'
# alias wd='who -d'	# print dead processes
# alias wq='who -q'

swuser () {  # Switch user
	sudo su $1;
	cd /home/$1
}

### Group Info ###
alias grpid='id -nG' # Returns all groups the user belongs to
alias grpad='id -ng'

## List linux users
alias lusers='compgen -u'

## $1 = username whose passwd we are trying to retrieve/verify
gtupw () {
	getent passwd | grep $1
}

##############
### Shells ###
alias getshells='cat /etc/shells'
alias getpush="printenv | grep -wE 'PATH|USER|SHELL|LANG|TERM|PWD|OLDPWD'"

##############
### python ###
alias p2='python'
alias p3='python3'

######################################
####### Computer Hardware Info #######
######################################
# see: https://www.binarytides.com/linux-check-processor/
alias ul='ulimit -a' # ulimit = obsolete, but still works
alias lsc='lscpu'
alias lshw='sudo lshw -C CPU'
alias cid='cpuid -1'
alias inxi='inxi -C'
alias hwi='hardinfo' # info about system hardware
alias gsm='gnome-system-monitor'
## nproc = number of available processors
alias dmid='sudo dmidecode -t 4'; fmp='yar'
## useful /proc/cpuinfo functions ##
alias pcpu='cat /proc/cpuinfo'
cpuGet () {
	cat /proc/cpuinfo | grep -i $1
}
wCPUspeed () {
	watch -n 0.1 "cat /proc/cpuinfo | grep -i mhz"
}

## hwloc / lstopo utility ##
# Provides cpu info at a glance
# https://www.open-mpi.org/projects/hwloc/tutorials/20120702-POA-hwloc-tutorial.html
# for more info on hwloc / lstopo utility
alias ltv='lstopo - -v --no-io'
# Run the following code to open lstopo
optopo () {
	lstopo -
	lstopo
}
#####################
#### Crash Dumps ####
#### See: https://askubuntu.com/questions/1160113/system-program-problem-detected
#### For info on apport, see: https://wiki.ubuntu.com/Apport

## get crash dumps
alias crsh='ls /var/crash/'  
## delete old crash dumps
alias rcrsh='sudo rm /var/crash/*' 

## save crash dumps in report
savcrsh () {
	DATE=`date`
	echo $DATE >> ~/reports/crash_dump_report.txt
	ls /var/crash/ >> ~/reports/crash_dump_report.txt
}
## delete crash dumps from report
dltcrsh () {
	crvar=$( sudo cat ~/reports/crash_dump_report.txt )
	if [[ -z $crvar ]]
	then
		echo 'Sorry, crash_dump_report is already empty'
	else
		read -sp 'Enter Special Password to delete crash_dump_report: ' passvar
		echo
		if [[ $gmp = $passvar ]]
		then
			echo
			echo $blanktext > ~/reports/crash_dump_report.txt
			echo 'crash_dump_report deleted'
		else 
			echo 'Wrong Password'
			echo 'Access Denied'
		fi
	fi
}
####################################
## Get your computer's serial number
alias getsn='sudo dmidecode -t system'
alias getssn='sudo dmidecode -s system-serial-number'
##########################
### Find linux version ###
alias linv='cat /proc/version'
alias uno='uname -o'
alias una='uname -a'
##########################
#### Find my Entropy #####
#### https://hackaday.com/2017/11/02/what-is-entropy-
#### and-how-do-i-get-more-of-it/#raspberry-pi-and-the-hw-rng
alias entropy='cat /proc/sys/kernel/random/entropy_avail'
alias wentropy='watch -n 1 cat /proc/sys/kernel/random/entropy_avail'
##########################
#### CPU Memory Usage ####
#### See: cyberciti.biz
alias pmem='cat /proc/meminfo'
alias vms='vmstat'
alias lsm='lsmem'
#top
#atop
#htop
#gnome-system-monitor
#free -t -m
#free -m
#vmstat
#cat /proc/meminfo
#less /proc/meminfo
#more /proc/meminfo
#ps -aux
##################################
#### Show my Jetson Nano Info ####
alias jtv='dpkg-query --show nvidia-l4t-core'
##################################
#### Show my Ubuntu Info ####
alias ubv='cat /etc/os-release'
#################################
### MISCELLANEOUS FUNCTIONS ###
#################################
md () {		## make directory, and go to it
    mkdir -p $1 # -p = make parent directories as needed
    cd $1
}
### Setting file permssions ###
mfx () {	## make file(s) executable for everyone
	  chmod +x $@
}
mfa () {	## make file(s) read/execute for everyone
	  chmod 755 $@
}
rfx () {	## remove file(s) execute/write permissions for all but owner
	  chmod 744 $@
}
rfa () {	## remove all file permissions for everyone but owner
	  chmod 600 $@
}
rfz () {	## as above, but with executability
	  chmod 700 $@
}
countItems () {
	  grep -i $1 * | wc -l
		## countItems takes a text string as its only argument and counts
		## the number of occurrences of this string in the current directory
}
currDate () {		## show current date
	DATE=`date`
	echo "Date and Time: $DATE"
}

################################################################
#### VERY USEFUL for deleting and creating USB partitions!! ####
################################################################
## https://dottheslash.wordpress.com/2011/11/29/deleting-all-partitions-on-a-usb-drive/
# First we need to delete the old partitions that remain on the USB key.
#     Open a terminal and type sudo su
#     Type fdisk -l and note your USB drive letter.
#     Type fdisk /dev/sdx (replacing x with your drive letter)
#     Type d to proceed to delete a partition
#     Type number 1 to select the 1st partition and press enter
#     Type d to proceed to delete another partition (fdisk should automatically select the second partition)

# Next we need to create the new partition.
#     Type n to make a new partition
#     Type p to make this partition primary and press enter
#     Type 1 to make this the first partition and then press enter
#     Press enter to accept the default first cylinder
#     Press enter again to accept the default last cylinder
#     Type w to write the new partition information to the USB key
#     Type umount /dev/sdx (replacing x with your drive letter)

# The last step is to create the fat filesystem.
#     Type mkfs.vfat -F 32 /dev/sdx1 (replacing x with your USB key drive letter)
#
# That’s it, you should now have a restored USB key with a single fat 32 partition
# that can be read from any computer.

################
## don't forget:
# dir
# df -k
# mount
# dmesg
# finger
# ping
# top
# pr, lp, lpr, lpstat, and lpstat -o
# traceroute # https://www.javatpoint.com/linux-traceroute
# mtr
# ps
# sed
# sort
# tty
# who

##########################################
### END OF GENERAL SYSTEM COMMAND SIDE ###
##########################################

################################
###  End of csys.sh  ###
################################




