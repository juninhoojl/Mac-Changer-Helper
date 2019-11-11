#!/bin/zsh

# Normalize and Return -> XX:XX:XX:XX:XX:XX
function Normalize() {
   #Remove - and : -> uppercase -> sed :
   Val=`echo "$1" | sed 's|[:-]||g'`
   Val=$( tr '[a-z]' '[A-Z]' <<< $Val)
   Val=`echo "$Val" | sed 's/\(..\)/\1:/g; s/.$//'`
   echo $Val
}

#Return 1 -> Valid MAC | 0 -> Invalid MAC
function Validate() {
	if [ -z `echo $1 | sed -n "/^\([0-9A-Z][0-9A-Z]:\)\{5\}[0-9A-Z][0-9A-Z]$/p"` ]
	then #Nao valido
		 #Exit (1) and Usage
	      echo 0
	else #Valido
	      echo 1
	fi
}

function ChangeMAC(){
	# $1 = Inteface
	# $2 = MAC desejado
	
	sudo ifconfig $1 ether $2
	sudo ifconfig $1 down
	sudo ifconfig $1 up
	# Current MAC:
	printf "\t¤ Current MAC: \033[0;32m${2}\033[0m\n"

}

# Help

#fmac
sudo -v

original="8c:85:90:10:6a:16"
interface="en0"
echo $interface
PMAC=`ifconfig $interface | grep ether | awk '{print $2}'`
printf "\t¤ Previous MAC: \033[0;35m${PMAC}\033[0m\n"

if [ -z "$1" ]
	then # No argument
    CMAC=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`
elif [ "$1" = "reset" ] # Reset
	then
	CMAC="$original"
else # MAC supplied
	CMAC="$1"
fi

ChangeMAC $interface $CMAC

exit
