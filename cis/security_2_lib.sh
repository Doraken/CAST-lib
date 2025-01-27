#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 
####
# INFO 
#      this lib is for RED-HAT based system
Report_result="/tmp/report"

function 2.1.1_Remove_telnet_server_and_clients ()
{
	#|# Description :  1.4.2 Implement Periodic Execution of File Integrity
	#|#
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between evaluate/correct 
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|#
	#|# Base usage  :   " "
	#|#
	#|# Send Back   :  
	############ STACK_TRACE_BUILDER #####################
	Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
	######################################################
	MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
	
	locale _mode="${1}" 
	locale _callback="${FUNCNAME[0]}"
		
	locale _Dspl_ref="$( echo ${FUNCNAME[0]} | sed -e 's/_/\ /g')"
	locale _Num_Rule="$( echo ${_Dspl_ref} | awk '{ print $1 }' )"
	locale _Txt_Rule="$( echo ${_Dspl_ref} | sed 's/[0-9]*//g' )"

	## TEST 
	locale _result="0" && yum list installed telnet-server -q > /dev/null 2>&1 && _result="1"
	yum list installed telnet -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "telnet-server"
					yum_UnInstall_Package "telnet"
					## END apply
					${_callback} "report"
				else
					Report_result "${_Num_Rule}" "${_Txt_Rule}" "FAILLED"
			fi 
		else
			Report_result "${_Num_Rule}" "${_Txt_Rule}" "TEST PASSED"
	fi
		
	
	############### Stack_TRACE_BUILDER ################
	Function_PATH="$( dirname ${Function_PATH} )"
	####################################################
}

function 2.1.2_Remove_rsh ()
{
	#|# Description :  Rule : 2.1.2     Remove rsh
	#|#
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between evaluate/correct 
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|#
	#|# Base usage  :   " "
	#|#
	#|# Send Back   :  
	############ STACK_TRACE_BUILDER #####################
	Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
	######################################################
	MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
	
	locale _mode="${1}" 
	locale _callback="${FUNCNAME[0]}"
		
	locale _Dspl_ref="$( echo ${FUNCNAME[0]} | sed -e 's/_/\ /g')"
	locale _Num_Rule="$( echo ${_Dspl_ref} | awk '{ print $1 }' )"
	locale _Txt_Rule="$( echo ${_Dspl_ref} | sed 's/[0-9]*//g' )"

	## TEST 
	_result="0" && yum list installed rsh-server -q > /dev/null 2>&1 && _result="1"
	yum list installed rsh -q > /dev/null 2>&1 && _result="1"

	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					MSG_DISPLAY "Info" ""
					yum_UnInstall_Package "rsh-server"
					yum_UnInstall_Package "rsh"
					## END apply
					${_callback} "report"
				else
					Report_result "${_Num_Rule}" "${_Txt_Rule}" "FAILLED"
			fi 
		else
			Report_result "${_Num_Rule}" "${_Txt_Rule}" "TEST PASSED"
	fi
		
	
	############### Stack_TRACE_BUILDER ################
	Function_PATH="$( dirname ${Function_PATH} )"
	####################################################
}

function 2.1.3_Remove_NIS ()
{
	#|# Description :  Rule : 2.1.2     Remove rsh
	#|#
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between evaluate/correct 
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|#
	#|# Base usage  :   " "
	#|#
	#|# Send Back   :  
	############ STACK_TRACE_BUILDER #####################
	Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
	######################################################
	MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
	
	locale _mode="${1}" 
	locale _callback="${FUNCNAME[0]}"
		
	locale _Dspl_ref="$( echo ${FUNCNAME[0]} | sed -e 's/_/\ /g')"
	locale _Num_Rule="$( echo ${_Dspl_ref} | awk '{ print $1 }' )"
	locale _Txt_Rule="$( echo ${_Dspl_ref} | sed 's/[0-9]*//g' )"
	
	## TEST 
	_result="0" && yum list installed ypserv -q > /dev/null 2>&1 && _result="1"
	yum list installed ypbind -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "ypserv"
					yum_UnInstall_Package "ypbind"
					## END apply
					${_callback} "report"
				else
					Report_result "${_Num_Rule}" "${_Txt_Rule}" "FAILLED"
			fi 
		else
			Report_result "${_Num_Rule}" "${_Txt_Rule}" "TEST PASSED"
	fi
		
	
	############### Stack_TRACE_BUILDER ################
	Function_PATH="$( dirname ${Function_PATH} )"
	####################################################
}

function 2.1.4_Remove_tftp ()
{
	#|# Description :  2.1.4 Remove tftp
	#|#
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between evaluate/correct 
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|#
	#|# Base usage  :   " "
	#|#
	#|# Send Back   :  
	############ STACK_TRACE_BUILDER #####################
	Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
	######################################################
	MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
	
	locale _mode="${1}" 
	locale _callback="${FUNCNAME[0]}"
		
	locale _Dspl_ref="$( echo ${FUNCNAME[0]} | sed -e 's/_/\ /g')"
	locale _Num_Rule="$( echo ${_Dspl_ref} | awk '{ print $1 }' )"
	locale _Txt_Rule="$( echo ${_Dspl_ref} | sed 's/[0-9]*//g' )"
	
	## TEST 
	_result="0" && yum list installed tftp-server -q > /dev/null 2>&1 && _result="1"
	 yum list installed tftp -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "tftp-server"
					yum_UnInstall_Package "tftp"
					## END apply
					${_callback} "report"
				else
					Report_result "${_Num_Rule}" "${_Txt_Rule}" "FAILLED"
			fi 
		else
			Report_result "${_Num_Rule}" "${_Txt_Rule}" "TEST PASSED"
	fi
		
	
	############### Stack_TRACE_BUILDER ################
	Function_PATH="$( dirname ${Function_PATH} )"
	####################################################
}

function 2.1.5_Remove_talk ()
{
	#|# Description :  2.1.5 Remove talk
	#|#
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between evaluate/correct 
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|#
	#|# Base usage  :   " "
	#|#
	#|# Send Back   :  
	############ STACK_TRACE_BUILDER #####################
	Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
	######################################################
	MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
	
	locale _mode="${1}" 
	locale _callback="${FUNCNAME[0]}"
		
	locale _Dspl_ref="$( echo ${FUNCNAME[0]} | sed -e 's/_/\ /g')"
	locale _Num_Rule="$( echo ${_Dspl_ref} | awk '{ print $1 }' )"
	locale _Txt_Rule="$( echo ${_Dspl_ref} | sed 's/[0-9]*//g' )"
	

	## TEST 
	_result="0" && yum list installed talk-server -q > /dev/null 2>&1 && _result="1"
	yum list installed talk -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "talk-server"
					yum_UnInstall_Package "talk"
					## END apply
					${_callback} "report"
				else
					Report_result "${_Num_Rule}" "${_Txt_Rule}" "FAILLED"
			fi 
		else
			Report_result "${_Num_Rule}" "${_Txt_Rule}" "TEST PASSED"
	fi
		
	
	############### Stack_TRACE_BUILDER ################
	Function_PATH="$( dirname ${Function_PATH} )"
	####################################################
}

function 2.1.6_Remove_xinetd ()
{
	#|# Description :  2.1.6 Remove xinetd
	#|#
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between evaluate/correct 
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|#
	#|# Base usage  :   " "
	#|#
	#|# Send Back   :  
	############ STACK_TRACE_BUILDER #####################
	Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
	######################################################
	MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
	
	locale _mode="${1}" 
	locale _callback="${FUNCNAME[0]}"
		
	locale _Dspl_ref="$( echo ${FUNCNAME[0]} | sed -e 's/_/\ /g')"
	locale _Num_Rule="$( echo ${_Dspl_ref} | awk '{ print $1 }' )"
	locale _Txt_Rule="$( echo ${_Dspl_ref} | sed 's/[0-9]*//g' )"
	
	## TEST 
	_result="0" && yum list installed xinetd -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "xinetd"
					## END apply
					${_callback} "report"
				else
					Report_result "${_Num_Rule}" "${_Txt_Rule}" "FAILLED"
			fi 
		else
			Report_result "${_Num_Rule}" "${_Txt_Rule}" "TEST PASSED"
	fi
		
	
	############### Stack_TRACE_BUILDER ################
	Function_PATH="$( dirname ${Function_PATH} )"
	####################################################
}

# Sourcing control variable 
LibState="OK"