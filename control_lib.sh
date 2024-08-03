###############################################################################
# Control.lib                                          Version : 1.1.2.3      #
#                                                                             #
# Creation Date : 25/11/2006                                                  #
# Team          : Only me after all                                           #
# Support mail  : doraken@doraken.net                                          #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provide base control and error messaging runtime     #
#                                                                             #
###############################################################################
####
# INFO



function CTRL_Stop_point
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "


if [ "${Can_Stop_level}" = "${Stop_Level}" ]
   then
        MSG_DISPLAY "info" "0" "Stop requested by configuration : Stoped at ${Stop_Level} "
        exit 0
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

################## Control execution Runtime

function CTRL_Result_func
{
#|# Var to set  :
#|# CRF_Result_Action             : Use this var to set The las action returne code         ( Mandatory )
#|# CRF_Generic_Base_MSG          : use this var to set base message of control             ( Mandatory )
#|# CRF_Generic_Base_MSG_ERR      : Use this var to set additional iformation on error      ( Mandatory )
#|# CRF_Result_ERR_Level          : Use this var to set the level of test severity on fail  ( Mandatory )
#|# CRF_Action_ONFAIL             : Use this var to set and action to do after CTRL fail    (  OPTIONAL )
#|# CRF_Action_ONOK               : Use this var to set and action to do after CTRL is OK   (  OPTIONAL )
#|# ${1}                          : Use this var to set [ CRF_Result_Action ]
#|# ${2}                          : Use this var to set [ CRF_Generic_Base_MSG ]
#|# ${3}                          : Use this var to set [ CRF_Generic_Base_MSG_ERR ]
#|# ${4}                          : Use this var to set [ CRF_Result_ERR_Level ]
#|# ${5}                          : Use this var to set [ CRF_Action_ONFAIL ]
#|# ${6}                          : Use this var to set [ CRF_Action_ONOK ]
#|#
#|# Base usage  : CTRL_Result_func "${?}" "Generic_Base_Param_MSG" "Generic_Base_Param_MSG_ERR" "Result_ERR_Level" "On fail action" "on success action"
#|#
#|# Description : This function is used to check result of a past action and choose action
#|#
#|# Send Back   : Message / Exit / function
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "


local CRF_Result_Action="${1}"
local RF_Generic_Base_MSG="${2}"
local CRF_Generic_Base_MSG_ERR="${3}"
local CRF_Result_ERR_Level="${4}"
local CRF_Action_ONFAIL="${5}"
local CRF_Action_ONOK="${6}"


if [ "${CRF_Result_Action}" = "0" ]
   then
        MSG_DISPLAY "EdSMessage" "0" ""
        if ! [ -z "${CRF_Action_ONOK}" ]
              then
                  _Ido="${CRF_Action_ONOK}"
                  CRF_Action_ONOK=""
                  ${_Ido}
        fi
   else
        MSG_DISPLAY "EdEMessage" "1" "${CRF_Generic_Base_MSG} ${CRF_Generic_Base_MSG_ERR} [ ERROR  ] " "${CRF_Result_ERR_Level}"
        if ! [ -z "${CRF_Action_ONFAIL}" ]
              then
              	   _Ido="${CRF_Action_ONFAIL}"
              	   CRF_Action_ONFAIL=""    
                   ${_Ido}
        fi
fi
Generic_Base_Param_MSG_ERR=""
CRF_Generic_Base_MSG=""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function CTRL_Result_Echeck
{
#|# Var to set  :
#|# CRF_Result_Action             : Use this var to set The las action returne code         ( Mandatory )
#|# CRF_Result_ERR_Level          : Use this var to set the level of test severity on fail  ( Mandatory )
#|# CRF_Action_ONFAIL             : Use this var to set and action to do after CTRL fail    (  OPTIONAL )
#|# CRF_Action_ONOK               : Use this var to set and action to do after CTRL is OK   (  OPTIONAL )
#|# ${1}                          : Use this var to set [ CRF_Result_Action ]
#|# ${2}                          : Use this var to set [ CRF_Result_ERR_Level ]
#|# ${3}                          : Use this var to set [ CRF_Action_ONFAIL ]
#|# ${4}                          : Use this var to set [ CRF_Action_ONOK ]
#|#
#|# Base usage  : CTRL_Result_func "${?}" "Result_ERR_Level" "On fail action" "on success action"
#|#
#|# Description : This function is used to check result of a past action and choose action
#|#
#|# Send Back   : Message / Exit / function
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "


local CRF_Result_Action="${1}"
local CRF_Result_ERR_Level="${2}"
local CRF_Action_ONFAIL="${3}"
local CRF_Action_ONOK="${4}"


if [ "${CRF_Result_Action}" = "0" ]
   then
        MSG_DISPLAY "EdSMessage" "1" ""
        if ! [ -z "${CRF_Action_ONOK}" ]
              then
                  _Ido="${CRF_Action_ONOK}"
                  CRF_Action_ONOK=""
                  ${_Ido}
        fi
   else
         MSG_DISPLAY "EdEMessage" "1" ""
        if ! [ -z "${CRF_Action_ONFAIL}" ]
              then
              	   _Ido="${CRF_Action_ONFAIL}"
              	   CRF_Action_ONFAIL=""    
                   ${_Ido}
        fi
        if [ ${CRF_Result_ERR_Level} -gt 0 ] 
            then 
                  exit ${CRF_Result_ERR_Level}
        fi
fi
Generic_Base_Param_MSG_ERR=""
CRF_Generic_Base_MSG=""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

###############  System check

function CTRL_USER_EXIST
{
#|# _user_tc : Use this var to set the username to check
#|# Returne_Code_CTRL_USER_EXIST : This var is used to send back information of result of control
#|# Basic usage :
#|#               _user_tc="My_account"
#|#               CTRL_USER_EXIST
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

local _user_tc="${1}"

MSG_DISPLAY "check" "0" "Seaching user ${_user_tc} "
USR_EXTRACTED=$(cat /etc/passwd | grep ${_user_tc} | awk -F: '{ print $1 }')
if [ "${USR_EXTRACTED}" = "${_user_tc}" ]
   then
        MSG_DISPLAY "EdSMEessage" "0"
        Returne_Code_CTRL_USER_EXIST="OK"
   else
        MSG_DISPLAY "EdEMessage" "1"
        Returne_Code_CTRL_USER_EXIST="NOK"
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function CTRL_GROUP_EXIST
{
#|# Base_Group_To_Check : Use this var to set the group name to check
#|# Returne_Code_CTRL_GROUP_EXIST : This var is used to send back information of result of control
#|# Basic usage :
#|#               _user_tc="My_group"
#|#               Base_Group_To_Check
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "


USR_EXTRACTED=$(cat /etc/group | grep ${Base_Group_To_Check} | awk -F: '{ print $1 }')
if [ "${USR_EXTRACTED}" = "${_user_tc}" ]
   then
                MSG_DISPLAY "debug" "0" "USER ${Base_Group_To_Check} : [ ALREADY PRESENT ] "
        Returne_Code_CTRL_GROUP_EXIST="OK"
   else
        MSG_DISPLAY "debug" "0" "USER ${Base_Group_To_Check} : [ NOT PRESENT ] "
        Returne_Code_CTRL_GROUP_EXIST="NOK"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Empty_Var_Control
{
#|# Var to set  :
#|# EVC_Var_To_Test       : Use this var to set the path to test                                 ( Mandatory )
#|# EVC_Var_Name_To_Test  : Use this var to set the name of the var to test for display messages ( Mandatory )
#|# EVC_Level_Of_ERR      : Use this var to set the severity level of an empty vars              ( Mandatory )
#|# EVC_MSG_add           : Use this var to set complementary message                            ( OPTIONAL )
#|# EVC_Action_ONFAIL     : Use this var to set anb action to do after CTRL fail                 ( OPTIONAL )
#|# EVC_Action_ONOK       : Use this var to set anb action to do after CTRL is OK                ( OPTIONAL )
#|# ${1}                  : Used to set [ Base_Var_to_test ]
#|# ${2}                  : Used to set [ Base_Var_Name_To_Test ]
#|# ${3}                  : Used to set [ Level_Of_ERR ]
#|# ${4}                  : Used to set [ EVC_MSG_add ]
#|# ${5}                  : Used to set [ Action_ONFAIL ]
#|# ${6}                  : Used to set [ Action_ONOK ]
#|#
#|# Base usage  : Empty_Var_Control "My_VAR" "My_Var_Name" "Level_Of_ERR" [ "MSG_add" "Action_ONFAIL" "Action_ONOK" ]
#|#
#|# Description : This function is used to check if a var is empty
#|#
#|# Send Back   : Send back result of check
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "


local EVC_Var_To_Test="${1}"
local EVC_Var_Name_To_Test="${2}"
local EVC_Level_Of_ERR="${3:-1}"
local EVC_MSG_add="${4}"
local EVC_Action_ONFAIL="${5}"
local EVC_Action_ONOK="${6}"

if [[ -z "${EVC_Var_To_Test}" ]]
   then
       if [[ ! -z "${EVC_Action_ONFAIL}" ]]
              then
                   MSG_DISPLAY "Info" "0" "current function path : [ ${Function_PATH} ] "
                   MSG_DISPLAY "check" "0" "Error variable ${EVC_Var_Name_To_Test} [ Not Set ]" 
                   MSG_DISPLAY "EdWMessage" "0" "executing :  ${EVC_Action_ONFAIL}"
                   ${EVC_Action_ONFAIL}
              else
                   MSG_DISPLAY "Info" "0" "current function path : [ ${Function_PATH} ] "
                   MSG_DISPLAY "check" "0" "Error variable ${EVC_Var_Name_To_Test} [ Not Set ]" 
                   MSG_DISPLAY "EdEMessage" "${EVC_Level_Of_ERR}" ""
           fi
   else
       MSG_DISPLAY "debug" "0" " Value of ${EVC_Var_Name_To_Test}  : [ Value is ${EVC_Var_To_Test} ]"
       if [[ ! -z "${EVC_Action_ONOK}" ]]
          then
              ${EVC_Action_ONOK}
       fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

LibState="OK"
