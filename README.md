# AlphNodeSwagExt
Small Extension for Linux Debian user to quick access Alephiun Node Status
 
## Disclaimer  
this script is delivered “as is” and I deny any and all liability for any damages arising out of using this script   

## Acknoledgment
Huge thanks to [Bitbar](https://github.com/matryer/bitbar) and [@p-e-w](https://github.com/p-e-w/argos) for creating the argos repositories  

## For who ?
**Ubuntu** users, running an **Alephium Node** on the same subnet.  
*(probably works on other Debian, not tested)*  

## Prerequisite
Alephium Node running, with API key setup in user.conf file,
known wallet name, password and IP address. Sensitive data will be stored in an encrypted files. 

## Install
### Dependencies and application requirements
`sudo apt update`  
 * argos  
need to be able to toggle the **argos** extention :  
`sudo apt-get -y install gnome-shell-extension-prefs`  
 * emojis  
`sudo apt install gnome-characters`
 * zenity  
`sudo apt install -y zenity`
 * gpg  
`sudo apt-get -y install gpg`
 * jq
`sudo apt install jq` 

### Argos extension :
from [@p-e-w](https://github.com/p-e-w/argos) repository  
copy the argos folder in your extensions folder  
`cp argos@pew-worldwidemann.com ~/.local/share/gnome-shell/extensions/`  
  
logout , log back in, open Extension and toggle Argos  

## Download this repository
within terminal ~$  (Ctrl + Alt + T)
`git clone https://github.com/Acktarius/AlphNodeSwagExt.git`  
mv the downloaded directory to /opt  
`sudo mv /AlphNodeSwagExt /opt/`   

## Install  
change directory  
`cd /opt/AlphNodeSwagExt`  
 * copy the extension script  
`cp alphNodeStatExt.1r+.sh ~/.config/argos/alphNodeStatExt.1r+.sh`  
 * copy the icon
`cp Alephium-logo.svg ~/.icons/`     
 * make sure the scripts files are executable  
`chmod 755 *.sh`

## Setup
1. Activate argos in extension (new icon on your launch pad)(just need to be done for first use)  
2. within the extension, run    
   `./first.sh`  
   (this is to store your credentials in an encrypted file, remember your new single use passphrase, you might need it sometimes, or click autosave)  
3. still within the extension, run
   `./second.sh`  
   (if the option was declined running *first.sh* .This is to give the ip address of the node on your local network)   
## Run  
to test, run:  
`./main.sh`   
it runs when click on the icon, the status will be orange if it took longer than 10s to fetch data.   
    
*(note you may have to log out and come back to see the extension appear in your top bar.)*  
  
---
  
## Contact
https://discord.gg/ZnMUUKUs

