#!/bin/bash
# this file is subject to Licence
#Copyright (c) 2024, Acktarius
##################################################################
#  get API key and  credentials
##################################################################
#Declaratons
bold=$(tput bold)
normal=$(tput sgr0)
zenwarn() {
zenity --warning --timeout=12 --text="$@"
}
zeninfo() {
zenity --info --timeout=12 --text="$@"
}
#Working directory
wdir="/opt/AlphNodeSwagExt"
cd $wdir
#main
#check APIkey
if [[ -f APIkeygpg ]]; then
zenwarn "API key encrypted file already exist, to delete it:\nsudo rm -f APIkeygpg'\n \
and come back visit this script"

else	
api=$(zenity --entry --title="Add API key" --text="Enter your API key (it will be store encrypted)"  width=700 --timeout=45)
case $? in
	0)
	echo $api
	if [[  ${#api} -lt 32  ]]; then
	zenwarn "expecting 32 characters" &
	else
	echo "$api" | gpg -c > APIkeygpg
	fi
	;;
	1)
	zeninfo "nothing done bye!" &
	exit
	;;
	*)
	zenwarn "no answer received ...\ngoing to next step\nBut you'll have to enter it at some point"
	;;
esac

fi

#check Credentials
if [[ -f credentialsgpg ]]; then
zenwarn "credentials encrypted file already exist, delete it with\n sudo rm -f credentialsgpg\n \
and come back visit this script" 
else	
account=$(zenity --forms  --title="Add Account" --timeout=45 --text="enter account Name and Password" \
--add-entry="Account" \
--add-password="Password")
case $? in
	0)
	echo $account
	a=$(echo $account | cut -d "|" -f 1)
	p=$(echo $account | cut -d "|" -f 2)
	if ([[ -z $a ]] || [[ -z $p ]]); then
	zenwarn "one or both of the entry is empty" &
	exit 
	else
	echo "username=$a&passwd=$p" | gpg -c > credentialsgpg
	fi
	;;
	1)
	echo "nothing done bye!" 
	zenity --info --timeout=12 --text="nothing done bye!" &
	;;
	*)
	echo "something went wrong"
	;;
esac
fi
#launch second?
if [[ ! -f .data ]]; then
if $(zenity --question --text="No IP address recorded for miner\nDo you want to set up one?"); then
source second.sh
else
zenity --info --timeout=12 --text="Up to you, but you'll need one at some point" &
fi
fi


exit
