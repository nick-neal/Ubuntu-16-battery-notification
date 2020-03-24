#!/usr/bin/env bash

##########
## Name: battery-notification.sh
## Author: Nicholas Neal (nwneal@kisoki.com)
## Description: 
## 			This is a small script that will install itself to cron
##			and run every minute, and check if your battery level is
##			low, and send an alert to your desktop if 15% or less.
##
## Dependencies: acpi, send-notify
## 
## Tested on Ubuntu Desktop 16.04.2 LTS and Ubuntu Desktop 18.04.4 LTS
##########

eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)";

# check if acpi and send-notify are installed.
if [ `dpkg -l | grep acpi | grep -v acpi-support | grep -v acpid | grep -c acpi` -ne 1 ]; then
	echo "run 'sudo apt install acpi' then run '$0' again."
	exit
fi

if [ $# -eq 1 ] && [ "$1" == "--install" ]; then
	echo "installing battery notifier..."
	
	if [ ! -e "$HOME/bin" ]; then
		mkdir $HOME/bin
	fi	
	
	cp $0 $HOME/bin/bn.sh
	(crontab -l 2>/dev/null; echo "*/2 * * * * $HOME/bin/bn.sh") | crontab -

else
	# check if power adapter is plugged in, if not, check battery status.
	if [ -z "`acpi -a | grep on-line`" ]; then
		batlvl=`acpi -b | grep -P -o '[0-9]+(?=%)'`

		if [ $batlvl -le 15 ] && [ $batlvl -ge 11 ]; then
			notify-send "Battery is at $batlvl%. Please plug your computer in."
		elif [ $batlvl -le 10 ] && [ $batlvl -ge 6 ]; then
			notify-send "Battery is at $batlvl%. Computer will shutdown at 5%."
		elif [ $batlvl -le 5 ]; then
			notify-send "BATTERY CRITICALLY LOW, SHUTTING DOWN IN 3 SECONDS!"
			sleep 3
			shutdown -h now
		fi
	fi	
fi
