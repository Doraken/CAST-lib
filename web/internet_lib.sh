#!/bin/ksh
###############################################################################
# Internet.lib                                         Version : 1.1          #
#                                                                             #
# Creation Date : 13/10/2006                                                  #
# Team          : Only me                                           #
# Support mail  : doraken@doraken.net                                          #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This lib is used to provide any function about web and download   #
#                                                                             #
###############################################################################
####
# INFO

############################



function Internet_Http_Get
{
#|# Base_Param_URL          : Use this var to set the base URL tu use for WGET
#|# Base_Param_File_To_Get  : Use this var to set the file to download with WGET
#|# PWD_Recept_PKG           : Use this var to set the directory for reception of file downloaded
#|# Base use :
#|#           Internet_Http_Get "My_pkg_URL" "My_pkg" "My_pkg_repository"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 


local Base_Param_URL="${1}"
local Base_Param_File_To_Get="${2}"
local PWD_Recept_PKG="${3}"
local Base_Url_Parameter="${4}"

Control_Check_wget_status

MSG_DISPLAY "debug" "0" "Recept Directory is set to  : [ ${PWD_Recept_PKG} ] "

Set_new_directory "${PWD_Recept_PKG}"

if [ -e "${PWD_Recept_PKG}/${Base_Param_File_To_Get}" ]
   then
      MSG_DISPLAY "info" "1" "File Allready Downloaded : [ ${Base_Param_File_To_Get} : OK ]  ] "
   else
        DLW_Final_URL="${Base_Param_URL}/${Base_Param_File_To_Get}${Base_Url_Parameter}"
        MSG_DISPLAY "debug" "0" "DLW_Final_URL is set to   : [ ${DLW_Final_URL} ] "
        ${Global_Tool_wget_bin}  ${WGET_OPTIONS} --directory-prefix=${PWD_Recept_PKG} ${DLW_Final_URL}
        if [ ! -e "${PWD_Recept_PKG}/${Base_Param_File_To_Get}" ]
           then
               MSG_DISPLAY "EdEMessage" "1" " File Downloaded : [ ${Base_Param_File_To_Get} : Failled ]  " 
           else
               MSG_DISPLAY "info" "1" "File Downloaded : [ ${Base_Param_File_To_Get} : OK ]  ] "
         fi
  fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}
# Sourcing control variable 
LibState="OK"