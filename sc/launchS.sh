#!/bin/bash
# this file is subject to Licence
#Copyright (c) 2024, Acktarius
##################################################################
#  launch Swagger
##################################################################
wdir=/opt/AlphNodeSwagExt

ip=$(cat $wdir/.data)
#Declaratons
url="http://$ip:12973/docs"
#main
firefox $url || zenity --error --timeout=12 --text="an error was encountered";