#!/bin/bash
# this file is subject to Licence
#Copyright (c) 2024, Acktarius
##################################################################
#    mini Auto Swagger
##################################################################
#working directory
wdir=/opt/AlphNodeSwagExt
cd $wdir
#runner
#echo "$$" > .pid

#Declaratons and variables
ip=$(cat .data)

url="http://$ip:12973/"
url1="http://$ip:12973/infos/version"
url2="http://$ip:12973/infos/self-clique"
url3="http://$ip:12973/wallets/"


#function
strindex() { 
  x="${1%%"$2"*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

#head builder
headBuilder () {
local APIkeyZ=$(echo "$(gpg -q -d APIkeygpg)")
cat headerTemplate.txt > .header.txt
echo -e "\n-H \"Referer: http://$ip:12973/docs/\"" >> .header.txt
echo -e "-H \"X-API-KEY: $APIkeyZ\"" >> .header.txt
unset APIkeyZ
}


curlAnyPost () {
curl -s -X POST --cookie-jar cookies.txt \
	-b cookies.txt \
	--config .header.txt \
	--digest \
	--data $1 \
	$2
}
curlAnyGet () {
curl -s -w "%{http_code}" -X GET --cookie-jar cookies.txt \
	-b cookies.txt \
	--config .header.txt \
	--digest \
	$1
}

unlockBalance () {
local -a credentialsZ
read -a credentialsZ <<< $(echo "$(gpg -q -d credentialsgpg)")
passJson=$(jq -n -c --arg a "${credentialsZ[1]}" '{
    "password": $a, 
  }'
)
curlAnyPost $passJson ${url3}${credentialsZ[0]}/unlock
sleep 1
balanceBrut=$(curlAnyGet ${url3}${credentialsZ[0]}/balances)
unset credentialsZ
}

#lockLogOut () {
#local -a credentialsZ
#read -a credentialsZ <<< $(echo "$(gpg -q -d credentialsgpg)")
#empty=''
#curlAnyPost $empty ${url3}${credentialsZ[0]}/lock
#unset credentialsZ
#}

#check


# MAIN
#OUTPUT 0
now=$(date +%s)
echo "$now"

headBuilder

#unlock Wallet and get Balance
unlockBalance
unset -f unlockBalance


#Core Version OUTPUT 1

versionBrut=$(curlAnyGet $url1)
if [[ "${versionBrut:(-3)}" == 200 ]]; then
	v=$(echo "${versionBrut:0:-3}" | jq .version)
	echo ${v:1:-1}
else
	echo "?"
fi

#get status OUTPUT 2

syncedBrut=$(curlAnyGet $url2)
if [[ "${syncedBrut:(-3)}" == 200 ]]; then
	echo "${syncedBrut:0:-3}" | jq .synced
else
	echo "?"
fi


#Get Wallet Balance OUTPUT 3
if [[ "${balanceBrut:(-3)}" == 200 ]]; then
#echo $balanceBrut
	b=$(echo "${balanceBrut:0:-3}" | jq .totalBalanceHint)
	echo ${b:1:-6}
else
	echo "?"
fi

#Get Wallet Balance locked deposit OUTPUT 4
if [[ "${balanceBrut:(-3)}" == 200 ]]; then
i=0
sumLocked=0
	while [[ $(echo "${balanceBrut:0:-3}" | jq .balances | jq  .[$i].lockedBalanceHint) != "null" ]]; do
	z=$(echo "${balanceBrut:0:-3}" | jq .balances | jq  .[$i].lockedBalanceHint)
	g=${z:1:-6}
	sumLocked=$(echo $sumLocked+$g | bc )
	i=$(( $i + 1 ))	
	done
	echo $sumLocked
else
	echo "?"
fi

#logout
#lockLogOut
rm -f .header.txt

unset i z g
#rm -f .pid

exit

