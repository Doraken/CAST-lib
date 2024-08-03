#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                      #
# Subject : This library provide base element to manage service under linux   #
#                                                                             #
###############################################################################
####
# INFO 

function Do_service_enable_bootstart
{
#|# Var to set  : 
#|# AcivateServiceName  : Use this var to set service name to activate at boot time
#|# ${1}        : Use this var to set [ AcivateServiceName ]                      
#|#
#|# Base usage  : Do_service_enable_bootstart "ServiceNAme"
#|#
#|# Description : This function is used to activate service at boot time.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
local AcivateServiceName="${1}"
Empty_Var_Control "${AcivateServiceName}" "AcivateServiceName"  "4" "Service name is a mandatory parameter "


Test_service_ststus ${AcivateServiceName}

if [ ${ServiceStatus} = "enabled" ] 
	then 
		MSG_DISPLAY "info" "1" "Service ${AcivateServiceName} is already : [ ${ServiceStatus} ]"
	else 
		systemctl enable ${AcivateServiceName}	
		CTRL_Result_func "${?}" "Activation of service : ${AcivateServiceName}" " [ can't Actiate ] " "2" "" ""
		Test_service_ststus ${AcivateServiceName}
		if [ ${ServiceStatus} = "enabled" ] 
			then 
				MSG_DISPLAY "info" "1" "Service ${AcivateServiceName} is succesfully : [ ${ServiceStatus} ]"
			else 
				MSG_DISPLAY "EdEMessage" "1" "Service ${AcivateServiceName} can t be enabled : [ ${ServiceStatus} ]"
		fi 
fi 


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Do_service_disable_bootstart
{
#|# Var to set  : 
#|# AcivateServiceName  : Use this var to set service name to activate at boot time
#|# ${1}        : Use this var to set [ AcivateServiceName ]                      
#|#
#|# Base usage  : Do_service_disable_bootstart "ServiceNAme"
#|#
#|# Description : This function is used to activate service at boot time.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
local AcivateServiceName="${1}"
Empty_Var_Control "${AcivateServiceName}" "AcivateServiceName"  "4" "Service name is a mandatory parameter "


Test_service_ststus ${AcivateServiceName}

if [ ${ServiceStatus} = "disabled" ] 
	then 
		MSG_DISPLAY "info" "1" "Service ${AcivateServiceName} is already : [ ${ServiceStatus} ]"
	else 
		systemctl disable ${AcivateServiceName}	
		CTRL_Result_func "${?}" "Activation of service : ${AcivateServiceName}" " [ can't Actiate ] " "2" "" ""
		Test_service_ststus ${AcivateServiceName}
		if [ ${ServiceStatus} = "disabled" ] 
			then 
				MSG_DISPLAY "info" "1" "Service ${AcivateServiceName} is succesfully : [ ${ServiceStatus} ]"
			else 
				MSG_DISPLAY "EdEMessage" "1" "Service ${AcivateServiceName} can t be disabled : [ ${ServiceStatus} ]"
		fi 
fi 


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}



function Test_service_ststus
{
#|# Var to set  : None
#|#             : Use this var to set 
#|#             : Use this var to set 
#|# ${1}        : Use this var to set [  ]                
#|# ${2}        : Use this var to set [  ]               
#|#
#|# Base usage  : None
#|#
#|# Description : None
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################!
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
local CheckServiceName="${1}"
Empty_Var_Control "${CheckServiceName}" "CheckServiceName"  "4" "Service name is a mandatory parameter "


ServiceStatus=$(systemctl status ntpd.service | grep "Loaded" | awk -F\; '{ print $2}')
MSG_DISPLAY "info" "1" "Service ${CheckServiceName} is : [ ${ServiceStatus} ]"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}


function Get_service_liste () 
{
#|# Var to set  : None             
#|#
#|# Base usage  : Get_service_liste
#|#
#|# Description : this function generate or regenerate list of all installed services
#|#
#|# Send Back   : _activated_service as service array 
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################!

_activated_service=""
for _services in $(service --status-all 2>&1  | awk '{ print $4 }')
    do  
	  MSG_DISPLAY "debug" "0" "Service found : [ ${_services} ]" 
	  _activated_service="${_activated_service} ${_services}"
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}


function Get_service_status () 
{
#|# Var to set  : _ServiceNAme             
#|#
#|# Base usage  : Get_service_liste
#|#
#|# Description : this function generate or regenerate list of all installed services
#|#
#|# Send Back   : _activated_service as service array 
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################!

local _ServiceNAme="${1}"
_service_state=$(service --status-all 2>&1  | awk '{print $2}')

case ${_service_state} in 
      +) ;; 
	  -) ;;
	  ?) ;;
	  *) ;;
esac 

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}



function Do_service_stop () 
{
#|# Var to set  : None             
#|#
#|# Base usage  : Get_service_liste
#|#
#|# Description : this function generate or regenerate list of all installed services
#|#
#|# Send Back   : _activated_service as service array 
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################!

_activated_service=""
for _services in $(service --status-all 2>&1  | awk '{ print $4 }')
    do  
	  MSG_DISPLAY "debug" "0" "Service found : [ ${_services} ]" 
	  _activated_service="${_activated_service} ${_services}"
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}

function Do_service_start () 
{
#|# Var to set  : None             
#|#
#|# Base usage  : Get_service_liste
#|#
#|# Description : this function generate or regenerate list of all installed services
#|#
#|# Send Back   : _activated_service as service array 
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################!

_activated_service=""
for _services in $(service --status-all 2>&1  | awk '{ print $4 }')
    do  
	  MSG_DISPLAY "debug" "0" "Service found : [ ${_services} ]" 
	  _activated_service="${_activated_service} ${_services}"
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}



function Dummy_function
{
#|# Var to set  : None
#|#             : Use this var to set 
#|#             : Use this var to set 
#|# ${1}        : Use this var to set [  ]                
#|# ${2}        : Use this var to set [  ]               
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
 

MSG_DISPLAY "info" "1" "this is a model function"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

# Sourcing control variable 
LibState="OK"  
