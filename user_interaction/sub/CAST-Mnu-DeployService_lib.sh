#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                            #
# Subject : This library provide base menu functions to configure CAST run    #
#                                                                             #
###############################################################################
####
# INFO 




function Deploy_Chroot                             # Deploy_Service                                    
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
 


Menu_Get_items "# Deploy_Chroot" "2" "${Base_Dir_Scripts_Lib}/user_interaction/sub/Deploy_Chroot.lib" "Deploy_Chroot:"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Deploy_openstack                               # Deploy_Service                                        
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
 


Menu_Get_items "# Deploy_openstack" "2" "${Base_Dir_Scripts_Lib}/user_interaction/sub/CAST-Mnu-DeployService_openStack.lib" "Deploy_openstack:"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}


function Deploy_Compiled_Package                              # Deploy_Service                                        
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
 


Menu_Get_items "# PKG_installable_ok" "2" "${Base_Dir_Scripts_Lib}/build/compil/pkg_install.lib" "Deploy_builded_package:"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}


# Sourcing control variable 
LibState="OK"  

