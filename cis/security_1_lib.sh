#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 
####
# INFO 
#      this lib is for RED-HAT based system

function 1.1.1_Separate_Filesystems ()
{
	#|# Description :  1.1.1	Separate Filesystems
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
	testmnt="/tmp /var /var/log /home"
	_result="0" 
	for mntpoint in ${testmnt} 
		do 
			cat /etc/fstab | grep "${mntpoint} " 
			if [ "${?}" != "0" ]
				then
					_result="1"
			fi
	done 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
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

function 1.1.2_tmp_mount_options ()
{
	#|# Description :  1.1.2 /tmp mount options
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
	_result="0"
	grep /tmp /etc/fstab > /dev/null 2&>1 
	if [ ${?} != "0" ] 
		then 
			_result="1"
			_mode=""
		else 
			grep /tmp /etc/fstab |  egrep 'nodev|nosuid|noexec' > /dev/null  2&>1 
			if [ ${?} != "0" ] 
				then 
				_result="1"
			fi 
	fi
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "/etc/fstab"
					_OriginalLine="$(cat /etc/fstab | grep "/tmp " |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g")"
					_oldVal="$(cat /etc/fstab | grep "/tmp " | awk '{ print $4 }' )"
					_NewLine="$(cat /etc/fstab | grep "/tmp " | sed -e "s/${_oldVal}/nodev,nosuid,noexec/g" |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g" )"
					sed -i "s/${_OriginalLine}/${_NewLine}/g" /etc/fstab 
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

function 1.1.3_home_mount_options ()
{
	#|# Description :  1.1.3 home mount options
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
	_result="0"
	grep /home /etc/fstab > /dev/null 2>1
	if [ ${?} != "0" ] 
		then 
			_result="1"
			_mode=""
		else 
			grep /home /etc/fstab |  egrep 'nodev' > /dev/null 2>&1
			if [ ${?} != "0" ] 
				then 
				_result="1"
			fi 
	fi
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "/etc/fstab"
					_OriginalLine="$(cat /etc/fstab | grep "/home " |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g")"
					_oldVal="$(cat /etc/fstab | grep "/home " | awk '{ print $4 }' )"
					_NewLine="$(cat /etc/fstab | grep "/home " | sed -e "s/${_oldVal}/default,nodev/g" |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g")"
					sed -i "s/${_OriginalLine}/${_NewLine}/g" /etc/fstab 
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

function 1.1.4_dev_shm_mount_options
{	
	#|# Description :  1.1.4 /dev/shm mount options
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
	_result="0"
	grep "/dev/shm" /etc/fstab > /dev/null 2&>1
	if [ ${?} != "0" ] 
		then 
			_result="1"
		else 
			grep "/dev/shm" /etc/fstab |  egrep 'rw,seclabel,noexec,nosuid,nodev' > /dev/null 2>&1
			if [ ${?} != "0" ] 
				then 
				_result="1"
			fi 
	fi
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "/etc/fstab"
					grep "/dev/shm" /etc/fstab > /dev/null 2&>1
					if [ ${?} != "0" ] 
						then 
							echo "tmpfs /dev/shm tmpfs rw,seclabel,noexec,nosuid,nodev 0 0" >> /etc/fstab
						else 
							_OriginalLine="$(cat /etc/fstab | grep "/dev/shm " |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g")"
							_NewLine="$(cat /etc/fstab | grep "/dev/shm " | sed -e "s/${_OriginalLine}/rw,seclabel,noexec,nosuid,nodev/g" |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g" )"
							sed -i "s/${_OriginalLine}/${_NewLine}/g" /etc/fstab 
					fi
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

function 1.1.5_Bind_Mount_the_var_tmp_directory_to_tmp ()
{
	#|# Description :  1.1.5 Bind Mount the /var/tmp directory to /tmp
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
	grep /var/tmp /etc/fstab > /dev/null 2&>1
	if [ ${?} != "0" ] 
		then 
			_result="1"
		else 
			grep /var/tmp /etc/fstab | grep "/tmp" | grep  "/var/tmp" | grep "none"  | grep "bind" > /dev/null 2&>1
			if [ ${?} != "0" ] 
				then 
					_result="1"
			fi 
	fi
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					File_Backup "/etc/fstab"
					_OriginalLine="$(cat /etc/fstab | grep "/var/tmp " |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g"  | sed -e "s/\#/\\\\#/g")"
					_NewLine="$(echo "/tmp /var/tmp none bind 0 0" |  sed -e "s/\ /\\\ /g" | sed -e "s/\//\\\\\//g" | sed -e "s/\#/\\\\#/g" )"
					sed -i "s/${_OriginalLine}/${_NewLine}/g" /etc/fstab 
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

function 1.1.7_Disable_mounting_certain_type_of_filesystems ()
{
	#|# Description :  1.1.7 Disable mounting certain type of filesystems
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
	_FromFile="/etc/modprobe.d/uncommonfs.conf"

	_Object="install cramfs /bin/true" 
	checkObjfromFile "${_Object}" "${_FromFile}"	
	_Object="install freevxfs /bin/true" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="install jffs2 /bin/true"   
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="install hfs /bin/true"    
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="install hfsplus /bin/true"  
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="install squashfs /bin/true" 
	checkObjfromFile "${_Object}" "${_FromFile}"
	_Object="install udf /bin/true"       
	checkObjfromFile "${_Object}" "${_FromFile}"
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_Object="install cramfs /bin/true" 
					PutObjToFile "${_Object}" "${_FromFile}"	
					_Object="install freevxfs /bin/true" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="install jffs2 /bin/true"   
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="install hfs /bin/true"    
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="install hfsplus /bin/true"  
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="install squashfs /bin/true" 
					PutObjToFile "${_Object}" "${_FromFile}"
					_Object="install udf /bin/true"       
					PutObjToFile "${_Object}" "${_FromFile}"
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

function 1.2_Use_the_Latest_OS_Release  
{
	#|# Description :  1.2	Use the Latest OS Release 
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
	
	## TEST 
	_result="1" && cat /etc/redhat-release | grep 7.6 > /dev/null 2>&1 && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					
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

function 1.3.2_Verify_that_gpgcheck_is_Globally_Activated 
{
	#|# Description :  1.3.2_Verify_that_gpgcheck_is_Globally_Activated  
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
	
	## TEST 
	_result="1" && cat /etc/yum.conf | grep "gpgcheck=1" > /dev/null 2>&1 && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_OriginalLine="$(cat /etc/yum.conf | grep "gpgcheck=" )"
					sed -i "s/${_OriginalLine}/gpgcheck=1/g" /etc/yum.conf
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

function 1.3.3_Disable_the_rhnsd_Daemon 
{
	#|# Description :  this functionc will remove  rhnsd Daemon
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
	chkconfig  2>>  /dev/null |grep rhnsd | grep on  >> /dev/null
	## end test
	if [ ${?} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then
					## APPLY
					systemctl stop rhnsd > /dev/null 
					chkconfig rhnsd off  > /dev/null
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

function 1.4.1_Install_AIDE  ()
{
	#|# Description :  1.4.1 Install AIDE 
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
	_result="1" && yum list installed aide  -q > /dev/null 2>&1 && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_Install_Package "aide"
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

function 1.4.2_Implement_Periodic_Execution_of_File_Integrity ()
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

	crontab -u root -l | grep aide | grep check >> /dev/null 
	if [ ${?} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					{ crontab -u root -l; echo "0 5 * * * /usr/sbin/aide --check"; } | crontab -u root -
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

function 1.5.1_Set_the_SELinux_State 
{
	#|# Description :  1.5.1 Set the SELinux State  
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
	
	## TEST 
	_result="1" && grep "SELINUX=enforcing" /etc/selinux/config  > /dev/null 2>&1 && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_OriginalLine="$(grep "SELINUX="  /etc/selinux/config )"
					sed -i "s/${_OriginalLine}/SELINUX=enforcing/g" /etc/yum.conf
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

function 1.5.2_Set_the_SELinux_Policy
{
	#|# Description :  1.5.2 Set the SELinux Policy 
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
	
	## TEST 
	_result="1" && grep "SELINUXTYPE=targeted" /etc/selinux/config  > /dev/null 2>&1 && _result="0"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					_OriginalLine="$(grep "SELINUXTYPE="  /etc/selinux/config )"
					sed -i "s/${_OriginalLine}/SELINUXTYPE=targeted/g" /etc/yum.conf
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

function 1.5.3_Remove_SETroubleshoot ()
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
	_result="0" && yum list installed SETroubleshoot -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "SETroubleshoot"
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

function 1.5.4_Remove_MCS_Translation_Service ()
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
	_result="0" && yum list installed mcstrans -q > /dev/null 2>&1 && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					yum_UnInstall_Package "mcstrans"
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

function 1.6.1_Set_User_Group_Owner_and_permissions_on_etc_grub_conf ()
{
	#|# Description :  1.6.1 Set User/Group Owner and permissions on /etc/grub2.conf
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
	locale _GRBcnf_OWN="$( ls -al /etc/grub2.cfg | awk '{ print $3 "_" $4 }' )"
	locale _GRBcnf_OWN="${_GRBcnf_OWN} $( ls -al /etc/grub.d | awk '{ print $3 "_" $4 }' )"
	for grub_sun in $( find /etc/grub.d/ -type f ) 
		do 	
			_GRBcnf_OWN="${_GRBcnf_OWN} $( ls -al ${grub_sun} | awk '{ print $3 "_" $4 }' )"
	done 
	for _Grubown in ${_GRBcnf_OWN} 
		do 
			if [ ${_Grubown} != "root_root" ] 
				then 
					_result="1"
			fi 
	done 
	
	
			
	if [ ${?} = "0" ]
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
					chown root:root /etc/grub2.conf
					chmod og-rwx /etc/grub2.conf
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