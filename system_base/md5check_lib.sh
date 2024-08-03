#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# Subject : This library provide base functions to manage file md5 check #####
####
# INFO

function MD5_Lib_Switch
#|# Var to set  : None
#|# Var used    : Global_Tool_MD5_Status
#|#
#|# Base usage  : MD5_Lib_Switch
#|#
#|# Description : this function for exit when md5sum bin is not present on the operating system
#|#
#|# Send Back   : None
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 
Lib_MD5_activation_Switch="1"
MSG_DISPLAY "check" "0" "Library md5check.lib status :"
if [[ "${Global_Tool_MD5_Status}" = "ENABLED"  ]]
	then     
		MSG_DISPLAY "debug" "0" "md5 status ${Global_Tool_MD5_Status}"
	else
		MSG_DISPLAY "EdEMessage" "1" "md5 status ${Global_Tool_MD5_Status}"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################	
}

function Do_md5_create_sum
#|# Var to set  : 
#|#      ${1}   : is used to store scaned file name 
#|#      ${2}   : is used to store ouput Type ( File to send md5 ouput to a file any other to keep it on console )
#|# Var used    : Global_Tool_MD5_Status
#|#
#|# Base usage  : Do_md5_create_sum "My_File" "Ouput_type" "Ouput_Target"
#|#
#|# Description : this function launch md5sum to generate file hash
#|#
#|# Send Back   : Console ouput or file ouput
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 
MD5_Lib_Switch

_md5_File_Scan="${1}"
_md5_ouput_scan_Type="${2}"
_Md5_ouput_Target="${3}"

Empty_Var_Control "${_md5_File_Scan}"       "_md5_File_Scan"        "4"
Empty_Var_Control "${_md5_ouput_scan_Type}" "_md5_ouput_scan_Type"  "4"

MSG_DISPLAY "debug" "0" "_md5_File_Scan="${1}""
MSG_DISPLAY "debug" "0" "_md5_ouput_scan_Type="${2}""
MSG_DISPLAY "debug" "0" "_Md5_ouput_Target="${3}""

Test_file_presence "${_md5_File_Scan}"      "Dont_Create_File"      "1"  

case ${_md5_ouput_scan_Type} in 
		File) eval md5sum ${_md5_File_Scan} >> ${_Md5_ouput_Target}
				;;
			*) md5sum ${_md5_File_Scan}
				;;
esac


_md5_File_Scan=""
_md5_ouput_scan_Type=""
_Md5_ouput_Target=""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################	
}

function Test_md5_sum
#|# Var to set  : 
#|#      ${1}   : is used to store scaned file name 
#|#      ${2}   : is used to store ouput Type ( File to send md5 ouput to a file any other to keep it on console )
#|# Var used    : Global_Tool_MD5_Status
#|#
#|# Base usage  : Do_md5_create_sum "inputFile"
#|#
#|# Description : this function launch md5sum to check hass of a file 
#|#
#|# Send Back   : Console ouput or file ouput
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 
MD5_Lib_Switch

_md5_File_Src="${1}"


MSG_DISPLAY "debug" "0" "_md5_File_Src="${1}""
MSG_DISPLAY "debug" "0" "_Md5_input_Target="${2}""

Empty_Var_Control "${_md5_File_Src}" "_md5_File_Src"     "4"
Test_file_presence "${_md5_File_Src}" "Dont_Create_File" "1"  

md5sum -c "${_md5_File_Src}" 

_md5_File_Scan=""
_md5_ouput_scan_Type=""
_Md5_ouput_Target=""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################	
}

# Sourcing control variable 
LibState="OK"