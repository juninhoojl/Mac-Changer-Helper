#Interfaces Disponiveis:

#networksetup -listallhardwareports

#Colors output
#declare -A cl=( ["nc"]='\033[0m' ["red"]='\033[0;31m' ["green"]='\033[0;32m' ["purple"]='\033[0;35m')
nc='\033[0m'
red='\033[0;31m'
gre='\033[0;32m'
pur='\033[0;35m'

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
	# use for loop read all nameservers

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

listint

# Valida interface
# $1 = Interface -> 1 (valid) | 0 (not valid)
validint () {
	if [[ " ${Inte[*]} " == *"$1"* ]]; then # Interface $1 disponivel
	    echo 1
	else # Interface $1 nao disponivel
		echo 0
	fi
}


