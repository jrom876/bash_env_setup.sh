#!/bin/bash

# File Name:		rmt.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876
#
###############
### PURPOSE ### 
# To provide custom aliases and functions 
# for remote tools such as screen and docker.

###############################
####### SCREEN COMMANDS #######
###############################
## See: https://www.tecmint.com/screen-command-examples-to-manage-linux-terminals/

### Follow these steps to properly enter and exit SCREEN shell:
##########
## Step 1: enter screen shell using
alias scr='screen'
##########
## Step 2: load SCREEN ENVIRONMENT by entering

scenv () {
	PS1="==> SCREEN \w ==>:\$ "
}
##########
## Step 3: list currently running screen processes to verify that we
## have a screen instance running.
alias scls='screen -ls'
##########
## Step 4: choose a function below to open a screen instance for
## viewing data on a specific port.
## For USB ports:
## arg1 = USB port number, arg2 = baud rate
## e.g.: 'scusb 0 9600' opens a screen to USB0 at 9600 baud rate
scusb () {
	sudo screen /dev/ttyUSB$1 $2
}
## For any ports:
## arg1 = port number, arg2 = baud rate
## e.g.: 'scusb ttyS0 115200' opens a screen to ttyS0 at 115200 baud rate
scport () {
	sudo screen /dev/$1 $2
}
##########
## Step 5: closing screen instances (3 steps involved)
## a) Run 'scls' or 'screen -ls' to see what screen processes are running.
## b) Then run 'scquit <arg1>' for each instance we are closing.
## arg1 is process ID which we will close, shown on 'scls' command.
scquit () {
	screen -X -S $1 quit
}

## To view USB ports at any point, run 'getTTy' or 'lsusb'.

## NOTE: If we are done closing processes, we can exit SCREEN shell by entering:
##		'Ctl-a', then 'k', then 'y' at prompt
## which shows:	"[screen is terminating]"
##			or
## 		'Ctl-d'
## if not	showing "[screen is terminating]"

## Once we see "[screen is terminating]", we are
## back in bash shell, but we need to enter:
##		. ./setup.sh
## to return to our custom bash CLI environment.

## d) Usually the Arduino Serial Monitor will still not have access
## to the USBx port, so we must kill the process running on that port.
## Thus we must now run 'kusb <arg1>' where arg1 is the USB port in Step 4,
## which kills the process currently running on that port.
## e.g: entering 'kusb 0' causes process on ttyUSB0 to terminate.
kusb () {
	sudo fuser -k /dev/ttyUSB$1
}
kport () {
	sudo fuser -k /dev/$1
}

####### Switching Between Sreens #######
# 'Ctl-a'	'd'		detatch screen
# 'Ctl-a'	'r'		reattatch screen
# 'Ctl-a $1'	'r'		reattatch specific screen
# 'Ctl-a'	'n'		view next screen
# 'Ctl-a'	'p'		view previous screen
# 'Ctl-a'	'c'		new screen
# 'Ctl-a'	'k' 'y'		kill screen
########################################

######################################
####### END OF SCREEN COMMANDS #######
######################################

###############################
####### DOCKER COMMANDS #######
###############################

### Do this on initial setup/install ###
## To avoid typing sudo for docker commands, type:
## 		sudo usermod -aG docker ${USER}
## To apply the new group membership,
## log out of the server and back in, or type:
## 		su - ${USER}

alias dci='sudo docker images'
alias dcps='sudo docker ps -a'

dct () {
	sudo docker run -it $1 sh
}
dcrun () {
	sudo docker run $1
}
dcrm () {
	sudo docker rm $@
}

####### CAUTION USING THESE COMMANDS #######
## Deletes all exited containers
alias dcra='sudo docker rm $( docker ps -a -q -f status=exited )'

## CAUTION!! Removes all stopped containers
alias dcprune='docker container prune'

##################################
#######  End of custom.sh  #######
##################################

