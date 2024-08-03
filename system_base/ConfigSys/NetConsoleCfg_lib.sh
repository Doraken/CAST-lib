###############################################################################
# NetConsole.cfg.lib                                                          #
#                                                                             #
# Creation Date : 18/02/2016                                                  #
# Team          : Myself                                                      #
# Support mail  : doraken@doraken.net                                          #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provide base function to rebuild NetCosole config    #
#                                                                             #
###############################################################################
####
# INFO 



function Do_configure_NetConsole
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
 

local NetConsolePort="${1}"
local SyslogServerAddr="${2}"
local SysLogPort="${3}"
local SysLogMacAddr="${4}"

Empty_Var_Control "${NetConsolePort}"   "NetConsolePort"    "4" " Net Console port is a mandatory parameter "
Empty_Var_Control "${SyslogServerAddr}" "SyslogServerAddr"  "4" " Syslog serveur ip aresse is a mandatory parameter "
Empty_Var_Control "${SysLogPort}"       "SysLogPort"        "4" " syslog port is a mandatory parameter "
Empty_Var_Control "${SysLogMacAddr}"    "SysLogMacAddr"     "4" " syslog Mac adresse is a mandatory parameter "

File_Backup "${NetConsoleConfig}"
FileneconsoleConfigRedirector=" >> ${NetConsoleConfig}"

echo  "" > ${NetConsoleConfig}

eval echo  "# This is the configuration file for the netconsole service.  By starting"       ${FileneconsoleConfigRedirector}
eval echo  "# this service you allow a remote syslog daemon to record console output"        ${FileneconsoleConfigRedirector}
eval echo  "# from this system."                                                             ${FileneconsoleConfigRedirector}
eval echo  ""                                                                                ${FileneconsoleConfigRedirector} 
eval echo  "# The local port number that the netconsole module will use"                     ${FileneconsoleConfigRedirector}
eval echo  "LOCALPORT=${NetConsolePort}"                                                     ${FileneconsoleConfigRedirector}
eval echo  ""                                                                                ${FileneconsoleConfigRedirector}
eval echo  "# The ethernet device to send console messages out of (only set this if it"      ${FileneconsoleConfigRedirector}
eval echo  "# can't be automatically determined)"                                            ${FileneconsoleConfigRedirector}
eval echo  "# DEV="                                                                          ${FileneconsoleConfigRedirector}
eval echo  ""                                                                                ${FileneconsoleConfigRedirector}
eval echo  "# The IP address of the remote syslog server to send messages to"                ${FileneconsoleConfigRedirector}
eval echo  "SYSLOGADDR=${SyslogServerAddr}"                                                  ${FileneconsoleConfigRedirector}
eval echo  ""                                                                                ${FileneconsoleConfigRedirector}
eval echo  "# The listening port of the remote syslog daemon"                                ${FileneconsoleConfigRedirector}
eval echo  "SYSLOGPORT=${SysLogPort}"                                                        ${FileneconsoleConfigRedirector}
eval echo  ""                                                                                ${FileneconsoleConfigRedirector}
eval echo  "# The MAC address of the remote syslog server (only set this if it can t"        ${FileneconsoleConfigRedirector}
eval echo  "# be automatically determined)"                                                  ${FileneconsoleConfigRedirector}
eval echo  "SYSLOGMACADDR=${SysLogMacAddr}"                                                  ${FileneconsoleConfigRedirector}


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
