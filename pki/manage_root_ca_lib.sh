#!/bin/bash
###############################################################################
#  maManage_root_ca.lib                                                       #
#                                                                             #
# Creation Date : 24/03/2023                                                  #
# Team          : **************************************                      #
# Support mail  : doraken@doraken.net                                         #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provides base functions to create and manage the main #
#           menu for CAST automation toolkit.                                 #
###############################################################################

####
# INFO


###################################### FUNCTIONS #################################

function Display_Root_State () 
{
#|# Var to set  : None
#|#
#|# Base usage  : Display_Root_State
#|#
#|# Description : This function displays the root state and launches the main installation menu.
#|#
#|# Send Back   : Displays the root state and returns to the main installation menu.
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "Debug" "6" "Current Stack: [ ${Function_PATH} ]"

Menu_Get_items "# In_main_install_Menu" "2" "${ROOT_LIB}/main.lib" "Install Packages:"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Manage_root_config () 
{
#|# Var to set  : None
#|#
#|# Base usage  : Manage_root_config
#|#
#|# Description : This function launches the menu to manage root configuration files.
#|#
#|# Send Back   : Displays the root configuration management menu.
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "Debug" "6" "Current Stack: [ ${Function_PATH} ]"

Menu_Get_items "# In_main_install_Menu" "2" "${ROOT_LIB}/manage_root_conf_ca.lib" "Manage Root Configuration Files:"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Generate_root_private () 
{
#|# Var to set  : None
#|#
#|# Base usage  : Generate_root_private
#|#
#|# Description : This function launches the menu to generate the root private key.
#|#
#|# Send Back   : Displays the menu for generating the root private key.
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "Debug" "6" "Current Stack: [ ${Function_PATH} ]"

Menu_Get_items "# In_main_install_Menu" "2" "${ROOT_LIB}/main.lib" "Generate Root Private Key:"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Generate_root_cert () 
{
#|# Var to set  : None
#|#
#|# Base usage  : Generate_root_cert
#|#
#|# Description : This function launches the menu to generate the root certificate.
#|#
#|# Send Back   : Displays the menu for generating the root certificate.
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "Debug" "6" "Current Stack: [ ${Function_PATH} ]"

Menu_Get_items "# In_main_install_Menu" "2" "${ROOT_LIB}/main.lib" "Generate Root Certificate:"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"  

