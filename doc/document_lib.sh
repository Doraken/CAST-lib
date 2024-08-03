#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic auto documentation from CAST 

function Get_all_function_names_to_document
{
#|#

############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
Do_file_remove "${Base_Catalog_function}" "" "" "0"
Do_file_remove "${Base_Catalog_function_depend}" "" "" "0"
Do_file_remove "${Base_Catalog_function_docs}" "" "" "0"
Do_file_remove "${Base_Catalog_function_TMP_dep}" "" "" "0"

for libs in $(find  ${_local_lib_dir} -type f -name "*_lib.sh" ) 
    do
       MSG_DISPLAY "info" "1" "Found Library file : [ ${libs} ]"
       File_Read "Get_all_function_core_to_document" < ${libs}
done
Get_all_function_dep_to_document
#Do_document_catalogue_refine
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_all_function_core_to_document
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
#MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
local geted_item="${1}"
Part_Item="$( echo  "${geted_item}" | awk '{ print $1 }' )"



case ${Part_Item} in
             function) Function_name="$( echo  "${geted_item}" | awk '{ print $2 }' )"
     	               echo  "Found function declaration : [ ${Function_name} ] "
     	               echo  "librairy;${libs};function;${Function_name}" >> ${Base_Catalog_function}
     	               ;;
                   \{) MSG_DISPLAY "debug" "0" "Start of function : [ ${Function_name} ]"
                       ;;
                   \}) MSG_DISPLAY "debug" "0" "End of function : [ ${Function_name} ]"
                       Function_name=""
                       ;;
               \#\|\#) if [ ! -z "${Function_name}" ]
                          then
                  	       geted_item="$( echo  ${geted_item} | awk -F '#' '{ print $3 }' )"
                           MSG_DISPLAY "debug" "0"   "Document : [  librairy;${libs};function;${functions_name};Document;${geted_item} ] "
                           echo  "librairy;${libs};function;${Function_name};Document;${geted_item}" >> ${Base_Catalog_function_docs}
                        fi
                        ;;
    Empty_Var_Control)  DGFC_EMPT_CTRL_CALL="$(echo  "${geted_item}" | awk '{ $6 }')"
                        if [ ! -z "${DGFC_EMPT_CTRL_CALL}" ]
                           then
                                MSG_DISPLAY "info"  "0" "Line of ${Function_name} : [ ${geted_item} ] "
                                MSG_DISPLAY "debug" "0" "first Element of line ${Function_name} : [ ${Part_Item} ] "
                                echo  "librairy;${libs};function;${Function_name};Item;${DGFC_EMPT_CTRL_CALL}" >> ${Base_Catalog_function_TMP_dep}
                        fi
                        DGFC_EMPT_CTRL_CALL="$(echo  "${geted_item}" | awk '{ $7 }')"
                        if [ ! -z "${DGFC_EMPT_CTRL_CALL}" ]
                           then
                                MSG_DISPLAY "info"  "0" "Line of ${Function_name} : [ ${geted_item} ] "
                                MSG_DISPLAY "debug" "0"   "first Element of line ${Function_name} : [ ${Part_Item} ] "
                                echo  "librairy;${libs};function;${Function_name};Item;${DGFC_EMPT_CTRL_CALL}" >> ${Base_Catalog_function_TMP_dep}
                        fi
                        ;;
                     *) if [ ! -z "${Function_name}" ]
                           then
                               MSG_DISPLAY "info"  "0"  "Line of ${Function_name} : [ ${geted_item} ] "
                               MSG_DISPLAY "debug" "0"   "first Element of line ${Function_name} : [ ${Part_Item} ] "
                               echo  "librairy;${libs};function;${Function_name};Item;${Part_Item}" >> ${Base_Catalog_function_TMP_dep}
                         fi
                         ;;
esac
geted_item=""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_all_function_dep_to_document
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

document_filter_dep_tmp_cat


Number_Of_Func="$(cat ${Base_Catalog_function} | sort -u |wc -l)"
Set_system_counter "init"

for DGD_get_line in $( cat ${Base_Catalog_function} | sort -u )
   do
   	 Set_system_counter "0"
   	 DGD_function_name="$( echo ${DGD_get_line} | awk -F ";" '{ print $4 }' )"
     DGD_Lib_name="$( echo ${DGD_get_line} | awk -F ";" '{ print $2 }' )"

     PRINT_MSG=" Curent function : [ ${DGD_function_name} ]"
     MSG_DISPLAY "debug" "0" "${PRINT_MSG}"
     PRINT_MSG=" Current Lib     : [ ${DGD_Lib_name} ]"
     MSG_DISPLAY "debug" "0" "${PRINT_MSG}"
     PRINT_MSG=" Function Number : [ ${External_Return_Counter} of ${Number_Of_Func}  ] "
     for DGD_Check_Item in $( cat ${Base_Catalog_function_TMP_dep} | grep "${DGD_Lib_name}" | grep "function;${DGD_function_name}" | awk -F ";" '{ print $6 }' )
         do
         	echo  " Check item  [ ${DGD_Check_Item} ]"
         	if [ -z ${DGD_Check_Item} ]
         	   then
         	   	   echo  ""  > /dev/null
               else
                   DGB_DEP="$(cat ${Base_Catalog_function} | grep "${DGD_Check_Item}$"  )"
         	            if [ -z "${DGB_DEP}" ]
         	               then
                               echo  "" > /dev/null
                           else
         	   	               MSG_DISPLAY "info"  "0"  "Found dependence : [ ${DGB_DEP} ]"
                               Depend_On_Item="$(eval cat ${Base_Catalog_function} | grep -w ${DGB_DEP} )"
                               printable_Function_name="\"${Function_name}\""
                               printable_Depend_On_Item="\"${Depend_On_Item}\""
                               MSG_DISPLAY "debug" "0" "Function ${printable_Function_name} Depend on : [ ${printable_Depend_On_Item} ] "
                               FONT_set_Basic_Font
                               Depend_On_Item="dependonlib;$(echo ${Depend_On_Item} | awk -F\; '{ print $2}');dependonfunction;$(echo ${Depend_On_Item} | awk -F\; '{ print $4 }')"
                               echo  "         ${Depend_On_Item}         "
                               echo  "librairy;${DGD_Lib_name};function;${DGD_function_name};${Depend_On_Item}" >> ${Base_Catalog_function_depend}
                        fi

            fi
      done
done


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Get_all_function_call_to_document
{
#|# Internal_item_checked                              : Use this var to set the item to check if it s a function call
#|# ${1}                                               : Use this var to set Internal_item_checked
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
local Internal_item_checked="${1}"

if [ -z "${Iterate_Get_all_function_call_to_document}" ]
   then
   	    date > ${Base_Catalog_function_depend}
   	    Iterate_Get_all_function_call_to_document="1"
   else
        Iterate_Get_all_function_call_to_document="$( expr ${Iterate_Get_all_function_call_to_document} + 1 )"
fi
case ${Internal_item_checked} in
                "\#")  MSG_DISPLAY "info"  "0"  "current Item : [ ${Internal_item_checked} type : [ Comment ] ] "
                       ;;
                   *)  if [ ! -z "${Internal_item_checked}" ]
                          then
                              cat ${Base_Catalog_function} | awk -F\; '{ print $4}' | grep -w "${Internal_item_checked}" > /dev/null
                              if [ "${?}" = "0" ]
                                 then
                                     Depend_On_Item="$(cat ${Base_Catalog_function} | grep -w "${Internal_item_checked}")"
                                     printable_Function_name="\"${Function_name}\""
                                     printable_Depend_On_Item="\"${Depend_On_Item}\""
                                     MSG_DISPLAY "debug" "0" "Function ${printable_Function_name} Depend on : [ ${printable_Depend_On_Item} ] "
                                     FONT_set_Basic_Font
                                     Depend_On_Item="$(echo ${Depend_On_Item} | awk -F\; '{ print "dependonlib;" $2 ";dependonfunction;" $4 }')"
                                     echo  "librairy;${libs};function;${functions_name};${Depend_On_Item}" >> ${Base_Catalog_function_depend}
                              fi
                       fi
                       ;;
esac


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_document_catalogue_refine
{
#|# Var to set  : None
#|#             : Use this var to set
#|#             : Use this var to set
#|# ${1}
#|# ${2}
#|#
#|# Base usage  : None
#|#
#|# Description : This function is used to refine and sort all catalogs
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
Get_system_random_,number

for items in $( cat ${Base_Dir_Scripts_CNF}/document.cnf | grep "Is_A_Catalog_FLAG" | awk -F "=" '{ print "\$\{" $1 "\}" }')
do
	eval echo  "${items}"
done

echo  ${Catalogs_lst}



Tmp_file_cat_refine="${Base_Dir_Scripts_Tmp}/${EXTERNAL_randomized_var}_func_dep_cat.cat"
cat ${Base_Catalog_function_depend} | sort -u > ${Tmp_file_cat_refine}
cat ${Tmp_file_cat_refine} > ${Base_Catalog_function_depend}

Get_system_random_,number

Tmp_file_cat_refine="${Base_Dir_Scripts_Tmp}/${EXTERNAL_randomized_var}_func_doc_cat.cat"
cat ${Base_Catalog_function_docs} | sort -u > ${Tmp_file_cat_refine}
cat ${Tmp_file_cat_refine} > ${Base_Catalog_function_docs}

Do_document_catalogue_parsing
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_document_catalogue_parsing
{
#|# Var to set  : None
#|#             : Use this var to set
#|#             : Use this var to set
#|# ${1}
#|# ${2}
#|#
#|# Base usage  : None
#|#
#|# Description : This function is used to refine and sort all catalogs
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
for functions_names in $(cat ${Base_Catalog_function} | grep "librairy" )
    do
       echo  "1|${functions_names}" >> ${Base_Catalog_function_Final}
       for Dependances_functions in $(cat ${Base_Catalog_function_depend} | grep "^${functions_names}")
           do
           	 echo  "2|${Dependances_functions}" >> ${Base_Catalog_function_Final}
       done
       for Doc_functions in $(cat ${Base_Catalog_function_docs} | grep "^${functions_names}")
           do
           	 echo  "3|${Doc_functions}" >> ${Base_Catalog_function_Final}
       done
done
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_document_catalogue_to_xml
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

File_Read "autodoc_filter_line_Printer " < ${Base_Catalog_function_depend}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_document_function_by_file
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
local Internal_Geted_line="${1}"

File_Read "autodoc_filter_line_Printer " < ${Base_Catalog_function_depend}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_document_generate
{
#|# Var to set  : None
#|# TOPrintFormat  : Use this var to set Output format of the Documentation
#|# ${1}           : Use this var to set [ TOPrintFormat ]
#|#
#|# Base usage  : Do_document_generate "format"
#|#
#|# Description : This function change type of output from txt to XML
#|#
#|# Send Back   : XML MANHTML or TXT function
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
local TOPrintFormat="${1}"


autodoc_filter_line_BASE_PATH

MSG_DISPLAY "check" "1" "Output format for documentation : [ ${TOPrintFormat} ] "
case ${TOPrintFormat} in
	XML|xml) MSG_DISPLAY "EdSMessage" "2" "Supported Output format"
             Document_Print_global_Print_xml
	         ;;
	TXT|txt)  MSG_DISPLAY "EdSMessage" "2" "Supported Output format"
              Document_Print_global_Print_txt
	         ;;
	MANHTML|manhtml)  MSG_DISPLAY "EdSMessage" "2" "Supported Output format"
                      Document_Print_function_man_page
	         ;;
          *) MSG_DISPLAY "EdEMessage" "2" "Unsupported Output format for documentation : [ ${TOPrintFormat} ] "
             ;;
esac


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"

