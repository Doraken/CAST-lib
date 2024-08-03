#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                 #
# Subject : This library provides base system command tunnig env              #
#                                                                             #
###############################################################################
####
# INFO 


function Get_system_tunning
{
#|# Var to set   : 
#|# SYSTEM_NAME  : use this var to set system name of the current operation system
#|#
#|# Base usage   : Get_system_tunning
#|#
#|# Returne : Function execution   
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
  SYSTEM_NAME=$(uname)
  case ${SYSTEM_NAME} in 
       Linux|linux|LINUX) echo  "Tunning scripts vars for [ ${SYSTEM_NAME} ] "
                          Get_system_tunning_SUB_LINUX
                       ;;
             AIX|aix|Aix) echo  "Tunning scripts vars for [ ${SYSTEM_NAME} ] "
                          Get_system_tunning_SUB_AIX
                       ;;
             SunOS|SUNOS|sunos) echo  "Tunning scripts vars for [ ${SYSTEM_NAME} ] "
                          Get_system_tunning_SUB_SOLARIS
                       ;;
                       *)echo  "Not yet suppoted system [ ${SYSTEM_NAME} ] "
                         CAST_SUPPORT_MSG "1"
                       ;;
  esac 
}

function Get_system_tunning_SUB_LINUX 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
 
 CMD_WHO="who i am"
 CMD_UNCOMPRESS_ZIP=""
 CMD_UNCOMPRESS="tar xvzf ${OLD_PWD}/${PACKAGE} "
 CMD_RECOMPRESS_ZIP=""
 PKGFile_Type_Comp="gzip"
 PKGFile_Type_Comp_SYSSPEC="data"
 Get_linux_distro

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}



function Get_linux_distro {
    #|# /**
    #|#  * detect_linux_distro
    #|#  * @desc Determines the Linux distribution type
    #|#  * @return Prints the type of Linux distribution: Debian, Ubuntu, Red Hat, or others
    #|#  *
    #|#  * Usage:
    #|#  * detect_linux_distro
    #|#  **/
    
    MSG_DISPLAY "check" "0" "Determining kind of linux :"
    if [ -f /etc/os-release ]
      then
        . /etc/os-release
        case "${ID}" in
            debian) MSG_DISPLAY "EdSMessage" "0" "${ID}"
                    GLB_default_package_manager="apt"
                ;;
            ubuntu) MSG_DISPLAY "EdSMessage" "0" "${ID}"
                    GLB_default_package_manager="apt"
                ;;
            rhel|centos|fedora) MSG_DISPLAY "EdSMessage" "0" "${ID}"
                                GLB_default_package_manager="yum"
                ;;
            *)
               MSG_DISPLAY "EdWMessage" "0" "${ID} - ${NAME} "
               MSG_DISPLAY "info" "0" "Unsupported linux distro"
               CAST_SUPPORT_MSG
                ;;
        esac
    else
        MSG_DISPLAY "EdWMessage" "0" "unknown"
        MSG_DISPLAY "info" "0" "Unsupported linux distro"
        CAST_SUPPORT_MSG
    fi
 
}


function Get_system_tunning_SUB_AIX
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
 
 CMD_WHO="who -m"
 CMD_UNCOMPRESS_ZIP="gzip -d ${OLD_PWD}/${PACKAGE}" 
 CMD_UNCOMPRESS_TAR="tar -xvf ${OLD_PWD}/${PKG_noext}.tar"
 CMD_RECOMPRESS_ZIP="gzip ${OLD_PWD}/${PKG_noext}.tar  "
 PKGFile_Type_Comp="gzip"
 PKGFile_Type_Comp_SYSSPEC="data"
 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_system_random_,number
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

EXTERNAL_randomized_var="${RANDOM}"
MSG_DISPLAY "debug" "0" "Current Randomized VAR  : [ ${EXTERNAL_randomized_var} ] "


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Set_system_counter
#|# Set_system_counter_TO_init             : use this var to init counter to 0
#|# ${1}                               : use this var to set Set_system_counter_TO_init
#|# External_Return_Counter            : is used to returne counter value
#|# Basic use                          : Set_system_counter_TO_init "[ To init ]"
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
local Set_system_counter_TO_init="${1}"

Empty_Var_Control "${Set_system_counter_TO_init}" "Set_system_counter_TO_init" "4"

External_Return_Counter="0" 
if [ "${Set_system_counter_TO_init}" = "init" ]
   then 
   	   Internal_var_count="0"
   else
       Internal_var_count="$( expr ${Internal_var_count} + 1 )"
fi 
External_Return_Counter="${Internal_var_count}"       


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################	
} 

# Sourcing control variable 
LibState="OK"