###############################################################################
#  mail.lib                                                                   #
#                                                                             #
# Creation Date : 17/03/2008                                                  #
# Team          : Only me                                          #
# Support mail  : doraken@doraken.net                                          #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provide base functions to handle mails sending       #
#                                                                             #
###############################################################################
####
# INFO 

function Mail_check_Mailler
{
#|# Var to set  : None
#|# MS_User_reciever            : Use this var to set mail to sent a mail
#|# MS_User_Subject             : Use this var to set to set subject of the mail 
#|# MS_User_Attached_File       : Use this var to set to set wich file to send with mail 
#|# MS_User_Message             : Use this var to set to set Message of the mail  
#|# ${1}        : Use this var to set [ MS_User_reciever ]                
#|# ${2}        : Use this var to set [ MS_User_Subject ]   
#|# ${3}        : Use this var to set [ MS_User_Attached_File ]                
#|# ${4}        : Use this var to set [ MS_User_Message ]                 
#|#
#|# Base usage  : Mail_Send "MS_User_reciever" "MS_User_Subject" "MS_User_Attached_File" "MS_User_Message" 
#|#
#|# Description : None
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

if  [ "${Global_Tool_mutt_Status}" = "ENABLED" ] 
  then
  	  Global_Mail_Mode="MUTT"
  elif [ "${Global_Tool_mailx_Status}" = "ENABLED" ] 
       then
            Global_Mail_Mode="mailx"
  elif [ "${Global_Tool_mail_Status}" = "ENABLED" ] 
       then 
       	   Global_Mail_Mode="mail"
       else
           MSG_DISPLAY "EdEMessage" "1" "No mail utility activated"
fi  

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}

function Mail_check_att
{
#|# Var to set  : None
#|# MCA_User_Attached_File            : Use this var to set mail to sent a mail
#|# ${1}        : Use this var to set [ MS_User_reciever ]                
#|#
#|# Base usage  : Mail_Send "MS_User_reciever" "MS_User_Subject" "MS_User_Attached_File" "MS_User_Message" 
#|#
#|# Description : None
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}

function Mail_Send
{
#|# Var to set  : None
#|# MS_User_reciever            : Use this var to set mail to sent a mail
#|# MS_User_Subject             : Use this var to set to set subject of the mail 
#|# MS_User_Attached_File       : Use this var to set to set wich file to send with mail 
#|# MS_User_Message             : Use this var to set to set Message of the mail  
#|# ${1}        : Use this var to set [ MS_User_reciever ]                
#|# ${2}        : Use this var to set [ MS_User_Subject ]   
#|# ${3}        : Use this var to set [ MS_User_Attached_File ]                
#|# ${4}        : Use this var to set [ MS_User_Message ]                 
#|#
#|# Base usage  : Mail_Send "MS_User_reciever" "MS_User_Subject" "MS_User_Attached_File" "MS_User_Message" 
#|#
#|# Description : None
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local MS_User_reciever="${1}"
local MS_User_Subject="${2}"
local MS_User_Attached_File="${3}"
local MS_User_Message="${4}"

Mail_check_Mailler

Empty_Var_Control "${MS_User_reciever}"      "MS_User_reciever"      "4"  "can t send message to nobody" 
Empty_Var_Control "${MS_User_Subject}"       "MS_User_Subject"       "4"  "Use defaul subject [ from script ${Action_Type} ]" "MS_User_Subject=\"from script ${Action_Type}\"" 
MS_File_On_ok_Simple="Global_Mail_Mode=$( echo  "${Global_Mail_Mode}_ATT" )" 
MS_File_On_ko_simple=""
Empty_Var_Control "${MS_User_Attached_File}" "MS_User_Attached_File"  "4"  "No file to send" "${MS_File_On_ko_simple}" "${MS_File_On_ok_Simple}" 
Empty_Var_Control "${MS_User_Message}"       "MS_User_Message"        "4" "" 



case ${Global_Mail_Mode} in 
        MAIL_ATT) if [ "${Global_Tool_uuencode_Status}" = "ENABLED" ] 
                   then 
                   	   MF_Simple_Filename="$( echo ${MS_User_Attached_File} | awk -F "/" '{ print $NF }')"
                       MS_Mail_commande_line="${Global_Tool_uuencode_bin}  ${MS_User_Attached_File} ${MF_Simple_Filename} | cat ${MS_User_Message} - |   ${Global_Tool_mail_bin} -s ${MS_User_Subject} ${MS_User_reciever}"
                   else 
                       MS_Mail_commande_line="cat ${MS_User_Message} | ${Global_Tool_mail_bin} -s ${MS_User_Subject} ${MS_User_reciever}"
                  fi
                  ;; 
       MAILX_ATT) if [ "${Global_Uuencode_Mode}" = "ENABLED" ] 
                    then 
                   	   MF_Simple_Filename="$( echo ${MS_User_Attached_File} | awk -F "/" '{ print $NF }')"
                       MS_Mail_commande_line="${Global_Tool_uuencode_bin}  ${MS_User_Attached_File} ${MF_Simple_Filename} | cat ${MS_User_Message} - |   ${Global_Tool_mailx_bin} -s ${MS_User_Subject} ${MS_User_reciever}"
                   else 
                       MS_Mail_commande_line="cat ${MS_User_Message} |  ${Global_Tool_mailx_bin} -s ${MS_User_Subject} ${MS_User_reciever}"
                  fi
                  ;;
        MUTT_ATT) if [ "${Global_Uuencode_Mode}" = "ENABLED" ] 
                     then 
                         MS_Mail_commande_line="${Global_Tool_mutt_bin} -s \" ${MS_User_Subject}\" -a ${MS_User_Attached_File} ${MS_User_reciever}  < ${MS_User_Message}"
                     else 
                         MS_Mail_commande_line="${Global_Tool_mutt_bin} -s \" ${MS_User_Subject}\" ${MS_User_reciever}  < ${MS_User_Message}"
                   fi
                   ;;
             MAIL) MS_Mail_commande_line=" cat ${MS_User_Message} |   ${Global_Tool_mail_bin} -s ${MS_User_Subject} ${MS_User_reciever}"
                   ;; 
            MAILX) MS_Mail_commande_line=" cat ${MS_User_Message} |   ${Global_Tool_mailx_bin} -s ${MS_User_Subject} ${MS_User_reciever}"
                   ;;
             MUTT) MS_Mail_commande_line="${Global_Tool_mutt_bin} -s \" ${MS_User_Subject}\" ${MS_User_reciever}  < ${MS_User_Message}"
                   ;;
                *) MSG_DISPLAY "EdEMessage" "2" "Not supported case ${Global_Mail_Mode}"
                   ;;
esac 

${MS_Mail_commande_line}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

# Sourcing control variable 
LibState="OK"  