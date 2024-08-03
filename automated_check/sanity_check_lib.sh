#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                                  #
# Subject : This library provide base auto sanity check to control sript env  #
#                                                                             #
###############################################################################
####
# Info

function SANITY_CHECK_Base_env_directory_check
{
#|# Var to set  : None
#|#
#|# Base usage  : SANITY_CHECK_Base_env_directory_check
#|#
#|# Description : This function check and create all mandatory directories needed for CAST execution
#|#
#|# Send Back   : Directory
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

MSG_DISPLAY "info" "1" "Directory Sanity check [ STARTING ] "
if [ "${SANITY_CHECK_Base_env_directory_check_exec}" = "1" ]
   then
   	   MSG_DISPLAY "debug" "0" "Sanity check for generic tmp already done"
   else
      for _Config_File in $( find ${Base_Dir_Scripts_CNF} -type f -name \*.cnf  ) 
         do 
            MSG_DISPLAY "info" "1" "checking base directory for config file : [ ${_Config_File} ] "
            for Dirs in $( cat ${_Config_File} | grep "DIR_To_CHECK" | awk '{ print $1 }' | awk -F\= '{print "\$\{"$1"\}" }' 2> /dev/null )
                do
                    Dirs="$( eval echo ${Dirs} )"
                    Edir="$( eval echo ${Dirs} )"
                    #MSG_DISPLAY "info" "1" "checking base directory  : [ ${Dirs} ] "
                    Set_new_directory   "${Edir}"
                done
        done
fi

SANITY_CHECK_Base_env_directory_check_exec="1"
Spacer_MSG
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}




function SANITY_CHECK_Base_env_directory_check_specs
{
#|# Var to set  : None
#|#
#|# Base usage  : SANITY_CHECK_Base_env_directory_check
#|#
#|# Description : This function check and create all mandatory directories needed for CAST execution
#|#
#|# Send Back   : Directory
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

if [ -z "${Conf_Specifics}" ]
   then
       MSG_DISPLAY "info" "1" "Specifics configuration file  : [ ERROR : NULL VALUE ] "
   else
       if [ "${Conf_Specifics}" = "dummy" ]
          then
              MSG_DISPLAY "info" "1" "Specifics configuration file : [ NONE ] "
          else
              echo  "${Base_Dir_Scripts_CNF_spec}/${Conf_Specifics} ---"
         cat ${Base_Dir_Scripts_CNF_spec}/${Conf_Specifics} | grep "DIR_To_CHECK" | awk '{ print $1 }' | awk -F\= '{print "\$\{"$1"\}" }' 
              for Dirs in $( cat ${Base_Dir_Scripts_CNF_spec}/${Conf_Specifics} | grep "DIR_To_CHECK" | awk '{ print $1 }' | awk -F\= '{print "\$\{"$1"\}" }' 2> /dev/null )
                  do     Dirs=$( eval echo ${Dirs} )
                         MSG_DISPLAY "info" "1" "checking base directory  : [ ${Dirs} ] "
                         Dirs=$( eval echo ${Dirs}) 
                         Set_new_directory   "${Dirs}"
                         pause
                   done
        fi
fi
MSG_DISPLAY "info" "1" "Directory Sanity check [ END ] "

SANITY_CHECK_Base_env_directory_check_exec="1"
Spacer_MSG
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SANITY_CHECK_Base_root_exec_check
{
#|# Var to set  : None
#|#
#|# Base usage  : SANITY_CHECK_Base_root_exec_check
#|#
#|# Description : This function check if you are using root to execute CAST
#|#               If active it will prompt for user confirmation and send back execution in root mode in system log
#|#
#|# Send Back   : User Check
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
Spacer_MSG

MSG_DISPLAY "info" "1" "User Sanity check [ STARTING ] "
My_Current_User=$( id | awk -F "[\(\)]" '{ print $2 }' 2> /dev/null )
if [ "${My_Current_User}" = "root" ]
   then
       MSG_DISPLAY "info" "1" "Your are currently running CAST toolBox with \"root\" account "
   	   PS3="Do you want to exit ? [ it's better to exit ] "
       select Result in "Continue" "EXIT"
              do
                case ${Result} in
	                 "Continue") MSG_DISPLAY "Warning1" "User select to user root account"
	                      My_Ident="$(who i am | awk '{ print $1 }')"
	                      MSG_DISPLAY "LoggerN"  " $( date ) CAST scripting user whith root account by [ ${My_Ident} ] "
	                      ;;
	                  "EXIT") MSG_DISPLAY "EdEMessage" "1" "User select to exit"  
	                      ;;
	                  *) MSG_DISPLAY "EdEMessage" "1" "Bad input exit [ ${Result} ] "  
	                      ;;
                 esac
        done
      else
       MSG_DISPLAY "info" "1" "you are currently running CAST toolBox with [ ${My_Current_User} ] "
       MSG_DISPLAY "LoggerN" "1" "CAST toolBox launched with [ ${My_Current_User} ] at $( date ) "  
fi
MSG_DISPLAY "info" "1" "User Sanity check [ END ] "

Spacer_MSG
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function SANITY_CHECK_Check_TMP_Directory
{
#|# Var to set  : None
#|#
#|# Base usage  : SANITY_CHECK_Check_TMP_Directory
#|#
#|# Description : This function check and create all mandatory writable directories needed for CAST execution
#|#
#|# Send Back   : writables Directory
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
Spacer_MSG
if [ "${SANITY_CHECK_Check_TMP_Directory_exec}" = "1" ]
   then
   	   MSG_DISPLAY "debug" "0" "Sanity check for generic tmp already done"
   else
       for Dirs in $( cat ${Conf_Generics} | grep "DIR_To_CHECK_TMP" | awk '{ print $1 }' | awk -F\= '{print "\$\{"$1"\}" }' 2> /dev/null )
           do Dirs=$( eval echo ${Dirs} )
           echo  ${Dirs} | grep tmp  > /dev/null
           if  [ "${?}" = "0" ]
              then
                  IS_Writable "${Dirs}" "1"
               else
                   MSG_DISPLAY "debug" "0" "Directory ${Dirs} is : [ Not a temporary Directory ] "
            fi
        done
fi
if [ -z "${Conf_Specifics}" ]
   then
       MSG_DISPLAY "info" "1" "Specifics configuration file  : [ ERROR : NULL VALUE ] "
   else
       if [ "${Conf_Specifics}" = "dummy" ]
          then
              MSG_DISPLAY "info" "1" "Specifics configuration file : [ NONE ] "
          else
              for Dirs in $( cat ${Base_Dir_Scripts_CNF_spec}/${Conf_Specifics} | grep "DIR_To_CHECK_TMP" | awk '{ print $1 }' | awk -F\= '{print "\$\{"$1"\}" }' 2> /dev/null )
                  do Dirs=$( eval echo ${Dirs} )
                     echo    "${Dirs}" | grep tmp  > /dev/null
                    if  [ "${?}" = "0" ]
                      then
        	              IS_Writable "${Dirs}" "1"
                      else
   	                      MSG_DISPLAY "debug" "0" "Directory ${Dirs} is : [ Not a temporary Directory ] "
                    fi
                done
       fi
fi
SANITY_CHECK_Check_TMP_Directory_exec="1"
Spacer_MSG
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SANITY_CHECK_Check_Language
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
Spacer_MSG
if [ "${LANG}" = "${Base_Script_Language}" ]
   then
   	   MSG_DISPLAY "info" "6" "System language  : [ ${LANG} ] "
   else
       MSG_DISPLAY "debug" "0" "System language  : [ ${LANG} ] "
       MSG_DISPLAY "debug" "0" " ACTION : [ Overriding system default language  ] "
       LANG="${Base_Script_Language}"
       LANGUAGE="${Base_Script_Language}"
       LC_ALL="${Base_Script_Language}"
       ### TODO add full language check
       export LANGUAGE
       export LANG
       export LC_ALL
       if [ "${LANG}" = "${Base_Script_Language}" ]
          then
   	          MSG_DISPLAY "debug" "0" "Overrided System language  : [ ${LANG} ] "
          else
              MSG_DISPLAY "debug" "0" "Overrid System language  : [ ERROR ] "
              MSG_DISPLAY "debug" "0" "Somme problem on messaging display may appear  "
       fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SANITY_CHECK_cnf_file
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SANITY_CHECK_tools
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Set_tool_global_status

Fil_Get_Items "EXEC_Global_MANDATORY_control_sanity" "1" "${Base_Dir_Scripts_Lib}/system_base/tool_lib.sh" "="

for SCT_items  in ${GLOBAL_FGI_Selected_items[@]}
   do
   	  SCT_items="$( echo  ${SCT_items} | awk -F "=" '{ print $1 }')"
   	  SCT_status="$( eval echo  "\${${SCT_items}}" )"
      SCT_Bin_Name="$( echo  "${SCT_items}" | awk -F "_" '{ print $3 }' )"
      if [ "${SCT_status}" = "ENABLED" ]
         then
             MSG_DISPLAY "debug" "0" "status of ${SCT_Bin_Name} bin  Mandatory  : [ ${SCT_status} ]"
         else
             MSG_DISPLAY "EdEMessage" "1" "status of ${SCT_Bin_Name} bin  Mandatory  : [ ${SCT_status} ] " 
      fi
done

Fil_Get_Items "EXEC_Global_SET_control_sanity" "1" "${Base_Dir_Scripts_Lib}/system_base/tool_lib.sh" "="

for SCT_items  in ${GLOBAL_FGI_Selected_items[@]}
   do
      SCT_items="$( echo  ${SCT_items} | awk -F "=" '{ print $1 }')"
   	  SCT_status="$( eval echo  "\${${SCT_items}}" )"
      SCT_Bin_Name="$( echo  "${SCT_items}" | awk -F "_" '{ print $3 }' )"
      if [ "${SCT_status}" = "ENABLED" ]
         then
             MSG_DISPLAY "debug" "0" "status of ${SCT_Bin_Name} bin Optional  : [ ${SCT_status} ]"
         else
             MSG_DISPLAY "debug" "0" "status of ${SCT_Bin_Name} bin  Optional  : [ ${SCT_status} ] " 
      fi
done


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SANITY_CHECK_Base_env_Users_And_Group
{
#|# Var to set  : None
#|#
#|# Base usage  : SANITY_CHECK_Base_env_Users_And_Group
#|#
#|# Description : This function check and create all mandatory directories needed for CAST execution
#|#
#|# Send Back   : Directory
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 


for SubConfFiles in $( ls ${Base_Dir_Scripts_CNF_Subs} -1 | grep cnf ) 
	do 
		for UsersCr in $( cat ${Base_Dir_Scripts_CNF_Subs}/${SubConfFiles} | grep "Account_To_Delete" | awk '{ print $1 }' | awk -F\= '{print "\$\{"$1"\}" }' 2> /dev/null )
			do UsersCr=$( eval echo ${UsersCr} )
               
		done

done 

MSG_DISPLAY "info" "1" "Directory Sanity check [ END ] "

SANITY_CHECK_Base_env_directory_check_exec="1"
Spacer_MSG
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}



# Sourcing control variable 
LibState="OK"
