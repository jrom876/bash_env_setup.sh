#!/bin/bash

# File Name:		custom.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
# Contact:		cesllc876@gmail.com
#			admin@jrom.io
# Github Page:		www.github.com/jrom876/setup_env/zsetup/custom.sh
#
############################################
### PURPOSE: CODE DEVELOPMENT EFFICIENCY ###
############################################

# These are aliases customized for the developer's convenience.
# They should be modified before use of this script in new systems.

# There are 2 COMMAND classes:

# 1) MOVE TO LOCATION COMMANDS
#	-- these scripts allow fast navigation between directory locations

# 2) COMPOUND COMMANDS
#	-- these scripts provide easy compilation and execution of
# 	   code for high-speed development

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
alias mroot='cd /'
alias mtetc='cd /etc/'

alias mtm='cd /media/$USER/; ls -la'
alias mts='cd ~/sandbox/; ls -la'

#################################
####### COMPOUND COMMANDS #######
#################################
## Laser Programs
alias ccgui='cd ~/laserDriver; \
		make -f make-gui.mk guion \
		cd $OLDPWD'
		
alias ccfui='cd ~/laserDriver; \
		python3 labjackgui.py'
		
alias cclaser='cd ~/laserDriver; \
		gcc -g -o laserPointer laserPointer.c -lm `pkg-config --cflags --libs gtk+-2.0`; \
		./laserPointer; \
		cd $OLDPWD'

alias ccprimeNums='cd ~/_files/primeNum; \
		g++ -g -o primeNum primeNum.cpp -lm; \
		./primeNum; echo;\
		cd $OLDPWD'
		
alias ccsciCalc='cd ~/sandbox/sciCalc-master/sciCalc; \
		make -f mc.mk; \
 		./main; \
		cd $OLDPWD'

## Python Programs
alias ccdtb='cd ~/sandbox/decToBinCalculator_master; \
		python3 decToBinCalc.py; \
		cd $OLDPWD'
alias cctp='cd ~/sandbox/Python_Person_master/TestPerson; \
		python3 TestPerson.py; \
		cd $OLDPWD'

## Coding Challenge 

alias cccc='cd ~/temp/coding_challenge; \
		python3 vlanout.py'

alias ccyycc='cd ~/temp/coding_challenge; \
		python3 -m pdb vlanout.py'
		
alias ccddcc='cd ~/temp/coding_challenge; \
		python3 driver1.py'
		
alias ccbapp='cd /var/www/CESApp; \
		sudo bash start.sh'	
				
alias ccfapp='cd /var/www/CESApp; \
		sudo docker cesapp.test'	
			
alias ccvapp='cd /var/www/TestApp; \
		sudo bash start.sh'
		
alias ccruise='cd ~/cruiseAuto; \
		python3 oldmycode.py'
			
alias ccintcalc='cd ~/intCalc; \
		python3 csvgen.py'
			
alias cczintcalc='cd ~/intCalc; \
		python3 top_gui.py'
		
alias ccmparse='cd ~/psetup; \
		python3 parse_input.py
		cd $OLDPWD'	

alias ccquil='cd ~/statics; \
		python3 equil.py
		cd $OLDPWD'

alias ccunits='cd ~/statics; \
		python3 units.py
		cd $OLDPWD'
			
####################################

ecxstom () {
	echo
	echo 'CUSTOM COMPOUND COMMANDS'; echo
	echo 'COMMANDS	EXPLANATION'
	echo 'ccbapp		sudo bash start.sh'
	echo 'cccc		python3 vlanout.py'
	echo 'ccyycc		python3 -m pdb vlanout.py'
	echo 'cclaser		./laserPointer'
	echo 'ccgui		make -f make-gui.mk guion'
	echo 'ccdtb		python3 decToBinCalc.py'
	echo 'ccprimeNums	~/_files/primeNum ./primeNum'
	echo 'ccsciCalc	~/sandbox/sciCalc-master/sciCalc make -f mc.mk; ./main'
	echo 'cctp		~/sandbox/Python_Person_master/TestPerson python3 TestPerson.py'
	echo 'ccruise		~/cruiseAuto python3 oldmycode.py'
	echo 'ccintcalc	~/intCalc python3 csvgen.py'
	echo 'cczintcalc	~/intCalc python3 top_gui.py'
	echo 'ccquil		~/statics python3 equil.py'
	echo 'ccunits		~/statics python3 units.py'; echo
}
	
####################################################

############################
####### GIT COMMANDS #######
############################
## https://www.linux.com/topic/desktop/introduction-using-git/

######################
### Clone git repo ###
## https://opensource.com/article/18/2/how-clone-modify-add-delete-git-files
gitClone () {
	git clone http://github.com/$1
}

#############################
### Checkout from My Repo ###

## https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging
gitchkout () {
	git checkout -b $1
}

# git branch

# git checkout

# git commit -a -m 'Create new footer [issue 53]'

# git checkout master

# Next, you have a hotfix to make. Let’s create a hotfix branch on which to work until it’s completed:

# git checkout -b hotfix
# Switched to a new branch 'hotfix'
# vim index.html
# git commit -a -m 'Fix broken email address'
# [hotfix 1fb7853] Fix broken email address
# 1 file changed, 2 insertions(+)

# You can run your tests, make sure the hotfix is what you want,
# and finally merge the hotfix branch back into your master branch
# to deploy to production. You do this with the git merge command:

# git checkout master
# git merge hotfix
# Updating f42c576..3a0874c
# Fast-forward
# index.html | 2 ++
# 1 file changed, 2 insertions(+)

# You’ll notice the phrase “fast-forward” in that merge.
# Because the commit C4 pointed to by the branch hotfix you merged in
# was directly ahead of the commit C2 you’re on, Git simply moves the
# pointer forward. To phrase that another way, when you try to merge
# one commit with a commit that can be reached by following the first
# commit’s history, Git simplifies things by moving the pointer forward
# because there is no divergent work to merge together — this is called a “fast-forward.”

# Your change is now in the snapshot of the commit pointed to
# by the master branch, and you can deploy the fix.

###################################
####### END OF GIT COMMANDS #######
###################################

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
