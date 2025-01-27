#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 
####
# INFO 
#      this lib is for RED-HAT based system
Report_result="/tmp/report"

function 4.1.1_Disable_IP_Forwarding ()
{
	#|# Description :  4.1.1 Disable IP Forwarding
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
	_State="$(/sbin/sysctl net.ipv4.ip_forward | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv4.conf.all.forwarding | awk '{ print $3}' 2> /dev/null)"   
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv4.conf.default.forwarding  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.all.forwarding  | awk '{ print $3}'  2> /dev/null)"   
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.default.forwarding | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv4.conf.all.mc_forwarding | awk '{ print $3}'  2> /dev/null)" 
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv4.conf.default.mc_forwarding | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.all.mc_forwarding | awk '{ print $3}'  2> /dev/null)" 
	if [ "${_State}" != "0" ]  
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.default.mc_forwarding | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv4.ip_forward = 0				 " >  /etc/sysctl.d/net-ipv4-ip_forward
					echo "net.ipv4.conf.all.forwarding = 0       " >> /etc/sysctl.d/net-ipv4-ip_forward
					echo "net.ipv4.conf.default.forwarding = 0   " >> /etc/sysctl.d/net-ipv4-ip_forward
					echo "net.ipv6.conf.all.forwarding = 0       " >> /etc/sysctl.d/net-ipv4-ip_forward
					echo "net.ipv6.conf.default.forwarding = 0   " >> /etc/sysctl.d/net-ipv4-ip_forward 
					echo "net.ipv4.conf.all.mc_forwarding = 0    " >  /etc/sysctl.d/net-ipv4-mc-ip_forward 
					echo "net.ipv4.conf.default.mc_forwarding = 0" >> /etc/sysctl.d/net-ipv4-mc-ip_forward 
					echo "net.ipv6.conf.all.mc_forwardin g= 0    " >> /etc/sysctl.d/net-ipv4-mc-ip_forward 
					echo "net.ipv6.conf.default.mc_forwarding=  0" >> /etc/sysctl.d/net-ipv4-mc-ip_forward 
					/sbin/sysctl -w net.ipv4.ip_forward=0 								 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv4.conf.all.forwarding=0   					 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv4.conf.default.forwarding=0			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.all.forwarding=0    			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.default.forwarding=0 			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv4.conf.all.mc_forwarding=0  			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv4.conf.default.mc_forwarding=0			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.all.mc_forwarding=0    			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.default.mc_forwarding=0 			 > /dev/null 2>&1
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

function 4.1.2_Disable_Send_Packet_Redirects ()
{
	#|# Description :  4.1.2 Disable Send Packet Redirects
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
	_State="$(/sbin/sysctl net.ipv4.conf.all.send_redirects  | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv4.conf.default.send_redirects  | awk '{ print $3}'  2> /dev/null)"   
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv4.conf.all.send_redirects = 0			 " >  /etc/sysctl.d/net-ipv4-send_redirects
					echo "net.ipv4.conf.default.send_redirects = 0       " >> /etc/sysctl.d/net-ipv4-send_redirects
					/sbin/sysctl -w net.ipv4.conf.all.send_redirects=0 			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv4.conf.default.send_redirects=0   			 > /dev/null 2>&1
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

function 4.2.1_Disable_Source_Routed_Packet_Acceptance ()
{
	#|# Description :  4.2.1 Disable Source Routed Packet Acceptance
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
	_State="$(/sbin/sysctl net.ipv4.conf.all.accept_source_route  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv4.conf.default.accept_source_route  | awk '{ print $3}'  2> /dev/null)"   
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.all.accept_source_route  | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.default.accept_source_route  | awk '{ print $3}'  2> /dev/null)"   
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv4.conf.all.accept_source_route = 0			  " >  /etc/sysctl.d/net-ipv4-accept_source_route
					echo "net.ipv4.conf.default.accept_source_route = 0       " >> /etc/sysctl.d/net-ipv4-accept_source_route
					echo "net.ipv6.conf.all.accept_source_route = 0			  " >  /etc/sysctl.d/net-ipv6-accept_source_route
					echo "net.ipv6.conf.default.accept_source_route = 0       " >> /etc/sysctl.d/net-ipv6-accept_source_route
					/sbin/sysctl -w net.ipv4.conf.all.accept_source_route=0 			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv4.conf.default.accept_source_route=0   			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.all.accept_source_route=0 			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.default.accept_source_route=0   			 > /dev/null 2>&1
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

function 4.2.2_Disable_Router_Advertisements_and_Autoconfiguration ()
{
	#|# Description :  4.2.2 Change Number of Unicast IPV6 Addresses assigned
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
	_State="$(/sbin/sysctl net.ipv6.conf.all.accept_ra  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.all.accept_ra_rtr_pref  | awk '{ print $3}'  2> /dev/null)"   
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
		_State="$(/sbin/sysctl net.ipv6.conf.all.accept_ra_pinfo  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.all.accept_ra_defrtr  | awk '{ print $3}'  2> /dev/null)"   
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.all.autoconf  | awk '{ print $3}' 2> /dev/null)"   
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv6.conf.all.accept_ra = 0 		          " >> /etc/sysctl.d/net.ipv6.conf.all.accept_ra
					echo "net.ipv6.conf.all.accept_ra_rtr_pref = 0  	  " >> /etc/sysctl.d/net.ipv6.conf.all.accept_ra
					echo "net.ipv6.conf.all.accept_ra_pinfo = 0  		  " >> /etc/sysctl.d/net.ipv6.conf.all.accept_ra
					echo "net.ipv6.conf.all.accept_ra_defrtr = 0  	      " >> /etc/sysctl.d/net.ipv6.conf.all.accept_ra
					echo "net.ipv6.conf.all.autoconf = 0  		          " >> /etc/sysctl.d/net.ipv6.conf.all.accept_ra
					/sbin/sysctl -w net.ipv6.conf.all.accept_ra=0 			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.all.accept_ra_rtr_pref=0 			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.all.accept_ra_pinfo=0 			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.all.accept_ra_defrtr=0 			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.all.autoconf=0 			 > /dev/null 2>&1

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

function 4.2.3_Change_Number_of_Unicast_IPV6_Addresses_assigned ()
{
	#|# Description :  4.2.3 Change Number of Unicast IPV6 Addresses assigned
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
	_State="$(/sbin/sysctl net.ipv6.conf.all.max_addresses  | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "1" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.default.max_addresses   | awk '{ print $3}' 2> /dev/null)"   
	if [ "${_State}" != "1" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv6.conf.all.max_addresses = 1   			  " >  /etc/sysctl.d/net.ipv6.conf.all.max_addresses
					echo "net.ipv6.conf.default.max_addresses = 1		      " >> /etc/sysctl.d/net.ipv6.conf.all.max_addresses
					/sbin/sysctl -w net.ipv6.conf.all.max_addresses=1   			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.default.max_addresses=1 			 > /dev/null 2>&1
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

function 4.2.4_Change_Amount_of_Duplicate_Address_Detection ()
{
	#|# Description :  4.2.4 Change Amount of Duplicate Address Detection
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
	_State="$(/sbin/sysctl net.ipv6.conf.all.dad_transmits  | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv6.conf.all.dad_transmits = 0    			  " >  /etc/sysctl.d/net.ipv6.conf.all.dad_transmits
					/sbin/sysctl -w net.ipv6.conf.all.dad_transmits=0  > /dev/null 2>&1
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

function 4.2.5_Change_Number_of_Router_Solicitations  ()
{
	#|# Description :  4.2.5 Change Number of Router Solicitations
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
	_State="$(/sbin/sysctl net.ipv6.conf.all.router_solicitations  | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv6.conf.all.router_solicitations = 0    			  " >  /etc/sysctl.d/net.ipv6.conf.all.da_transmits
					/sbin/sysctl -w net.ipv6.conf.all.router_solicitations=0  > /dev/null 2>&1
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

function 4.2.6_Disable_ICMP_Redirect_Acceptance  ()
{
	#|# Description :  4.2.6 Disable ICMP Redirect Acceptance
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
	_State="$(/sbin/sysctl net.ipv4.conf.all.accept_redirects  | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv4.conf.default.accept_redirects | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.all.accept_redirects  | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.default.accept_redirects  | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv4.conf.all.accept_redirects = 0    			  " >  /etc/sysctl.d/net.ipv6.conf.all.da_transmits
					echo "net.ipv4.conf.default.accept_redirects = 0    			  " >  /etc/sysctl.d/net.ipv6.conf.all.da_transmits
					echo "net.ipv6.conf.all.accept_redirects = 0    			  " >  /etc/sysctl.d/net.ipv6.conf.all.da_transmits
					echo "net.ipv6.conf.default.accept_redirects = 0    			  " >  /etc/sysctl.d/net.ipv6.conf.all.da_transmits
					/sbin/sysctl -w net.ipv4.conf.all.accept_redirects=0   > /dev/null 2>&1
					/sbin/sysctl -w net.ipv4.conf.default.accept_redirects=0   > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.all.accept_redirects=0   > /dev/null 2>&1
					/sbin/sysctl -w net.ipv6.conf.default.accept_redirects=0   > /dev/null 2>&1
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

function 4.2.7_Disable_Secure_ICMP_Redirect_Acceptance ()
{
	#|# Description :  4.2.7 Disable Secure ICMP Redirect Acceptance
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
	_State="$(/sbin/sysctl net.ipv4.conf.all.secure_redirects  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv4.conf.default.secure_redirects  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "0" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv4.conf.all.secure_redirects = 0    			  " >  /etc/sysctl.d/net.ipv4.conf.all.secure_redirects
					echo "net.ipv4.conf.default.secure_redirects = 0    			  " >>  /etc/sysctl.d/net.ipv4.conf.all.secure_redirects
					/sbin/sysctl -w net.ipv4.conf.all.secure_redirects=0  > /dev/null 2>&1
					/sbin/sysctl -w net.ipv4.conf.default.secure_redirects=0  > /dev/null 2>&1
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

function 4.2.8_Log_Suspicious_Packets ()
{
	#|# Description :  4.2.8Log Suspicious Packets
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
		_State="$(/sbin/sysctl net.ipv4.conf.all.log_martians  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "1" ] 
		then 
			_result="1"
	fi 
	State="$(/sbin/sysctl net.ipv4.conf.default.log_martians  | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "1" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv4.conf.all.log_martians = 1   			  		  " >  /etc/sysctl.d/net.ipv4.conf.default.log_martians
					echo "net.ipv4.conf.default.log_martians = 1    			  " >> /etc/sysctl.d/net.ipv4.conf.default.log_martians
					/sbin/sysctl -w net.ipv4.conf.all.log_martians=1			 > /dev/null 2>&1
					/sbin/sysctl -w net.ipv4.conf.default.log_martians=1		 > /dev/null 2>&1
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

function 4.2.9_Enable_Ignore_Broadcast_Requests  ()
{
	#|# Description :  4.2.9 Enable Ignore Broadcast Requests
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
		_State="$(/sbin/sysctl net.ipv4.icmp_echo_ignore_broadcasts | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "1" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv4.icmp_echo_ignore_broadcasts = 1    			  " >  /etc/sysctl.d/net.ipv4.icmp_echo_ignore_broadcasts
					/sbin/sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1 		> /dev/null 2>&1
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

function 4.2.10_Enable_Bad_Error_Message_Protection  ()
{
	#|# Description :  4.2.10 Enable Bad Error Message Protection
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
		_State="$(/sbin/sysctl net.ipv4.icmp_ignore_bogus_error_responses  | awk '{ print $3}'  2> /dev/null)"
	if [ "${_State}" != "1" ] 
		then 
			_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv4.icmp_ignore_bogus_error_responses = 1    			  " >  /etc/sysctl.d/net.ipv4.icmp_ignore_bogus_error_responses
					/sbin/sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1     > /dev/null 2>&1
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

function 4.2.11_Enable_RFC_recommended_Source_Route_Validation  ()
{
	#|# Description :  4.2.11 Enable RFC-recommended Source Route Validation
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
		_State="$(/sbin/sysctl net.ipv4.conf.all.rp_filter  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "1" ] 
		then 
	_result="1"
	fi 
		_State="$(/sbin/sysctl net.ipv4.conf.default.rp_filter  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "1" ] 
		then 
	_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv4.conf.all.rp_filter = 1    			  " >  /etc/sysctl.d/net.ipv4.conf.all.rp_filter
					echo "net.ipv4.conf.default.rp_filter = 1    		  " >> /etc/sysctl.d/net.ipv4.conf.all.rp_filter
					/sbin/sysctl -w net.ipv4.conf.all.rp_filter=1 		> /dev/null 2>&1
					/sbin/sysctl -w net.ipv4.conf.default.rp_filter=1  	> /dev/null 2>&1
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

function 4.2.12_Enable_TCP_SYN_Cookies  ()
{
	#|# Description :  4.2.12	Enable TCP SYN Cookies
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
		_State="$(/sbin/sysctl net.ipv4.tcp_syncookies  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "1" ] 
		then 
	_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv4.tcp_syncookies = 1     			  " >  /etc/sysctl.d/net.ipv4.tcp_syncookies
					/sbin/sysctl -w net.ipv4.tcp_syncookies=1  		> /dev/null 2>&1
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

function 4.3_Disable_IPv6 ()
{
	#|# Description :  4.3 Disable IPv6 
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
	_State="$(/sbin/sysctl net.ipv6.conf.all.disable_ipv6  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "1" ] 
		then 
	_result="1"
	fi 
	_State="$(/sbin/sysctl net.ipv6.conf.default.disable_ipv6  | awk '{ print $3}' 2> /dev/null)"
	if [ "${_State}" != "1" ] 
		then 
	_result="1"
	fi 
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "net.ipv6.conf.all.disable_ipv6 = 1      			  " >  /etc/sysctl.d/net.ipv6.conf.default.disable_ipv6
					echo "net.ipv6.conf.default.disable_ipv6 = 1    		  " >>  /etc/sysctl.d/net.ipv6.conf.default.disable_ipv6
					/sbin/sysctl -w	net.ipv6.conf.all.disable_ipv6=1 			> /dev/null 2>&1
					/sbin/sysctl -w	net.ipv6.conf.default.disable_ipv6=1		> /dev/null 2>&1
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

function 4.4_Enable_Firewalld ()
{
	#|# Description :  4.4_Enable_Firewalld
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
	_result="0" && systemctl list-units --type=service | grep firewalld | awk '{ print $2 "_" $3 "_" $4 }' | grep "loaded active running"  > /dev/null 2>&1   && _result="1"
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					systemctl enable firewalld
					systemctl start firewalld 
					iptables --flush
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

function 4.5_Uncommon_Network_Protocols ()
{
	#|# Description :  4.4_Enable_Firewalld
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
	_FromFile="/etc/modprobe.conf"
	grep -r dccp /etc/modprobe.conf /etc/modprobe.d/* | grep install | awk -F\: '{ print $2 }'   > /dev/null 2>&1
	if [ "${?}" != "0" ]
        then
                _result="1"
	fi
	grep -r sctp /etc/modprobe.conf /etc/modprobe.d/* | grep install | awk -F\: '{ print $2 }'  > /dev/null 2>&1
	if [ "${?}" != "0" ]
        then
                _result="1"
	fi
	grep -r rds /etc/modprobe.conf /etc/modprobe.d/* | grep install | awk -F\: '{ print $2 }'   > /dev/null 2>&1
	if [ "${?}" != "0" ]
        then
                _result="1"
	fi
	grep -r tipc /etc/modprobe.conf /etc/modprobe.d/* | grep install | awk -F\: '{ print $2 }'  > /dev/null 2>&1
	if [ "${?}" != "0" ]
        then
                _result="1"
	fi
	
	## end test
	if [ ${_result} = "1" ] 
		then 
			if [ "${_mode}" = "apply" ] 
				then 
					## APPLY
					echo "install dccp /bin/true" > /etc/modprobe.d/UNP.conf
					echo "install sctp /bin/true" >> /etc/modprobe.d/UNP.conf
					echo "install rds  /bin/true" >> /etc/modprobe.d/UNP.conf
					echo "install tipc /bin/true" >> /etc/modprobe.d/UNP.conf
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