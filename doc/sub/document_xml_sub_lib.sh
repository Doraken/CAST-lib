#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic xml auto documentation from CAST 


function Document_Print_global_Print_xml
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_Print_global_Print_xml
#|#
#|# Description : This fuction generate documentation xml output
#|#
#|# Send Back   : xml flow
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

for Libraries_geted in $( cat ${Base_Catalog_function} | awk -F ";" '{ print $2 }' | sort -u )
      do
        Document_doc_xml="${Base_Dir_Scripts_Data_doc_xml}/$( echo  ${Libraries_geted} | awk -F "/" '{ print $NF}' | awk -F "." '{ print $1".xml"}' )"
        New_Lib_Name="$(echo ${Libraries_geted} | awk -F "/" '{ print $NF}')" > ${Document_doc_xml}
        echo  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"                >> ${Document_doc_xml}
        echo  "<?xml-stylesheet type=\"text/xsl\" href=\"autodoc.xsl\"?>" >> ${Document_doc_xml}
        echo  " <Library>"                                                >> ${Document_doc_xml}
        echo  " <LibraryName>${New_Lib_Name}</LibraryName>"               >> ${Document_doc_xml}
        Document_Print_function_xml
        echo  " </Library>"                                               >> ${Document_doc_xml}
done
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Document_Print_function_xml
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_Print_function_xml
#|#
#|# Description : This function is used whithout parameter and can only be called by
#|# Document_Print_global_Print_xml
#|#
#|# Send Back   : xml flow
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

MSG_DISPLAY "debug" "0" " Value of Base_Catalog_function : [ ${Base_Catalog_function} ]"
MSG_DISPLAY "debug" "0" " Value of New_Lib_Name          : [ ${New_Lib_Name} ]"

for Function_geted in $( cat ${Base_Catalog_function} | grep ${New_Lib_Name} | awk -F ";" '{ print $4 }' )
    do
      echo  "<Function>"                                     >> ${Document_doc_xml}
      echo  "<FunctionName>${Function_geted}</FunctionName>" >> ${Document_doc_xml}
      Document_Print_Dependences_xml
      echo  "<DocText>"                                      >> ${Document_doc_xml}
      cat ${Base_Catalog_function_docs} | grep "\;${Function_geted}\;" |  awk -F ";" '{ print "    " $6}' >> ${Document_doc_xml}
      echo  "</DocText>"                                     >> ${Document_doc_xml}
      echo  "</Function>"                                    >> ${Document_doc_xml}
done
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Document_Print_Dependences_xml
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_Print_Dependences_xml
#|#
#|# Description : This function is used whithout parameter and can only be called by
#|# Document_Print_function_xml
#|#
#|# Send Back   : xml flow
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Internal_Geted_line="${1}"
echo  "<DependOn>" >> ${Document_doc_xml}
for Dependences_Geted in  $( cat ${Base_Catalog_function_depend} | grep "\;${Function_geted}\;" |  awk -F ";" '{ print $8 ";"  $6  }' | sort -u )
    do
      echo  "<FunctionDepend>"                                                                    >> ${Document_doc_xml}
      echo  "${Dependences_Geted}" | awk -F ";" '{print "<FunctionName>" $1 "</FunctionName>" }'  >> ${Document_doc_xml}
      echo  "${Dependences_Geted}" | awk -F ";" '{print "<FunctionLib>" $2 "</FunctionLib>" }'    >> ${Document_doc_xml}
      echo  "</FunctionDepend>"                                                                   >> ${Document_doc_xml}
done
echo  "</DependOn>" >> ${Document_doc_xml}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"