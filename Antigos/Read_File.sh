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

a='09:60--08-c4-99Fa'

retval=$( Normalize $a)

#echo $retval

valor=$( Validate $retval)

echo $valor


# Recebe 01:23:45:67:89:AB ou 01-23-45-67-89-AB e valida se for um MAC valido