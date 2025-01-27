#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 

# Liste des objets Azure avec leurs bigrammes

function do_select_azure_tenant_config ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

Menu_Get_items "#__ azure_tenant_selector" "2" "${Base_Dir_Scripts_CNF_spec}/azure/confiog_azure*.cnf" "azure_configuration_menu_:"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################1
}


LibState="OK"

