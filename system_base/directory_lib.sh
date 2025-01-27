#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic auto documentation from CAST 
# Subject : This library provides base runtime to check directory properties   #
#                                                                         #
###############################################################################
####

################################## Directory Functions ##################################

function Dir_null_or_slash ()
 {
#|# Var to set  :
#|# Path_To_test : The path of the directory to test
#|# ${1}         : First parameter, used to set Path_To_test
#|# 
#|# Description : This function checks if the provided directory path is either empty
#|# or just a root slash ('/'). If either condition is met, an error message is displayed.
#|#
#|# Basic Usage : 
#|#               Dir_null_or_slash "My_directory_path"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

    local Path_To_test="${1}"

# Check if the path is empty
    if [ -z "${Path_To_test}" ]
    then 
        MSG_DISPLAY "check" "0" "Checking directory: [ ${Path_To_test} ] "
        MSG_DISPLAY "EdEMessage" "1" "Error ON PATH: [ Value is NULL ]"
    else 
    # Check if the path is just a root slash ('/')
        if [ "${Path_To_test}" = "/" ]
    then 
            MSG_DISPLAY "check" "0" "Checking directory: [ ${Path_To_test} ] "
            MSG_DISPLAY "EdEMessage" "1" "Error ON PATH: [ Value is / ]"
        fi
    fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Set_new_directory () 
{
#|# Var to set  :
#|# Base_param_Dir_To_Create    : The directory path to control and create if necessary
#|# ${1}                        : First parameter, used to set Base_param_Dir_To_Create
#|# 
#|# Description : This function checks if a directory exists, and if not, it creates it.
#|# If the directory path is invalid or the directory cannot be created, appropriate 
#|# messages are displayed. It also prevents the function from being run more than once.
#|#
#|# Basic Usage : 
#|#               Set_new_directory "My_Directory"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

    local Base_param_Dir_To_Create="${1}"
    
    Dir_null_or_slash "${Base_param_Dir_To_Create}"
    MSG_DISPLAY "check" "0" "Checking directory: [ ${Base_param_Dir_To_Create} ] "
    
    if [[ ${runned} -gt 1 ]]
    then 
        MSG_DISPLAY "EdEMessage" "2" "NOT CREATED"
    else 
    # Check if the directory exists
        if [ -d "${Base_param_Dir_To_Create}" ]
           then 
               MSG_DISPLAY "EdSMessage" "1" "Present"
               runned="0"
            else 
               MSG_DISPLAY "EdWMessage" "2" "NOT FOUND"
               mkdir -p ${Base_param_Dir_To_Create} >/dev/null 2>&1
               runned=$(expr ${runned} + 1 )
               Set_new_directory "${Base_param_Dir_To_Create}"
        fi
    fi 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_directory_list ()
{
#|# Var to set  :
#|# Base_param_Dir      : The base directory where subdirectories are to be listed
#|# Sendback_Dir_Listed : Variable to store the result of the directory listing
#|# 
#|# Description : This function lists all subdirectories within a specified directory.
#|# It verifies that each listed item is indeed a directory before adding it to the 
#|# result. The result is stored in the Sendback_Dir_Listed variable.
#|#
#|# Basic Usage : 
#|#               Get_directory_list "Base_directory" "Result_Variable"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

    local Base_Param_Dir_To_TEST="${Base_param_Dir}"
    local Result_Var_Name="${2}"
    local Sendback_Dir_Listed=""

    Test_directory "${Base_Param_Dir_To_TEST}"
    
    for Dirs_Listed in $(ls -1 ${Base_param_Dir}/)
         do 
            if [ -d "${Base_param_Dir}/${Dirs_Listed}" ]
              then 
                  MSG_DISPLAY "debug" "0" "Directory found: [ ${Dirs_Listed} ] "
                  Sendback_Dir_Listed="${Sendback_Dir_Listed} ${Dirs_Listed}"
               else 
                  MSG_DISPLAY "debug" "0" "Found: [ ${Dirs_Listed} ] but it is not a directory"
        fi 
    done 

    eval "${Result_Var_Name}='${Sendback_Dir_Listed}'"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Test_directory () 
{
#|# Var to set  :
#|# Base_Param_Dir_To_TEST : The directory path to test
#|# ${1}                   : First parameter, used to set Base_Param_Dir_To_TEST
#|#
#|# Description : This function checks if a directory exists at the specified path.
#|# It displays a message indicating whether the directory was found or not.
#|#
#|# Basic Usage : 
#|#               Test_directory "My_directory_full_path"

############ STACK_TRACE_BUILDER #####################
    Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

    local Base_Param_Dir_To_TEST="${1}"
    MSG_DISPLAY "check" "0" "Checking directory: [ ${Base_Param_Dir_To_TEST} ] "
    
# Check if the directory exists
    if [ -d "${Base_Param_Dir_To_TEST}" ]
      then 
         MSG_DISPLAY "EdSMessage" "1" "FOUND" 
      else 
         MSG_DISPLAY "EdEMessage" "1" "Not FOUND" 
    fi 

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"
