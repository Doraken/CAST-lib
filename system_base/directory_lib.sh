#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic auto documentation from CAST 
# Subject : This library provide base runtime to check directory properties   #
#                                                                             #
###############################################################################
####
# INFO 


################################## Directory function 

function Dir_null_or_slash
{
#|# Path_To_test : Use this var to set the path to test 
#|# ${1}         : use this var to set Path_To_test
#|# base usage   :
#|#                Dir_null_or_slash "My_directory_path"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

local Path_To_test="${1}"


if [ -z "${Path_To_test}" ] 
   then 
         MSG_DISPLAY "check" "0" "Checking  directory : [ ${Path_To_test} ] "
   	   MSG_DISPLAY "EdEMessage" "1" " Error ON PATH  : [ Value is NULL ]"
   else 
       if [ "${Path_To_test}" = "/" ]
          then 
               MSG_DISPLAY "check" "0" "Checking  directory : [ ${Path_To_test} ] "
           	   MSG_DISPLAY "EdEMessage" "1" " Error ON PATH  : [ Value is / ]"
      fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}



function Set_new_directory
{
#|# Base_param_Dir_To_Create    : use this var to set which irectory to control and create
#|# ${1}                        : use this var to set Base_param_Dir_To_Create
#|# Basic usage : 
#|#               Set_new_directory "My_Directory"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

local Base_param_Dir_To_Create="${1}"
 
Dir_null_or_slash "${Base_param_Dir_To_Create}"
MSG_DISPLAY "check" "0" "Checking  directory : [ ${Base_param_Dir_To_Create} ] "
if [[ ${runned} -gt 1 ]] 
   then 
       MSG_DISPLAY "EdEMessage" "2" "NOT CREATED"
   else 
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

function Get_directory_list
{
#|# Base_param_Dir      : use this var to set wher to list subdirectory
#|# Sendback_Dir_Listed : this var is used to keep result of listing  

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
   do if [ -d "${Base_param_Dir}/${Dirs_Listed}" ]
         then 	   
             MSG_DISPLAY "debug" "0" "Directory found : [ ${Dirs_Listed} ] "
             Sendback_Dir_Listed="${Sendback_Dir_Listed} ${Dirs_Listed}"
	     else 
             MSG_DISPLAY "debug" "0" "Found : [ ${Dirs_Listed} ] but it s not a directory "
      fi 
done 

eval "${Result_Var_Name}='${Sendback_Dir_Listed}'"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Test_directory
{
#|# Base_Param_Dir_To_TEST : Use this var to set which directory to test 
#|# ${1}                   : User this var to set Base_Param_Dir_To_TEST
#|# Basic use :
#|#             
#|#              Test_directory "My_directory_full_path"

############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

local Base_Param_Dir_To_TEST="${1}"
MSG_DISPLAY "check" "0" "Checking  directory : [ ${Base_param_Dir_To_Create} ] "
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

LibState="OK"
