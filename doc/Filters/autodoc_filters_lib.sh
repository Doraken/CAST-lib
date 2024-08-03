#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic autodocumentation filter from CAST 

function autodoc_filter_line_Printer
{
#|# Internal_Geted_line                   : use this var to set the line to parse
#|# ${1}                                  : Use this var to set Internal_Geted_line
#|# Basic usage : Do_document_catalogue_to_xml_sub_line_parser "Line to parse"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
Internal_Geted_line="${1}"

echo  "${Internal_Geted_line}"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function autodoc_filter_line_BASE_PATH
{
#|# No parameters are used for this function
#|# This function is used to cut off all path information in doc's catalogues
#|# Basic usage : autodoc_filter_line_BASE_PATH
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "info" "1" "Filtering file : [ ${Base_Catalog_function} ] "

Filter_Base_Path_in_Cat "${Base_Catalog_function}"

MSG_DISPLAY "info" "1" "Filtering file : [ ${Base_Catalog_function_depend} ] "

Filter_Base_Path_in_Cat "${Base_Catalog_function_depend}"

MSG_DISPLAY "info" "1" "Filtering file : [ ${Base_Catalog_function_docs} ] "

Filter_Base_Path_in_Cat "${Base_Catalog_function_docs}"



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Filter_Base_Path_in_Cat
{
#|# BASE_FILE_TO_FILTER                   : use this var to set the file to filter
#|# ${1}                                  : Use this var to set BASE_FILE_TO_FILTER
#|# Basic usage : Filter_Base_Path_in_Cat "File To filter"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
BASE_FILE_TO_FILTER="${1}"
Protected_PATH="$( echo  ${Base_Dir_Scripts} |   sed  -e  's/\//\\\//g')"

MSG_DISPLAY "debug" "0" "Protected Path var is set to : [ ${Protected_PATH} ]"

eval sed -e 's/${Protected_PATH}//g' ${BASE_FILE_TO_FILTER} > ${BASE_FILE_TO_FILTER}.new
cat ${BASE_FILE_TO_FILTER}.new > ${BASE_FILE_TO_FILTER}
Do_file_remove "${BASE_FILE_TO_FILTER}.new"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function document_filter_dep_tmp_cat
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

egrep -v ";Item;;$"     ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;$"      ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;;$"     ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;.$"     ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;###$"   ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;\=$"    ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;\[$"    ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;\]$"    ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;\*$"    ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;:$"     ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;eval$"  ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;if$"    ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;then$"  ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;else$"  ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;fi$"    ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;for$"   ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;do$"    ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;done$"  ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;while$" ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;case$"  ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;export$"  ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;############$"     ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
egrep -v ";Item;######################################################$"     ${Base_Catalog_function_TMP_dep} > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}

sort -u  ${Base_Catalog_function_TMP_dep}                > ${Base_Dir_Scripts_Tmp}/filter_cat.tmp && cat    ${Base_Dir_Scripts_Tmp}/filter_cat.tmp  > ${Base_Catalog_function_TMP_dep}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"

