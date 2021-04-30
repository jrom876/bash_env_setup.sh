#!/bin/bash

# File Name:		csys.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
#			jrom876@gmail.com
# Contact:		cesllc876@gmail.com
# Github Page:		www.github.com/jrom876
#
########################################
### PURPOSE: GENERAL SYSTEM COMMANDS ###
########################################

##	This file contains utilities and commands for things such as: 

##		-- viewing computer status
##		-- group and user control 
##		-- modifying file permissions

####################
#### REFERENCES ####
####################

## https://www.tutorialkart.com/bash-shell-scripting/bash-split-string/
## https://ryanstutorials.net/linuxtutorial/scripting.php
## https://unix.stackexchange.com/questions/531938/parse-a-string-in-bash-script
## https://linuxconfig.org/how-to-use-arrays-in-bash-script
## See: https://askubuntu.com/questions/1160113/system-program-problem-detected
## For info on apport, see: https://wiki.ubuntu.com/Apport
## See: https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-18-04
## See: https://net2.com/how-to-switch-users-on-linux-ubuntu/
## https://www.cyberciti.biz/open-source/command-line-hacks/compgen-linux-command/
## https://unix.stackexchange.com/questions/151118/understand-compgen-builtin-command
## https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html
## see: https://www.binarytides.com/linux-check-processor/
## for more info on hwloc / lstopo utility
## https://www.open-mpi.org/projects/hwloc/tutorials/20120702-POA-hwloc-tutorial.html
## https://hackaday.com/2017/11/02/what-is-entropy-and-how-do-i-get-more-of-it/#raspberry-pi-and-the-hw-rng
## For CPU MEMORY USAGE See: cyberciti.biz
## https://dottheslash.wordpress.com/2011/11/29/deleting-all-partitions-on-a-usb-drive/

#######################
shopt -s expand_aliases
#######################

########################
### GLOBAL VARIABLES ###
export degrees
degrees="°"
########################

########################
### GENERAL COMMANDS ###
########################
alias c='clear'
alias f='file *'
alias h='history'
alias p='pwd'
alias la='ls -la'
##alias whe='whereami'
alias wh='whereis'
alias hn='hostname'
alias ifc='ifconfig -a'
alias bye='clear; exit'
#alias ifp='ifplugstatus'
# alias ifcwlan='ifconfig wlan0'
# alias ifceth='ifconfig eth0'
# alias ifclo='ifconfig lo'

############################
#### CRASH DUMP UTILITY ####
############################

## PURPOSE:		To provide methods for storing, retrieving, and deleting
##			crash dumps and crash dump reports

#### See: https://askubuntu.com/questions/1160113/system-program-problem-detected
#### For info on apport, see: https://wiki.ubuntu.com/Apport

## get crash dumps
alias crsh='ls /var/crash/'
## delete old crash dumps
alias rcrsh='sudo rm /var/crash/*'

## save crash dumps in report
savcrsh () {
	local DATE=`date`
	echo $DATE >> ~/reports/crash_dump_report.txt
	ls /var/crash/ >> ~/reports/crash_dump_report.txt
}
storecrash () {
	sudo cp -rbf /var/crash/* ~/bkups/crash_dumps/
}
clrcrash () {
	sudo rm -rf ~/bkups/crash_dumps/
}
mtcrash () {
	cd ~/bkups/crash_dumps/
	ls -la
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

###########################
#### FAN SPEED UTILITY ####
###########################

##	PURPOSE:	COOLING FAN SETTINGS
##				To allow the user to setup, modify and display 
##				Jetson Nano Cooling Fan settings
##	SETUP:
## 		Basic setup:
##			0.	Open terminal
##			1.	sudo sh -c 'echo 120 > /sys/devices/pwm-fan/target_pwm'
## 		To setup automatic cooling fan to run at boot:
##			0.	Create and edit rc.local:
##					sudo nano /etc/rc.local
##			1.	Paste the following in the new rc.local file:
#					#!/bin/bash
#					sleep 10
#					sudo /usr/bin/jetson_clocks
#					sudo sh -c 'echo 120 > /sys/devices/pwm-fan/target_pwm'
##			2.	Save and quit (ctl+o, enter, ctl+x)
##			3.	Add permission to rc.local:
##					sudo chmod u+x rc.local
##			4.	Reboot

#################################
####### TABLE OF CONTENTS #######
#################################
ecfan () {
	echo 
	echo 'WELCOME TO FAN SPEED UTILITY'; echo
	echo 'This utility displays CPU cooling fan and temperature status and '
	echo 'provides commands for the user to safely modify fan speed settings'
	echo 'and assess system temperatures.'; echo
	echo '===================================================='
	echo 'CPU FAN AND TEMPERATURE STATUS'; echo
	#echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"; echo
	fanstatus
	echo '===================================================='
	echo 'COMMANDS	EXPLANATION'; echo
	echo 'fanmod $1	To modify Jetson Nano cooling fan speed setting'
	echo '		The suggested <arg> range is 100-125. Default is 120'
	echo '		Call:	fanmod <fanspeed>  for fanspeed'
	echo '			fanmod <max> for max  125'
	echo '			fanmod <min> for min  100'
	echo '			fanmod <mid> for mid  113'
	echo '			fanmod <d>   for default  120'; echo
	echo 'fanstatus	Display Fan and CPU Temperature Status'
	echo 'gtfanspeed	Display Fan Speed'
	echo 'sensors		Display CPU Temperatures'
	echo "extemp 		Display CPU temp in $degrees F"
	echo 'ctof		Convert Celsius to Fahrenheit'
	echo 'ftoc		Convert Fahrenheit to Celsius';	echo 	
}

###########################################
####### FAN SPEED UTILITY FUNCTIONS #######
###########################################

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	fanmod():	FAN SPEED UTILITY -- Allows User to safely modify the
##			Jetson Nano cooling fan speed setting
##	Call:		fanmod <arg=fanspeed> (password required)
##	Requires:	$1 -- set <arg> between 100 and 125 for best results

fanmod() {
	echo 'WELCOME TO FAN SPEED UTILITY -- MODIFIER'
	if [ -z $1 ]; then
		echo 'Invalid entry: Exiting FAN SPEED UTILITY '
	elif [ $1 = 'd' ]; then							
		sudo sh -c "echo 120 > /sys/devices/pwm-fan/target_pwm"
		echo; echo "Fan speed has been reset to 120 (default)"
		echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
		extemp; echo
		echo 'Enter extemp to display CPU temps'
		echo 'Enter gtfanspeed to display fan speed'
	elif [ $1 = 'max' ]; then							
		sudo sh -c "echo 125 > /sys/devices/pwm-fan/target_pwm"
		echo; echo "Fan speed has been set to 125 (max)"
		echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
		extemp; echo
		echo 'Enter extemp to display CPU temps'
		echo 'Enter gtfanspeed to display fan speed'
	elif [ $1 = 'min' ]; then							
		sudo sh -c "echo 100 > /sys/devices/pwm-fan/target_pwm"
		echo; echo "Fan speed has been set to 100 (min)"
		echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
		extemp; echo
		echo 'Enter extemp to display CPU temps'
		echo 'Enter gtfanspeed to display fan speed'
	elif [ $1 = 'mid' ]; then							
		sudo sh -c "echo 113 > /sys/devices/pwm-fan/target_pwm"
		echo; echo "Fan speed has been set to 113 (mid)"
		echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
		extemp; echo
		echo 'Enter extemp to display CPU temps'
		echo 'Enter gtfanspeed to display fan speed'
	elif [ -n $1 ]; then
		if [ $1 -lt 100 ] || [ $1 -gt 125 ]; then
			echo 'That number is out of range.'
			echo 'The suggested range is 100-125. Default is 120'
			read -sp 'Enter special password to proceed, or n to enter a new speed, or d for default speed ' answer
			if [ $answer == "$fmp" ]; then
				sudo sh -c "echo $1 > /sys/devices/pwm-fan/target_pwm"
				echo; echo "Fan speed has been successfully set to $1"
				echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
				extemp; echo
				echo 'Enter extemp to display CPU temps'
				echo 'Enter gtfanspeed to display fan speed'
			elif [ $answer == 'n' ]; then	
				echo
				read -p  'Enter new value	' newvalue		
				if [ $newvalue -lt 100 ] || [ $newvalue -gt 125 ]; then
					echo 'Exiting FAN SPEED UTILITY'
				else 
					sudo sh -c "echo $newvalue > /sys/devices/pwm-fan/target_pwm"
					echo; echo "Fan speed has been successfully set to $newvalue"
					echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
					extemp; echo					
					echo 'Enter extemp to display CPU temps'
					echo 'Enter gtfanspeed to display fan speed'
				fi			
			elif [ $answer == 'd' ]; then 				
				sudo sh -c "echo 120 > /sys/devices/pwm-fan/target_pwm"
				echo; echo "Fan speed has been reset to 120 (default)"
				echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
				extemp; echo
				echo 'Enter extemp to display CPU temps'
				echo 'Enter gtfanspeed to display fan speed'
			else 
				echo 'Exiting FAN SPEED UTILITY'
			fi
		else
			sudo sh -c "echo $1 > /sys/devices/pwm-fan/target_pwm"
			echo; echo "Fan speed has been successfully set to $1"
			echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
			extemp; echo
			echo 'Enter extemp to display CPU temps'
			echo 'Enter gtfanspeed to display fan speed'
		fi		
	else
		echo 'Default'
	fi
}

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	fanstatus():	Displays Fan Speed and CPU Temperatures, and 
#			converts the thermal-fan temp1 reading from °C 
#			to °F  for the convenience of Americans and Brits
##	Call:		fanstatus
##	Requires:	None
##	Dependencies:	sensors
##			extemp
##			ctof (embedded python3)
##			python3 import os
##			python3 import math 

fanstatus () {
	echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"; echo
	#local halo=$( sensors )
	#echo "$halo"; echo
	extemp; echo
	echo 'Use: 	fanmod <new speed>   to change fan speed (password required)'
	#echo 'Use:	ctof <temp in degrees C> 	to convert temp from c to f'
}

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	gtfanspeed():	Displays Fan Speed
##	Call:		gtfanspeed
##	Requires:	None

gtfanspeed () {
	echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
}

extemp () {
	local tempo=$( sensors | grep -e "temp1" )
	#echo "tempo at start = $tempo" ## DBPRINT	
	local tempo0="${tempo#*\+}"
	tempo0="${tempo0%%\°*}"
	#echo "tempo0 = $tempo0" ## DBPRINT
	local tempo1="${tempo##*\+}"
	tempo1="${tempo1%\°*}"
	#echo "tempo1 =  $tempo1" ## DBPRINT
	local vargo0=$( ctof $tempo0 )
	echo "ilwifi temp1:        +$tempo0°C  =  $vargo0"
	local vargo1=$( ctof $tempo1 )
	echo "thermal-fan temp1:   +$tempo1°C  =  $vargo1"
}

function ctof {
TEMP_ARG1="$1" python3 - <<END
import os
import math 

intemp = os.environ['TEMP_ARG1']
#print('Celsius to Fahrenheit = ',intemp)
intemp = float(intemp)

def ctof(intemp):
	result = (intemp*1.8)+32 
	if (result > 0):
		print("+{0:.1f}°F ".format(result))
	else:
		print("{0:.1f}°F ".format(result))
	return result
ctof(intemp)
  
END
	  
}

function ftoc {
TEMP_ARG2="$1" python3 - <<END
import os
import math 

intemp = os.environ['TEMP_ARG2']
#print('Fahrenheit to Celsius = ',intemp)
intemp = float(intemp)

def ftoc (intemp):
	result = (intemp-32)/1.8 
	if (result > 0):
		print("+{0:.1f}°C ".format(result))
	else:
		print("{0:.1f}°C ".format(result))
	#print("{0:.1f}°C ".format(result))
	return result
ftoc(intemp)
	  
END
	  
}

##################################
#### Show my Jetson Nano Info ####
alias jtv='dpkg-query --show nvidia-l4t-core'
##################################
#### Show my Ubuntu Info ####
alias ubv='cat /etc/os-release'
##################################

####################
### USER CONTROL ###
####################

#### See: https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-18-04
#### See: https://net2.com/how-to-switch-users-on-linux-ubuntu/
#alias who='whoami'
alias usid='id -nu'
alias wami='whoami > ~/reports/users; wc -l ~/reports/users; cat ~/reports/users'
# alias wded='who -d'	# print dead processes
# alias wq='who -q'

swuser () {  # Switch user
	sudo su $1;
	cd /home/$1
}

### Group Info ###
alias grpid='id -nG' # Returns all groups the user belongs to
alias grpad='id -ng'

## https://www.cyberciti.biz/open-source/command-line-hacks/compgen-linux-command/
## https://unix.stackexchange.com/questions/151118/understand-compgen-builtin-command
## https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html
## List linux users
alias lusers='compgen -u'

##############
### Shells ###
alias getshells='cat /etc/shells'
alias getpush="printenv | grep -wE 'PATH|USER|SHELL|LANG|TERM|PWD|OLDPWD'"

##############
### python ###
alias p2='python'
alias p3='python3'

###################
## search zsetup ##
srzsetup () {
	cat zsetup/* | grep -in $1
}

######################################
####### COMPUTER HARDWARE INFO #######
######################################
# see: https://www.binarytides.com/linux-check-processor/
alias ul='ulimit -a' # ulimit = obsolete, but still works
alias lsc='lscpu'
alias lshw='sudo lshw -C CPU'
##alias cid='cpuid -1'
alias inxi='inxi -F'
alias hwi='hardinfo' # info about system hardware
alias gsm='gnome-system-monitor'
## nproc = number of available processors
alias dmid='sudo dmidecode -t 4'
## useful /proc/cpuinfo functions ##
alias pcpu='cat /proc/cpuinfo'

## Displays real-time CPU speeds
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
#########################################
### Get your computer's serial number ###
alias getsn='sudo dmidecode -t system'
alias getssn='sudo dmidecode -s system-serial-number'
##########################
### Find linux version ###
alias linv='cat /proc/version'
alias uno='uname -o'
alias una='uname -a'
##########################
#### FIND MY ENTROPY #####
#### https://hackaday.com/2017/11/02/what-is-entropy-and-how-do-i-get-more-of-it/#raspberry-pi-and-the-hw-rng
alias entropy='cat /proc/sys/kernel/random/entropy_avail'
alias wentropy='watch -n 1 cat /proc/sys/kernel/random/entropy_avail'
##########################
#### CPU MEMORY USAGE ####
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
## countItems $1 takes a text string as its only argument and counts
## the number of occurrences of this string in the current directory
countItems () {
	  grep -i $1 * | wc -l
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
