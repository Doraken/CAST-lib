#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic html auto documentation from CAST 

function Document_Print_function_man_page
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_Print_function_man_page
#|#
#|# Description : This function is used whithout parameter and can only be called by
#|#
#|#
#|# Send Back   : html flow
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

MSG_DISPLAY "debug" "0" " Value of Base_Catalog_function : [ ${Base_Catalog_function} ]"
MSG_DISPLAY "debug" "0" " Value of New_Lib_Name          : [ ${New_Lib_Name} ]"
for New_Lib_Name in $(for Tvar in $( cat ../data/catalogue/function.cat | awk -F ";" '{ print $2 }') ; do  basename ${Tvar} ; done | sort -u)
    do
      for Function_geted in $( cat ${Base_Catalog_function} | grep ${New_Lib_Name} | awk -F ";" '{ print $4 }' )
          do
             DPFMP_Base_File_name="$( echo  ${Function_geted} | awk -F "." '{ print $1 }' )"
             Document_doc_man="${BDir_Data_doc_man_html}/${DPFMP_Base_File_name}.html"
             echo  "<HTML>"                                                                                   >> ${Document_doc_man}
             echo  "    <BODY>"                                                                               >> ${Document_doc_man}
             echo  "       <PRE><!-- Manpage converted by pcd autodoc by Arnaud Crampet  --></PRE>"           >> ${Document_doc_man}
             echo  "         <PRE><H2>SYNOPSIS</H2></PRE>"                                                    >> ${Document_doc_man}
             echo  " <B>                                 "                                                    >> ${Document_doc_man}
             cat ${Base_Catalog_function_docs} | grep "\;${Function_geted}\;" |  awk -F ";" '{ print "    " $6}' >> ${Document_doc_man}
             echo  "</B>"                                                                                     >> ${Document_doc_man}
             echo  "<ADDRESS>contact PCD at : ${CAST_MAINTENER_MAIL} <ADDRESS>"                                     >> ${Document_doc_man}                                                                                 >> ${Document_doc_xml}
             echo  "     </BODY> "                                                                            >> ${Document_doc_man}
             echo  "</HTML>"                                                                                  >> ${Document_doc_man}
       done
done
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# Sourcing control variable 
LibState="OK"