#!/bin/bash
# author : Arnaud Crampet
# Date : xx/08/2024
# generic azure devops tool from CAST 
 
function generate_route_config_file() 
{
#|#  Nom de la fonction    : generate_route_config_file
#|#  Description           : Génère un fichier de configuration pour une route spécifique en utilisant les informations fournies. Elle crée un répertoire de configuration et remplit le fichier avec les détails de la route.
#|#  Paramètres:
#|#      route_name        : Nom de la route à configurer (obligatoire).
#|#      address_prefix    : Préfixe d'adresse de la route (obligatoire).
#|#      next_hop_type     : Type de prochain saut de la route (obligatoire).
#|#      next_hop_ip       : Adresse IP du prochain saut (facultatif).
#|#  Utilisation           : generate_route_config_file "route_name" "address_prefix" "next_hop_type" "next_hop_ip"
#|#  Retour                : Aucun (génère un fichier de configuration et affiche les messages de progression).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _route_name="${1}"
local _address_prefix="${2:-Notset}"
local _next_hop_type="${3:-Notset}"
local _next_hop_ip="${4:-Notset}"

# Contrôle des variables vides
Empty_Var_Control "${_route_name}" "_route_name" "4" "Le nom de la route est requis."
Empty_Var_Control "${_address_prefix}" "_address_prefix" "4" "Le préfixe d'adresse est requis."
Empty_Var_Control "${_next_hop_type}" "_next_hop_type" "4" "Le type de prochain saut est requis."
Empty_Var_Control "${_next_hop_ip}" "_next_hop_ip" "4" "L'adresse IP du prochain saut est facultative mais non définie."

# Création du répertoire pour la route
local _route_dir="${_route_name}"
MSG_DISPLAY "check" "0" "Création du répertoire de configuration '${_route_dir}/config'"
mkdir -p "${_route_dir}/config"
CTRL_Result_func "${?}" "Création du répertoire de configuration" "Échec de la création du répertoire de configuration" "1"

# Génération du fichier de configuration
local _config_file="${_route_dir}/config/config.sh"
MSG_DISPLAY "check" "0" "Génération du fichier de configuration : ${_config_file}"

cat <<EOL > "${_config_file}"
ADDRESS_PREFIX="${_address_prefix}"
NEXT_HOP_TYPE="${_next_hop_type}"
NEXT_HOP_IP="${_next_hop_ip}"
EOL
CTRL_Result_func "${?}" "Génération du fichier de configuration" "Échec de la génération du fichier de configuration" "1"

MSG_DISPLAY "info" "0" "Fichier de configuration généré avec succès : ${_config_file}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function process_route_table() 
{
#|#  Nom de la fonction    : process_route_table
#|#  Description           : Traite une table de routage spécifique dans un groupe de ressources Azure, extrait les informations de chaque route et génère un fichier de configuration pour chaque route.
#|#  Paramètres:
#|#      _rg               : Nom du groupe de ressources contenant la table de routage (obligatoire).
#|#      _rt_name          : Nom de la table de routage à traiter (obligatoire).
#|#  Utilisation           : process_route_table $RESOURCEGROUP $ROUTETABLE
#|#  Retour                : Aucun (génère des fichiers de configuration pour chaque route et affiche les messages de progression).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _rg="${1}"
local _rt_name="${2}"

# Contrôle des variables vides
Empty_Var_Control "${_rg}" "_rg" "4" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_rt_name}" "_rt_name" "4" "Le nom de la table de routage est requis."

MSG_DISPLAY "info" "0" "Traitement de la table de routage : ${_rt_name} dans le groupe de ressources : ${_rg}"

# Récupération des informations de la table de routage
MSG_DISPLAY "check" "0" "Récupération des informations de la table de routage '${_rt_name}'"
local _rt_info
_rt_info=$(az network route-table show --resource-group "${_rg}" --name "${_rt_name}" --query "{id:id, routes:routes}" -o json)
CTRL_Result_func "${?}" "Récupération des informations de la table de routage" "Échec de la récupération des informations de la table de routage" "1"

if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Informations de la table de routage '${_rt_name}' récupérées avec succès."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la récupération des informations de la table de routage '${_rt_name}'."
    exit 1
fi

# Extraction des routes et génération des fichiers de configuration
local _routes
_routes=$(echo "${_rt_info}" | jq -c '.routes[]')

for _route in ${_routes}; do
    local _route_name
    local _address_prefix
    local _next_hop_type
    local _next_hop_ip

    _route_name="$(echo "${_route}" | jq -r '.name')"
    _address_prefix="$(echo "${_route}" | jq -r '.addressPrefix')"
    _next_hop_type="$(echo "${_route}" | jq -r '.nextHopType')"
    _next_hop_ip="$(echo "${_route}" | jq -r '.nextHopIpAddress')"

    MSG_DISPLAY "check" "0" "Génération du fichier de configuration pour la route '${_route_name}'"
    generate_route_config_file "${_route_name}" "${_address_prefix}" "${_next_hop_type}" "${_next_hop_ip}"
    CTRL_Result_func "${?}" "Génération du fichier de configuration pour la route '${_route_name}'" "Échec de la génération du fichier de configuration pour la route '${_route_name}'" "1"

    if [[ $? -eq 0 ]]; then
        MSG_DISPLAY "info" "0" "Fichier de configuration pour la route '${_route_name}' généré avec succès."
    else
        MSG_DISPLAY "error" "1" "Erreur lors de la génération du fichier de configuration pour la route '${_route_name}'."
        exit 1
    fi
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function set-route-table() 
{
#|#  Nom de la fonction    : set-route-table
#|#  Description           : Vérifie si une table de routage existe dans le groupe de ressources spécifié. Si elle n'existe pas, elle est créée à l'emplacement spécifié.
#|#  Paramètres:
#|#      _ressource_group  : Nom du groupe de ressources (obligatoire).
#|#      _route_table      : Nom de la table de routage à vérifier ou à créer (obligatoire).
#|#      _location         : Localisation pour la création de la table de routage (obligatoire).
#|#  Utilisation           : set-route-table "ressource_group" "route_table" "location"
#|#  Retour                : Aucun (affiche les messages de création ou d'existence).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _ressource_group="$1"
local _route_table="$2"
local _location="$3"

# Contrôle des variables vides
Empty_Var_Control "${_ressource_group}" "_ressource_group" "2" "Le groupe de ressources est requis."
Empty_Var_Control "${_route_table}" "_route_table" "2" "La table de routage est requise."
Empty_Var_Control "${_location}" "_location" "2" "La localisation est requise."

# Vérifier si la table de routage existe
route_table_exists=$(az network route-table show --resource-group "${_ressource_group}" --name "${_route_table}" --query "name" -o tsv | sed 's/[[:space:]]*$//')

MSG_DISPLAY "check" "0" "Vérification de l'existence de la table de routage '${_route_table}'"
if [ -z "${route_table_exists}" ]; then
    MSG_DISPLAY "info" "0" "La table de routage '${_route_table}' n'existe pas. Création en cours..."
    az network route-table create --resource-group "${_ressource_group}" --name "${_route_table}" --location "${_location}" &>> ${log_file}
    CTRL_Result_func "${?}" "Création de la table de routage" "Échec de la création de la table de routage" "1"
    MSG_DISPLAY "info" "0" "Table de routage '${_route_table}' créée avec succès."
else
    MSG_DISPLAY "info" "0" "La table de routage '${_route_table}' existe déjà."
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

LibState="OK"
