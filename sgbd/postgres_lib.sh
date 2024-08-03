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

function Do_postgres_init
{
#|#  BASE_Postgres_Install_PATH    : Use this var to set where postgres is installed
#|#  BASE_Postgres_USER            : Use this var to set which user to run any commande on Postgres
#|#  BASE_Postgres_DATA_DIR        : Use this var to set Where postgres store all DDB DATAS
#|#           Basic Use            :
#|#                                  Base_Postgres_Install_PATH="Myspath"
#|#                                  BASE_Postgres_USER="postgres_username"
#|#                                  BASE_Postgres_DATA_DIR="My_dataDir"
#|#                                  BDD_Do_postgres_init
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "Debug" "8" "Current Stack : [ ${Function_PATH} ] " 
MSG_DISPLAY "Info" "1" "POSTRESG STATUS : [ INIT ] "
MSG_DISPLAY "Config" "1" "Postgres Install PATH    : [ ${BASE_Postgres_Install_PATH}  ]"
MSG_DISPLAY "Config" "1" "Postgres owner username  : [ ${BASE_Postgres_USER}  ]"
MSG_DISPLAY "Config" "1" "Postgres DATA path : [ ${BASE_Postgres_DATA_DIR}  ]"

Base_param_Dir_To_Create="BASE_Postgres_DATA_DIR"
Set_new_directory
su -c "${Base_Postgres_Install_PATH}/bin/initdb -D ${BASE_Postgres_DATA_DIR}" ${BASE_Postgres_USER}
su -c "${Base_Postgres_Install_PATH}/bin/postmaster -D ${BASE_Postgres_DATA_DIR} " ${BASE_Postgres_USER}
su -c "${Base_Postgres_Install_PATH}/bin/createdb test " ${BASE_Postgres_USER}
su -c "${Base_Postgres_Install_PATH}/bin/psql test " ${BASE_Postgres_USER}
MSG_DISPLAY "Info" "1" "POSTRESG STATUS : [ INIT DONE ] "


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_postgres_start
{
#|#  Base_Postgres_Install_PATH    : Use this var to set where postgres is installed
#|#  BASE_Postgres_USER            : Use this var to set which user to run any commande on Postgres
#|#  BASE_Postgres_DATA_DIR        : Use this var to set Where postgres store all DDB DATAS
#|#  Base use :

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

function Do_postgres_stop
{
#|#  Base_Postgres_Install_PATH    : Use this var to set where postgres is installed
#|#  BASE_Postgres_USER            : Use this var to set which user to run any commande on Postgres
#|#  BASE_Postgres_DATA_DIR        : Use this var to set Where postgres store all DDB DATAS

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
