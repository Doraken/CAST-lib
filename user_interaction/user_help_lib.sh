#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                 #
# Subject : This library provide base functions to manage help withing menu   #
#                                                                             #
###############################################################################
####
# INFO

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

function Get_HELP
{
#|# Var to set  : None
#|#             : Use this var to set
#|#             : Use this var to set
#|# ${1}        : Use this var to set [ help file to use ]
#|# ${2}        : Use this var to set [ Base help TAG ]
#|# ${3}        : Use this var to set [ refinet help tag ]
#|#
#|# Base usage  : Get_HELP "Help File" "Base help tag" "Refined Help Tag"
#|#
#|# Description : None
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################


local _HelpFileUsed="${1}"
local _HelpBaseTAG="${2}"
local _HelpRefineBaseTAG="${3}"


cat ${_HelpFileUsed}| grep "^${_HelpBaseTAG}" | grep "${_HelpRefineBaseTAG}i" | awk -F"#\|#" '{ print $3 }'

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"