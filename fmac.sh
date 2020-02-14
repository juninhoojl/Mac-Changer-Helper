#!/bin/zsh
#Colors output
#declare -A cl=( ["nc"]='\033[0m' ["red"]='\033[0;31m' ["green"]='\033[0;32m' ["purple"]='\033[0;35m')
nc='\033[0m'
red='\033[0;31m'
gre='\033[0;32m'
pur='\033[0;35m'

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



# Confere qual interface esta sendo usada na rota padrao
# Se nao for fornecido nenhuma interface, vai usar ela

# Lista todas as interfaces, a padrao ou uma escolhida que exista
# $1 = Interface (default) -> about it
listint () {
	# Escolha entre um dos devices disponiveis

	DefInt=$(route -n get 0.0.0.0 | awk '/interface: / {print $2}')

	if [ -n "$DefInt" ]; then
	    echo "(Default route is through interface $DefInt)"
	else
	    echo "(No default route found)"
	fi

	Desc=(`networksetup -listallhardwareports | grep 'Port' | awk '{print $3}'`)
	Addd=(`networksetup -listallhardwareports | grep 'Address' | awk '{print $3}'`)
	Inte=(`networksetup -listallhardwareports | grep 'Device' | awk '{print $2}'`)
	# get length of an array
	tLen=${#Desc[@]}

		for (( i=0; i<${tLen}; i++ ));
		do
			if [[ ("${DefInt}" == "${Inte[$i]}") ]] ; then
				echo "${pur}${Inte[$i]}${nc} (${Desc[$i]}) → ${Addd[$i]}"
			elif [[ ("$1" != 1) && ($1 != 1)]]; then
				#statements
				echo "${gre}${Inte[$i]}${nc} (${Desc[$i]}) → ${Addd[$i]}"
			fi
		done
}



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

#ChangeMAC $interface $CMAC

exit
