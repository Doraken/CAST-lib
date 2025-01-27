#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 
####
# INFO 
#      this lib is for RED-HAT based system
 




function 7.2.1_Set_Password_Expiration_Days ()
{
	#|# Description :  7.2.1 Set Password Expiration Days
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
	_FromFile="/etc/login.defs"
	_result="0"

	_Object="PASS_MAX_DAYS 99 "
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="PASS_MAX_DAYS"
					_OriginalLine="$(cat ${_FromFile} | grep "^${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/PASS_MAX_DAYS\ 99\ /g" ${_FromFile}
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

function 7.2.2_Set_Password_Change_Minimum_Number_of_Days ()
{
	#|# Description :  7.2.1 Set Password Expiration Days
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
	locale callback="${FUNCNAME[0]}"
		
	locale _Dspl_ref="$( echo ${FUNCNAME[0]} | sed -e 's/_/\ /g')"
	locale _Num_Rule="$( echo ${_Dspl_ref} | awk '{ print $1 }' )"
	locale _Txt_Rule="$( echo ${_Dspl_ref} | sed 's/[0-9]*//g' )"
	## TEST
	locale _FromFile="/etc/login.defs"
	_result="0"

	_Object="PASS_MIN_DAYS 0"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="PASS_MIN_DAYS"
					_OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/PASS_MIN_DAYS\ 0\ /g" ${_FromFile}
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

function 7.2.3_Set_Password_Expiring_Warning_Days ()
{
	#|# Description :  7.2.3	Set Password Expiring Warning Days
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
	locale _FromFile="/etc/login.defs"
	locale _result="0"

	locale _Object="PASS_WARN_AGE 0"
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="PASS_WARN_AGE"
					_OriginalLine="$(cat ${_FromFile} | grep "${_Object}"  |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/PASS_WARN_AGE\ 7\ /g" ${_FromFile}
					for User in $(cat /etc/passwd | awk -F\: '{ print $1 }') 
						do 
							chage --warndays 7 ${User} > /dev/null 2&>1
					done
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

function 7.5_Lock_Inactive_User_Accounts ()
{
	#|# Description :  7.5 Lock Inactive User Accounts
	#|# Var to set  : 
	#|# 				_mode                       : use this var to set the action mode between report/apply
	#|# 				${1}                        : use this var to set Base_param_Dir_To_Create        
	#|# Base usage  :  Function_Name "apply or repport"
	#|# Send Back   :  Repport or repport and securing actions
	############ STACK_TRACE_BUILDER #####################
	Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
	######################################################
	MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
	
	_mode="${1}" 
	_callback="${FUNCNAME[0]}"
		
	_Dspl_ref="$( echo ${FUNCNAME[0]} | sed -e 's/_/\ /g')"
	_Num_Rule="$( echo ${_Dspl_ref} | awk '{ print $1 }' )"
	_Txt_Rule="$( echo ${_Dspl_ref} | sed 's/[0-9]*//g' )"
	## TEST

	_Object="$(useradd -D | grep INACTIVE)"
	if [ "${_Object}" != "INACTIVE=35" ] 
		then 
			_result="1" 
		else 
			_result="0"
	fi
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					useradd -D -f 35 
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