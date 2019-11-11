while :
do
   read MAC?"Enter MAC address: "
   case "$MAC" in
       ({2}([[:xdigit:]]){5}(:{2}([[:xdigit:]])))
       break;;
   esac
   echo "Invalid MAC address"
done