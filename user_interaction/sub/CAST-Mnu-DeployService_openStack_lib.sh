#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                        #
# Subject : This library provide base menu functions to configure CAST run    #
#                                                                             #
###############################################################################
####
# INFO 




function Install_Base_Services                             # Deploy_openstack                                    
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
 


Menu_Get_items "# Deploy_Chroot" "2" "${Base_Dir_Scripts_Lib}/user_interaction/sub/Deploy_Chroot_lib.sh" "Deploy_Chroot:"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function yum_InstalledList_Init                             # Deploy_openstack                                    
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
 
set -A PackageList 

PackageList=$( yum  list installed | awk '{ print $1}')
Test_yum_package_presence 

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

# Sourcing control variable 
LibState="OK"  

