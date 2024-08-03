#!/bin/bash 
# author : Arnaud Crampet 
# Date : 25/06/2024
# generic ressource group display script
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

# generating log file name and path
init_log_fileName

# Redirecting all error to log file
eval #exec 2> ${logfile}

init_all



echo -n "gathering data for ressoruce groupe : ${resourceGroup} ... "
result="$( az group  show --resource-group ${resourceGroup} --output tsv )"
error_CTRL "${?}"

echo "result = ${result} " 