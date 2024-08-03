#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic auto documentation from CAST 
# Subject : This library provide sub sql sub function to manage sql connexion #
#                                                                             #
###############################################################################
####
# INFO

function Do_SQL_Sub_connect_Server
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

Test_file_presence  "${EXTERNAL_SQL_current_FIFO_file}" "Dont_Create_File" "0"  ""  "return 1"
  External_Sql_Connection_Result="${?}"
           if [ " ${INTERNAM_ITERAT_SQL_CONNECT}"  = "3"  ]
                then
                     MSG_DISPLAY "ErrorN" "1" "Connection retry number ${INTERNAM_ITERAT_SQL_CONNECT} : [ FATAL ERROR too much retry ]"
                else
                       if  [ "${External_Sql_Connection_Result}" = "1" ]
                            then
                                   echo  "2"
                                    MSG_DISPLAY "Debug" "6" "Current SQL FIFO file : [ Allreay Used Changing Session ID  ] "
                                    Get_system_random_,number
                                    EXTERNAL_SQL_current_FIFO_file="${Base_SQL_Fifo_FileName}_${EXTERNAL_randomized_var}"
                                    EXTERNAL_SQL_current_Log_File="${Base_SQL_Log_FileName}_${EXTERNAL_randomized_var}"
                                    MSG_DISPLAY "Debug" "6" "Current SQL FIFO file : [ ${EXTERNAL_SQL_current_FIFO_file} ] "
                                    MSG_DISPLAY "Debug" "6" "Current SQL Log file : [ ${EXTERNAL_SQL_current_Log_File} ] "
                                    Test_file_presence "${EXTERNAL_SQL_current_FIFO_file}" "Dont_Create_File" "0"  ""  "return 1"
                                    External_Sql_Connection_Result=$( expr ${External_Sql_Connection_Result} + 1 )
                            else
                                   External_Sql_Connection_Result=$( expr ${External_Sql_Connection_Result} + 1 )
                        fi
              fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# Sourcing control variable 
LibState="OK"  
