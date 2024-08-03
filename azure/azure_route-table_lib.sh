#!/bin/bash
 
function generate_route_config_file()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
    local route_name="${1}"
    local address_prefix="${2:-Notset}"
    local next_hop_type="${3:-Notset}"
    local next_hop_ip="${4:-Notset}"

    Empty_Var_Control "${route_name}"     "route_name"      "4"
    Empty_Var_Control "${address_prefix}" "address_prefix"  "4"
    Empty_Var_Control "${next_hop_type}"  "next_hop_type"   "4"
    Empty_Var_Control "${next_hop_ip}"    "next_hop_ip"     "4"



    # Créer le répertoire pour la route
    local route_dir="${route_name}"
    mkdir -p "${route_dir}/config"

    # Générer le fichier de configuration
    local config_file="${route_dir}/config/config.sh"
    
    echo "Generating configuration file: $config_file"
    
    cat <<EOL > $config_file
ADDRESS_PREFIX="${address_prefix}"
NEXT_HOP_TYPE="${next_hop_type}"
NEXT_HOP_IP="${next_hop_ip}"
EOL
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
} 


function process_route_table() 
{
#|#usage : process_route_table $RESOURCEGROUP $ROUTETABLE
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
    local rg="${1}"
    local rt_name="${2}"

    echo "Processing route table: ${rt_name} in resource group: $rg"

    # Récupérer les informations de la table de routage
    rt_info=$(az network route-table show --resource-group ${rg} --name ${rt_name} --query "{id:id, routes:routes}" -o json)

    # Extraire les routes et générer des fichiers de configuration
    routes=$(echo "${rt_info}" | jq -c '.routes[]')
    for route in ${routes}
     do
        route_name="$(echo "${routes}" | jq -r '.name')"
        address_prefix="$(echo "${routes}" | jq -r '.addressPrefix')"
        next_hop_type="$(echo "${routes}" | jq -r '.nextHopType')"
        next_hop_ip="$(echo "${routes}" | jq -r '.nextHopIpAddress')"
        generate_route_config_file "${route_name}" "${address_prefix}" "${next_hop_type}" "${next_hop_ip}"
    done
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


LibState="OK"

