#!/bin/bash 
# author : Arnaud Crampet 
# Date : 25/06/2024
# generic route table removing script
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
       MSG_DISPLAY "EdEMessage" "1" ""
fi 
#sourcing ressourcegroupe configuration file :
if [[ -f  ./config/config.sh ]]
  then 
    MSG_DISPLAY "check" "0" "Loading ressource group configuration"
    . ./config/config.sh 
    if [[ ${ConfigRessourceGroupeState} = "OK" ]]
    then 
        MSG_DISPLAY "EdSMessage" "0" ""
    else 
        MSG_DISPLAY "EdEMessage" "0" ""
    fi 
fi

resourceGroup=$( pwd | awk -F \/ '{ print $NF }' )



# Redirecting all error to log file
#exec 2> ${logfile}

init_all


# gathering ressource group object list
OBJECTS=$(az resource list --resource-group ${resourceGroup} --query "[].{name:name, type:type}" -o json)

# Boucle sur chaque objet et génère la structure de répertoires et fichiers
echo "${OBJECTS}" | jq -c '.[]' | while read -r OBJECT; do
    OBJECT_NAME=$(echo ${OBJECT} | jq -r '.name')
    OBJECT_TYPE=$(echo ${OBJECT} | jq -r '.type')
    
    # Crée le répertoire pour l'objet
    mkdir -p "$OBJECT_NAME/config"
    
    # Récupère les détails de l'objet
    OBJECT_DETAILS=$(az resource show --resource-group ${resourceGroup} --name ${OBJECT_NAME} --resource-type ${OBJECT_TYPE} -o json)
    
    # Convertit les détails de l'objet en variables shell et écrit dans config.sh
    echo "# Configuration pour l'objet ${OBJECT_NAME}" > "${OBJECT_NAME}/config/config.sh"
    echo "$OBJECT_DETAILS" | jq -r 'to_entries | .[] | "" + (.key | ascii_upcase) + "=" + "\"" + (.value | tostring) + "\""' >> "${OBJECT_NAME}/config/config.sh"
    
done

echo "Discover and configuration files generation completed for resource group: ${resourceGroup}"
