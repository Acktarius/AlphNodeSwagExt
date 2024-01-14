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
Alephium Node running, with API key setup in user.info file,
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
`cp alphNodeStatExt.3r+.sh ~/.config/argos/alphNodeStatExt.3r+.sh`  
 * copy the icon
`cp miner.svg ~/.icons/miner`     
 * make sure the scripts files are executable  
`chmod 755 *.sh`

## Setup
1. Activate argos in extension (new icon on your launch pad)(just need to be done for first use)  
2. within the extension, run    
   `./first.sh`  
   (this is to store your credentials in an encrypted file, remember your new single use passphrase, you might need it sometimes)  
3. still within the extension, run
   `./second.sh`  
   (if the option was declined at *first.sh* .This is to give the ip address of the node on your local network)   
## Run  
to test, run:  
`./main.sh`   
it runs for 2minutes, and then runs 2minutes every 30 minutes, the date in the extension turns <span color='#ff7f50'>orange</span> if it did not receive input for more than 1/2hour.   
you can click on **Run Script** if you wnat to refresh. (no more need of the terminal).    
*(now you may have to log out and come back to see the extension appear in your top bar.)*  
  
---
  
## Contact
https://discord.gg/tw3wWR3q  

