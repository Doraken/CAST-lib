#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                 #
# Subject : This library provide base compress  and unpacking for archives    #
#                                                                             #
###############################################################################
####
# INFO 

function Do_archive_file_extract_tgz
{
#|# Var to set  :
#|# AFET_Base_Param_File_Path           : Use this var to set Base pathe of the file 
#|# AFET_Base_Param_File_To_EXTRACT     : Use this var to set the name of the file to extract
#|# AFET_Base_Param_File_To_Extract_ext : Use this var to set the extention of the file to extracte
#|# ${1}        : Use this var to set [ AFET_Base_Param_File_Path ]                        
#|# ${2}        : Use this var to set [ AFET_Base_Param_File_To_EXTRACT ]                       
#|# ${3}        : Use this var to set [ AFET_Base_Param_File_To_Extract_ext ] 
#|#
#|# Base usage  : Do_archive_file_extract_tgz  "FULL_PATH_OF_THE_FILE" "ARCHIVE_FILENAME_WITHOUT_EXT" "ARCHIVE_EXT"
#|#
#|# Description : This function uncompress Tar.gz /tar.bz /tar  files
#|#
#|# Send Back   : uncompressed file 
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

AFET_Base_Param_File_Path="${1}"
AFET_Base_Param_File_To_EXTRACT="${2}"
AFET_Base_Param_File_To_Extract_ext="${3}"

Empty_Var_Control "${AFET_Base_Param_File_Path}"             "AFET_Base_Param_File_Path"             "4"
Empty_Var_Control "${AFET_Base_Param_File_To_EXTRACT}"       "AFET_Base_Param_File_To_EXTRACT"       "4"
Empty_Var_Control "${AFET_Base_Param_File_To_Extract_ext}"   "AFET_Base_Param_File_To_Extract_ext"   "4"

Test_file_presence "${AFET_Base_Param_File_Path}/${AFET_Base_Param_File_To_EXTRACT}.${AFET_Base_Param_File_To_Extract_ext}" "Dont_Create_File" "2" 

Generic_Base_Param_MSG="Uncompressing of ${AFET_Base_Param_File_To_TEST} : "
case ${AFET_Base_Param_File_To_Extract_ext} in 
     tar.gz|tgz) if [ -d "${AFET_Base_Param_File_Path}/${AFET_Base_Param_File_To_EXTRACT}" ]
                    then 
                         MSG_DISPLAY "info" "1" "The package is alredy uncompressed : [ PASS ] "
                    else
                        Return_Path="$(pwd)" 
                        cd  ${AFET_Base_Param_File_Path}/
                        tar -xzf ${AFET_Base_Param_File_Path}/${AFET_Base_Param_File_To_EXTRACT}.${AFET_Base_Param_File_To_Extract_ext} 
                        CTRL_Result_func "${?}" "Check for Archive extraction of [ ${AFET_Base_Param_File_To_EXTRACT}.${AFET_Base_Param_File_To_Extract_ext}  ] " "" "1"
                        cd ${Return_Path}
                 fi ;;
            tar) if [ -d "${AFET_Base_Param_File_Path}/${AFET_Base_Param_File_To_EXTRACT}" ]
                    then 
                         MSG_DISPLAY "info" "1" "The package is alredy uncompressed : [ PASS ] "
                    else
                        Return_Path="$(pwd)" 
                        cd  ${AFET_Base_Param_File_Path}/
                        tar -xf ${AFET_Base_Param_File_Path}/${AFET_Base_Param_File_To_EXTRACT}.${AFET_Base_Param_File_To_Extract_ext} 
                        CTRL_Result_func "${?}" "Check for Archive extraction of [ ${AFET_Base_Param_File_To_EXTRACT}.${AFET_Base_Param_File_To_Extract_ext} ] " "" "1"
                        cd ${Return_Path}
                 fi ;;
       tar.bz2 ) if [ -d "${AFET_Base_Param_File_Path}/${AFET_Base_Param_File_To_EXTRACT}" ]
                    then 
                         MSG_DISPLAY "info" "1" "The package is alredy uncompressed : [ PASS ] "
                    else
                        Return_Path="$(pwd)" 
                        cd  ${AFET_Base_Param_File_Path}/
                        tar -xjf ${AFET_Base_Param_File_Path}/${AFET_Base_Param_File_To_EXTRACT}.${AFET_Base_Param_File_To_Extract_ext} 
                        CTRL_Result_func "${?}" "Check for Archive extraction of [ ${AFET_Base_Param_File_To_EXTRACT}.${AFET_Base_Param_File_To_Extract_ext} ] " "" "1"
                        cd ${Return_Path}
                 fi ;;
              *) MSG_DISPLAY "EdEMessage" "1" "Not supporterd file format : [ ERROR ] "
                  ;;
esac 


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Do_file_compress_tgz
{
#|# Var to set  :
#|# AFCT_Base_Param_File_Path_to_Compress   : Use this var to set Base pathe of the file 
#|# AFCT_Base_Param_Compressed_FileName     : Use this var to set the name of the archive file to create
#|# AFCT_Base_Param_Compressed_FileName_ext : Use this var to set the extention of the archive file to extracte
#|# ${1}        : Use this var to set [ AFCT_Base_Param_File_Path_to_Compress ]                        
#|# ${2}        : Use this var to set [ AFCT_Base_Param_Compressed_FileName ]                       
#|# ${3}        : Use this var to set [ AFCT_Base_Param_Compressed_FileName_ext ] 
#|#
#|# Base usage  : Do_file_compress_tgz  "AFCT_Base_Param_File_Path_to_Compress" "AFCT_Base_Param_Compressed_FileName" "AFCT_Base_Param_Compressed_FileName_ext"
#|#
#|# Description : This function compress tar.gz / tar.bz / tar files
#|#
#|# Send Back   : Compressed file 
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local AFCT_Base_Param_File_Path_to_Compress="${1}"
local AFCT_Base_Param_Compressed_FileName="${2}"
local AFCT_Base_Param_Compressed_FileName_ext="${3}"

Empty_Var_Control "${AFCT_Base_Param_File_Path_to_Compress}"   "AFCT_Base_Param_File_Path_to_Compress"   "4"
Empty_Var_Control "${AFCT_Base_Param_Compressed_FileName}"     "AFCT_Base_Param_Compressed_FileName"     "4"
Empty_Var_Control "${AFCT_Base_Param_Compressed_FileName_ext}" "AFCT_Base_Param_Compressed_FileName_ext" "4"

Test_file_presence "${AFCT_Base_Param_File_Path_to_Compress}" "Dont_Create_File" "2" 

Generic_Base_Param_MSG="Archiving of ${AFCT_Base_Param_File_Path} : "
case ${AFCT_Base_Param_File_To_COMPRESS_ext} in 
     tar.gz|tgz) MSG_DISPLAY "info" "1" "${Generic_Base_Param_MSG} : [ Starting ]"
                 tar -cvzf  ${AFCT_Base_Param_File_Path_to_Compress} ${AFCT_Base_Param_Compressed_FileName}.${AFCT_Base_Param_Compressed_FileName_ext}
                 MSG_DISPLAY "info" "1" "${Generic_Base_Param_MSG} : [ End ]"
                 ;;
            tar) MSG_DISPLAY "info" "1" "${Generic_Base_Param_MSG} in format $${AFCT_Base_Param_File_To_COMPRESS_ext}  : [ Starting ]"
                 tar -cvf ${AFCT_Base_Param_File_Path_to_Compress} ${AFCT_Base_Param_Compressed_FileName}.${AFCT_Base_Param_Compressed_FileName_ext} 
                 MSG_DISPLAY "info" "1" "${Generic_Base_Param_MSG} : [ End ]"
                 ;;
       tar.bz2 ) MSG_DISPLAY "info" "1" "${Generic_Base_Param_MSG} in format $${AFCT_Base_Param_File_To_COMPRESS_ext}  : [ Starting ]"
                 tar -cjf ${AFCT_Base_Param_File_Path_to_Compress} ${AFCT_Base_Param_Compressed_FileName}.${AFCT_Base_Param_Compressed_FileName_ext} 
                 MSG_DISPLAY "info" "1" "${Generic_Base_Param_MSG} : [ End ]"
                 ;;
              *) MSG_DISPLAY "EdEMessage" "1" "Not supporterd file format : [ ERROR ] "
                 ;;
esac 


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

# Sourcing control variable 
LibState="OK"