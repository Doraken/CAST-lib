#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                        #
# Subject : This library provide base menu functions to deploy chroots on     #
#           server                                                            #
###############################################################################
####
# INFO 

function Display_Chroot_configuration ()
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
 



Menu_Get_items "# Configure_ChRoot_Size" "2" "${Base_Dir_Scripts_Lib}/user_interaction/sub/Configure_Chroot_Size.lib" "Configure_ChRoot_Size:"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}


function Select_Chroot_Size                             # Deploy_Chroot                              
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
 



Menu_Get_items "# Configure_ChRoot_Size" "2" "${Base_Dir_Scripts_Lib}/user_interaction/sub/Configure_Chroot_Size.lib" "Configure_ChRoot_Size:"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

# Sourcing control variable 
LibState="OK"  
