#!/bin/bash 
# author : David Cheong
# Date : 02/08/2024
# generic azure devops tool from CAST 

# RESSOURCE_GROUP="rg-livret-ppr-og-fc-01"
# RESSOURCE_NAME="ws-livret-ppr-oa-fc-01"
# DOCKER_IMAGE="retoolprdstfc01.azurecr.io/debian-en-sid-slim-2-nodejs:1.0.4"

# Fonction pour définir l'image Docker d'une application web
set_webapp_docker_image() {
#|# /**
#|#  * set_webapp_docker_image
#|#  * @description Sets the properties of a VM based on provided variables.
#|#  * @param _RESSOURCE_GROUP The name of the resource group.
#|#  * @param _RESSOURCE_NAME The name of the web application.
#|#  * @param _DOCKER_IMAGE The name of the docker image.
#|#  * @usage set_webapp_docker_image "_RESSOURCE_GROUP" "_RESSOURCE_NAME" "_DOCKER_IMAGE"
#|#  */
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "  

local _RESSOURCE_GROUP="${1}"
local _RESSOURCE_NAME="${2}"
local _DOCKER_IMAGE="${3}"

Empty_Var_Control "_RESSOURCE_GROUP" "${_RESSOURCE_GROUP}" "4"
Empty_Var_Control "_RESSOURCE_NAME" "${_RESSOURCE_NAME}"   "4"
Empty_Var_Control "_DOCKER_IMAGE" "${_DOCKER_IMAGE}"       "4"

  # Exécution de la commande Azure CLI pour configurer l'application web
az webapp config container set \
    --resource-group "$RESOURCE_GROUP" \
    --name "$RESOURCE_NAME" \
    --container-image-name "$DOCKER_IMAGE"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Fonction pour vérifier si une application web existe
check_webapp_exists() {
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

    local resource_group="$1"
    local webapp_name="$2"

    # Vérification des paramètres
    if [[ -z "$resource_group" || -z "$webapp_name" ]]; 
      then
        echo "Erreur : Le groupe de ressources et le nom de l'application web doivent être fournis."
        return 1
    fi

    # Vérification de l'existence de l'application web
    az webapp show --resource-group "$resource_group" --name "$webapp_name" > /dev/null 2>&1
    local status=$?
    if [[ $status -ne 0 ]]; 
      then
        echo "L'application web '$webapp_name' n'existe pas dans le groupe de ressources '$resource_group'."
        return 1
    fi

    echo "L'application web '$webapp_name' existe dans le groupe de ressources '$resource_group'."
    return 0
    
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Fonction pour lister toutes les applications web dans un groupe de ressources
list_webapps() {
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

    local resource_group="$1"

    # Vérification du paramètre
    if [[ -z "$resource_group" ]]; 
      then
        echo "Erreur : Le groupe de ressources doit être fourni."
        return 1
    fi

    # Liste des applications web
    echo "Liste des applications web dans le groupe de ressources '$resource_group' :"
    az webapp list --resource-group "$resource_group" --query "[].{Name:name}" -o table
    return 0
    
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Fonction pour redémarrer une application web
restart_webapp() {
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

    local resource_group="$1"
    local webapp_name="$2"

    # Vérification des paramètres
    if [[ -z "$resource_group" || -z "$webapp_name" ]]; 
      then
        echo "Erreur : Le groupe de ressources et le nom de l'application web doivent être fournis."
        return 1
    fi

    # Redémarrage de l'application web
    az webapp restart --resource-group "$resource_group" --name "$webapp_name"
    local status=$?
    if [[ $status -ne 0 ]]; 
      then
        echo "Erreur : Impossible de redémarrer l'application web '$webapp_name' dans le groupe de ressources '$resource_group'."
        return $status
    fi

    echo "Succès : L'application web '$webapp_name' a été redémarrée dans le groupe de ressources '$resource_group'."
    return 0
    
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Fonction pour supprimer une application web
delete_webapp() {
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

    local resource_group="$1"
    local webapp_name="$2"

    # Vérification des paramètres
    if [[ -z "$resource_group" || -z "$webapp_name" ]]; 
      then
        echo "Erreur : Le groupe de ressources et le nom de l'application web doivent être fournis."
        return 1
    fi

    # Suppression de l'application web
    az webapp delete --resource-group "$resource_group" --name "$webapp_name"
    local status=$?
    if [[ $status -ne 0 ]]; 
      then
        echo "Erreur : Impossible de supprimer l'application web '$webapp_name' dans le groupe de ressources '$resource_group'."
        return $status
    fi

    echo "Succès : L'application web '$webapp_name' a été supprimée dans le groupe de ressources '$resource_group'."
    return 0
    
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Fonction pour accéder à l'application web via SSH
get_ssh_webapp() {
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "


    az webapp ssh -n "$RESOURCE_NAME" -g "$RESOURCE_GROUP"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################    
}

LibState="OK"