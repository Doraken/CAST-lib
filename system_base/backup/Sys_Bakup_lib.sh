#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                         #
# Subject : This library provide base system config file backup runtimes      #
#                                                                             #
###############################################################################
####
# INFO 

function Do_passwd_backup
{
#|# Var to set  : None
#|# Base usage  : Do_passwd_backup
#|#
#|# Description : This function is used tu générate a day dated backup of
#|#               passwd , shadows and group file . This may prevent any 
#|#               risk of user data loose
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

File_Backup "/etc/passwd"
#File_Backup "/etc/group"


MSG_DISPLAY "info" "1" "this is a model function"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Do_group_backup
{
#|# Var to set  : None
#|# Base usage  : Backup_groupDef
#|#
#|# Description : This function is used to create a spécifica backup of  
#|#               passwd , shadows and group file . This may prevent any 
#|#               risk of user data loose
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

#File_Backup "/etc/passwd"
File_Backup "/etc/group"


MSG_DISPLAY "info" "1" "this is a model function"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}








function Dummy_function
{
#|# Var to set  : None
#|#             : Use this var to set 
#|#             : Use this var to set 
#|# ${1}        : Use this var to set [  ]                
#|# ${2}        : Use this var to set [  ]               
#|#
#|# Base usage  : None
#|#
#|# Description : None
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

MSG_DISPLAY "info" "1" "this is a model function"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}








# Sourcing control variable 
LibState="OK"  
