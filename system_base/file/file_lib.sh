#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                          #
# Subject : This library provide base file controls runtimes for file         #
#           management                                                        #
###############################################################################
####
# INFO

######################### Files functions



function Test_file_extend
{
#|# Var to set  :
#|# INTERNAL_File_To_TEST      : Use this var to set the fileto test                   ( Mandatory )
#|# INTERNAL_Ext_To_TEST       : Use this var to set the ext to test                   ( Mandatory )
#|# INTERNAL_CRITICITY_OF_FAIL : Use this var to set the level of the error            ( Mandatory )
#|# INTERNAL_ACTION_ON_FAIL    : Use this var to set the action to do if the test FAIL ( Optional )
#|# INTERNAL_ACTION_ON_SUCCESS : Use this var to set the action to do if the test FAIL ( Optional )
#|# ${1}                       : use this var to set [ INTERNAL_File_To_TEST ]
#|# ${2}                       : use this var to set [ INTERNAL_Ext_To_TEST ]
#|# ${3}                       : use this var to set [ INTERNAL_CRITICITY_OF_FAIL ]
#|# ${4}                       : use this var to set [ INTERNAL_ACTION_ON_FAIL ]
#|# ${5}                       : use this var to set [ INTERNAL_ACTION_ON_SUCCESS ]
#|#
#|# Base usage  : Test_file_extend "My_File" "My_ext" "INTERNAL_CRITICITY_OF_FAIL" "INTERNAL_ACTION_ON_FAIL" "INTERNAL_ACTION_ON_SUCCESS"
#|#
#|# Description : This function is used to chek if a file exist or not and do specifics actions in both case
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local INTERNAL_File_To_TEST="${1}"
local INTERNAL_Ext_To_TEST="${2}"
local INTERNAL_CRITICITY_OF_FAIL="${3}"
local INTERNAL_ACTION_ON_FAIL="${4}"
local INTERNAL_ACTION_ON_SUCCESS="${5}"

  Empty_Var_Control "${INTERNAL_File_To_TEST}"       "INTERNAL_File_To_TEST"         "4"
  Empty_Var_Control "${INTERNAL_Ext_To_TEST}"        "INTERNAL_Ext_To_TEST"          "4"
  Empty_Var_Control "${INTERNAL_CRITICITY_OF_FAIL}"  "INTERNAL_CRITICITY_OF_FAIL"    "4"

INTERNAL_EXT_SIZE="$( echo ${INTERNAL_Ext_To_TEST} | awk -F\. '{ print NF }' )"
INTERNAL_FILE_EXT_SIZE="$( echo ${INTERNAL_File_To_TEST} | awk -F\. '{ print NF }'  )"
INTERNAL_FILE_EXT_SIZE="$( expr ${INTERNAL_FILE_EXT_SIZE} - 1 )"

RUN_IN="1"
FIELD_TO_GET="2"
FILE_FINAL_EXT=$(echo "${INTERNAL_File_To_TEST}" | awk -F\. -v VAR1=${FIELD_TO_GET} '{ print $VAR1 }' )
until [ "${RUN_IN}" = "${INTERNAL_FILE_EXT_SIZE}" ]
     do
       RUN_IN="$( expr ${RUN_IN} + 1 )"
       FIELD_TO_GET="$( expr ${FIELD_TO_GET} + 1 )"
       FILE_FINAL_EXT="${FILE_FINAL_EXT}.$(echo ${INTERNAL_File_To_TEST} | awk -F\. -v VAR1=${FIELD_TO_GET} '{ print $VAR1 }' )"
done

if ! [ "${FILE_FINAL_EXT}" = "${INTERNAL_Ext_To_TEST}" ]
   then
      MSG_DISPLAY "EdEMessage" "1" "Bad extention on file ${INTERNAL_File_To_TEST} : [ ${FILE_FINAL_EXT} ]" "${INTERNAL_CRITICITY_OF_FAIL}"
       if ! [ -z "${INTERNAL_ACTION_ON_FAIL}" ]
              then
                   ${INTERNAL_ACTION_ON_FAIL}
           fi
   else
       MSG_DISPLAY "debug" "0" " File extention for ${INTERNAL_File_To_TEST} : [ OK ]"
       if ! [ -z "${INTERNAL_ACTION_ON_SUCCESS}" ]
              then
                   ${INTERNAL_ACTION_ON_SUCCESS}
           fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Test_file_type
{
#|# Var to set  :
#|# INTERNAL_FILE_TO_TEST  : Use this var to set the file name of the file to test     ( Mandatory )
#|# INTERNAL_FILE_TYPE     : Use this var to set the type of file to obtain            ( Mandatory )
#|# INTERNAL_ERR_TYPE      : Use this var to set the type of error on fail             ( Mandatory )
#|# INTERNAL_ERR_LEVEL     : Use this var to set the level of the error                ( Mandatory )
#|# ACTION_ON_FAIL         : Use this var to set the action to take on failled test    ( Optional )
#|# ACTION_ON_SUCCESS      : Use this var to set the action to take on successful test ( Optional )
#|# ${1}                   : Use this var to set [ INTERNAL_FILE_TO_TEST ]
#|# ${2}                   : Use this var to set [ INTERNAL_FILE_TYPE ]
#|# ${3}                   : Use this var to set [ INTERNAL_ERR_TYPE ]
#|# ${4}                   : Use this var to set [ ACTION_ON_FAIL ]
#|# ${5}                   : Use this var to set [ ACTION_ON_FAIL ]
#|# ${6}                   : Use this var to set [ ACTION_ON_SUCCESS ]
#|# Base usage
#|#    Test_file_type  "INTERNAL_FILE_TO_TEST" "INTERNAL_FILE_TYPE" "INTERNAL_ERR_TYPE" "INTERNAL_ERR_LEVEL"  [ "ACTION_ON_FAIL" "ACTION_ON_SUCCESS" ]
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local INTERNAL_FILE_TO_TEST="${1}"
local INTERNAL_FILE_TYPE="${2}"
local INTERNAL_ERR_TYPE="${3}"
local INTERNAL_ERR_LEVEL="${4}"
local ACTION_ON_FAIL="${5}"
local ACTION_ON_SUCCESS="${6}"

Empty_Var_Control "${INTERNAL_FILE_TO_TEST}" "INTERNAL_FILE_TO_TEST"  "4"
Empty_Var_Control "${INTERNAL_FILE_TYPE}"    "INTERNAL_FILE_TYPE"     "4"
Empty_Var_Control "${INTERNAL_ERR_LEVEL}"    "INTERNAL_ERR_LEVEL"     "4"



echo "${ACTION_ON_FAIL}"
INTERNAL_FileType=$( file ${INTERNAL_FILE_TO_TEST} | awk '{ print $2 }' )
if [ "${INTERNAL_FileType}" = "${INTERNAL_FILE_TYPE}" ]
   then
       MSG_DISPLAY "debug" "0" " File  ${Base_Param_File_To_TEST} type control : [ PASSED ] "
       if ! [ -z "${ACTION_ON_SUCCESS}" ]
              then
                   ${ACTION_ON_SUCCESS}
           fi
   else
       MSG_DISPLAY "debug" "0" " File ${Base_Param_File_To_TEST} : [ ERROR ] "
       MSG_DISPLAY "${INTERNAL_ERR_TYPE}" "${INTERNAL_ERR_LEVEL}" " File type ${Base_Param_File_To_TEST} : [ ${INTERNAL_FileType} ] " 
       if ! [ -z "${ACTION_ON_FAIL}" ]
              then
                   ${ACTION_ON_FAIL}
           fi
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_file_type
{
#|# Var to set  :
#|# Base_Param_File_To_get_type : use this var to set which file to controle                       ( Mandatory )
#|# Get_file_type_on_fail       : use this vas to set which action to do on failled check
#|# Get_file_type_on_success    : use this var to set which action to do on success check
#|# File_type_to_Return         : This vas is used to send back file type to the calling function
#|# ${1}                        : Use this var to set [ Base_Param_File_To_TEST ]
#|# ${2}                        : Use this var to set [ Get_file_type_on_fail ]
#|# ${3}                        : use this var to set [ Get_file_type_on_success ]
#|# Basic Usage : Get_file_type "My file to get type"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local Base_Param_File_To_get_type="${1}"
local Get_file_type_on_fail="${2}"
local Get_file_type_on_success="${3}"
local Criticity_base="2"

Empty_Var_Control "${Base_Param_File_To_get_type}" "Base_Param_File_To_get_type"  "4"



if ! [ -z "${Get_file_type_on_fail}" ]
   then
        Internal_ACT_FAIL="${Get_file_type_on_fail}"
        Criticity_base="0"
   else
        Internal_ACT_FAIL=""
fi
if ! [ -z "${Get_file_type_on_fail}" ]
   then
        Internal_ACT_SUCCESS="${Get_file_type_on_success}"
        Criticity_base="0"
   else
        Internal_ACT_SUCCESS=""
fi


Test_file_presence "${Base_Param_File_To_get_type}" "Dont_Create_File" "${Criticity_base}" "${Internal_ACT_FAIL}"  "${Internal_ACT_SUCCESS}"
File_type_to_Return="$(file ${Base_Param_File_To_get_type} | awk '{ print $2 }' )"
MSG_DISPLAY "debug" "0" " File : [ ${Base_Param_File_To_get_type} ] Type : [ ${File_type_to_Return} ]"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Test_file_presence
{
#|# Var to set  :
#|# Base_Param_File_To_TEST               : use this var to set which file to controle
#|# lib_Test_file_presence_create           : Use this var to set if you want to create the file if he wn't exist
#|# lib_Test_file_presence_critic_level     : Use this var to set the serverity exit level
#|# lib_Test_file_presence_onfail_action    : Use this var to set the action to do on failed condition
#|# lib_Test_file_presence_onsuccess_action : Use this var to set the action to do on passed condition
#|# ${1}                                  : Use this var to set [ Base_Param_File_To_TEST ]
#|# ${2}                                  : Use this var to set [ lib_Test_file_presence_create ]
#|# ${3}                                  : Use this var to set [ lib_Test_file_presence_critic_level ]
#|# ${4}                                  : Use this var to set [ lib_Test_file_presence_onfail_action ]
#|# ${5}                                  : Use this var to set [ lib_Test_file_presence_onsuccess_action ]
#|#
#|# Base usage  : Test_file_presence "file to control" "Dont_Create_File" "criticity_of_fail"  "Action on fail"  "Action on success"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local Base_Param_File_To_TEST="${1}"
local lib_Test_file_presence_create="${2}"
local lib_Test_file_presence_critic_level="${3}"
local lib_Test_file_presence_onfail_action="${4}"
local lib_Test_file_presence_onsuccess_action="${5}"
 
Empty_Var_Control "${Base_Param_File_To_TEST}"             "Base_Param_File_To_TEST"              "4"
Empty_Var_Control "${lib_Test_file_presence_create}"       "lib_Test_file_presence_create"        "4"
Empty_Var_Control "${lib_Test_file_presence_critic_level}" "lib_Test_file_presence_critic_level"  "4"

MSG_DISPLAY "debug" "0" " File  Base_Param_File_To_TEST                  : [ ${Base_Param_File_To_TEST} ] "
MSG_DISPLAY "debug" "0" " File  lib_Test_file_presence_create            : [ ${lib_Test_file_presence_create} ] "
MSG_DISPLAY "debug" "0" " File  lib_Test_file_presence_critic_level      : [ ${lib_Test_file_presence_critic_level} ] "
MSG_DISPLAY "debug" "0" " File lib_Test_file_presence_onfail_action      : [ ${lib_Test_file_presence_onfail_action} ] "
MSG_DISPLAY "debug" "0" " File  lib_Test_file_presence_onsuccess_action  : [ ${lib_Test_file_presence_onsuccess_action} ] "
MSG_DISPLAY "check" "0" "checking file ${Base_Param_File_To_TEST} :"
if [ "${Iterate_Function_Test_file_presence}" = "1" ]
   then
        if [ -e "${Base_Param_File_To_TEST}" ]
           then
        	    MSG_DISPLAY "EdSMessage" "CREATED"
                #MSG_DISPLAY "debug" "0" " File ${Base_Param_File_To_TEST} : [ CREATED ] "
                if ! [ -z "${lib_Test_file_presence_onsuccess_action}" ]
                       then
                           ${lib_Test_file_presence_onsuccess_action}
                fi
           else
        	    MSG_DISPLAY "EdSMessage" "CAN T CREATE"
                MSG_DISPLAY "EdEMessage" "1" " File ${Base_Param_File_To_TEST} : [ CAN T CREATE ]" "${lib_Test_file_presence_critic_level}"
                if ! [  -z "${lib_Test_file_presence_onfail_action}" ]
                       then
                            ${lib_Test_file_presence_onfail_action}
                fi
        fi
   else
        if [ -e "${Base_Param_File_To_TEST}" ]
           then
        	    MSG_DISPLAY "EdSMessage" "FOUND"
                #MSG_DISPLAY "debug" "0" " File ${Base_Param_File_To_TEST} : [ PRESENT ] "
                if ! [ -z "${lib_Test_file_presence_onsuccess_action}" ]
                        then
                             ${lib_Test_file_presence_onsuccess_action}
                fi
           else
               case ${lib_Test_file_presence_create} in
                    Create_file) touch ${Base_Param_File_To_TEST}
                                 Iterate_Function_Test_file_presence="1"
                                 Test_file_presence
                                 ;;
                Dont_Create_File)# MSG_DISPLAY "EdEMessage" "2" "Not FOUND"
                                  if [ ${lib_Test_file_presence_critic_level} -eq "0" ]
                                     then 
                                          echo "OOOOOOOOOOOOOOOOOOOOOOOKKKK"
                                   else 
                		                   MSG_DISPLAY "EdEMessage" "2" "File ${Base_Param_File_To_TEST} : [ NOT FOUND ]" "${lib_Test_file_presence_critic_level}"
                                  fi
                                 ;;
                              *) MSG_DISPLAY "EdEMessage" "2" "Not supported case"
                                 ;;
               esac
               #MSG_DISPLAY "EdEMessage" "2" "NOT FOUND"
    		      #MSG_DISPLAY "EdEMessage" "2" "File ${Base_Param_File_To_TEST} : [ Not PRESENT ]" "${lib_Test_file_presence_critic_level}" 
                    if ! [ -z "${lib_Test_file_presence_onfail_action}" ]
                       then
                            ${lib_Test_file_presence_onfail_action}
                    fi
         fi
fi
Iterate_Function_Test_file_presence="0"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Do_file_remove
{
#|# Var to set  :
#|# Base_Param_File_To_REMOVE  : Use this var to set the ful pathed filename to remove
#|# FR_Action_ONFAIL           : Use this var to set wich action to do on function fail
#|# FR_Action_ONOK             : Use this var to set wich action to do on function success
#|# FR_Result_ERR_Level        : Use this var to set wich action to set the level of error
#|# $1                         : Use this var to set [ Base_Param_File_To_REMOVE ]
#|# $2                         : Use this var to set [ FR_Action_ONFAIL ]
#|# $3                         : Use this var to set [ FR_Action_ONOK ]
#|# $4                         : Use this var to set [ FR_Result_ERR_Level ]
#|#
#|# Base usage  : Do_file_remove "/My/file/to/remose.file" "Action ON FAIL" "Action ON OK" "err level"
#|#
#|# Description : This function is used to delete one file and check if all is ok
#|#
#|# Send Back   : May send back some actions
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Base_Param_File_To_REMOVE="${1}"
Empty_Var_Control "${Base_Param_File_To_REMOVE}" "Base_Param_File_To_REMOVE" "4"


MSG_DISPLAY "debug" "0" "File to remove : [ ${Base_Param_File_To_REMOVE} ]"
FR_Action_ONFAIL="${2}"
if [ -z ${FR_Action_ONFAIL} ]
   then
   	  MSG_DISPLAY "debug" "0" "Action to do on error : [ ${FR_Action_ONFAIL} ]"
   	  Action_ONFAIL="${FR_Action_ONFAIL}"
   else
      MSG_DISPLAY "debug" "0" "Action to do on error : [ NONE ]"
fi

FR_Action_ONOK="${3}"
if [ -z ${Action_ONOK} ]
   then
   	  MSG_DISPLAY "debug" "0" "Action to do on error : [ ${Action_ONOK} ]"
   	  Action_ONOK="${FR_Action_ONOK}"
   else
      MSG_DISPLAY "debug" "0" "Action to do on error : [ NONE ]"
fi


FR_Result_ERR_Level="${4}"
MSG_DISPLAY "debug" "0" "Error Level on fail  : [ ${FR_Result_ERR_Level} ]"
Result_ERR_Level="${FR_Result_ERR_Level}"

Generic_Base_Param_MSG="Removing File ${Base_Param_File_To_REMOVE} :"
Generic_Base_Param_MSG_ERR=" as failled "

###### Remove only one file

if [ -f ${Base_Param_File_To_REMOVE} ]
   then 
      rm ${Base_Param_File_To_REMOVE}
      CTRL_Result_func "${?}" "Check for file removing for [ ${Base_Param_File_To_REMOVE} ] " "" "${FR_Result_ERR_Level}" "${FR_Action_ONFAIL}" "${FR_Action_ONOK}"
      Base_Param_File_To_REMOVE=""
   else 
      MSG_DISPLAY "debug" "0" "File not present nothing to do  : [ ${Base_Param_File_To_REMOVE} ]"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_file_sourcing_control
{
#|# Var to set  :
#|# Base_File_To_Source         : this var is used to set the filename of the file
#|# Base_Path_For_File          : This var is used to set the full path of the file
#|# Action_To_Do_After_Sourcing : This var is used to set action to do after a successfully sourcing Operation
#|# $1                          : This var feed Base_File_To_Source
#|# $2                          : This var feed Path to file to source
#|# $3                          : This var feed Action to do after succefully sourcing operation
#|# Sourced_OK                  : This var is set when sourcing file to ensure the correct sourcing of the file
#|#
#|# Base usage  :  Do_file_sourcing_control "my_file" "my_path_to_file"
#|#
#|# Description : This function is used to control if sourcing procedure is OK
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Base_File_To_Source="$1"
Base_Path_For_File="$2"
Action_To_Do_After_Sourcing="${3}"

Empty_Var_Control "${Base_File_To_Source}"         "Base_File_To_Source"         "4"
Empty_Var_Control "${Base_Path_For_File}"          "Base_Path_For_File"          "4"
Empty_Var_Control "${Action_To_Do_After_Sourcing}" "Action_To_Do_After_Sourcing" "4"

MSG_DISPLAY "debug" "0" "Base_File_To_Source defined to : [ ${Base_File_To_Source} ] "
MSG_DISPLAY "debug" "0" "Base_Path_For_File defined to : [ ${Base_Path_For_File} ] "
MSG_DISPLAY "debug" "0" "Action_To_Do_After_Sourcing defined to : [ ${Action_To_Do_After_Sourcing} ] "

Sourced_OK="0"
###### Sourcing One file


Dir_null_or_slash ${Base_Path_For_File}


Test_directory "${Base_Path_For_File}"


Test_file_presence "${Base_Path_For_File}/${Base_File_To_Source}" "1"

. ${Base_Path_For_File}/${Base_File_To_Source}

if [ "${Sourced_OK}" = "1" ]
   then
        MSG_DISPLAY "debug" "0" "Sourcing File ${Base_File_To_Source} : [ OK ] "
        if [ -z "${Action_To_Do_After_Sourcing}" ]
           then
                   MSG_DISPLAY "debug" "0" "Post Sourcing File Action for ${Base_File_To_Source} : [ NONE ] "
           else
                   MSG_DISPLAY "debug" "0" "Post Sourcing File Action for ${Base_File_To_Source} : [ ${Action_To_Do_After_Sourcing} ] "
               ${Action_To_Do_After_Sourcing}
        fi
   else
        MSG_DISPLAY "EdEMessage" "1" "Sourcing File ${Base_File_To_Source} : [ KO ] " "1"
fi

Base_File_To_Source=""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_filename
{
#|# This function provide capacity to find filename at the end of the path
#|# $1                  : use this var to set Path and file to refine
#|# Base usage
#|#                     Get_filename "My_PATH/my_file vars"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

STRING_PATH_FILEMANE="${1}"
Empty_Var_Control "${STRING_PATH_FILEMANE}" "STRING_PATH_FILEMANE" "4"

if [ -z "${STRING_PATH_FILEMANE}" ]
   then
       MSG_DISPLAY "EdEMessage" "1" "EMPTT var for \$\1 in Get_filename CALL  : [ KO ] " 
   else
       FILE_NAME_var="$( echo ${STRING_PATH_FILEMANE} | awk -F\/ '{ print $NF }')"
       if [ "${FILE_NAME_var}" = "/" ]
          then
              MSG_DISPLAY "EdEMessage" "1" "Error no Filename i \$\1 Get_filename Call  : [ KO ] "
          else
              MSG_DISPLAY "debug" "0" "Return of Get_filename is  : [ ${FILE_NAME_var} ] "
              Return_var_Get_filename="${FILE_NAME_var}"
       fi
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function File_Backup
{
#|# Base_File_To_bck                        : use this var to set which file to backup
#|# ${1}                                    : use this var to set Base_File_To_bck
#|# Basic use     : File_Backup file to backup
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Base_File_To_bck="${1}"
Empty_Var_Control "${Base_File_To_bck}" "Base_File_To_bck" "4"


Get_filename "${Base_File_To_bck}"
File_BkcSubDir=$( dirname ${Base_File_To_bck} )
Set_new_directory "${Base_Dir_Scripts_BCK}${File_BkcSubDir}"
Internal_BCK_file="${Base_Dir_Scripts_BCK}${File_BkcSubDir}/${Return_var_Get_filename}_${USE_DATE}"

File_move_or_copy "${Base_File_To_bck}" "${Internal_BCK_file}" "copy" "0"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function File_move_or_copy
{
#|# Base_File_To_move_or_copy                       : use this var to set which file to copy or move
#|# Base_Destination                                : Use this var to set the destination of the files / dirs
#|# Action_type_cpmv                                : use this var to set if you copy or move the file / dirs
#|# Is_To_Dir                                       : Use this var if the destination is a directory
#|#
#|# ${1}                                    : use this var to set Base_File_To_move_or_copy
#|# ${2}                                    : Use this var to set Base_File_Dest
#|# ${3}                                    : use this var to set Action_type_cpmv ( copy = cp | move  = mv )
#|# ${4}                                    : Use this var to set Is_To_Dir
#|# Basic use     : File_move_or_copy "file to MVCP" "destination full path " "action type" "destination is a dir 0/1"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Base_File_To_move_or_copy="${1}"
Base_Destination="${2}"
Action_type_cpmv="${3}"
Is_To_Dir="${4}"

Empty_Var_Control "${Base_File_To_move_or_copy}" "Base_File_To_move_or_copy" "4"
Empty_Var_Control "${Base_Destination}"          "Base_Destination"          "4"
Empty_Var_Control "${Action_type_cpmv}"          "Action_type_cpmv"          "4"


MSG_DISPLAY "debug" "0" "Value for Base_File_To_move_or_copy : [ ${Base_File_To_move_or_copy} ]"
MSG_DISPLAY "debug" "0" "Value for Base_Destination          : [ ${Base_Destination} ]"
MSG_DISPLAY "debug" "0" "Value for Action_type_cpmv          : [ ${Action_type_cpmv} ]"
MSG_DISPLAY "debug" "0" "Value for Is_To_Dir                 : [ ${Is_To_Dir} ]"

if [ "${Is_To_Dir}" = "1" ]
   then
       Set_new_directory="${Base_File_Dest}"
       Internal_CPMV_dest="${Base_Destination}/"
   else
	   Internal_CPMV_dest="${Base_Destination}"
	   #Test_file_presence "${Internal_CPMV_dest}" "Dont_Create_File" "0"
fi

Get_filename "${Base_File_To_move_or_copy}"

MSG_DISPLAY "debug" "0"  "Internal_CPMV_dest is set to : [ ${Internal_CPMV_dest} ]"
case ${Action_type_cpmv} in
     copy|COPY) ACTION_CPVM="cp"
                MSG_DISPLAY "debug" "0" " Choosen action : [ ${Action_type_cpmv} ]"
                if [ -d ${Base_File_To_move_or_copy} ]
                   then
                      Base_Action_Params=" -Rp"
                   else
                      Base_Action_Params=""
                fi
                ;;

     move|MOVE) ACTION_CPVM="mv"
                MSG_DISPLAY "debug" "0" " Choosen action : [ ${Action_type_cpmv} ]"
                Base_Action_Params=""
                ;;

            * ) MSG_DISPLAY "EdEMessage" "2" " Not supported OPTION : [ ${Action_type_cpmv} ]"
                ;;
esac


Test_file_presence "${Base_File_To_move_or_copy}" "Dont_Create_File" "2"
MSG_DISPLAY "debug" "8" "CMD : [ ${ACTION_CPVM} ${Base_Action_Params} ${Base_File_To_move_or_copy}  ${Internal_CPMV_dest} ]"
${ACTION_CPVM} ${Base_Action_Params} ${Base_File_To_move_or_copy}  ${Internal_CPMV_dest}
Test_file_presence "${Internal_CPMV_dest}" "Dont_Create_File" "2"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function File_Read
{
#|# Data_miner                             : Use this var to set which function or cmd to make data mining in line
#|# ${1}                                   : Use this var to set Data_miner
#|# use "<<" to send file to function
#|# Basic usage : File_Read ["data miner"] << file
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
#MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
Data_miner="${1}"

Empty_Var_Control "${Data_miner}" "Data_miner" "4"

while read Internal_myline
  do
    if [ -z "${Data_miner}" ]
       then
       	    echo  " Line DATA : [ ${Internal_myline} ] "
       else
            ${Data_miner} "${Internal_myline}"
    fi
    Internal_myline=""
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function File_MD5_Create
{
#|# Var to set  : None
#|#             : Use this var to set
#|#             : Use this var to set
#|# ${1}
#|# ${2}
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
 


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function File_MD5_check_create
{
#|# Var to set           :
#|# File_to_control_MD5  : Use this var to set
#|#                      : Use this var to set
#|# ${1}
#|# ${2}
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
 

md5sum -b ${File_to_control_MD5} > ${File_to_control_MD5}.md5

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Fil_Get_Items
{
#|# Var to set  :
#|# FGI_get_Tag            : use this var to set the tag to find to builde var aray          ( Mandatory )
#|# FGI_Level_Item_Info    : Use this var to set which geted item part to keep               ( Mandatory )
#|# FGI_file_to_parse      : use this var to set which file to parse to get items            ( Mandatory )
#|# FGI_Field_Serpparator  : use this var to set which field separator tu use to parse file  ( Optional )
#|# ${1}                    : use this var to set [ FGI_get_Tag ]
#|# ${2}                    : use this var to set [ FGI_Level_Item_Info ]
#|# ${3}                    : use this var to set [ FGI_file_to_parse ]
#|# ${4}                    : use this var to set [ FGI_Field_Serpparator ]
#|#
#|# Base usage  : Fil_Get_Items "FGI_get_Tag" "FGI_Level_Item_Info" "FGI_file_to_parse" [ "FGI_Field_Serpparator" ]
#|# Description : This function scan a file to creat a array of item in a var
#|#
#|# Send Back   : One array var
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
FGI_get_Tag="${1}"
FGI_Level_Item_Info="${2}"
FGI_file_to_parse="${3}"

Empty_Var_Control "${FGI_get_Tag}"         "FGI_get_Tag"         "4"
Empty_Var_Control "${FGI_Level_Item_Info}" "FGI_Level_Item_Info" "4"
Empty_Var_Control "${FGI_file_to_parse}"   "FGI_file_to_parse"   "4"


for FGI_items_find in $( cat ${FGI_file_to_parse} | grep "${FGI_get_Tag}" | awk -v toprt=${FGI_Level_Item_Info} '{ print $toprt }')
    do
       case "${FGI_items_find}" in
                          *\#) MSG_DISPLAY "debug" "0" "Loop call find [ filtered call ]"
                              ;;
              ${FGI_get_Tag}) MSG_DISPLAY "debug" "0" "Loop call find [ filtered call ]"
                               ;;
                            *) MSG_DISPLAY "debug" "0"  " Item  get from file  [ ${FGI_items_find}  ]  "
                              FGI_Selected_items="${FGI_items_find} ${FGI_Selected_items}"
                              ;;
       esac
done

set GLOBAL_FGI_Selected_items $( echo ${FGI_Selected_items} )

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"