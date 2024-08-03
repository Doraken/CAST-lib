#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                          #
# Subject : This lib is used to provide any function about user menu control  #
#                                                                             #
###############################################################################
####
# INFO

############################

function USER_Continue_ON_ERR
{
#|# MSG_TO_Display : use this var to set the displayed message when an user action is needed
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 


set -A Configuration_install_pkg 'Error occured :'                       \
     'Continue'           \
     'exit'

Menu_Build Configuration_install_pkg
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Continue
{
#|# MSG_TO_Display : use this var to set the displayed message when an user action is needed
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

MSG_DISPLAY "info" "1" "You choose to continue"

Menu_Build Configuration_install_pkg
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"