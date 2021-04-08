#!/bin/bash

# File Name:		anacron.sh
# Written by:		Jacob Romero
#					Creative Engineering Solutions, LLC
# Contact:			cesllc876@gmail.com
#					admin@jrom.io
# Github Page:		www.github.com/jrom876
#
##################################
####### PURPOSE: CRON JOBS #######
##################################

## Custom cron job scripts

##################################
shopt -s expand_aliases
##################################

ecacron () {
	echo
	#~ echo 'COMMAND LIST FOR:	anacron.sh'; echo
	echo 'WELCOME TO ANACRON AND CRON UTILITY'; echo
	echo 'This utility allows authorized users to modify, test '
	echo 'and verify anacron and cron jobs'; echo
	#~ echo 'ANACRON AND CRON COMMANDS'; echo
	echo '~~~~~~~ ANACRON ~~~~~~~'; echo
	echo 'mtanacron	cd ~/.local/etc; ls -la';echo
	echo 'edacron		sudo nano anacrontab'
	echo 'edahourly	cd ~/.local/etc/cron.hourly; sudo nano example'
	echo 'edadaily	cd ~/.local/etc/cron.daily; sudo nano example';echo
	echo 'acronspool	anacron -T -t ~/.local/etc/anacrontab -S /home/jrom/.var/spool/anacron'
	echo 'rnacron		anacron -fn -t /home/jrom/.local/etc/anacrontab -S /home/jrom/.var/spool/anacron'
	echo 'setacron	anacron -t /home/jrom/.local/etc/anacrontab -S /home/jrom/.var/spool/anacron'; echo
	echo 'lstmp		ls -la /tmp/'
	echo 'rrtacron	restart anacron'
	echo 'clrtmp		rm -f /tmp/hello /tmp/yowza /tmp/logtest'
	echo 'llocal		ls -la /home/jrom/.local/etc'; echo
	echo '~~~~~~~ CRON ~~~~~~~'; echo
	echo 'mcrh		cd /etc/cron.hourly; ls -la'
	echo 'mcrd		cd /etc/cron.daily; ls -la'
	echo 'mcrw		cd /etc/cron.weekly; ls -la'; echo
	echo 'edcron		cd /etc/cron.d; sudo nano anacron'
	echo 'eddaily		cd /etc/cron.daily; sudo nano 0anacron'
	echo 'edhourly	cd /etc/cron.hourly; sudo nano 0anacron'; echo
	echo 'lscron		ls /etc/cron*'
	echo 'rrtcron		restart cron'; echo
}

alias mcrh='cd /etc/cron.hourly; ls -la'
alias mcrd='cd /etc/cron.daily; ls -la'
alias mcrw='cd /etc/cron.weekly; ls -la'

#################
#### ANACRON ####
#################

alias mtanacron='cd ~/.local/etc; ls -la'
edacron () {
	cd ~/.local/etc;
	sudo nano anacrontab
}
edahourly () {
	cd ~/.local/etc/cron.hourly;
	sudo nano example
}
edadaily () {
	cd ~/.local/etc/cron.daily;
	sudo nano example
}
acronspool () {
	echo 'Silence is success';
	anacron -T -t ~/.local/etc/anacrontab -S /home/jrom/.var/spool/anacron
}
rnacron () {
	anacron -fn -t /home/jrom/.local/etc/anacrontab \
	-S /home/jrom/.var/spool/anacron
}
setacron () {
	anacron -t /home/jrom/.local/etc/anacrontab \
	-S /home/jrom/.var/spool/anacron
}
rrtcron () {
	sudo service cron restart;
	systemctl status cron
}
rrtacron () {
	sudo service anacron restart
	systemctl status anacron
}
#~ alias rrtcron ='sudo service cron restart'
alias lstmp='ls -la /tmp/; cat /tmp/hello; cat /tmp/yowza; cat /tmp/logtest'
alias clrtmp='rm -f /tmp/hello /tmp/yowza /tmp/logtest'
alias llocal='ls -a /home/jrom/.local/etc'

##############
#### CRON ####
##############

alias lscron='ls /etc/cron*'
edcron () {
	cd /etc/cron.d;
	sudo nano anacron
}
eddaily () {
	cd /etc/cron.daily;
	sudo nano 0anacron
}
edhourly () {
	cd /etc/cron.hourly;
	sudo nano 0anacron
}

################
## REFERENCES ##
################
## https://www.tecmint.com/create-and-manage-cron-jobs-on-linux/
## https://www.cyberithub.com/simple-easy-crontab-command-examples-in-linux-to-schedule-cron-jobs/
## https://opensource.com/article/21/2/linux-automation?utm_medium=Email&utm_campaign=weekly&sc_cid=7013a000002vqnQAAQ
## https://linuxize.com/post/scheduling-cron-jobs-with-crontab/
## https://www.tecmint.com/cron-vs-anacron-schedule-jobs-using-anacron-on-linux/
## https://www.lifewire.com/crontab-linux-command-4095300

## https://stackoverflow.com/questions/418896/how-to-redirect-output-to-a-file-and-stdout
## https://www.8bitavenue.com/how-to-open-url-in-linux-by-command-line/
## xdg-open https://www.8bitavenue.com

## Linux Directory Structure
## https://www.howtogeek.com/117435/htg-explains-the-linux-directory-structure-explained/

######################
#### Exerpt From: ####
## https://opensource.com/article/21/2/linux-automation?utm_medium=Email&utm_campaign=weekly&sc_cid=7013a000002vqnQAAQ

## Many Linux systems come bundled with a few maintenance jobs for cron 
## to perform. I like to keep my jobs separate from the system jobs, so 
## I create a directory in my home directory. Specifically, there's a 
## hidden folder called ~/.local ("local" in the sense that it's 
## customized for your user account rather than for your "global" 
## computer system), so I create the subdirectory etc/cron.daily to 
## mirror cron's usual home on my system. You must also create a spool 
## directory to keep track of the last time jobs were run.

## mkdir -p ~/.local/etc/cron.daily ~/.var/spool/anacron
## mkdir -p ~/.local/etc/cron.weekly
## mkdir -p ~/.local/etc/cron.custom

## You can place any script you want to run regularly into the 
## ~/.local/etc/cron.daily directory. Copy the example script into the 
## directory now, and mark it executable using the chmod command.

## cp example ~/.local/etc/cron.daily
## #chmod +x ~/.local/etc/cron.daily/example

## Next, set up anacron to run whatever scripts are located in the ~/.local/etc/cron.daily directory.


#~ By default, much of the cron system is considered the systems administrators 
#~ domain because its often used for important low-level tasks, like 
#~ rotating log files and updating certificates. 
#~ The configuration demonstrated in this article is designed for a 
#~ regular user setting up personal automation tasks.

#~ To configure anacron to run your cron jobs, create a configuration file at 

#~ /.local/etc/anacrontab:

#~ SHELL=/bin/sh
#~ PATH=/sbin:/bin:/usr/sbin:/usr/bin
#~ 1  0  cron.mine    run-parts /home/tux/.local/etc/cron.daily/

#~ This file tells anacron to run all executable scripts (run-parts) 
#~ found in ~/.local/etc/cron.daily every one day (that is, daily), 
#~ with a zero-minute delay. Sometimes, a few minutes delay is used so 
#~ that your computer isnt hit with all the possible tasks right after you log in. 
#~ These settings are suitable for testing, though.

#~ The cron.mine value is an arbitrary name for the process. 
#~ I call it cron.mine but you could call it cron.personal or penguin or anything you want.

#~ Verify your anacrontab files syntax:

#~ anacron -T -t ~/.local/etc/anacrontab \
#~ -S /home/tux/.var/spool/anacron

#~ Silence means success.


## https://opensource.com/article/21/2/linux-automation?utm_medium=Email&utm_campaign=weekly&sc_cid=7013a000002vqnQAAQ

################################
#~ Adding anacron to .profile

#~ Finally, you must ensure that anacron runs with your local configuration. 
#~ Because youre running anacron as a regular user and not as the root user, 
#~ you must direct it to your local configurations —the anacrontab file 
#~ telling anacron what to do, and the spool directory helping anacron keep 
#~ track of how many days its been since each job was last executed:

#~ anacron -fn -t /home/jrom/.local/etc/anacrontab \
#~ -S /home/jrom/.var/spool/anacron
#~ or
#~ anacron -fn -t /home/jrom/.local/etc/anacrontab -S /home/jrom/.var/spool/anacron

#~ The -fn options tell anacron to ignore timestamps, meaning that youre 
#~ forcing it to run your cron job no matter what. 
#~ This is exclusively for testing purposes.

################################
#~ Testing your cron job

#~ Now that everythings set up, you can test the job. 
#~ You can technically test this without rebooting, but it makes the 
#~ most sense to reboot because thats what this is designed to handle: 
#~ interrupted and irregular login sessions. 
#~ Take a moment to reboot your computer, log in, and then look for the test file:

#~ ls /tmp/hello
#~ /tmp/hello

#~ Assuming the file exists, your example script has executed successfully. 
#~ You can now remove the test options from ~/.profile, 
#~ leaving this as your final configuration:

#~ anacron -t /home/tux/.local/etc/anacrontab \
#~ -S /home/tux/.var/spool/anacron

#########################################

#~ Using anacron

#~ You have your personal automation infrastructure configured, so you can 
#~ place any script you want your computer to manage for you into the 
#~ ~/.local/etc/cron.daily directory and it will run as scheduled.

#~ Its up to you how often you want jobs to run. Your example script is 
#~ executed once a day. Obviously, that depends on whether your computer 
#~ is powered on and awake on any given day. If you use your computer on 
#~ Friday but set it aside for the weekend, the script wont run on Saturday and Sunday. 
#~ However, on Monday the script will execute because anacron will know 
#~ that at least one day has passed. You can add weekly, fortnightly, or 
#~ even monthly directories to ~/.local/etc to schedule a wide variety of intervals.

#~ To add a new interval:

#~ 1. Add a directory to ~/.local/etc (for instance, cron.weekly).
#~ 2. Add a line to ~/.local/etc/anacrontab to run scripts in the new directory. For a weekly interval, the configuration would be:
#~ 3. 7 0 cron.mine run-parts /home/tux/.local/etc/cron.weekly/ (with the 0 value optionally being some number of minutes to politely delay the start of the script).
#~ 4. Place your scripts in the cron.weekly directory.

#~ Welcome to the automated lifestyle. It wont feel like it, but youre about to become a lot more productive.

#### End of Exerpt ####

########################################
####### Construction Zone #######

#################################
####### TIME ZONE UTILITY #######
#################################
## https://askubuntu.com/questions/54364/how-do-you-set-the-timezone-for-crontab
## https://www.tecmint.com/set-time-timezone-and-synchronize-time-using-timedatectl-command/
alias settzdata='sudo dpkg-reconfigure tzdata'

#~ sudo dpkg-reconfigure tzdata
#~ sudo service cron restart
#~ timedatectl

####### End of Construction Zone #######
##########################################
