#!/bin/bash

# File Name:		custom.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876/setup_env/zsetup/custom.sh
#
####################################################
####### PURPOSE: CODE DEVELOPMENT EFFICIENCY #######
####################################################

# These are aliases customized for the developer's convenience.
# They should be modified before use of this script in new systems.

# There are 4 COMMAND classes:

# 1) MOVE TO LOCATION COMMANDS
#	-- these scripts allow fast navigation between directory locations

# 2) COMPOUND COMMANDS
#	-- these scripts provide easy compilation and execution of
# 	   code for high-speed development

# 3) WEB COMMANDS (IN DEVELOPMENT)
#	-- these scripts will open various web pages quickly using xdg-open
#
#	https://www.8bitavenue.com/how-to-open-url-in-linux-by-command-line/
#	xdg-open https://www.8bitavenue.com

# 4) GIT COMMANDS (IN DEVELOPMENT)
#	-- these scripts will automate some of the git functions

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
#######################################################
### MOVE TO LOCATION COMMANDS ###
# CAUTION: Do not create any commands using "mtr"
#######################################################
# main locations #
alias mth='cd ~/'
alias mtftp='cd /home/ftpuser/'
alias mtsftp='cd /home/sftpuser/'
alias mroot='cd /'
alias mtetc='cd /etc/'

#################################
####### COMPOUND COMMANDS #######
####### WARNING!! #######
## ccx- prefixed commands are hereby resrerved for xdg-open commands 
#################################

#################################

## These are examples only to demonstrate the basics of calling compiler functions
## using custom bash scripts

## Laser Programs
alias ccgui='cd ~/laserDriver; \
		make -f make-gui.mk guion \
		cd $OLDPWD'
		
alias cclaser='cd ~/laserDriver; \
		gcc -g -o laserPointer laserPointer.c -lm `pkg-config --cflags --libs gtk+-2.0`; \
		./laserPointer; \
		cd $OLDPWD'
		
alias ccplus='cd ~/cruiseAuto/hacker; \
		g++ -o cplus cplus.cpp -lm -lrt; \

alias ccprimeNums='cd ~/_files/primeNum; \
		g++ -g -o primeNum primeNum.cpp -lm; \
		./primeNum; echo; \
		cd $OLDPWD'

###################################

## These examples show how to compile C/C++ programs and explicitly create:
##		-- pre-processed files (.i extension)
##		-- assembly files (.s extension)
##		-- object files (.o extension)
##		-- posistionally independent executable files (.pie extension)
##		-- hex files (.hex extension)

## https://www.opensourceforu.com/2020/02/understanding-elf-the-executable-and-linkable-format/
## https://linux-audit.com/elf-binaries-on-linux-understanding-and-analysis/

alias cvlaser='cd ~/laserDriver; \
		gcc -g -o laserPointer laserPointer.c -lm `pkg-config --cflags --libs gtk+-2.0`; \
		gcc -E laserPointer.c -o laserPointer.i; \
		gcc -S laserPointer.c -fverbose-asm -o laserPointer.s; \
		gcc -c laserPointer.c -o laserPointer.o; \
		gcc -pie laserPointer.c -o laserPointer.pie -lm; \
		readelf -h laserPointer; \
		objcopy -O ihex laserPointer laserPointer.hex; \
		echo; \
		./laserPointer'

alias cvprimeNums='cd ~/_files/primeNum; \
		g++ -g -o primeNum primeNum.cpp -lm; \
		g++ -E primeNum.cpp -o primeNum.i; \
		g++ -S primeNum.cpp -fverbose-asm -o primeNum.s; \
		g++ -c primeNum.cpp -o primeNum.o; \
		g++ -pie primeNum.cpp -o primeNum.pie; \
		readelf -h primeNum; \
		objcopy -O ihex primeNum primeNum.hex; \
		echo; \
		./primeNum; echo'

#######################
####### SciCalc #######
		
alias ccsciCalc='cd ~/sandbox/sciCalc-master/sciCalc; \
		make -f mc.mk; \
 		./main; \
		cd $OLDPWD'
		
alias cctest='cd ~/sandbox/sciCalc-master/sciCalc; \
		checkmk lbtest.check >lbtest.c; \
		gcc -g -o lbtest lbtest.c -lcheck -lm -lpthread -lrt -lsubunit -lcheck_pic; \
		checkmk bpf2test.check >bpf2test.c; \
		gcc -g -o bpf2test bpf2test.c -lcheck -lm -lpthread -lrt -lsubunit -lcheck_pic; \
		checkmk inrushItest.check >inrushItest.c; \
		gcc -g -o inrushItest inrushItest.c -lcheck -lm -lpthread -lrt -lsubunit -lcheck_pic; \
		checkmk ustripZtest.check >ustripZtest.c; \
		gcc -g -o ustripZtest ustripZtest.c -lcheck -lm -lpthread -lrt -lsubunit -lcheck_pic'
	
####################################################

################################
####### XDG-OPEN UTILITY #######
################################
## NOTE: These ccx- commands are best used when a browser is already open

##	https://www.8bitavenue.com/how-to-open-url-in-linux-by-command-line/
##	xdg-open https://www.8bitavenue.com

alias ccx8bit='xdg-open https://www.8bitavenue.com/how-to-open-url-in-linux-by-command-line/ &'
alias ccxlinux='xdg-open https://www.howtogeek.com/117435/htg-explains-the-linux-directory-structure-explained/'
alias ccxacron='xdg-open https://opensource.com/article/21/2/linux-automation?utm_medium=Email&utm_campaign=weekly&sc_cid=7013a000002vqnQAAQ'
alias ccxchrome='chromium-browser'
alias ccxgithub='xdg-open https://github.com/jrom876'

#####################################
### Raspberry Pi Web Server Setup ###
#####################################
## https://thepihut.com/blogs/raspberry-pi-tutorials/
## how-to-change-the-default-account-username-and-password
## https://thepi.io/how-to-set-up-a-web-server-on-the-raspberry-pi/
## https://www.raspberrypi.org/documentation/configuration/security.md

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

##################################
#######  End of custom.sh  #######
##################################
