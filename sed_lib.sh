#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.
 
# INFO                                                                      #
# Subject : This library provide base functions to manage sed  
 

################################################################################
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
 

MSG_DISPLAY "info" "1" "this is a model function"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_sed_replace_string
{
#|# Var to set  : 
#|# ${1}        : Use this var to set [ Original string to replace ]
#|# ${2}        : Use this var to set [ New string ] 
#|# ${3}        : Use this var to set [ File to edit ]
#|# ${4}        : Use this var to set [ Extended status message ]
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
 

local _Orig_String="${1}" 
local _New_String="${2}" 
local _File_Edited="${3}"
local _Ext_Message="${4}"

Empty_Var_Control "${_Orig_String}" "_Orig_String" "4"
Empty_Var_Control "${_New_String}"  "_New_String"  "4"
Empty_Var_Control "${_File_Edited}" "_File_Edited" "4"
Empty_Var_Control "${_Ext_Message}" "_Ext_Message" "4"


MSG_DISPLAY "check" "0" "Editing file ${Base_Param_File_To_TEST} to replace ${_Orig_String}"

sed -i 's/${_Orig_String}/${_New_String}/g' ${_File_Edited} >> /dev/null 





############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"