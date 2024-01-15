#!/bin/bash
# this file is subject to Licence
#Copyright (c) 2024, Acktarius
##################################################################
#  get API key and  credentials
##################################################################
#Working directory
wdir="/opt/AlphNodeSwagExt"
cd $wdir
#Declaratons
bold=$(tput bold)
normal=$(tput sgr0)
zenwarn() {
zenity --warning --timeout=12 --text="$@"
}
zeninfo() {
zenity --info --timeout=12 --text="$@"
}
zenques() {
	zenity --question --timeout=12 --text="$@"
}
zenerror() {
	zenity --error --timeout=12 --text="$@"
}
#MAIN
if [[ -f .data ]]; then
	if (zenques "data file already exist.\nDo you want to delete it?"); then
		rm -f .data
		exit
	fi
else	
value=$(zenity --entry \
--title="Enter IP of the Node" \
--text="IP Address" \
--entry-text="xxx.yyy.z.w")
case $? in
	0)
	if [[ ! $value =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
	zenity --warning --text="IP format incorrect!" &
	else
		if [[ $(echo "$(ping -c 2 -q $value | grep -c -E "(^| )0% packet loss")") -gt "0" ]]; then
	zeninfo "IP format is correct and ping successful" &
	echo "$value" > .data
		else
	zenerror "ping on this IP was not successful" &
		fi
	fi
	;;
	1)
	zeninfo "nothing done bye!" &
	;;
	*)
	zenerror "something went wrong" &
	;;
esac

fi

exit
