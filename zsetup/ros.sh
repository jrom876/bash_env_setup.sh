#!/bin/bash

# File Name:		ros.sh
# Written by:		Jacob Romero
#					Creative Engineering Solutions, LLC
# Contact:			cesllc876@gmail.com
#					admin@jrom.io
# Github Page:		www.github.com/jrom876
#
################################
### PURPOSE: ROS DEVELOPMENT ###
################################

# This file is for automating and displaying ROS commands to 
# simplify robotics design for developers

###############################################################
# Change History

# 7/16/2021 Jacob Romero 		Original code 

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
#################################
####### TABLE OF CONTENTS #######
#################################
ecros () {
	echo 
	echo 'WELCOME TO ROS DESIGN UTILITY'; echo
	echo 'This utility provides bash scripts to simplify ROS design.'; echo
	echo '===================================================='
	echo 'Packages that you create should live together in a directory called
a workspace. For example, the author’s workspace is a directory called /home/jrom/ros, 
but you can name your workspace whatever you like, and store the directory any-
where in your account that you prefer. Use the normal mkdir command to create a direc-
tory. We’ll refer to this new directory as your workspace directory.'; echo
	echo 'e.g.	mkdir -p ~/ros/src/package-name'; echo
	echo 'The command to create a new ROS package, which should be run
from the src directory of your workspace, looks like this: '; echo
	echo 'catkin_create_pkg package-name'; echo 
	echo 'Actually, this package creation command doesn’t do much: It creates a directory to hold
the package and creates two configuration files inside that directory.
The first configuration file, called package.xml , is the manifest discussed in Sec-
tion 2.4.
The second file, called CMakeLists.txt , is a script for an industrial-strength cross-
platform build system called CMake. It contains a list of build instructions includ-
ing what executables should be created, what source files to use to build each of
them, and where to find the include files and libraries needed for those executables.
CMake is used internally by catkin.'; echo

	echo 'Once your CMakeLists.txt is set up, you can build your work-
space—including compiling all of the executables in all of its packages—using this com-
mand:'; echo 
	echo 'catkin_make'
	echo 'source devel/setup.bash'
	echo 'rosrun emacs hello'; echo

	echo '===================================================='
	echo 'ROS BUILTIN COMMANDS'; echo
	echo 'catkin_create_pkg package-name'; echo 
	echo  'rospack list
rospack find package-name (eg: rospack find turtle)
rosls package-name
roscd package-name
rosnode list
rosnode info node-name
rosnode kill node-name
rosparam list'; echo 
	echo '===================================================='
	echo 'CUSTOM ROS COMMANDS'; echo
	echo 'romove		move to my ros directory'
	echo '		cd ~/ros/src/emacs; ls -la'; echo 
	echo 'rocmake ()	1. This command opens CMakeLists.txt for editing.'	
	echo '		Find the following line in CMakeLists.txt and add your package-names:'; echo
	echo '		find_package(catkin REQUIRED COMPONENTS package-names)'; echo
	echo '		2. Next, we need to add two lines to CMakeLists.txt declaring 
		the executable we would like to create. The general form is:'; echo 
	echo '		add_executable(executable-name source-files)
		target_link_libraries(executable-name ${catkin_LIBRARIES})'; echo 

	echo  'ropkg ()	This command opens package.xml for editing.'
	echo '		Find the following line in package.xml and add your package-names:'; echo
	echo '		<build_depend>package-name</build_depend>
		<exec_depend>package-name</exec_depend>'; echo

	echo  'rolaunch ()	This command runs example.launch.'; echo
	echo '		It is currently set to run turtlesim/turtle_node and '
	echo '		turtlesim/turtle_teleop_key'; echo

	#~ echo  ''
	#~ echo  ''	
	echo  ''; echo
	
}
###############
## ROS stuff ##
###############

alias romove='cd ~/ros/src/emacs; \
				ls -la'

function rocmake () {
	cd ~/ros/src/emacs;
	nano CMakeLists.txt;
}

function ropkg () {
	cd ~/ros/src/emacs;
	nano package.xml;
}

function rolaunch () {	
	cd ~/ros/src/emacs;
	roslaunch example.launch;
}

######################################

#~ alias r1move='cd ~/rmac/src/emacs; \
				#~ ls -la'

#~ function r1cmake () {
	#~ cd ~/rmac/src/emacs;
	#~ nano CMakeLists.txt;
#~ }

#~ function r1pkg () {
	#~ cd ~/rmac/src/emacs;
	#~ nano package.xml;
#~ }

#~ alias r2move='cd ~/rmac/src/rmacs; \
				#~ ls -la'

#~ function r2cmake () {
	#~ cd ~/rmac/src/rmacs;
	#~ nano CMakeLists.txt;
#~ }

#~ function r2pkg () {
	#~ cd ~/rmac/src/rmacs;
	#~ nano package.xml;
#~ }

#~ Packages that you create should live together in a directory called
#~ a workspace. For example, the author’s workspace is a directory called /home/jokane-
#~ /ros , but you can name your workspace whatever you like, and store the directory any-
#~ where in your account that you prefer. Use the normal mkdir command to create a direc-
#~ tory. We’ll refer to this new directory as your workspace directory.



		#~ rospack list
		#~ rospack find package-name (eg: rospack find turtle)
		#~ rosls package-name
		#~ roscd package-name

#~ 		roscore
#~ 		rosrun package-name executable-name


#~ 		roscore
#~ 		rosrun turtlesim turtlesim_node
#~ 		rosrun turtlesim turtle_teleop_key

#~ 		rosnode list shows the following:
#~ /rosout
#~ /teleop_turtle
#~ /turtlesim

		#~ rosnode info node-name
		#~ rosnode kill node-name

#~ 		rqt_graph

#~ To get a list of active topics, use this command:
#~ 		rostopic list

#~ You can see the actual messages that are being published on a single
#~ topic using the rostopic command:
#~ 		rostopic echo topic-name
#~ 		eg: rostopic echo /turtle1/cmd_vel

#~ There are also two commands for measuring the speed at
#~ which messages are published and the bandwidth consumed by those messages:
#~ 		rostopic hz topic-name
#~ 		rostopic bw topic-name

#~ You can learn more about a topic using the rostopic info command:
#~ 		rostopic info topic-name
#~ For example, from this command:
#~ 		rostopic info /turtle1/color_sensor

#~ To see details about a message type, use a command like
#~ 		rosmsg show message-type-name
#~ Let’s try using it on the message type for /turtle1/color_sensor that we found above:
#~ 		rosmsg show turtlesim/Color
#~ The output is:
#~ uint8 r
#~ uint8 g
#~ uint8 b

#~ 		rostopic pub -r rate-in-hz topic-name message-type message-content
#~ This command repeatedly publishes the given message on the given topic at the given rate.
#~ The final message content parameter should provide values for all of the fields in the
#~ message type, in order. Here’s an example:
#~ 		rostopic pub -r 1 /turtle1/cmd_vel geometry_msgs/Twist ’[2, 0, 0]’ ’[0, 0, 0]’
#~ As you might guess, the messages generated by this example command the turtle to
#~ drive straight ahead (along its x-axis), with no rotation.

#~ Likewise, a command like this will command the robot to rotate in place about its z-
#~ axis (which is perpendicular to your computer’s screen):
#~ 		rostopic pub -r 1 /turtle1/cmd_vel geometry_msgs/Twist ’[0, 0, 0]’ ’[0, 0, 1]

#~ One final command line tool, which can be helpful when ROS is not behaving
#~ the way you expect, is roswtf, which can be run with no arguments.
#~ 		roswtf

#~ 		rosrun turtlesim turtlesim_node __name:=A
#~ 		rosrun turtlesim turtlesim_node __name:=B
#~ 		rosrun turtlesim turtle_teleop_key __name:=C
#~ 		rosrun turtlesim turtle_teleop_key __name:=D

#~ The command to create a new ROS package, which should be run
#~ from the src directory of your workspace, looks like this:
#~ 		catkin_create_pkg package-name


#~ 		catkin_make
#~ 		source devel/setup.bash
#~ 		rosrun emacs hello


#######################################
####### Construction Zone Pylon #######

####### End of Construction Zone Pylon #######
##############################################
