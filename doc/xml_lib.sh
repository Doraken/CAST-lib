#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic xml from CAST 


function XML_Get_Model 
{
#|# XML_Model_To_Use                : Use this var to set which XML base model to use to generate XML CODE
#|# ${1}                            : Use this var to set XML_Model_To_Use
#|# XML_ARRAY_DATA                  : Use this var to set which liste of data to fiil in 
#|# ${2}                            : Use this var to set XML_ARRAY_DATA
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
local XML_Model_To_Use="${1}"
local XML_ARRAY_DATA="${2}"

Empty_Var_Control "${XML_Model_To_Use}"  "XML_Model_To_Use"  "4"
Empty_Var_Control "${XML_ARRAY_DATA}"    "XML_ARRAY_DATA"    "4"

eval eval set -A XML_ARRAY_DATA $(echo  "\$\{${XML_ARRAY_DATA}\[\@\]\}")
for List in ${XML_ARRAY_DATA[@]}
    do
      MSG_DISPLAY "debug" "0" "XML Array def [ ${List} ]"
done 
       
if [ ${XML_Conf_init} = "0" ]
   then 
       MSG_DISPLAY "debug" "0" "XML base definition file Sourced [ Sourcing ]"
   	   Do_file_sourcing_control "xml_base_def.def" "${Base_Dir_Scripts_Data_Xml_DEF}"
       MSG_DISPLAY "debug" "0" "XML base definition file Sourced [ OK ]"
       XML_Conf_init="1"
   else
       MSG_DISPLAY "debug" "0" "XML base definition file Sourced [ already OK ]"
fi      
${XML_Model_To_Use}

Set_system_counter "init"
Base_Spacer=""
Base_print_elm="0"
for XML_MODEL_ARRAY in ${XML_BASE_ARRAY[@]}
   do 
   	  Set_system_counter
      Actual_XML_Array="${External_Return_Counter}"
   	  MSG_DISPLAY "debug" "0" "XML model array Number [ ${External_Return_Counter} ]" 
   	  
   	  for Possible_feed in ${XML_fill_in_array[@]}
   	     do 
   	     	MSG_DISPLAY "debug" "0" "Possible_feed [ ${Possible_feed} ]" 
   	     	if  [ ! "${OK_feed}" = "1" ]
   	     	    then 
   	     	        case ${Possible_feed} in 
                         ${Actual_XML_Array}) XML_Get_Model_Sub_feeder_POS
                                              OK_feed="1"
   	     	                                  Feeded_done="1"
                                              ;;
                                           *) OK_feed="0"
                                              ;;
                     esac
                else 
                    MSG_DISPLAY "debug" "0" "Dummy Cycle [ x ]" 
             fi 
      done
      if [ "${OK_feed}" = "1" ] 
         then 
         	 MSG_DISPLAY "debug" "0" "Need to close [ NOT NEEDED ]"
         else
             XML_Get_Model_Sub_feeder_NOPOS
      fi  
      OK_feed=""
      
done

for closes in ${CLOSE_XML} 
    do 
      Base_Spacer="$( echo  "${Base_Spacer}" | cut -b 9- )"  
      echo  "${Base_Spacer}${closes}"
done 
Base_Spacer_do=""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function XML_Get_Model_Sub_feeder_POS
{
#|# Sub function of XML_Get_Model_Sub_feeder Do not call directly
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
if [ "${Base_Spacer_do}" = "1" ]
   then
   	   Base_Spacer_do="1"
   else
       Base_Spacer="${Base_Spacer}     "
       No_More_Space="${Base_Spacer}" 
       Base_Spacer_do="1"
fi
echo  "${No_More_Space}<${XML_MODEL_ARRAY}>${XML_ARRAY_DATA[Base_print_elm]}</${XML_MODEL_ARRAY}>"
Base_print_elm="$(expr ${Base_print_elm} + 1)"

OK_feed="1"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}


function XML_Get_Model_Sub_feeder_NOPOS
{
#|# Sub function of XML_Get_Model_Sub_feeder Do not call directly
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

CLOSE_XML="</${XML_MODEL_ARRAY}> ${CLOSE_XML}"
echo  "${Base_Spacer}<${XML_MODEL_ARRAY}>"
Base_Spacer="${Base_Spacer}     "
OK_feed="0"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}


# Sourcing control variable 
LibState="OK"  
