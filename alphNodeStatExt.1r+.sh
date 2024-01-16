#!/bin/bash
# this file is subject to Licence
#Copyright (c) 2024, Acktarius
##################################################################
#  argos extension script for Alph Node
##################################################################
#Working directory  
wdir=/opt/AlphNodeSwagExt
#variables and declarations
declare -a dataArray
#functions
color (){
if [[ $(echo "$1 > $2" | bc -l ) = 1 ]]; then
echo "#FF7F50"
else
echo "#1fc600"
fi
}
#Check 1
if [[ ! -f $wdir/credentialsgpg ]] || [[ ! -f $wdir/APIkeygpg ]]; then
echo " :exclamation: | iconName=Alephium-logo"
echo "---"
echo "no credentials"
echo "Run script: <span color='#1fc600'><b><u>first.sh</u></b></span> | bash=/opt/AlphNodeSwagExt/first.sh terminal=false"
exit                                                   
fi
#Check 2
if [[ ! -f $wdir/.data ]]; then
echo " :exclamation: | iconName=Alephium-logo"
echo "---"
echo "no IP address on record"
echo "Run script <span color='#1fc600'><b><u>second.sh</u></b></span> | bash=/opt/AlphNodeSwagExt/second.sh terminal=false"
exit                                                   
fi
#get node info
data=$(. $wdir/miniAutoSwagger.sh)
read -a dataArray <<< $(echo $data)
# Time stamp + Status + Wallet Balance + Wallet balance locked = 5#param 
if [[ "${#dataArray[@]}" -lt 5 ]]; then
echo " :exclamation: | iconName=Alephium-logo"
echo "---"
echo "Error collecting data"
                                                  
else
now=$(date +%s)
delta=$(( $now - ${dataArray[0]}  ))

#extension
echo "| iconName=Alephium-logo"
echo "---"
echo "Core version   <span color='#4d4dff'>${dataArray[1]}</span>"
echo "Synced <span color='$(color $delta 10)'>${dataArray[2]}</span>"
echo "Balance <span color='$(color 1 ${dataArray[3]})'>${dataArray[3]}</span> ALPH"
echo "Locked Balance <span color='$(color 1 ${dataArray[4]})'>${dataArray[4]}</span> ALPH"
echo "---"
echo "Launch Swagger <span color='#d4e157'>{...}</span> | bash=$wdir/sc/launchS.sh terminal=false"
fi

unset dataArray
exit