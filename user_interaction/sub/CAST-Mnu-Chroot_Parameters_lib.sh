#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                           #
# Subject : This library provide base menu functions to configure CAST run    #
#                                                                             #
###############################################################################
####
# INFO 

function CHROOT_base_size                             # Configure_ChRoot_Size                                      
{
#|# Var to set  : None             
#|#
#|# Base usage  : CHROOT_base 
#|#
#|# Description : This function manage the specific configuration file name.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

. ${BDir_Data_Def}/Chroots/Small.ChrtDef
Banner
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function CHROOT_Medium_size                             # Configure_ChRoot_Size                                            
{
#|# Var to set  : None             
#|#
#|# Base usage  : CHROOT_Medium 
#|#
#|# Description : This function manage the specific configuration file name.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

. ${BDir_Data_Def}/Chroots/Medium.ChrtDef
Banner
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function CHROOT_big_size                             # Configure_ChRoot_Size                                           
{
#|# Var to set  : None             
#|#
#|# Base usage  : CHROOT_big  
#|#
#|# Description : This function manage the specific configuration file name.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

. ${BDir_Data_Def}/Chroots/Big.ChrtDef

Banner
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Banner                             # Configure_ChRoot_Size                                           
{
#|# Var to set  : None             
#|#
#|# Base usage  : CHROOT_big  
#|#
#|# Description : This function manage the specific configuration file name.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

BANNER="Chroot configuration : "
BANNER="${BANNER} \\n Root File system       : [ ${dev_root} ]"
BANNER="${BANNER} \\n Dev file system        : [ ${dev_dev} ]"
BANNER="${BANNER} \\n Temp File system       : [ ${dev_tmp} ]"
BANNER="${BANNER} \\n optional file system   : [ ${dev_opt} ]"
BANNER="${BANNER} \\n data file system       : [ ${dev_data} ]"
BANNER="${BANNER} \\n products file system   : [ ${dev_products} ]"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"  