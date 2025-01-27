#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 

function do_create_route_table() 
{
  #|#  * create_route_table
  #|#  * @description Creates a route table in the specified resource group.
  #|#  * @param route_table_name The name of the route table.
  #|#  * @param resource_group The resource group for the route table.
  #|#  * @param location The location (region) for the route table.
  #|#  * @usage create_route_table "route_table_name" "resource_group" "location"

  Function_Name="${FUNCNAME[0]}"
  Function_PATH="${Function_PATH}/${Function_Name}"
  MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

  local route_table_name="${1}"
  local resource_group="${2}"
  local location="${3}"
  
  Empty_Var_Control "${route_table_name}" "route_table_name" "2"
  Empty_Var_Control "${resource_group}" "resource_group" "2"
  Empty_Var_Control "${location}" "location" "2"

  az network route-table create --name "${route_table_name}" --resource-group "${resource_group}" --location "${location}"

  Function_PATH="$(dirname ${Function_PATH})"
}



function do_add_route ()
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


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_remove_root ()
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

function get_route_liste ()
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



LibState="OK"