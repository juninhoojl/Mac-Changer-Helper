#!/bin/zsh
# --------------------------------------------------------
# Script: 
# Description:
# Code by: juninhoojl
# --------------------------------------------------------

# -i [interface]
# -a [MAC]
# -r [random]
	#se dps do -r tiver 22:xx:xx:xx:xx:xx
	#se dps do -r tiver 22:xx:xx:DE:xx:xx
	#Vai ser aleatorio onde nao tem nada
# -o [original]
# -l [arquivo]
# -t [tempo]

# se n = op, entao n+1 alguma seguinte. Se for 
#

while [ $# -gt 0 ] ; do
    case "$1" in
    -h|--help) #Nao exige nada
        usage
        ;;
    -r|--random) #Nao exige nada ou endereco incompleto
        delete=1
        echo "Aleatorio"
        ;;
    -a|--address) #Exige endereco completo
        output="$2"
        echo "Endereco"
        shift #Torna $2 $1 e assim por diante
        ;;
    -*) #opcao nao existente
        usage "Unknown option '$1'"
        ;;
    *) #Sem argumentos
        if [ -z "$foo" ] ; then
            foo="$1"
        elif [ -z "$bar" ] ; then
            bar="$1"
        else
            usage "Too many arguments"
        fi
        ;;
    esac
    shift
done