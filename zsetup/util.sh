#!/bin/bash

# File Name:		util.sh
# Written by:		Jacob Romero
#					Creative Engineering Solutions, LLC
# Contact:			cesllc876@gmail.com
#					admin@jrom.io
# Github Page:		www.github.com/jrom876
#
#########################################
####### PURPOSE: SYSTEM UTILITIES #######
#########################################

##	This file contains utilities and commands for: 

##	-- cooling fan settings
##	-- crash dumps
##	-- clamav and clamtk antivirus tools
## 	-- the PS1 variable (in development)
##	-- xrandr screen utility
##	-- xinput device utility
##	-- symbolic links (symlinks)

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

####################
#### REFERENCES ####
####################

## clamav
## https://askubuntu.com/questions/114000/how-to-update-clamav-definitions-database


## https://www.howtogeek.com/117435/htg-explains-the-linux-directory-structure-explained/
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

## Linux Directory Structure
## https://www.howtogeek.com/117435/htg-explains-the-linux-directory-structure-explained/

#######################
shopt -s expand_aliases
#######################

########################
### GLOBAL VARIABLES ###
export degrees
degrees="°"
export MY_FAN_SPEED
MY_FAN_SPEED=$( cat /sys/devices/pwm-fan/target_pwm )
########################

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
	echo '			fanmod max for max  125'
	echo '			fanmod min for min  100'
	echo '			fanmod mid for mid  113'
	echo '			fanmod d   for default  120'; echo
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
##				Jetson Nano cooling fan speed setting
##	Call:		fanmod <arg=fanspeed> (password required)
##	Requires:	$1 -- set <arg> between 100 and 125 for best results

fanmod() {
	echo 'WELCOME TO FAN SPEED UTILITY -- MODIFIER'
	if [ -z $1 ]; then
		echo 'Invalid entry: Exiting FAN SPEED UTILITY '
	elif [ $1 = 'd' ]; then							
		sudo sh -c "echo 120 > /sys/devices/pwm-fan/target_pwm"
		MY_FAN_SPEED=$( cat /sys/devices/pwm-fan/target_pwm )
		echo; echo "Fan speed has been reset to 120 (default)"
		echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
		extemp; echo
		echo 'Enter extemp to display CPU temps'
		echo 'Enter gtfanspeed to display fan speed'
	elif [ $1 = 'super' ]; then							
		sudo sh -c "echo 130 > /sys/devices/pwm-fan/target_pwm"
		MY_FAN_SPEED=$( cat /sys/devices/pwm-fan/target_pwm )
		echo; echo "Fan speed has been set to 130 (super)"
		echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
		extemp; echo
		echo 'Enter extemp to display CPU temps'
		echo 'Enter gtfanspeed to display fan speed'
	elif [ $1 = 'max' ]; then							
		sudo sh -c "echo 125 > /sys/devices/pwm-fan/target_pwm"
		MY_FAN_SPEED=$( cat /sys/devices/pwm-fan/target_pwm )
		echo; echo "Fan speed has been set to 125 (max)"
		echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
		extemp; echo
		echo 'Enter extemp to display CPU temps'
		echo 'Enter gtfanspeed to display fan speed'
	elif [ $1 = 'min' ]; then							
		sudo sh -c "echo 100 > /sys/devices/pwm-fan/target_pwm"
		MY_FAN_SPEED=$( cat /sys/devices/pwm-fan/target_pwm )
		echo; echo "Fan speed has been set to 100 (min)"
		echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
		extemp; echo
		echo 'Enter extemp to display CPU temps'
		echo 'Enter gtfanspeed to display fan speed'
	elif [ $1 = 'mid' ]; then							
		sudo sh -c "echo 113 > /sys/devices/pwm-fan/target_pwm"
		MY_FAN_SPEED=$( cat /sys/devices/pwm-fan/target_pwm )
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
				MY_FAN_SPEED=$( cat /sys/devices/pwm-fan/target_pwm )
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
					MY_FAN_SPEED=$( cat /sys/devices/pwm-fan/target_pwm )
					echo; echo "Fan speed has been successfully set to $newvalue"
					echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
					extemp; echo					
					echo 'Enter extemp to display CPU temps'
					echo 'Enter gtfanspeed to display fan speed'
				fi			
			elif [ $answer == 'd' ]; then 				
				sudo sh -c "echo 120 > /sys/devices/pwm-fan/target_pwm"
				MY_FAN_SPEED=$( cat /sys/devices/pwm-fan/target_pwm )
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
			MY_FAN_SPEED=$( cat /sys/devices/pwm-fan/target_pwm )
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
#					converts the thermal-fan temp1 reading from °C 
#					to °F for the convenience of Americans and Brits
##	Call:			fanstatus
##	Requires:		None
##	Dependencies:	sensors
##					extemp
##					ctof (embedded python3)
##					python3 import os
##					python3 import math 

fanstatus () {
	echo "Fan Speed:	$( echo $MY_FAN_SPEED )"
	extemp; echo
	#~ echo 'fanmod $1	To modify Jetson Nano cooling fan speed setting'
	#~ echo '		The suggested <arg> range is 100-125. Default is 120'
	#~ echo '		Call:	fanmod <fanspeed>  for fanspeed'
	#~ echo '			fanmod max for max  125'
	#~ echo '			fanmod min for min  100'
	#~ echo '			fanmod mid for mid  113'
	#~ echo '			fanmod d   for default  120'; echo
	#echo 'Use:	ctof <temp in degrees C> 	to convert temp from c to f'
}

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	extemp():		Extracts ilwifi and fantemp readings from sensors, 
##					converts them from °C to °F for the convenience of 
##					Americans and Brits, places them in global 
##					environment vars, and displays them in stdout
##	Call:			extemp
##	Requires:		sensors

extemp () {
	## Extract ilwifi and fantemp readings from sensors
	local tempo=$( sensors | grep -e "temp1" )
	local ilwifi="${tempo#*\+}"
	ilwifi="${ilwifi%%\°*}"	
	local fantemp="${tempo##*\+}"
	fantemp="${fantemp%\°*}"
	
	## Create and instantiate global env temp vars, and convert temps
	export ILWIFI_TEMP_C
	ILWIFI_TEMP_C="${ilwifi}°C"
	export ILWIFI_TEMP_F
	ILWIFI_TEMP_F=$( ctof $ilwifi )
	ILWIFI_TEMP_F=$ILWIFI_TEMP_F	
	export THERMAL_FAN_TEMP_C
	THERMAL_FAN_TEMP_C="${fantemp}°C"	
	export THERMAL_FAN_TEMP_F
	THERMAL_FAN_TEMP_F=$( ctof $fantemp )
	THERMAL_FAN_TEMP_F=$THERMAL_FAN_TEMP_F
	
	## Display converted temp values in stdout
	local vargo0=$( ctof $ilwifi )
	echo "ilwifi temp1:        $ilwifi°C  =  $vargo0"
	local vargo1=$( ctof $fantemp )
	echo "thermal-fan temp1:   $fantemp°C  =  $vargo1"
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
		print("{0:.1f}°F ".format(result))
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

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
##	gtfanspeed():	Displays Fan Speed
##	Call:			gtfanspeed
##	Requires:		None

gtfanspeed () {
	echo "Fan Speed:	$( cat /sys/devices/pwm-fan/target_pwm )"
}

## Experimental
wyytemp () {
	local senso=$( sensors | grep -e "temp1" )	
	local senso0="${senso#*\+}"
	senso0="${senso0%%\°*}"
	#~ echo "senso0 = $senso0"	
	export ILWIFI_TEMP_C
	ILWIFI_TEMP_C="+${senso0}°C"
	#~ echo "ILWIFI_TEMP_C = $ILWIFI_TEMP_C"	
	export ILWIFI_TEMP_F
	ILWIFI_TEMP_F=$( ctof $senso0 )
	ILWIFI_TEMP_F="$ILWIFI_TEMP_F"
	#~ echo "ilwifi temp1:        +$senso0°C  =  $ILWIFI_TEMP_F"	
	THERMAL_FAN_TEMP_C="+${senso##*\+}"
	export THERMAL_FAN_TEMP_C
	#~ echo "THERMAL_FAN_TEMP_C = $THERMAL_FAN_TEMP_C"	
	local senso1="${senso##*\+}"
	senso1="${senso1%\°*}"	
	THERMAL_FAN_TEMP_F=$( ctof $senso1 )
	THERMAL_FAN_TEMP_F=$THERMAL_FAN_TEMP_F
	export THERMAL_FAN_TEMP_F
	#~ echo "thermal-fan temp1:   +$THERMAL_FAN_TEMP_C=  $THERMAL_FAN_TEMP_F"	
	#~ echo 'wyytemp successful'
}

## SAVE ##
#~ zeetemp () {
	#~ local tempo=$( sensors | grep -e "temp1" )
	#~ local tempo0="${tempo#*\+}"
	#~ tempo0="${tempo0%%\°*}"
	#~ local tempo1="${tempo##*\+}"
	#~ tempo1="${tempo1%\°*}"
	#~ local vargo0=$( ctof $tempo0 )
	#~ echo "ilwifi temp1:        +$tempo0°C  =  $vargo0"
	#~ local vargo1=$( ctof $tempo1 )
	#~ echo "thermal-fan temp1:   +$tempo1°C  =  $vargo1"
#~ }

##################################
#### END OF FAN SPEED UTILITY ####
##################################


############################
#### CRASH DUMP UTILITY ####
############################

## PURPOSE:		To provide methods for storing, retrieving, and deleting
##				crash dumps and crash dump reports

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

###################################
#### END OF CRASH DUMP UTILITY ####
###################################

###############################
#### XRANDR SCREEN UTILITY ####
###############################
## https://askubuntu.com/questions/1043644/how-to-rotate-screen-in-ubuntu-using-terminal
## https://man.archlinux.org/man/xrandr.1

## This script rotates the screen and touchscreen
## Credits: Ruben Barkow-Kuder: https://gist.github.com/rubo77/daa262e0229f6e398766
## But I had to do some debug to get rubo77s code to work on my device

#### configuration
# find your Touchscreen device with `xinput`

function getscreen () {
	TouchscreenDevice="$(xrandr | grep primary | cut -d" " -f1)";
	echo "$TouchscreenDevice"
}

function rotatescreen () {
	TouchscreenDevice="$(xrandr | grep primary | cut -d" " -f1)";

	if [ "$1" = "--help"  ] || [ "$1" = "-h"  ] ; then
		echo 'Usage: rotate-screen [OPTION]'
		echo
		echo 'This script rotates the screen and touchscreen input 90 degrees each time it is called,' 
		echo
		echo Usage:
		echo ' -h --help display this help'
		echo ' -r turn orientation 90° right'
		echo ' -l turn orientation 90° left'
		echo ' -i turn orientation 180°'
		echo ' -n (or no options) rotates the screen back to normal'
		#~ exit 0
	fi

	if [ "$1" == "-i" ]; then
	  echo "Upside down"
	  xrandr --output "$TouchscreenDevice" --rotate inverted
	elif [ "$1" == "-l" ]; then
	  echo "90° to the left"
	  xrandr --output "$TouchscreenDevice" --rotate left
	elif [ "$1" == "-r" ]; then
	  echo "90° to the right"
	  xrandr --output "$TouchscreenDevice" --rotate right
	else
	  echo "Back to normal"
	  xrandr --output "$TouchscreenDevice" --rotate normal
	fi
}

# with this script, you can simply call

# rotatescreen -r
# rotatescreen -l
# rotatescreen -i
# rotatescreen -n

######################################
#### END OF XRANDR SCREEN UTILITY ####
######################################

###############################
#### XINPUT SCREEN UTILITY ####
###############################
# find your Touchscreen device with `xinput`

function getdevice () {
	#~ Dev1="$(xinput | grep master | cut -d" " -f2,3,4)";
	Devs="$(xinput | grep master | cut -d" " -f2,3,4)";
	#~ FrontStrap="$(FrontStrap%master*)";
	#~ echo "$Dev1";
	#~ echo
	echo "$Devs";
	#~ echo;
	#~ yowza="$( echo $Devs | grep Virtual -m 1)"
	#~ InputDevice="$(xinput | grep master | cut -d" " -f1)";
	#~ InputDevice="$(xinput | grep master)";
	#~ InputDevice="${InputDevice#*'Virtual'}"
	#~ InputDevice=($InputDevice)
	#~ echo "$yowza"
}
#%.*
######################################
#### END OF XINPUT SCREEN UTILITY ####
######################################

###############################
#### SYMBOLIC LINK UTILITY ####
###############################
## Create symlinks
## https://linuxhandbook.com/hard-link/
## https://www.computerhope.com/issues/ch001638.htm
##	cmd:	ln -s target linkname
##	eg:		ln -s myfile.txt mylink


## $1 == target, $2 == linkname
function slinker () {
	ln -s $1 $2
}
######################################
#### END OF SYMBOLIC LINK UTILITY ####
######################################

###########################
### ENVIRONMENT OPTIONS ###
## Choose desired CLI environment by commenting/uncommenting
## one of the options below
# PS1="\w ==>:\$ "
# PS1="==> \w ==>:\$ "
# PS1="==> \t \w ==>:\$ "
# PS1="\u@\h:\w\$ " ## default
# PS1="\u@\t:\w\$ "
# PS1="\u \s \t \w:\$ "
# \u = user; \s = shell; \t = time; \h = host; \w = working directory
# \$ = shows '$' if logged in as user; shows '#' if logged in as root
# For more info on setting environment variables
# see: https://ss64.com/bash/syntax-prompt.html
# and: https://www.tutorialspoint.com/unix/unix-environment.htm
#

################################
####### THE PS1 VARIABLE #######
################################
## https://linoxide.com/change-bash-prompt-variable-ps1/
## https://www.linuxnix.com/linuxunix-shell-ps1-prompt-explained-in-detail

	#~ d - the date in "Weekday Month Date" format (e.g., "Tue May 26")

	#~ e - an ASCII escape character (033)

	#~ h - the hostname up to the first .

	#~ H - the full hostname

	#~ j - the number of jobs currently run in background

	#~ l - the basename of the shells terminal device name

	#~ n - newline

	#~ r - carriage return

	#~ s - the name of the shell, the basename of $0 (the portion following the final slash)

	#~ t - the current time in 24-hour HH:MM:SS format

	#~ T - the current time in 12-hour HH:MM:SS format

	#~ @ - the current time in 12-hour am/pm format

	#~ A - the current time in 24-hour HH:MM format

	#~ u - the username of the current user

	#~ v - the version of bash (e.g., 4.00)

	#~ V - the release of bash, version + patch level (e.g., 4.00.0)

	#~ w - Complete path of current working directory

	#~ W - the basename of the current working directory

	#~ ! - the history number of this command

	#~ ## - the command number of this command

	#~ $ - if the effective UID is 0, a #, otherwise a $

	#~ nnn - the character corresponding to the octal number nnn

	#~ \ - a backslash

	#~ [ - begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt

	#~ ] - end a sequence of non-printing characters


################################
### END OF SYSTEM UTILITIES  ###
################################
