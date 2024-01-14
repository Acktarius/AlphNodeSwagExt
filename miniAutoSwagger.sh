#!/bin/bash
# this file is subject to Licence
#Copyright (c) 2024, Acktarius
##################################################################
#    mini Auto Swagger
##################################################################
#working directory
#wdir="/opt/AlphNodeSwagExt"
#cd $wdir
#runner
#echo "$$" > .pid
#variables
#declare -a mode
##index
#declare -a i
#bold=$(tput bold)
#normal=$(tput sgr0)
ip=$(cat .data)
#Declaratons
url="http://$ip/login.cgi"
url2="http://$ip/get_home.cgi"
url3="http://$ip/updatecglog.cgi"
url4="http://$ip/get_minerinfo.cgi"
urlq="http://$ip/logout.cgi"	

#function
strindex() { 
  x="${1%%"$2"*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

#head builder
headBuilder () {
local APIkeyZ=$(echo "$(gpg -d APIkeygpg)")
cat headerTemplate.txt > .header.txt
echo "-H X-API-KEY $APIkeyZ" >> .header.txt
unset APIkeyZ
}


curlAnyPost () {
curl -sL -X POST --cookie-jar cookies.txt \
	-b cookies.txt \
	--config .header.txt \
	--digest \
	--data "$1" \
	$2
}
curlAnyGet () {
curl -s -X GET --cookie-jar cookies.txt \
	-b cookies.txt \
	--config curlConfigFile.txt \
	--digest \
	$1
}


curlit () {
local credentialsZ=$(echo "$(gpg -d credentialsgpg)")
curlAnyPost $credentialsZ $url > /dev/null
unset credentialsZ
}

#check


# MAIN
#OUTPUT 0
now=$(date +%s)
echo "$now"

headBuilder

#Login
curlit
unset -f curlit
sleep 2

#Core Version OUTPUT 1

#get status OUTPUT 2
hashbrut=$(echo "$(curlAnyGet $url2)")
i[0]=$(strindex "$hashbrut" '"av":')
i[1]=$(strindex "$hashbrut" '"sys_status":')
i[2]=$(strindex "$hashbrut" '"url":')
i[3]=$(strindex "$hashbrut" '"worker":')
i[4]=$(strindex "$hashbrut" '"accepted":')
i[5]=$(strindex "$hashbrut" '"reject":')
i[6]=$(strindex "$hashbrut" '"rejected_percentage":')
av["hash"]=$(echo "${hashbrut:((${i[0]}+6)):10}" | cut -d '"' -f 1 | cut -d "." -f 1 )
av["status"]="${hashbrut:((${i[1]}+14)):1}"
av["pool"]=$(echo "${hashbrut:((${i[2]}+7)):40}" | cut -d '"' -f 1 )
av["worker"]=$(echo "${hashbrut:((${i[3]}+10)):20}" | cut -d '"' -f 1)
av["accepted"]=$(echo "${hashbrut:((${i[4]}+12)):10}" | cut -d '"' -f 1)
av["rejected"]=$(echo "${hashbrut:((${i[5]}+10)):10}" | cut -d '"' -f 1)
av["rejectedp"]=$(echo "${hashbrut:((${i[6]}+23)):10}" | cut -d '"' -f 1)
unset i l

#Get Wallet Balance OUTPUT 3
powerbrut=$(curlAnyGet $url3) 
i[7]=$(strindex "$powerbrut" 'PS[')
i[8]=$(strindex "$powerbrut" 'TAvg[')
i[9]=$(strindex "$powerbrut" 'WORKMODE[')
av["power"]="$(echo "${powerbrut:((${i[7]}+3)):20}" | cut -d " " -f 5)"
av["tavg"]=$(echo "${powerbrut:((${i[8]}+5)):5}" | cut -d ']' -f 1)
av["mode"]="${powerbrut:((${i[9]}+9)):1}"

if [[ ${av["mode"]} -eq 0 ]]; then
av["mode"]="Normal"
elif [[ ${av["mode"]} -eq 1 ]]; then
av["mode"]="Performance"
else
av["mode"]="?"
fi

#Get Wallet Balance locked deposit OUTPUT 4

#logout
$(curlAnyGet $urlq) 2> /dev/null


unset i av model
rm -f .pid

exit
