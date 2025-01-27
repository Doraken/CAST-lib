#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                             #
# Subject : This library provides base system command tuning environment #
#                                                                         #
###############################################################################
####

################################## System Tuning Functions ##################################

function Get_system_tunning ()
{
#|# Var to set  :
#|# SYSTEM_NAME  : The name of the current operating system
#|#
#|# Description : This function detects the operating system and calls the appropriate 
#|# sub-function to set system-specific variables for script tuning.
#|#
#|# Base Usage : Get_system_tunning
#|#
#|# Returns : Executes the relevant system-specific tuning function
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
    
    SYSTEM_NAME=$(uname)
    case ${SYSTEM_NAME} in 
        Linux|linux|LINUX) 
            echo "Tuning scripts vars for [ ${SYSTEM_NAME} ] "
            Get_system_tunning_SUB_LINUX
            ;;
        AIX|aix|Aix) 
            echo "Tuning scripts vars for [ ${SYSTEM_NAME} ] "
            Get_system_tunning_SUB_AIX
            ;;
        SunOS|SUNOS|sunos) 
            echo "Tuning scripts vars for [ ${SYSTEM_NAME} ] "
            Get_system_tunning_SUB_SOLARIS
            ;;
        *) 
            echo "Not yet supported system [ ${SYSTEM_NAME} ] "
            CAST_SUPPORT_MSG "1"
            ;;
    esac 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_system_tunning_SUB_LINUX ()
{
#|# Description : This function sets system-specific variables for Linux environments.
#|# It includes commands for retrieving user information, uncompressing files, and
#|# detecting the Linux distribution.
#|#
#|# Base Usage : Called internally by Get_system_tunning
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

function Get_linux_distro () 
{
#|# Description : This function determines the Linux distribution type and sets the
#|# default package manager accordingly. If the distribution is not supported, it
#|# provides a warning message.
#|#
#|# Base Usage : Called internally by Get_system_tunning_SUB_LINUX
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


    MSG_DISPLAY "check" "0" "Determining kind of Linux:"
    if [ -f /etc/os-release ]
     then
        . /etc/os-release
        case "${ID}" in
            debian) 
                MSG_DISPLAY "EdSMessage" "0" "${ID}"
                GLB_default_package_manager="apt"
                ;;
            ubuntu) 
                MSG_DISPLAY "EdSMessage" "0" "${ID}"
                GLB_default_package_manager="apt"
                ;;
            rhel|centos|fedora) 
                MSG_DISPLAY "EdSMessage" "0" "${ID}"
                GLB_default_package_manager="yum"
                ;;
            *) 
                MSG_DISPLAY "EdWMessage" "0" "${ID} - ${NAME} "
                MSG_DISPLAY "info" "0" "Unsupported Linux distro"
                CAST_SUPPORT_MSG
                ;;
        esac
    else
        MSG_DISPLAY "EdWMessage" "0" "unknown"
        MSG_DISPLAY "info" "0" "Unsupported Linux distro"
        CAST_SUPPORT_MSG
    fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_system_tunning_SUB_AIX () 
{
#|# Description : This function sets system-specific variables for AIX environments.
#|# It includes commands for retrieving user information, uncompressing files, and
#|# recompressing files using gzip.
#|#
#|# Base Usage : Called internally by Get_system_tunning
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
    
    CMD_WHO="who -m"
    CMD_UNCOMPRESS_ZIP="gzip -d ${OLD_PWD}/${PACKAGE}" 
    CMD_UNCOMPRESS_TAR="tar -xvf ${OLD_PWD}/${PKG_noext}.tar"
    CMD_RECOMPRESS_ZIP="gzip ${OLD_PWD}/${PKG_noext}.tar"
    PKGFile_Type_Comp="gzip"
    PKGFile_Type_Comp_SYSSPEC="data"
    
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_system_random_number () 
{
#|# Var to set  :
#|# EXTERNAL_randomized_var : The variable that stores the generated random number
#|#
#|# Description : This function generates a random number and stores it in the
#|# EXTERNAL_randomized_var variable for further use.
#|#
#|# Base Usage : Get_system_random_number
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
    
    EXTERNAL_randomized_var="${RANDOM}"
    MSG_DISPLAY "debug" "0" "Current Randomized VAR : [ ${EXTERNAL_randomized_var} ] "

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Set_system_counter ()
{
#|# Var to set  :
#|# Set_system_counter_TO_init  : Initializes the counter to 0 if set to "init"
#|# ${1}                        : First parameter, used to set Set_system_counter_TO_init
#|# External_Return_Counter     : Variable that returns the counter value
#|#
#|# Description : This function manages a system counter that can be initialized or
#|# incremented. It returns the current counter value.
#|#
#|# Base Usage : Set_system_counter "init" 
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
    
    local Set_system_counter_TO_init="${1}"

    Empty_Var_Control "${Set_system_counter_TO_init}" "Set_system_counter_TO_init" "4"

    External_Return_Counter="0" 
    if [ "${Set_system_counter_TO_init}" = "init" ]; then 
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
