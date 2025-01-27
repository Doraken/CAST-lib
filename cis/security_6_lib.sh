#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 
####
# INFO 
#      this lib is for RED-HAT based system
 
function 6.1.1_Enable_cronie_anacron_Daemon ()
{
	#|# Description :  6.1.1 Enable cronie-anacron Daemon
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
	_result="1" && yum list installed rsyslog -q > /dev/null 2>&1 && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "cronie-noanacron"
					yum_UnInstall_Package "crontabs"
					yum_Install_Package "cronie"
					yum_Install_Package "cronie-anacron" 
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

function 6.1.2_Enable_crond_Daemon  ()
{
	#|# Description :  6.1.2	Enable crond Daemon 
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
	_state=$(systemctl | grep crond | awk '{ print $2 "_" $3 "_" $4  }') 
	if [ "${_state}" = "loaded_active_running" ]
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
					systemctl enable crond 		 > /dev/null 2>&1 
					systemctl start crond  		 > /dev/null 2>&1 
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

function 6.1.3_Set_User_Group_Owner_and_Permission_on_etc_cronie_anacrontab ()
{
	#|# Description :  6.1.3 Set User/Group Owner and Permission on /etc/cronie-anacrontab
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
	_state=$(stat -c "%a %u %g" /etc/anacrontab | egrep ".00 0 0" ) 
	if [ "${_state}" = "600 0 0" ]
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
					chown root:root /etc/anacrontab  > /dev/null 2>&1 
					chmod og-rwx /etc/anacrontab		> /dev/null 2>&1 	
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

function 6.2.3_Set_Permissions_on_etc_ssh_sshd_config ()
{
	#|# Description :  6.1.3 Set User/Group Owner and Permission on /etc/cronie-anacrontab
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
	_state=$(ls -al /etc/ssh/sshd_config | awk '{ print $3 "_" $4 }') 
	if [ "${_state}" != "root_root" ]
		then
			_result="1"
	fi	
	_state=$(ls -al /etc/ssh/sshd_config | awk '{ print $1 }') 
	if [ "${_state}" != "-rw-------." ]
		then
			_result="1"
	fi	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					chown root:root /etc/ssh/sshd_config > /dev/null 2>&1 
					chmod 600 /etc/ssh/sshd_config> /dev/null 2>&1 	
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

function 6.2.4_Disable_SSH_X11_Forwarding ()
{
	#|# Description :  6.2.4	Disable SSH X11 Forwarding
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
	_FromFile="/etc/ssh/sshd_config"
	_result="0"

	_Object="X11Forwarding yes"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="X11Forwarding"
					_OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g")"
					sed -i "s/${_OriginalLine}/X11Forwarding\ no/g" ${_FromFile}
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

function 6.2.5_Set_SSH_MaxAuthTries_to_4_or_Less ()
{
	#|# Description :  6.2.5	Set SSH MaxAuthTries to 4 or Less
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
	_FromFile="/etc/ssh/sshd_config"
	_result="0"

	_Object="MaxAuthTries 4"
	checkObjfromFile "${_Object}" "${_FromFile}" 
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="MaxAuthTries"
					_OriginalLine="$(cat ${_FromFile} | grep  "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					echo " my origine ${_OriginalLine}"
					sed -i "s/${_OriginalLine}/MaxAuthTries\ 4/g" ${_FromFile}
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

function 6.2.6_Set_SSH_IgnoreRhosts_to_Yes ()
{
	#|# Description :  6.2.6 Set SSH IgnoreRhosts to Yes
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
	_FromFile="/etc/ssh/sshd_config"
	_result="0"

	_Object="IgnoreRhosts yes"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="IgnoreRhosts"
					_OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/IgnoreRhosts\ yes/g" ${_FromFile}
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

function 6.2.7_Set_SSH_HostbasedAuthentication_to_No ()
{
	#|# Description :  6.2.7	Set SSH HostbasedAuthentication to No
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
	_FromFile="/etc/ssh/sshd_config"
	_result="0"

	_Object="HostbasedAuthentication no"
	
	
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_FromFile="/etc/ssh/sshd_config"
					_Object="HostbasedAuthentication"
					_OriginalLine="$(cat ${_FromFile} | egrep -v "# " | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/HostbasedAuthentication\ no/g" ${_FromFile}
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

function 6.2.8_Disable_SSH_Root_Login ()
{
	#|# Description :  6.2.8 Disable SSH Root Login
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
	_FromFile="/etc/ssh/sshd_config"
	_result="0"

	_Object="PermitRootLogin no"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="PermitRootLogin"
					_OriginalLine="$(cat ${_FromFile} | egrep -v "the"| grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/PermitRootLogin\ no/g" ${_FromFile}
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

function 6.2.9_Set_SSH_PermitEmptyPasswords_to_No ()
{
	#|# Description :  6.2.9 Set SSH PermitEmptyPasswords to No
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
	_FromFile="/etc/ssh/sshd_config"
	_result="0"

	_Object="PermitEmptyPasswords no"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="PermitEmptyPasswords"
					_OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/PermitEmptyPasswords\ no/g" ${_FromFile}
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

function 6.2.10_Do_Not_Allow_Users_to_Set_Environment_Options ()
{
	#|# Description :  6.2.10	Do Not Allow Users to Set Environment Options
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
	_FromFile="/etc/ssh/sshd_config"
	_result="0"

	_Object="PermitUserEnvironment no"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="PermitUserEnvironment"
					_OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/PermitUserEnvironment\ no/g" ${_FromFile}
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

function 6.2.11_Use_Only_Approved_Cipher_in_Counter_Mode ()
{
	#|# Description :  6.2.11	Use Only Approved Cipher in Counter Mode
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
	_FromFile="/etc/ssh/sshd_config"
	_result="0"

	_Object="Ciphers aes128-ctr,aes192-ctr,aes256-ctr"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="Ciphers"
					_OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/Ciphers\ aes128-ctr,aes192-ctr,aes256-ctr/g" ${_FromFile}
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

function 6.3.1_Set_Password_Creation_Requirement_Parameters_Using_pam_cracklib ()
{
	#|# Description :  6.3.1_Set_Password_Creation_Requirement_Parameters_Using_pam_cracklib
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
	_FromFile="/etc/pam.d/system-auth"
	_Object="password requisite pam_pwquality.so try_first_pass retry=3"
	checkObjfromFile "${_Object}" "${_FromFile}"  
	_FromFile="/etc/security/pwquality.conf"
	_Object="minlen = 10"
	checkObjfromFile "${_Object}" "${_FromFile}"  
	_Object="dcredit = -1"
	checkObjfromFile "${_Object}" "${_FromFile}"    
	_Object="ucredit = -1"
	checkObjfromFile "${_Object}" "${_FromFile}"  
	_Object="ocredit = -1"
	checkObjfromFile "${_Object}" "${_FromFile}"   
	_Object="lcredit = -1"
	checkObjfromFile "${_Object}" "${_FromFile}"  
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_FromFile="/etc/pam.d/system-auth"
					_Object="password"
					_OriginalLine="$(cat ${_FromFile} | grep "${_Object}" | grep pam_pwquality.so |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/password\ requisite\ pam_pwquality.so\ try_first_pass\ retry=3/g" ${_FromFile}
					_FromFile="/etc/security/pwquality.conf"
					_Object="minlen ="
					 _OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/minlen\ =\ 10/g" ${_FromFile}
					_Object="dcredit ="
					 _OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/dcredit\ =\ -1/g" ${_FromFile}
					_Object="ucredit ="
					_OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/ucredit\ =\ -1/g" ${_FromFile} 
					_Object="ocredit ="
					 _OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/ocredit\ =\ -1/g" ${_FromFile}
					_Object="lcredit ="
					 _OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/lcredit\ =\ -1/g" ${_FromFile}
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

function 6.3.3_Upgrade_Password_Hashing_Algorithm_to_SHA-512 ()
{
	#|# Description :  6.3.3	Upgrade Password Hashing Algorithm to SHA-512
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
	
	_result="1" && authconfig --test | grep hashing | grep sha512 > /dev/null 2>1 &&  _result="0"

	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					authconfig --passalgo=sha512 --update > /dev/null 2&>1
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


function 6.3.5_Restrict_Access_to_the_su_Command ()
{
	#|# Description :  6.3.5	Restrict Access to the su Command
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
	_FromFile="/etc/pam.d/su"
	_result="0"

	_Object="auth required pam_wheel.so use_uid"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="auth"
					_OriginalLine="$(cat ${_FromFile} | grep required | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/auth\ required\ pam_wheel.so\ use_uid/g" ${_FromFile}
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