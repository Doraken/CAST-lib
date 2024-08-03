#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 

function set_vm_properties ()
{
#|# /**
#|#  * set_vm_properties
#|#  * @description Sets the properties of a VM based on provided variables.
#|#  * @param vm_name The name of the VM.
#|#  * @param resource_group The resource group of the VM.
#|#  * @param property_name The name of the property to set.
#|#  * @param property_value The value to set for the property.
#|#  * @usage set_vm_properties "vm_name" "resource_group" "property_name" "property_value"
#|#  */
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

local vm_name="${1}"
local resource_group="${2}"
local property_name="${3}"
local property_value="${4}"

Empty_Var_Control "${vm_name}" "vm_name" "2"
Empty_Var_Control "${resource_group}" "resource_group" "2"
Empty_Var_Control "${property_name}" "property_name" "2"
Empty_Var_Control "${property_value}" "property_value" "2"

az vm update --resource-group "${resource_group}" --name "${vm_name}" --set "${property_name}=${property_value}"



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_vm_create ()
{
#|# /**
#|#  * do_vm_create
#|#  * @description Creates a VM based on provided variables.
#|#  * @param vm_name The name of the VM.
#|#  * @param vm_template The template to use for VM creation.
#|#  * @usage do_vm_create "vm_name" "vm_template"
#|#  */
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

  local vm_name="${1}"
  local resource_group="${2}"
  local vm_template="${3}"
  
  Empty_Var_Control "${vm_name}" "vm_name" "2"
  Empty_Var_Control "${resource_group}" "resource_group" "2"
  Empty_Var_Control "${vm_template}" "vm_template" "2"

  az vm create --resource-group "${resource_group}" --name "${vm_name}" --image "${vm_template}"



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_vm_remove ()
{
#|# /**
#|#  * do_vm_remove
#|#  * @description Removes a VM based on provided variables.
#|#  * @param vm_name The name of the VM.
#|#  * @param resource_group The resource group of the VM.
#|#  * @usage do_vm_remove "vm_name" "resource_group"
#|#  */
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

local vm_name="${1}"
local resource_group="${2}"
  
Empty_Var_Control "${vm_name}" "vm_name" "2"
Empty_Var_Control "${resource_group}" "resource_group" "2"

az vm delete --resource-group "${resource_group}" --name "${vm_name}" --yes

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_vm_stop ()
{
#|# /**
#|#  * do_vm_stop
#|#  * @description Stops a VM based on provided variables.
#|#  * @param vm_name The name of the VM.
#|#  * @param resource_group The resource group of the VM.
#|#  * @usage do_vm_stop "vm_name" "resource_group"
#|#  */
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

local vm_name="${1}"
local resource_group="${2}"
  
Empty_Var_Control "${vm_name}"        "vm_name"        "2"
Empty_Var_Control "${resource_group}" "resource_group" "2"

az vm stop --resource-group "${resource_group}" --name "${vm_name}"
 
 

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_vm_start ()
{
#|# /**
#|#  * do_vm_start
#|#  * @description Starts a VM based on provided variables.
#|#  * @param vm_name The name of the VM.
#|#  * @param resource_group The resource group of the VM.
#|#  * @usage do_vm_start "vm_name" "resource_group"
#|#  */
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

local vm_name="${1}"
local resource_group="${2}"
  
Empty_Var_Control "${vm_name}" "vm_name" "2"
Empty_Var_Control "${resource_group}" "resource_group" "2"

az vm start --resource-group "${resource_group}" --name "${vm_name}"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_vm_config ()
{
#|# /**
#|#  * Get_vm_config
#|#  * @description Retrieves the full configuration of a VM based on provided variables.
#|#  * @param vm_name The name of the VM.
#|#  * @param resource_group The resource group of the VM.
#|#  * @usage Get_vm_config "vm_name" "resource_group"
#|#  */
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

local vm_name="${1}"
local resource_group="${2}"
  
Empty_Var_Control "${vm_name}"        "vm_name"        "2"
Empty_Var_Control "${resource_group}" "resource_group" "2"

az vm show --resource-group "${resource_group}" --name "${vm_name}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Set_vm_config ()
{
#|# /**
#|#  * Set_vm_config
#|#  * @description Changes the configuration of a VM based on provided variables.
#|#  * @param vm_name The name of the VM.
#|#  * @param config_name The name of the configuration to set.
#|#  * @param config_value The value to set for the configuration.
#|#  * @usage Set_vm_config "vm_name" "config_name" "config_value"
#|#  */
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

local vm_name="${1}"
local resource_group="${2}"
local config_name="${3}"
local config_value="${4}"
  
Empty_Var_Control "${vm_name}"        "vm_name"        "2"
Empty_Var_Control "${resource_group}" "resource_group" "2"
Empty_Var_Control "${config_name}"    "config_name"    "2"
Empty_Var_Control "${config_value}"   "config_value"   "2"

az vm update --resource-group "${resource_group}" --name "${vm_name}" --set "${config_name}=${config_value}"

 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


LibState="OK"