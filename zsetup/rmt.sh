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
###############

# To provide custom aliases and functions for remote tools 
## such as flask, screen and docker.

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

##############################
####### FLASK COMMANDS #######
###############################

## some fun stuff!!
## https://www.freecodecamp.org/news/how-to-build-a-web-application-using-flask-and-deploy-it-to-the-cloud-3551c985e492/

#cd my_flask_app
#python3 -m venv venv
#source venv/bin/activate
#pip install flask
#python -m flask --version

#export FLASK_APP=homeslice
#flask run

ecflask () {
	echo
	echo 'FLASK ROUTINE: Run the following commands to deploy a flask app.'; 
	echo 'Replace the my_flask_app variable with the name of the app you are running.'
	echo 'Verify the home variable has the same name as the templates/home.html file.'; echo;
	echo 'cd my_flask_app'
	echo 'python3 -m venv venv'
	echo 'source venv/bin/activate'
	echo 'export FLASK_APP=home'
	echo 'flask run'
	echo
	echo 'Or you can use these custom commands:'; echo;
	echo 'rnmyflask		this will run all 5 of the commands above (deploys my_flask_app)'; echo;
	echo 'rnexport		this will just run the last 2 commands above'; echo
	echo 'CTRL - C 		to end flask' echo
	echo 'rndeactivate		to exit venv' echo
}

rnmyflask () {
	cd my_flask_app
	python3 -m venv venv
	source venv/bin/activate
	export FLASK_APP=home
	flask run
}

rncesflask () {
	cd ces_flask_app
	python3 -m venv cesvenv
	source cesvenv/bin/activate
	export FLASK_APP=home
	flask run
}

## NOTE: CRTL + SHIFT + R does the same thing as rnexport
rnexport () {
	export FLASK_APP=home
	flask run
}

rndeactivate () {
	deactivate
	cd $OLDPWD
}

rnstartflask () {
	cd my_flask_app
	python3 -m venv venv
	source venv/bin/activate
}

## arg1 = name of directory where app is located
## e.g.: 	rnflask my_flask_app
rnflask () {
	cd $1
	python3 -m venv venv
	source venv/bin/activate
	export FLASK_APP=home
	flask run
}

shwflask () {
	myvar=$( python -m pip show flask | grep -F "Version" )
	echo "Flask $myvar"
}

#####################################
####### END OF FLASK COMMANDS #######
#####################################
## https://www.thegeekdiary.com/
## https://www.raspberrypi.org/blog/docker-comes-to-raspberry-pi/
## https://blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/
## https://www.digitalocean.com/community/tutorials/how-to-build-and-
## deploy-a-flask-application-using-docker-on-ubuntu-18-04
## https://github.com/gabeos/docker-flask-template
## https://www.docker.com/resources/what-container
###############################
####### DOCKER COMMANDS #######
###############################
### Do this on initial setup/install ###
## To avoid typing sudo for docker commands, type:
## 		sudo usermod -aG docker ${USER}
## To apply the new group membership,
## log out of the server and back in, or type:
## 		su - ${USER}

ecdocker () {
	echo
	echo 'DOCKER COMMANDS'; echo
	 
	echo 'dcim		sudo docker images			view all docker images'
	echo 'dcps		sudo docker ps -a			view all containers'
	echo 'dcinfo		sudo docker info			shows docker status'
	echo 'dcterm		sudo docker run -it $1 bash		opens interactive terminal'
	echo 'dcrun		sudo docker run $1			runs $1 container'
	echo 'dcrm $@		sudo docker rm $@			removes a container'
	echo 'dcart $1	sudo docker start $1			starts a container'
	echo 'dcstop $1	sudo docker stop $1			stops a container'
	echo 'dcend $1	sudo docker stop $1; docker rm $1	stops and removes a container'
	echo 'dctouch		sudo touch uwsgi.ini			reloads app homepage in browser'
	echo
}

alias dcim='sudo docker images'
alias dcps='sudo docker ps -a'
alias dcinfo='sudo docker info'

## creates interactive terminal
dcterm () {
	sudo docker run -it $1 bash
}
dcrun () {
	sudo docker run $1
}
dcart () {
	sudo docker start $1
}
dcstop () {
	sudo docker stop $1
}
dcrm () {
	sudo docker rm $@
}

dcend () {
	sudo docker stop $1; \
	docker rm $1
}

dctouch () {
	sudo touch uwsgi.ini
}


#################################################################
## https://www.raspberrypi.org/blog/docker-comes-to-raspberry-pi/
## https://blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/
## https://stackoverflow.com/questions/13772884/css-problems-with-flask-web-app

####### CAUTION USING THESE COMMANDS #######
## Deletes all exited containers
alias dcra='sudo docker rm $( docker ps -a -q -f status=exited )'

## CAUTION!! Removes all stopped containers
alias dcprune='docker container prune'


## nc -ip <network name> <server name>

## docker ps --format $FORMAT

## docker attach <container name>

## docker network create <new network name>
## docker run --rn -ti --<new network name> --name <put new server name here> ubuntu:18.04 bash

#DOCKERFORMAT=$( \nID\t{{.ID}}\nIMAGE\t{{.Image}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.RunningFor}}\nSTATUS\t{{.Status}}\nPORTS\t{{.Ports}}\nNAMES\t{{.Names}}\n )
## export $DOCKERFORMAT

## $FORMAT
## \nID\t{{.ID}}
## \nIMAGE\t{{.Image}}
## \nCOMMAND\t{{.Command}}
## \nCREATED\t{{.RunningFor}}
## \nSTATUS\t{{.Status}}
## \nPORTS\t{{.Ports}}
## \nNAMES\t{{.Names}}\n

######################################
####### END OF DOCKER COMMANDS #######
######################################

## https://www.digitalocean.com/community/tutorials/how-to-build-and-
## 		deploy-a-flask-application-using-docker-on-ubuntu-18-04

#To get started, you will create a directory structure that will hold 
#your Flask application. This tutorial will create a directory called 
#TestApp in /var/www, but you can modify the command to name it 
#whatever you’d like.

#sudo mkdir /var/www/TestApp


#Move in to the newly created TestApp directory:

#cd /var/www/TestApp

#Next, create the base folder structure for the Flask application:

#sudo mkdir -p app/static app/templates

#The -p flag indicates that mkdir will create a directory and 
#all parent directories that don’t exist. In this case, mkdir 
#will create the app parent directory in the process of making 
#the static and templates directories.


################################
####### NODE.JS COMMANDS #######
################################

## https://www.tecmint.com/create-first-nodejs-app-in-linux/
## https://www.tecmint.com/install-pm2-to-run-nodejs-apps-on-linux-server/

#sudo node /var/www/html/app/server.js
#sudo node /var/www/html/adminside/server.js
#sudo pm2 start /var/www/html/app/server.js
#sudo pm2 start /var/www/html/adminside/server.js

## Left off here in my js tutorial
## https://www.w3schools.com/js/js_array_iteration.asp

#######################################
####### END OF NODE.JS COMMANDS #######
#######################################

###############################
####### SCREEN COMMANDS #######
###############################
## See: https://www.tecmint.com/screen-command-examples-to-manage-linux-terminals/

ecscreen () {
	echo
	echo 'SCREEN REMOTE DATA VIEWER'; echo
	echo 'Follow these steps to properly enter and exit SCREEN.'; echo 
	echo 'STEP 1:	Enter 	scr	which opens the screen shell'; echo;
	echo 'STEP 2:	Enter 	scenv	which loads the "SCREEN" PS1 environment variable'; echo;
	echo 'STEP 3:	Enter	scls	which lists currently running screen processes, so we can verify '
	echo '	that we have a screen instance running'; echo;
	echo 'STEP 4:	Enter	scusb <arg1=USB port> <arg2=baud rate> ' 
	echo '	to open a screen instance for viewing data on a specific port'
	echo '	For USB ports:	arg1 = USB port number, arg2 = baud rate'
	echo '	e.g.: 	scusb 0 9600 	opens a screen to USB0 at 9600 baud rate'; echo
	echo 'STEP 5:	TO CLOSE, enter	Ctl-a, then k, then y at prompt'
	echo '	which shows [screen is terminating]'
	echo '	or enter'
	echo '	Ctl-d if not showing [screen is terminating]'

	echo '	Once we see "[screen is terminating]", we are back in the bash shell, but we need to enter:'
	echo '		. ./setup.sh '
	echo '	to return to our custom bash CLI environment.'; echo
	echo '	ALTERNATE CLOSE METHOD'
	echo '	a) Run		scls or screen -ls 	to see what screen processes are running.'
	echo '	b) Then run 	scquit <arg1> 		for each instance we are closing.'
	echo '	arg1 is process ID which we will close, shown on scls command.';echo
	echo 'STEP 6:	Enter	kusb or kport'
	echo '	Usually the Arduino Serial Monitor will still not have access to the USBx port, '
	echo '	so we must kill the process running on that port.'
	echo '	Thus we must now run 	kusb <arg1> 	where arg1 is the USB port in Step 4,'
	echo '	which kills the process currently running on that port.'
	echo '	e.g:	kusb 0 	causes process on ttyUSB0 to terminate.'
	echo
	echo '####### Switching Between Sreens #######;'
	echo 'Ctl-a		d		detatch screen'
	echo 'Ctl-a		r		reattatch screen'
	echo 'Ctl-a $1	r		reattatch specific screen'
	echo 'Ctl-a		n		view next screen'
	echo 'Ctl-a		p		view previous screen'
	echo 'Ctl-a		c		new screen'
	echo 'Ctl-a		k	y	kill screen'
}

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


##################################
#######  End of custom.sh  #######
##################################

## nc -ip <network name> <server name>



## docker ps --format $FORMAT

## docker attach <container name>

## docker network create <new network name>
## docker run --rn -ti --<new network name> --name <put new server name here> ubuntu:18.04 bash

#DOCKERFORMAT=$( \nID\t{{.ID}}\nIMAGE\t{{.Image}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.RunningFor}}\nSTATUS\t{{.Status}}\nPORTS\t{{.Ports}}\nNAMES\t{{.Names}}\n )
## export $DOCKERFORMAT

## $FORMAT
## \nID\t{{.ID}}
## \nIMAGE\t{{.Image}}
## \nCOMMAND\t{{.Command}}
## \nCREATED\t{{.RunningFor}}
## \nSTATUS\t{{.Status}}
## \nPORTS\t{{.Ports}}
## \nNAMES\t{{.Names}}\n

