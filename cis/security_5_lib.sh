#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 
####
# INFO 
#      this lib is for RED-HAT based system
Report_result="/tmp/report"

function 5.1.1_Install_the_rsyslog_package ()
{
	#|# Description :  5.1.1 Install the rsyslog package
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
	 

	locale _result="1" && yum list installed rsyslog -q > /dev/null 2>&1 && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_Install_Package "rsyslog"
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

function 5.1.2_Activate_the_rsyslog_service ()
{
	#|# Description :  5.1.1 Install the rsyslog package
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
	_result="1" && systemctl list-units --type=service | grep rsyslog | awk '{ print $2 "_" $3 "_" $4 }' | grep "loaded_active_running"  > /dev/null 2>&1   && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					systemctl enable rsyslog
					systemctl start rsyslog
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

function 5.1.3_Configure_etc_rsyslog.conf ()
{
	#|# Description :  5.1.3 Configure etc rsyslog.conf
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
	locale _FromFile="/etc/rsyslog.conf"
	locale _result="0"

	 Object="auth,user.* /var/log/messages" 
	 checkObjfromFile "${_Object}" "${_FromFile}"
	 Object="kern.* /var/log/kern.log" 
	 checkObjfromFile "${_Object}" "${_FromFile}"
	 Object="daemon.* /var/log/daemon.log"  
	 checkObjfromFile "${_Object}" "${_FromFile}"
	 Object="syslog.* /var/log/syslog" 
	 checkObjfromFile "${_Object}" "${_FromFile}"
	 Object="lpr,news,uucp,local0,local1,local2,local3,local4,local5,local6.* /var/log/unused.log" 
	 checkObjfromFile "${_Object}" "${_FromFile}"

	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "/etc/rsyslog.conf"
					echo "# rsyslog configuration file " > /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# For more information see /usr/share/doc/rsyslog-*/rsyslog_conf.html " >> /etc/rsyslog.conf
					 echo "# If you experience problems, see http://www.rsyslog.com/doc/troubleshoot.html " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "#### MODULES #### " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# The imjournal module bellow is now used as a message source instead of imuxsock. " >> /etc/rsyslog.conf
					 echo "$ModLoad imuxsock # provides support for local system logging (e.g. via logger command) " >> /etc/rsyslog.conf
					 echo "$ModLoad imjournal # provides access to the systemd journal " >> /etc/rsyslog.conf
					 echo "#$ModLoad imklog # reads kernel messages (the same are read from journald) " >> /etc/rsyslog.conf
					 echo "#$ModLoad immark # provides --MARK-- message capability " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Provides UDP syslog reception " >> /etc/rsyslog.conf
					 echo "#$ModLoad imudp " >> /etc/rsyslog.conf
					 echo "#$UDPServerRun 514 " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Provides TCP syslog reception " >> /etc/rsyslog.conf
					 echo "#$ModLoad imtcp " >> /etc/rsyslog.conf
					 echo "#$InputTCPServerRun 514 " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "#### GLOBAL DIRECTIVES #### " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Where to place auxiliary files " >> /etc/rsyslog.conf
					 echo "$WorkDirectory /var/lib/rsyslog " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Use default timestamp format " >> /etc/rsyslog.conf
					 echo "$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# File syncing capability is disabled by default. This feature is usually not required, " >> /etc/rsyslog.conf
					 echo "# not useful and an extreme performance hit " >> /etc/rsyslog.conf
					 echo "#$ActionFileEnableSync on " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Include all config files in /etc/rsyslog.d/ " >> /etc/rsyslog.conf
					 echo "$IncludeConfig /etc/rsyslog.d/*.conf " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Turn off message reception via local log socket; " >> /etc/rsyslog.conf
					 echo "# local messages are retrieved through imjournal now. " >> /etc/rsyslog.conf
					 echo "$OmitLocalLogging on " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# File to store the position in the journal " >> /etc/rsyslog.conf
					 echo "$IMJournalStateFile imjournal.state " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "#### RULES #### " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Log all kernel messages to the console. " >> /etc/rsyslog.conf
					 echo "# Logging much else clutters up the screen. " >> /etc/rsyslog.conf
					 echo "kern.* /var/log/kern.log " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Log anything (except mail) of level info or higher. " >> /etc/rsyslog.conf
					 echo "# Don't log private authentication messages! " >> /etc/rsyslog.conf
					 echo "auth,user.* /var/log/messages " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "#register log for all daemons " >> /etc/rsyslog.conf
					 echo "daemon.* /var/log/daemon.log " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "#regiter all syslog msgs " >> /etc/rsyslog.conf
					 echo "syslog.* /var/log/syslog " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# The authpriv file has restricted access. " >> /etc/rsyslog.conf
					 echo "authpriv.* /var/log/secure " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Log all the mail messages in one place. " >> /etc/rsyslog.conf
					 echo "mail.* /var/log/maillog " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Log cron stuff " >> /etc/rsyslog.conf
					 echo "cron.* /var/log/cron " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Everybody gets emergency messages " >> /etc/rsyslog.conf
					 echo "*.emerg :omusrmsg:* " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Save news errors of level crit and higher in a special file. " >> /etc/rsyslog.conf
					 echo "uucp,news.crit /var/log/spooler " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# Save boot messages also to boot.log " >> /etc/rsyslog.conf
					 echo "local7.* /var/log/boot.log " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "#unused logs : " >> /etc/rsyslog.conf
					 echo "lpr,news,uucp,local0,local1,local2,local3,local4,local5,local6.* /var/log/unused.log " >> /etc/rsyslog.conf
					 echo " " >> /etc/rsyslog.conf
					 echo "# ### begin forwarding rule ### " >> /etc/rsyslog.conf
					 echo "# The statement between the begin ... end define a SINGLE forwarding " >> /etc/rsyslog.conf
					 echo "# rule. They belong together, do NOT split them. If you create multiple " >> /etc/rsyslog.conf
					 echo "# forwarding rules, duplicate the whole block! " >> /etc/rsyslog.conf
					 echo "# Remote Logging (we use TCP for reliable delivery) " >> /etc/rsyslog.conf
					 echo "# " >> /etc/rsyslog.conf
					 echo "# An on-disk queue is created for this action. If the remote host is " >> /etc/rsyslog.conf
					 echo "# down, messages are spooled to disk and sent when it is up again. " >> /etc/rsyslog.conf
					 echo "#$ActionQueueFileName fwdRule1 # unique name prefix for spool files " >> /etc/rsyslog.conf
					 echo "#$ActionQueueMaxDiskSpace 1g # 1gb space limit (use as much as possible) " >> /etc/rsyslog.conf
					 echo "#$ActionQueueSaveOnShutdown on # save messages to disk on shutdown " >> /etc/rsyslog.conf
					 echo "#$ActionQueueType LinkedList # run asynchronously " >> /etc/rsyslog.conf
					 echo "#$ActionResumeRetryCount -1 # infinite retries if host is down " >> /etc/rsyslog.conf
					 echo "# remote host is: name/ip:port, e.g. 192.168.0.1:514, port optional " >> /etc/rsyslog.conf
					 echo "#*.* @@remote-host:514 " >> /etc/rsyslog.conf
					 echo "# ### end of the forwarding rule ### " >> /etc/rsyslog.conf
						
					service rsyslog restart  > /dev/null 2>&1 
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

function 5.2.1_Enable_auditd_Service ()
{
	#|# Description :  5.1.1 Install the rsyslog package
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
	locale _result="1" && systemctl list-units --type=service | grep auditd | awk '{ print $2 "_" $3 "_" $4 }' | grep "loaded_active_running"  > /dev/null 2>&1   && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					systemctl enable auditd
					systemctl start auditd
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

function 5.2.2.1_Configure_Audit_Log_Storage_Size ()
{
	#|# Description :  5.2.2.1 Configure Audit Log Storage Size
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
	locale _result="1" && cat /etc/audit/auditd.conf  | grep "max_log_file = 30" | egrep -v \# > /dev/null 2>&1 && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "/etc/audit/auditd.conf"
					_cat /etc/audit/auditd.conf  | grep "max_log_file" 
					if [ "${?}" = "0" ]
						then 
							_OriginalLine="$(cat /etc/audit/auditd.conf  | grep "max_log_file =" | egrep -v \#  )"
							sed -i "s/${_OriginalLine}/max_log_file\ =\ 30/g" /etc/audit/auditd.conf 
						else 
							echo "max_log_file = 30" >> /etc/audit/auditd.conf 
					fi 
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

function 5.2.2.2_Configure_actions_on_Audit_Log_Full ()
{
	#|# Description :  5.2.2.2	Configure actions on Audit Log Full
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
	locale _result="1" && grep "^space_left_action" /etc/audit/auditd.conf | egrep -v \# > /dev/null 2>&1 && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_OriginalLine="$(cat /etc/audit/auditd.conf  | grep "max_log_file =" | egrep -v \#  )"
					sed -i "s/${_OriginalLine}/max_log_file\ =\ 30/g" /etc/audit/auditd.conf
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

function 5.2.2.3_Keep_All_Auditing_Information ()
{
	#|# Description :  5.2.2.3 Keep All Auditing Information
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
	locale _result="0" 
	locale _Value=$(grep ^max_log_file_action /etc/audit/auditd.conf | egrep -v \#)
	if [ "${_Value}" != "max_log_file_action = ROTATE" ] 
		then 
			_result="1"
	fi
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_OriginalLine="$(grep ^max_log_file_action /etc/audit/auditd.conf)"
					sed -i "s/${_OriginalLine}/max_log_file_action\ =\ ROTATE/g" /etc/audit/auditd.conf
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

function 5.2.3_Enable_Auditing_for_Processes_That_Start_Prior_to_auditd  ()
{
	#|# Description :  5.2.3 Enable Auditing for Processes That Start Prior to auditd 
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
	locale _element_state="can t be applied"
	## TEST
   	Report_result "${_Num_Rule}" "${_Txt_Rule}" "TEST PASSED"
	 
	############### Stack_TRACE_BUILDER ################
	Function_PATH="$( dirname ${Function_PATH} )"
	####################################################
}

function 5.2.4_Record_Events_That_Modify_Date_and_Time_Information ()
{
	#|# Description :  5.2.4 Record Events That Modify Date and Time Information
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
	locale _result="0" 
	
	locale _FromFile="/etc/audit/rules.d/audit.rules"
	
	_TObj="-a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change" 
	checkObjfromFile "${_Object}" "${_FromFile}"
    _TObj="-a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -F key=time-change" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	_TObj="-a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "${_FromFile}"
					_TObj="-a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_TObj="-a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -F key=time-change" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_TObj="-a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change" 
					PutObjToFile "${_Object}" "${_FromFile}"
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

function 5.2.5_Record_Events_That_Modify_User_Group_Information ()
{
	#|# Description :  5.2.5 Record Events That Modify User Group Information
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
	locale _result="0" 
	
	locale _FromFile="/etc/audit/rules.d/audit.rules"
	
	_TObj="-w /etc/group -p wa -k identity "
	checkObjfromFile "${_Object}" "${_FromFile}"
	_TObj="-w /etc/gshadow -p wa -k identity"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_TObj="-w /etc/shadow -p wa -k identity"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_TObj="-w /etc/passwd -p wa -k identity"*
	checkObjfromFile "${_Object}" "${_FromFile}"
	_TObj="-w /etc/security/opasswd -p wa -k identity" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "${_FromFile}"
					_TObj="-w /etc/group -p wa -k identity "
					PutObjToFile "${_Object}" "${_FromFile}"
					_TObj="-w /etc/gshadow -p wa -k identity"
					PutObjToFile "${_Object}" "${_FromFile}"
					_TObj="-w /etc/shadow -p wa -k identity"
					PutObjToFile "${_Object}" "${_FromFile}"
					_TObj="-w /etc/passwd -p wa -k identity"*
					PutObjToFile "${_Object}" "${_FromFile}"
					_TObj="-w /etc/security/opasswd -p wa -k identity" 
					PutObjToFile "${_Object}" "${_FromFile}"
					
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

function 5.2.6_Record_Events_That_Modify_the_System_s_Network_Environment ()
{
	#|# Description :  5.2.6 Record Events That Modify the System’s Network Environment
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
	locale _result="0" 
	locale _FromFile="/etc/audit/rules.d/audit.rules" 
	
	_Object="-a always,exit -F arch=b64 -S sethostname,setdomainname -F key=system-locale"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-w /etc/issue -p wa -k system-locale" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-w /etc/issue.net -p wa -k system-locale" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-w /etc/hosts -p wa -k system-locale" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-w /etc/hostname -p wa -k system-locale" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "${_FromFile}"
					_Object="-a always,exit -F arch=b64 -S sethostname,setdomainname -F key=system-locale"
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-w /etc/issue -p wa -k system-locale" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-w /etc/issue.net -p wa -k system-locale" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-w /etc/hosts -p wa -k system-locale" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-w /etc/hostname -p wa -k system-locale" 
					PutObjToFile "${_Object}" "${_FromFile}"
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

function 5.2.7_Record_Events_That_Modify_the_System_s_Mandatory_Access_Controls ()
{
	#|# Description :  5.2.7 Record Events That Modify the System s Mandatory Access Controls
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
	_Value=$(grep "^-a always,exit -F dir=/etc/selinux/ -F perm=wa -F key=MAC-policy" /etc/audit/rules.d/audit.rules )
	if [ "${_Value}" != "-a always,exit -F dir=/etc/selinux/ -F perm=wa -F key=MAC-policy" ] 
		then 
			_result="1"
	fi
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "/etc/fstab"
					_Value=$(grep "^-a always,exit -F dir=/etc/selinux/ -F perm=wa -F key=MAC-policy" /etc/audit/rules.d/audit.rules )
					if [ "${_Value}" != "-a always,exit -F dir=/etc/selinux/ -F perm=wa -F key=MAC-policy" ] 
						then 
							echo "-a always,exit -F dir=/etc/selinux/ -F perm=wa -F key=MAC-policy" >> /etc/audit/rules.d/audit.rules
					fi
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

function 5.2.8_Collect_Login_and_Logout_Events ()
{
	#|# Description :  5.2.8 Collect Login and Logout Events
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
		
	_FromFile="/etc/audit/rules.d/audit.rules"
	
	_TObj="-w /var/log/faillog -p wa -k logins" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	_TObj="-w /var/log/lastlog -p wa -k logins" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	_TObj="-w /var/log/tallylog -p -wa -k logins" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "${_FromFile}"
					_TObj="-w /var/log/faillog -p wa -k logins" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_TObj="-w /var/log/lastlog -p wa -k logins" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_TObj="-w /var/log/tallylog -p -wa -k logins" 
					PutObjToFile "${_Object}" "${_FromFile}"
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

function 5.2.9_Collect_Session_Initiation_Information ()
{
	#|# Description :  5.2.9	Collect Session Initiation Information
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
	_FromFile="/etc/audit/rules.d/audit.rules"
		
	_Object="-w /var/run/utmp -p wa -k session" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-w /var/log/wtmp -p wa -k session" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-w /var/log/btmp -p wa -k session"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "/etc/fstab"
					_Object="-w /var/run/utmp -p wa -k session" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-w /var/log/wtmp -p wa -k session" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-w /var/log/btmp -p wa -k session"
					PutObjToFile "${_Object}" "${_FromFile}"	
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

function 5.2.10_Collect_Discretionary_Access_Control_Permission_Modification_Events ()
{
	#|# Description :  5.2.10 Collect Discretionary Access Control Permission Modification Events
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
	_FromFile="/etc/audit/rules.d/audit.rules"
		
	_Object="-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
	checkObjfromFile "${_Object}" "${_FromFile}"

	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "${_FromFile}"
					_Object="-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
					PutObjToFile "${_Object}" "${_FromFile}"
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

function 5.2.11_Collect_Unsuccessful_Unauthorized_Access_Attempts_to_Files ()
{
	#|# Description :  5.2.11 Collect Unsuccessful Unauthorized Access Attempts to Files
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
	_FromFile="/etc/audit/rules.d/audit.rules"
		
	_Object="-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
	checkObjfromFile "${_Object}" "${_FromFile}"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "${_FromFile}"
					_Object="-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=4294967295 -F key=perm_mod"
					PutObjToFile "${_Object}" "${_FromFile}"
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

function 5.2.12_Collect_Successful_File_System_Mounts ()
{
	#|# Description :  5.2.12 Collect Successful File System Mounts
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
	_FromFile="/etc/audit/rules.d/audit.rules"
		
	_Object="-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -F key=export"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "${_FromFile}"
					_Object="-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -F key=export"
					PutObjToFile "${_Object}" "${_FromFile}"
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

function 5.2.13_Collect_File_Deletion_Events_by_User ()
{
	#|# Description :  5.2.13 Collect File Deletion Events by User
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
	_FromFile="/etc/audit/rules.d/audit.rules"
		
	_Object="-a always,exit -F arch=b64 -S unlink,unlinkat,rename,renameat -F auid>=1000 -F auid!=4294967295 -F key=delete"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "${_FromFile}"
					_Object="-a always,exit -F arch=b64 -S unlink,unlinkat,rename,renameat -F auid>=1000 -F auid!=4294967295 -F key=delete"
					PutObjToFile "${_Object}" "${_FromFile}"
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

function 5.2.14_Collect_Changes_to_System_Administration_Scope_sudoers ()
{
	#|# Description :  5.2.13 Collect File Deletion Events by User
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
	_FromFile="/etc/audit/rules.d/audit.rules"
		
	_Object="-w /etc/sudoers -p wa -k actions"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="-w /etc/sudoers.d/ -p wa -k actions"
	checkObjfromFile "${_Object}" "${_FromFile}"

	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "${_FromFile}"
					_Object="-w /etc/sudoers -p wa -k actions"
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="-w /etc/sudoers.d/ -p wa -k actions"
					PutObjToFile "${_Object}" "${_FromFile}"
					
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

function 5.2.15_Collect_System_Administrator_Actions_sudolog ()
{
	#|# Description :  5.2.15 Collect System Administrator Actions (sudolog)
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
	_FromFile="/etc/audit/rules.d/audit.rules"
		
	_Object="-w /var/log/sudo.log -p wa -k actions"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					
					_Object="-w /var/log/sudo.log -p wa -k actions "
					__state="$(cat ${_FromFile} | grep /var/log/sudo.log | grep actions )"
					if [ "${?}" != "0" ]
						then 
							echo "${_Object}" >>  /etc/audit/rules.d/audit.rules
						else 
							_OriginalLine="$(cat ${_FromFile} | grep /var/log/sudo.log | grep actions |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
							sed -i "s/${_OriginalLine}/auth\ required\ pam_wheel.so\ use_uid/g" ${_FromFile}
					fi
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

function 5.2.16_Collect_Kernel_Module_Loading_and_Unloading ()
{
	#|# Description :  5.2.16 Collect Kernel Module Loading and Unloading
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
	_FromFile="/etc/audit/rules.d/audit.rules"
		
	_Object="-w /var/log/sudo.log -p wa -k actions "
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="-w /var/log/sudo.log -p wa -k actions "
					PutObjToFile "${_Object}" "${_FromFile}"
					
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

function 5.3_Configure_logrotate ()
{
	#|# Description :  5.3	Configure logrotate
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
	_FromFile="/etc/logrotate.d/syslog"
		
	_Object="/var/log/aide"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="/var/log/journaux/full-log"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="/var/log/cron"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="/var/log/maillog"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="/var/log/messages"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="/var/log/secure"
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="/var/log/spooler"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "${_FromFile}"
					echo "/var/log/aide" >   ${_FromFile}
					echo "/var/log/journaux/full-log" >>  ${_FromFile}
					echo "/var/log/cron" >>  ${_FromFile}
					echo "/var/log/maillog" >>  ${_FromFile}
					echo "/var/log/messages" >>  ${_FromFile}
					echo "/var/log/secure" >>  ${_FromFile} 
					echo "/var/log/spooler" >>  ${_FromFile}
					echo "{" >>  ${_FromFile}
					echo "	daily" >>  ${_FromFile}
					echo "	rotate 366" >>  ${_FromFile}
					echo "	create 0600 root root" >>  ${_FromFile}
					echo "	compress" >>  ${_FromFile}
					echo "	sharedscripts" >>  ${_FromFile} 
					echo "	postrotate" >>  ${_FromFile}
					echo "	/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true" >>  ${_FromFile}
					echo "	endscript" >>  ${_FromFile}
					echo "}" >>  ${_FromFile} 
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