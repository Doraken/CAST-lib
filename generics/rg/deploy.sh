#!/bin/bash 
# author : Arnaud Crampet 
# Date : 25/06/2024
# generic route ressource group deploy script
script_name=$(basename "${0}" .sh)

# Sourcing core ressource file 
. ./lib/core.sh 
if [[ ${CoreState} = "OK" ]]
   then 
       echo "core scripting loaded"
   else 
       echo "Error on core scripting configuration"
       exit 1 
fi 

#sourcing tenant configuration file :
MSG_DISPLAY "check" "0" "Loading tenant configuration"
. ../../config/config.sh 
if [[ ${ConfigTenantState} = "OK" ]]
   then 
       MSG_DISPLAY "EdSMessage" "0" ""
   else 
       MSG_DISPLAY "EdSMessage" "1" ""
fi 
#sourcing ressourcegroupe configuration file :
MSG_DISPLAY "check" "0" "Loading ressource group configuration"
. ./config/config.sh 
if [[ ${ConfigRessourceGroupeState} = "OK" ]]
   then 
       MSG_DISPLAY "EdSMessage" "0" ""
   else 
       MSG_DISPLAY "EdSMessage" "0" ""
fi 

# init all base var and display configuraiton 
init_all

