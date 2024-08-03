#!/bin/bash 

#TODO check var null or not

function set_webapp_docker_image ()
{
#TODO [x] intégrer la fonction type  from @ACR to @DCH

############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

local _RESSOURCE_GROUP="${1}"
local _RESSOURCE_NAME="${2}"
local _DOCKER_IMAGE="${3}"

Empty_Var_Control "_RESSOURCE_GROUP" "${_RESSOURCE_GROUP}" "4"
Empty_Var_Control "_RESSOURCE_NAME" "${_RESSOURCE_NAME}"   "4"
Empty_Var_Control "_DOCKER_IMAGE" "${_DOCKER_IMAGE}"       "4"

az webapp config container set \
  --resource-group "${_RESSOURCE_GROUP}" \
  --name "${_RESSOURCE_NAME}" \
  --container-image-name "${_DOCKER_IMAGE}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function get_ssh_webapp ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

  # Exécuter la commande SSH pour accéder à l'application web
  az webapp ssh -n "${RESSOURCE_NAME}" -g "${RESSOURCE_GROUP}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################    
}

LibState="OK"