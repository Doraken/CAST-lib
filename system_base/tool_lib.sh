#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.
# Subject : This library provide base tool and binaries detection             #
#                                                                             #
###############################################################################
####
# INFO

function Get_tool_logger_status                  # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_logger_status
#|#
#|# Description : This function is used to check if logger bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

MSG_DISPLAY "check" "0" "System logger status :"

Global_Tool_Logger_bin="$(which logger 2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_Logger_bin} ]
   then
   	   Global_Tool_Logger_Status="DISABLED"      # EXEC_Global_SET_control_sanity
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_Logger_Status}"
		 
   else
       Global_Tool_Logger_Status="ENABLED"
       MSG_DISPLAY "EdSMessage" "${Global_Tool_Logger_Status}"
    
       
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_tool_cvs_status                   # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_cvs_status
#|#
#|# Description : This function is used to check if md5sum bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
MSG_DISPLAY "check" "0" "System CVS status :"
Global_Tool_cvs_bin="$(which cvs 2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_cvs_bin} ]
   then
       Global_Tool_cvs_Status="DISABLED"         # EXEC_Global_SET_control_sanity
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_cvs_Status}"
   else

       Global_Tool_cvs_Status="ENABLED"
       MSG_DISPLAY "EdSMessage" "${Global_Tool_cvs_Status}"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_tool_md5um_status                   # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Tool_md5sum_Get
#|#
#|# Description : This function is used to check if md5sum bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
MSG_DISPLAY "check" "0" "System md5sum status :"
Global_Tool_md5sum_bin="$(which md5sum 2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_md5sum_bin} ]
   then
       Global_Tool_md5sum_Status="DISABLED"      # EXEC_Global_SET_control_sanity
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_md5sum_Status}"
   else
       Global_Tool_md5sum_Status="ENABLED"
       MSG_DISPLAY "EdSMessage" "${Global_Tool_md5sum_Status}"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_tool_perl_status                   # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_perl_status
#|#
#|# Description : This function is used to check if perl bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
MSG_DISPLAY "check" "0" "System perl status :"
Global_Tool_perl_bin="$(which perl  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_perl_bin} ]
   then
       Global_Tool_perl_Status="DISABLED"        # EXEC_Global_SET_control_sanity
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_perl_Status}"
   else
       Global_Tool_perl_Status="ENABLED"
       MSG_DISPLAY "EdSMessage" "${Global_Tool_perl_Status}"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_tool_wget_status                   # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_wget_status
#|#
#|# Description : This function is used to check if wget bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
MSG_DISPLAY "check" "0" "System wget status :"
Global_Tool_wget_bin="$(which wget  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_wget_bin} ]
   then
       Global_Tool_wget_Status="DISABLED"        # EXEC_Global_SET_control_sanity
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_wget_Status}"
   else
       Global_Tool_wget_Status="ENABLED"
       MSG_DISPLAY "EdSMessage" "${Global_Tool_wget_Status}"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_tool_awk_status                   # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_awk_status
#|#
#|# Description : This function is used to check if awk bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
MSG_DISPLAY "check" "0" "System awk status :"
Global_Tool_awk_bin="$(which awk  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_awk_bin} ]
   then
       Global_Tool_awk_Status="DISABLED"        # EXEC_Global_MANDATORY_control_sanity
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_awk_Status}"
   else
       Global_Tool_awk_Status="ENABLED"
       MSG_DISPLAY "EdSMessage" "${Global_Tool_awk_Status}"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_tool_wc_status                   # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_wc_status
#|#
#|# Description : This function is used to check if wc bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
MSG_DISPLAY "check" "0" "System wc status :"
Global_Tool_wc_bin="$(which wc  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_wc_bin} ]
   then
    Global_Tool_wc_Status="DISABLED"                          # EXEC_Global_SET_control_sanity
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_wc_Status}"
   else
       Global_Tool_wc_Status="ENABLED"
       MSG_DISPLAY "EdSMessage" "${Global_Tool_wc_Status}"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Get_tool_tail_status ()                   # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_tail_status
#|#
#|# Description : This function is used to check if tail bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
MSG_DISPLAY "check" "0" "System tail status :"
Global_Tool_tail_bin="$(which tail  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_tail_bin} ]
   then
    Global_Tool_tail_Status="DISABLED"        # EXEC_Global_SET_control_sanity
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_tail_Status}"
   else
       Global_Tool_tail_Status="ENABLED"
       MSG_DISPLAY "EdSMessage" "${Global_Tool_tail_Status}"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Get_tool_head_status                   # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_head_status
#|#
#|# Description : This function is used to check if head bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

MSG_DISPLAY "check" "0" "System head status :"
Global_Tool_head_bin="$(which head  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_head_bin} ]
   then
    Global_Tool_head_Status="DISABLED"        # EXEC_Global_SET_control_sanity
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_head_Status}"
   else
       Global_Tool_head_Status="ENABLED"
       MSG_DISPLAY "EdSMessage" "${Global_Tool_head_Status}"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}



function Get_tool_grep_status                   # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_grep_status
#|#
#|# Description : This function is used to check if grep bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

MSG_DISPLAY "check" "0" "System grep status :"
Global_Tool_grep_bin="$(which grep  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_grep_bin} ]
   then
       Global_Tool_grep_Status="DISABLED"        # EXEC_Global_MANDATORY_control_sanity
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_grep_Status}"
   else
       Global_Tool_grep_Status="ENABLED"
       MSG_DISPLAY "EdSMessage" "${Global_Tool_grep_Status}"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Get_tool_uuencode_status                                     # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_uuencode_status
#|#
#|# Description : This function is used to check if uuencode bin is present
#|#
#|# Send Back   : Vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


MSG_DISPLAY "check" "0" "System uuencode status :"
Global_Tool_uuencode_bin="$( which uuencode  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"


if [ -z ${Global_Tool_uuencode_bin} ]
   then
   	    Global_Tool_uuencode_Status="DISABLED"
        MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_grep_Status}"
   	   
   else
        Global_Tool_uuencode_Status="ENABLED"    # EXEC_Global_SET_control_sanity
        MSG_DISPLAY "EdSMessage" "2" "${Global_Tool_grep_Status}"

fi
 



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_tool_mail_status                                         # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_mail_status
#|#
#|# Description : This function is used to check if mail bin is present
#|#
#|# Send Back   : Vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
MSG_DISPLAY "check" "0" "System mail status :"
Global_Tool_mail_bin="$( which mail  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_mail_bin} ]
   then
   	    Global_Tool_mail_Status="DISABLED"
   	    MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_mail_Status}"
   else
        Global_Tool_mail_Status="ENABLED"    # EXEC_Global_SET_control_sanity
        MSG_DISPLAY "EdSMessage" "${Global_Tool_mail_Status}"
fi


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_tool_mailx_status                                        # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_mailx_status
#|#
#|# Description : This function is used to check if mailx bin is present
#|#
#|# Send Back   : Vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
MSG_DISPLAY "check" "0" "System mailx status :"
Global_Tool_mailx_bin="$( which mailx  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_mailx_bin} ]
   then
   	   Global_Tool_mailx_Status="DISABLED"
   	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_mailx_Status}"
   else
       Global_Tool_mailx_Status="ENABLED"    # EXEC_Global_SET_control_sanity
       MSG_DISPLAY "EdSMessage" "${Global_Tool_mailx_Status}"
fi


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_tool_mutt_status                                         # EXEC_Global_SET
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_mutt_status
#|#
#|# Description : This function is used to check if mutt bin is present
#|#
#|# Send Back   : Vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
MSG_DISPLAY "check" "0" "System mutt status :"
Global_Tool_mutt_bin="$( which mutt  2>> ${Base_Dir_Scripts_LOG}/Tool.log )"
if [ -z ${Global_Tool_mutt_bin} ]
   then
   	   Global_Tool_mutt_Status="DISABLED"
	   MSG_DISPLAY "EdWMessage" "2" "${Global_Tool_mutt_Status}"
   else
       Global_Tool_mutt_Status="ENABLED"    # EXEC_Global_SET_control_sanity
       MSG_DISPLAY "EdEMessage" "2" "${Global_Tool_mutt_Status}"
fi


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Set_tool_global_status
{
#|# Var to set  : None
#|#
#|# Base usage  : Get_tool_perl_status
#|#
#|# Description : This function is used to check if perl bin is present
#|#
#|# Send Back   : vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Get_tool_items_exe "EXEC_Global_SET" "2" "${Base_Dir_Scripts_Lib}/system_base/tool_lib.sh"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_tool_items_exe
{
#|# Var to set  :
#|# TGITE_get_Tag            : use this var to set the tag to find to builde var aray          ( Mandatory )
#|# TGITE_Level_Item_Info    : Use this var to set which geted item part to keep               ( Mandatory )
#|# TGITE_file_to_parse      : use this var to set which file to parse to get items            ( Mandatory )
#|# ${1}                    : use this var to set [ TGITE_get_Tag ]
#|# ${2}                    : use this var to set [ TGITE_Level_Item_Info ]
#|# ${3}                    : use this var to set [ TGITE_file_to_parse ]
#|#
#|# Base usage  : Get_tool_items_exe "TGITE_get_Tag" "TGITE_Level_Item_Info" "TGITE_file_to_parse" [ "TGITE_Field_Serpparator" ]
#|# Description : This function scan a file to creat a array of function to execute
#|#
#|# Send Back   : function execution
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
local TGITE_get_Tag="${1}"
local TGITE_Level_Item_Info="${2}"
local TGITE_file_to_parse="${3}"



for TGITE_items_find in $( cat ${TGITE_file_to_parse} | grep "${TGITE_get_Tag}" | egrep -v "Get_tool_items_exe" | awk -v toprt=${TGITE_Level_Item_Info} '{ print $toprt }')
    do
       case "${TGITE_items_find}" in
                          *\#) MSG_DISPLAY "debug" "0" "Loop call find [ filtered call ]"
                              ;;
             ${TGITE_get_Tag}) MSG_DISPLAY "debug" "0" "Loop call find [ filtered call ]"
                               ;;
                            *)MSG_DISPLAY "debug" "0"  " Item  get from file  [ ${TGITE_items_find}  ]  "
                              TGITE_Selected_items="${TGITE_items_find} ${TGITE_Selected_items}"
                              ;;
       esac
done

for TGITE_to_execute in ${TGITE_Selected_items}
    do
       ${TGITE_to_execute}
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}





# Sourcing control variable 
LibState="OK"