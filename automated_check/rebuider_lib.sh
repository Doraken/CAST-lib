#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                            #
# Subject : This library provide base runtime to rebuild any files like       #
#           calatolgue or configuration files                                 #
###############################################################################
####
# INFO 

function rebuild_catalogue
{
#|#  Catalogue_type                       : Use this var to set which type of catalogue to rebuild  | rebuild_catalogue_INF#
#|#  ${1}                                 : use this var to set ${Catalogue_type}                   | rebuild_catalogue_INF#
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local Catalogue_type="${1}"
Empty_Var_Control "${Catalogue_type}" "Catalogue_type" "4"


case ${Catalogue_type} in 
	                File_catalogue) MSG_DISPLAY "debug" "0" " Choosed type of Catalogue to rebuild : [ ${Catalogue_type} ] "  
                                    rebuild_catalogue_File
	                                ;;
	                             *) MSG_DISPLAY "EdEMessage" "2" "This rebuild is not supported yet TYPE = [ ${Catalogue_type} ]"            
	                                ;;
esac


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function rebuild_catalogue_File
{
#|# Base_Source_Catalogue                     : use this var to set source file catalogue
#|# ${1}                                      : Use this var to set Base_Source_Catalogue
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Test_file_presence "${Global_File_CATALOG}" "Dont_Create_File" "criticity_of_fail"  "SUB_rebuild_catalogue_File_Global_cat"  "SUB_rebuild_catalogue_File_Global_cat_menu"
SUB_rebuild_catalogue_File_Global_Consystency_check

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function SUB_rebuild_catalogue_File_Global_Consystency_check
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Last_catalogue_line="$(tail -1 ${Global_File_CATALOG})"


MSG_DISPLAY "StMessage" "5" "Consystency check : "
if [ "${Last_catalogue_line}" = "FLAGEND_CATALOG" ] 
   then 
   	   MSG_DISPLAY "EdSMessage" "0" " "
   else 
       MSG_DISPLAY "EdEMessage" "0" " "
       MSG_DISPLAY "info" "1"   "due to a failled Consystency check the catalogue will be  automaticaly rebuilded "
       SUB_rebuild_catalogue_File_Global_cat
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}

function SUB_rebuild_catalogue_File_Global_cat_menu
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Base_catalogue_Date=$(head -1 ${Global_File_CATALOG})

if [ ${Iterate_one_rebuilde_cat} = "1" ] 
  then 
  	   MSG_DISPLAY "debug" "0" "Already rebuilded global CAT"
  else
      clear 
      Iterate_one_rebuilde_cat=1
      select choice in " Rebuild Global Catalogue [ Last rebuild on : ${Base_catalogue_Date} ] " \
		                " Continue with actual catalogue " 
		             do
			            case ${REPLY} in
				                         1) SUB_rebuild_catalogue_File_Global_cat
				                            SUB_rebuild_catalogue_File_SPEC_cat
				                            break
					                        ;;
				                         2) clear
				                            SUB_rebuild_catalogue_File_SPEC_cat
				                            break
					                        ;;
				                         *) clear 
				                            MSG_DISPLAY "info" "1" "Invalid choice assuming to continue"
				                            break
				                            ;;
			            esac
      done
fi


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}


function SUB_rebuild_catalogue_File_Global_cat
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

MSG_DISPLAY "info" "1" "Stating Global file catalogue regen it may take serveral minutes please wait ]"
date > ${Global_File_CATALOG}
MSG_DISPLAY "info" "1" "Generating USR info"
find /usr >> ${Global_File_CATALOG}
MSG_DISPLAY "info" "1" "Generating OPT info"
find /opt >> ${Global_File_CATALOG}
MSG_DISPLAY "info" "1" "Generating etc info"
find /etc >> ${Global_File_CATALOG}
echo  "FLAGEND_CATALOG"  >> ${Global_File_CATALOG}
MSG_DISPLAY "info" "1" "Stating Global file catalogue regen : [ FINISHED ]"



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}


function SUB_rebuild_catalogue_File_SPEC_cat
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
Get_system_random_,number
TMP_file_cat=${BDir_Tmp}/${EXTERNAL_randomized_var}_spec_cat.cat
date >> ${TMP_file_cat}
iterate_count="0"
for CHROOT_file in $(cat ${catalogue_used}) 
    do 
     clear
     iterate_count="$(expr ${iterate_count} + 1 )"
     eval  echo  " Listed Item for chroot creation [ ${CHROOT_BASE_DIR}/${CHROOT_file} ] "
     Get_file_type "/${CHROOT_file}" "SUB_rebuild_catalogue_get_file" "SUB_rebuild_catalogue_put_file" 
done
echo  "FLAGEND_CATALOG" >> ${TMP_file_cat}
File_Backup "${catalogue_used}" 
mv ${TMP_file_cat} ${catalogue_used}
exit 0 ; ${Relaunch}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}

function SUB_rebuild_catalogue_get_file 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

StMessage
MSG_DISPLAY "StMessage" "0" "Searching in Global Catalogue ${CHROOT_file}"
cat ${Global_File_CATALOG} | grep "${CHROOT_file}$"
if [ ${?} = "1" ]
    then
    	 MSG_DISPLAY "EdEMessage" "0" ""
    else
         cat ${Global_File_CATALOG} | grep "${CHROOT_file}$" >> ${TMP_file_cat}
fi 


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}


function SUB_rebuild_catalogue_put_file
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

echo  "${CHROOT_file}"  >> ${TMP_file_cat}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}

# Sourcing control variable 
LibState="OK"