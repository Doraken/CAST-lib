#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic auto documentation from CAST 
# Subject : This library provide base  support for databases interaction      #
#                                                                             #
###############################################################################
####
# INFO
############################## Postgres #######################################

function Do_mysql_init
{
#|#  Base_Mysql_Install_PATH    : Use this var to set where Mysql is installed
#|#  BASE_Mysql_USER            : Use this var to set which user to run any commande on Mysql
#|#  BASE_Mysql_DATA_DIR        : Use this var to set Where Mysql store all DDB DATAS

############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "Debug" "8" "Current Stack : [ ${Function_PATH} ] " 

${Base_Mysql_Install_PATH}/bin/

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_mysql_start
{
#|#  Base_Mysql_Install_PATH    : Use this var to set where Mysql is installed
#|#  BASE_Mysql_USER            : Use this var to set which user to run any commande on Mysql
#|#  BASE_Mysql_DATA_DIR        : Use this var to set Where Mysql store all DDB DATAS

############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "Debug" "8" "Current Stack : [ ${Function_PATH} ] " 


echo ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_mysql_stop
{
#|#  Base_Mysql_Install_PATH    : Use this var to set where Mysql is installed
#|#  BASE_Mysql_USER            : Use this var to set which user to run any commande on Mysql
#|#  BASE_Mysql_DATA_DIR        : Use this var to set Where Mysql store all DDB DATAS

############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "Debug" "8" "Current Stack : [ ${Function_PATH} ] " 


echo ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# Sourcing control variable 
LibState="OK"  
