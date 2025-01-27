#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 
####
# INFO 
#      this lib is for RED-HAT based system
Report_result="/tmp/report"

function 3.1_Set_Daemon_umask ()
{
	#|# Description :  3.1 Set Daemon umask
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_umask_state="$(cat /etc/init.d/functions | grep ^umask | awk '{print $2}')"
	if [ ${_umask_state} = "027" ]
		then 
			_result="0"
		else 
			_result="1"
	fi 
		## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "/etc/init.d/functions"
					sed -i "s/umask\ ${_umask_state}/umask\ 027/g" /etc/init.d/functions
					## END apply
					${_callback} "Report"
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

function 3.1.1_Remove_X_Windows ()
{
	#|# Description :  3.1 Set Daemon umask
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="1" && systemctl get-default | grep multi-user.target > /dev/null 2>&1 && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					systemctl set-default multi-user.target
					## END apply
					${_callback} "Report"
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

function 3.2_Disable_Avahi_Server ()
{
	#|# Description :  3.2 Disable Avahi Server
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed avahi -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "avahi"
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

function 3.2.1_Disable_Print_Server_CUPS ()
{
	#|# Description :  3.2.1 Disable Print Server -CUPS
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed cups -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "cups"
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

function 3.3_Remove_DHCP_Server ()
{
	#|# Description :  3.3 Remove DHCP Server
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed dhcp -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "dhcp"
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

function 3.4_Remove_LDAP ()
{
	#|# Description :  3.4       Remove LDAP
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed openldap-servers -q > /dev/null 2>&1 && _result="1"
	yum list installed openldap-clients -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "openldap-servers"
					yum_UnInstall_Package "openldap-clients"
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

function 3.5_Disable_NFS_and_RPC ()
{
	#|# Description :  3.5 Disable NFS and RPC
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed cifs-utils -q > /dev/null 2>&1 && _result="1"
	yum list installed gssproxy -q       > /dev/null 2>&1 && _result="1"
	yum list installed nfs-utils -q      > /dev/null 2>&1 && _result="1"
	yum list installed nfs4-acl-tools -q > /dev/null 2>&1 && _result="1"
	yum list installed target-cli -q     > /dev/null 2>&1 && _result="1"
	yum list installed targetd -q        > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "cifs-utils"
					yum_UnInstall_Package "gssproxy"
					yum_UnInstall_Package "nfs-utils"
					yum_UnInstall_Package "nfs4-acl-tools"
					yum_UnInstall_Package "target-cli"
					yum_UnInstall_Package "targetd"
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

function 3.6_Remove_DNS_Server ()
{
	#|# Description :  3.6 Remove DNS Server
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed bind -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "bind"
					## END apply
					${_callback} "Report"
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

function 3.7_Remove_FTP_Server ()
{
	#|# Description :  3.7 Remove FTP Server
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed vsftpd -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "vsftpd"
					## END apply
					${_callback} "Report"
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

function 3.6_Remove_HTTP_Server ()
{
	#|# Description :  3.6 Remove HTTP Server
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed httpd -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "httpd"
					## END apply
					${_callback} "Report"
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

function 3.8_Remove_Dovecot_IMAP_and_POP3_services ()
{
	#|# Description :  3.8 Remove Dovecot (IMAP and POP3 services)
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed dovecot -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "dovecot"
					## END apply
					${_callback} "Report"
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

function 3.9_Remove_Samba ()
{
	#|# Description :  3.9 Remove Samba
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed samba -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "samba"
					## END apply
					${_callback} "Report"
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

function 3.10_Remove_HTTP_Proxy_Server ()
{
	#|# Description :  3.10 Remove HTTP Proxy Server
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed squid -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "squid"
					## END apply
					${_callback} "Report"
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

function 3.11_Remove_SNMP_Server ()
{
	#|# Description :  3.11_Remove_SNMP_Server
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0" && yum list installed net-snmp -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "net-snmp"
					## END apply
					${_callback} "Report"
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

function 3.12_Configure_Network_Time_Protocol_NTP ()
{
	#|# Description :  3.11_Remove_SNMP_Server
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="0"
	_state_ntp=$(systemctl | grep ntpd | awk '{ print $2 "_" $3 "_" $4  }') 
	if [ "${_state_ntp}" = "loaded_active_running" ]
		then 
			_result="0"
		else 
			_result="1"
	fi	
	yum list installed chrony -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "chrony"
					yum_Install_Package   "ntp"
					echo "#For more information about this file, see the man pages  # ntp.conf(5), ntp_acc(5), ntp_auth(5), ntp_clock(5), ntp_misc(5), ntp_mon(5). "                 > /etc/ntp.conf 
					echo "driftfile /var/lib/ntp/drift "                                                                                                                            >> /etc/ntp.conf 
					echo "# Permit time synchronization with our time source, but do not  # permit the source to query or modify the service on this system."                       >> /etc/ntp.conf 
					echo "restrict ${ntpserver} mask 255.255.255.255 nomodify notrap nopeer noquery"                                                                                >> /etc/ntp.conf 
					echo "# Permit all access over the loopback interface.  This could  # be tightened as well, but to do so would effect some of  # the administrative functions." >> /etc/ntp.conf 
					echo "restrict 127.0.0.1 nomodify "                                                                                                                             >> /etc/ntp.conf 
					echo "server ${ntpserver} burst iburst"                                                                                                                         >> /etc/ntp.conf 
					echo "logfile /var/log/ntp.log"                                                                                                                                 >> /etc/ntp.conf 
					systemctl start ntpd  		2>/dev/null
					systemctl enable ntpd 		2>/dev/null
					systemctl disable ntpdate 	2>/dev/null
					## END apply
					${_callback} "Report"
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

function 3.13_Configure_Mail_Transfer_Agent_for_Local_Only_Mode ()
{
	#|# Description :  3.11_Remove_SNMP_Server
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
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
	_result="1" && ss -autn4 | grep "\:25"  | awk '{ print $5 }' | grep "127.0.0.1:25" > /dev/null 2>&1 && _result="0"
	ss -autn6 | grep "\:25" > /dev/null 2>&1 && _result="1"
		## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "/etc/postfix/main.cf"
					_OriginalLine="$(cat /etc/postfix/main.cf | grep "inet_interfaces" | egrep -v \# |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					_NewLine="inet_interfaces\ =\ localhost"
					sed -i "s/${_OriginalLine}/${_NewLine}/g" /etc/postfix/main.cf
					_OriginalLine="$(cat /etc/postfix/main.cf | grep "inet_protocols" | egrep -v \# |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g")"
					_NewLine="inet_protocols\ =\ ipv4"
					sed -i "s/${_OriginalLine}/${_NewLine}/g" /etc/postfix/main.cf
					service postfix restart  > /dev/null 2>&1 
					## END apply
					${_callback} "Report"
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