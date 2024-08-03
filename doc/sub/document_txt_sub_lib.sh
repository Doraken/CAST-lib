#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic txt autodocumentation  from CAST 

function Document_Print_global_Print_txt
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_Print_global_Print_txt
#|#
#|# Description : This fuction generate documentation txt output
#|#
#|# Send Back   : TXT flow
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

for Libraries_geted in $( cat ${Base_Catalog_function} | awk -F ";" '{ print $2 }' | sort -u )
      do
        Document_doc_txt="${Base_Dir_Scripts_Data_doc_txt}/$( echo  ${Libraries_geted} | awk -F "/" '{ print $NF}' | awk -F "." '{ print $1".txt"}' )"
        New_Lib_Name="$(echo ${Libraries_geted} | awk -F "/" '{ print $NF}')"
        echo  " Used lib : [ ${New_Lib_Name}   ] "  > ${Document_doc_txt}
        Document_Print_function_txt
done
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Document_Print_function_txt
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_Print_function_txt
#|#
#|# Description : #|# This function is used whithout parameter and can only be called by
#|# Document_Print_global_Print_txt
#|#
#|# Send Back   : txt flow
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

for Function_geted in $( cat ${Base_Catalog_function} | grep ${New_Lib_Name} | awk -F ";" '{ print $4 }' )
    do
      echo  " Information for function : [ ${Function_geted} ]"  >> ${Document_doc_txt}
      echo  " This function depend on : "                        >> ${Document_doc_txt}
      Document_Print_Dependences_txt
      echo  " How to use this function  "                        >> ${Document_doc_txt}
      echo  "  "                                                 >> ${Document_doc_txt}
      cat ${Base_Catalog_function_docs} | grep "\;${Function_geted}\;" |  awk -F ";" '{ print "    " $6}' >> ${Document_doc_txt}
      echo  "                                                 " >> ${Document_doc_txt}
      echo  " ----------------------------------------------- " >> ${Document_doc_txt}
      echo  "                                                 " >> ${Document_doc_txt}

done
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Document_Print_Dependences_txt
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_Print_Dependences_txt
#|#
#|# Description : This function is used whithout parameter and can only be called by
#|# Document_Print_function_txt
#|#
#|# Send Back   : txt flow
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Internal_Geted_line="${1}"
for Dependences_Geted in  $( cat ${Base_Catalog_function_depend} | grep "\;${Function_geted}\;" |  awk -F ";" '{ print $8 ";"  $6  }')
    do
      Function_Dep_To_Print="$( echo  ${Dependences_Geted} | awk -F ";" '{print $1 " Found in lib : " $2 }')"
      echo  "                            ${Function_Dep_To_Print}"                                            >> ${Document_doc_txt}
done
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