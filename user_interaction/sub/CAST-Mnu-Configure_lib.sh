#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                           #
# Subject : This library provide base menu functions to configure CAST run    #
#                                                                             #
###############################################################################
####
# INFO 


function Change_Specific_Configuration                             # Configure_CAST                              
{
#|# Var to set  : None             
#|#
#|# Base usage  : Change_Specific_Configuration
#|#
#|# Description : This function manage the specific configuration file name.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 



Menu_Change_Conf_item "Conf_Specifics" "${Conf_Specifics}"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

# Sourcing control variable 
LibState="OK"  
