#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
 
# INFO                                                             
# Subject : This library provide base functions to get system information    

RELEASE=$(cat /proc/sys/kernel/osrelease)
VERSION=$(cat /proc/sys/kernel/version)

DATE=$(date +%Y-%m-%d)
CPU=$(sed -n -e '/model name/p' /proc/cpuinfo | awk '{print $4,$5,$6,$7,$9}')



function Report_Linux_get_os_release
{
#|# Var to set  : None
#|#
#|# Base usage  : Report_Linux_get_os_release
#|#
#|# Description : This function is used to get kernel information about installed os
#|#
#|# Send Back   : this function returne three vars GLOBALE_OS_TYPE , GLOBALE_OS_RELEASE , GLOBALE_OS_VERSION
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

RLGOSR_TYPE="$(cat /proc/sys/kernel/ostype)"
RLGOSR_RELEASE="$(cat /proc/sys/kernel/osrelease)"
RLGOSR_VERSION="$(cat /proc/sys/kernel/version | awk  '{ print "\\" $0 }' )"

MSG_DISPLAY "info" "1" "Operating sytem type : [ ${RLGOSR_TYPE}] "
MSG_DISPLAY "info" "1" "Operating sytem release : [ ${RLGOSR_RELEASE} ] "
MSG_DISPLAY "info" "1" "Operating sytem version : [ ${RLGOSR_VERSION} ] "

GLOBALE_OS_TYPE="${RLGOSR_TYPE}"
GLOBALE_OS_RELEASE="${RLGOSR_RELEASE}"
GLOBALE_OS_VERSION="${RLGOSR_VERSION}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Report_Linux_get_os_Kernel_params
{
#|# Var to set  : None
#|#
#|# Base usage  : Report_Linux_get_os_Kernel_params
#|#
#|# Description : This function is used to get kernel information about installed os
#|#
#|# Send Back   : this function returne three vars GLOBALE_OS_TYPE , GLOBALE_OS_RELEASE , GLOBALE_OS_VERSION
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

RLGOKP_SHM_MIN="$(cat /proc/sys/kernel/shmmni)"
RLGOKP_SHM_MAX="$(cat /proc/sys/kernel/shmmax)"
RLGOKP_SHM_ALL="$(cat /proc/sys/kernel/shmall)"

MSG_DISPLAY "info" "1" "Max shared memory pages              : [ ${RLGOKP_SHM_ALL} ] "
MSG_DISPLAY "info" "1" "Max size of shared memory Segment    : [ ${RLGOKP_SHM_MAX} ] "
MSG_DISPLAY "info" "1" "Max number of shared memory segments : [ ${RLGOKP_SHM_MIN} ] "

GLOBALE_SHM_MIN="${RLGOKP_SHM_MIN}"
GLOBALE_SHM_MAX="${RLGOKP_SHM_MAX}"
GLOBALE_SHM_ALL="${RLGOKP_SHM_ALL}"

set -A RLGOKP_sem_all_param $( cat /proc/sys/kernel/sem )

GLOBALE_sem_SEMMSL="${RLGOKP_sem_all_param[0]}"
GLOBALE_sem_SEMOPM="${RLGOKP_sem_all_param[1]}"
GLOBALE_sem_SEMMNS="${RLGOKP_sem_all_param[2]}"
GLOBALE_sem_SEMMNI="${RLGOKP_sem_all_param[3]}"

MSG_DISPLAY "info" "1" "Maximum number of semaphores in a sempahore set : [ ${GLOBALE_sem_SEMMSL} ] "
MSG_DISPLAY "info" "1" "Maximum number of sempahores in the system : [ ${GLOBALE_sem_SEMOPM} ] "
MSG_DISPLAY "info" "1" "Maximum number of operations in a single Start of changesemopEnd of change call : [ ${GLOBALE_sem_SEMMNS} ] "
MSG_DISPLAY "info" "1" "Maximum number of sempahore sets : [ ${GLOBALE_sem_SEMMNI} ] "

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Report_Linux_get_os_IPV4_status
{
#|# Var to set  : None
#|#
#|# Base usage  : Report_Linux_get_os_Kernel_params
#|#
#|# Description : This function is used to get kernel information about installed os
#|#
#|# Send Back   : this function returne three vars GLOBALE_OS_TYPE , GLOBALE_OS_RELEASE , GLOBALE_OS_VERSION
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

RIS_IPV4_Base_dir="/proc/sys/net/ipv4/"

if [ "$( cat ${RIS_IPV4_Base_dir}/ip_forward)" = "1" ]
   then
   	   RIS_IPV4_forward="Enabled"
   else
       RIS_IPV4_forward="Disabled"
fi
GLOBALE_IPV4_Forward="${RIS_IPV4_forward}"
MSG_DISPLAY "info" "1" "Forward Packets between interfaces  : [ ${GLOBALE_IPV4_Forward} ] "

GLOBALE_IPV4_TTL="$( cat ${RIS_IPV4_Base_dir}/ip_default_ttl)"
MSG_DISPLAY "info" "1" "Forward Packets between interfaces  : [ ${GLOBALE_IPV4_TTL} ] "

if [ "$( cat ${RIS_IPV4_Base_dir}/tcp_abort_on_overflow)" = "1" ]
   then
       RIS_IPV4_abort_on_overflow="Enabled"
   else
       RIS_IPV4_abort_on_overflow="Disabled"
fi
GLOBALE_IPV4_abort_on_overflow=${RIS_IPV4_forward}
MSG_DISPLAY "info" "1" "Tcp connexion abort on overflow   : [ ${GLOBALE_IPV4_abort_on_overflow} ] "

if [ "$( cat ${RIS_IPV4_Base_dir}/tcp_tw_recycle)" = "1" ]
   then
       RIS_IPV4_tcp_tw_recycle="Enabled"
   else
       RIS_IPV4_tcp_tw_recycle="Disabled"
fi
GLOBALE_IPV4_tcp_tw_recycle=${RIS_IPV4_forward}
MSG_DISPLAY "info" "1" "Fast recycling TIME-WAIT sockets  : [ ${GLOBALE_IPV4_tcp_tw_recycle} ] "

if [ "$( cat ${RIS_IPV4_Base_dir}/ip_dynaddr)" = "1" ]
   then
       RIS_IPV4_ip_dynaddr="Enabled"
   else
       RIS_IPV4_ip_dynaddr="Disabled"
fi
GLOBALE_IPV4_ip_dynaddr=${RIS_IPV4_ip_dynaddr}
MSG_DISPLAY "info" "1" "Tcp connexion abort on overflow   : [ ${GLOBALE_IPV4_ip_dynaddr} ] "

if [ "$( cat ${RIS_IPV4_Base_dir}/ip_dynaddr)" = "1" ]
   then
       RIS_IPV4_ip_dynaddr="Enabled"
   else
       RIS_IPV4_ip_dynaddr="Disabled"
fi
GLOBALE_IPV4_ip_dynaddr=${RIS_IPV4_ip_dynaddr}
MSG_DISPLAY "info" "1" "Support for dynamic addresses  : [ ${GLOBALE_IPV4_ip_dynaddr} ] "

if [ "$( cat ${RIS_IPV4_Base_dir}/icmp_echo_ignore_all)" = "1" ]
   then
       RIS_IPV4_icmp_echo_ignore_all="Enabled"
   else
       RIS_IPV4_icmp_echo_ignore_all="Disabled"
fi
GLOBALE_IPV4_icmp_echo_ignore_all=${RIS_IPV4_icmp_echo_ignore_all}
MSG_DISPLAY "info" "1" "Ignore all icmp echo  : [ ${GLOBALE_IPV4_icmp_echo_ignore_all} ] "

if [ "$( cat ${RIS_IPV4_Base_dir}/icmp_echo_ignore_broadcasts)" = "1" ]
   then
       RIS_IPV4_icmp_echo_ignore_broadcasts="Enabled"
   else
       RIS_IPV4_icmp_echo_ignore_broadcasts="Disabled"
fi
GLOBALE_IPV4_icmp_echo_ignore_broadcasts=${RIS_IPV4_icmp_echo_ignore_broadcasts}
MSG_DISPLAY "info" "1" "Ignore all icmp echo on multicast : [ ${GLOBALE_IPV4_icmp_echo_ignore_broadcasts} ] "


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Repport_FS_State_ONE_Server
{
#|# Var to set  :
#|# RFSOS_PF_Name : Use this var to set plate forme name to use
#|#             : Use this var to set
#|# ${1}        : Use this var to set [ RFSOS_PF_Name ]
#|# ${2}        : Use this var to set [  ]
#|#
#|# Base usage  : None
#|#
#|# Description : None
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="State_ONE_Server"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

CURENT_WORK_DIR=`echo ${Current_PF} | awk -F\/ '{ print $NF }'`
MSG_DISPLAY "debug" "0" "Current CURENT WORK DIR : [ ${CURENT_WORK_DIR} ] "

CURRENT_GENERATE_DIR=${Server_Stat_Directory}/${CURENT_WORK_DIR}
MSG_DISPLAY "debug" "0" "Current CURRENT GENERATE DIR : [ ${CURRENT_GENERATE_DIR} ] "

Current_Generated_Report="${CURRENT_GENERATE_DIR}/${current_server}.HTML"
Set_new_directory "${CURRENT_GENERATE_DIR}"

Full_Server_File_PATH="${Current_PF}/${current_server}"
MSG_DISPLAY "debug" "0" "Current Full Server File PATH to Check : [ ${Full_Server_File_PATH} ] "

HTML_File_to_export="${Server_Stat_Directory}/${CURENT_WORK_DIR}/${current_server}.html"
Server_Name_To_report="${current_server}"
HEAD_REPORT
TABLE_HEAD_REPORT_FS

for Lines in $( cat ${Full_Server_File_PATH} )
    do
       MSG_DISPLAY "debug" "0" "Current lines : [ ${Lines} ] "

       Device_Name_To_State=$( echo ${Lines} | awk -F\| '{ print $1 }' )
       MSG_DISPLAY "debug" "0" "Current Device Name To State : [ ${Device_Name_To_State} ] "

       Device_size_To_state="$( echo ${Lines} | awk -F\| '{ print $2 }' )"
       MSG_DISPLAY "debug" "0" "Current Device size To state : [ ${Device_size_To_state} ] "

       Device_OcSi_To_State="$( echo ${Lines} | awk -F\| '{ print $3 }' )"
       MSG_DISPLAY "debug" "0" "Current Device Name To State : [ ${Device_Name_To_State} ] "

       Device_Free_To_State="$( echo ${Lines} | awk -F\| '{ print $4 }' )"
       MSG_DISPLAY "debug" "0" "Current Device Free Space To State : [ ${Device_Free_To_State} ] "

       Device_perc_To_State=$( echo ${Lines} | awk -F\| '{ print $5 }' )
       MSG_DISPLAY "debug" "0" "Current Device percent used To State : [ ${Device_perc_To_State} ] "

       Device_Mnts_To_State=$( echo ${Lines} | awk -F\| '{ print $6 }' )
       MSG_DISPLAY "debug" "0" "Current Device Mount point To State : [ ${Device_Mnts_To_State} ] "

       Percent_Occuped=$( echo ${Device_perc_To_State}  | awk -F% '{ print $1 }' )
       MSG_DISPLAY "debug" "0" "Current Percent_Occuped : [ ${Percent_Occuped} ] "
       if [ "${Percent_Occuped}" -gt "85" ]
          then
               if [ "${Percent_Occuped}" -gt "95" ]
                  then
                     State_Case="ERROR"
                     MSG_DISPLAY "info" "1" "ERROR File System ${Device_Name_To_State} mounted on ${Device_Mnts_To_State} is at  : ${Percent_Occuped}"
                     Error_HTML_REPORT_FS
                 else
                     State_Case="WARNING"
                     MSG_DISPLAY "info" "1" "Warning File System ${Device_Name_To_State} mounted on ${Device_Mnts_To_State} is at  : ${Percent_Occuped}"
                     Warn_HTML_REPORT_FS
              fi
          else
              State_Case="GOOD"
              MSG_DISPLAY "info" "1" "File System ${Device_Name_To_State} mounted on ${Device_Mnts_To_State} is at  : ${Percent_Occuped}"
              HTML_Good_Html_Report_FS
              meta_Report_GENERATE_INFS
       fi
done
TABLE_CLOSE_REPORT_FS
footer_report_gen
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