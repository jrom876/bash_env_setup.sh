#!/bin/bash

# File Name:		fwriter.sh
# Written by:		Jacob Romero
#			Creative Engineering Solutions, LLC
#			jrom876@gmail.com
# Contact:		cesllc876@gmail.com
# Github Page:		www.github.com/jrom876
#
####################################
### PURPOSE: FILE WRITER UTILITY ###
####################################

##	This utility contains custom text document handlers 
##	for opening and manipulating various text files.
##
##	These commands should be modified before use in new systems.

####################
#### REFERENCES ####
## https://ask.libreoffice.org/en/question/47273/open-new-file-from-command-line/
####################

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

#######################
shopt -s expand_aliases
#######################
########################
### GLOBAL VARIABLES ###
########################

#################################
####### TABLE OF CONTENTS #######
#################################
ecwriter () {
	echo 
	echo 'WELCOME TO FILE WRITER UTILITY'; echo
	echo 'This utility provides custom custom text document handlers which '
	echo 'allow the user to call specific text files using libreoffice'; echo
	echo '===================================================='
	echo 'PREFIX USAGE'
	echo 'zw- 			writeable docs; current drafts, etc'
	echo 'zq-			password protected docs'
	echo 'zz-			read only docs; saved as is'
	echo '===================================================='
	echo 'COMMANDS		EXPLANATION'; echo
	echo 'zwriter $1 &		opens $1 in a subshell'
	echo '			<arg> should either be a file that exists in this dir,'
	echo '			or else you must provide an absolute path to the file'; echo
	echo 'zwelev			draft_2_14_20.odt'
	echo 'zwpoeticus		novordsec.odt'; echo	
}

## https://ask.libreoffice.org/en/question/47273/open-new-file-from-command-line/

########################################################################
##	zwriter:	Allows User to open libreoffice documents from the CLI 
##	Call:		zwriter mydoc.odt & 
##	Note:		using & at the end runs the process in a subshell 

alias zwriter='/usr/bin/libreoffice --writer --norestore &>uwriter.log'

################################
###  End of uwriter.sh  ###
################################
