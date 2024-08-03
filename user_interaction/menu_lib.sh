#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                        #
# Subject : This library provide base runtime to build dynamic menu           #
#                                                                             #
###############################################################################
####
# INFO

function Menu_Get_items
{
#|# Var to set  :
#|# Base_Menu_get_Tag       : use this var to set the tag to find to builde the menu
#|# Base_Level_Menu_Info    : Use this var to set which geted item part to keep
#|# Base_file_to_parse_Menu : use this var to set which file to parse to build menu
#|# Base_Menu_Name          : Use this var to set the name of the menu
#|# ${1}                    : use this var to set [ Base_Menu_get_Tag ]
#|# ${2}                    : use this var to set [ Base_Level_Menu_Info ]
#|# ${3}                    : use this var to set [ Base_file_to_parse_Menu ]
#|# ${4}                    : use this var to set [ Base_Menu_Name ]
#|#
#|# Base usage  : Menu_Get_items "My menu tag" "My keep item level " "My source file menu" "Menu Name"
#|# Description : This function scan a file to creat a array to send to Menu_Build
#|#
#|# Send Back   : a typer array var to Menu_Build
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 
PS3='choice? '
Base_Menu_get_Tag="${1}"
Base_Level_Menu_Info="${2}"
Base_file_to_parse_Menu="${3}"
Base_Menu_Name="${4}"
Selected_Menu_items=()
declare -a Selected_Menu_items=(${Base_Menu_Name})

for Base_items_menu in $( cat ${Base_file_to_parse_Menu} | grep "${Base_Menu_get_Tag}" | awk -v toprt=${Base_Level_Menu_Info} '{ print $toprt }')
    do
       case "${Base_items_menu}" in
                          *\#) MSG_DISPLAY "debug" "0" "Loop call find [ filtered call ]"
                              ;;
       	 ${Base_Menu_get_Tag}) MSG_DISPLAY "debug" "0" "Loop call find [ filtered call ]"
       	                       ;;
       	                    *) MSG_DISPLAY "debug" "0"  " Item  get from file  [ ${Base_items_menu}  ]  "
                              Selected_Menu_items+=(${Base_items_menu})
                              
                              ;;
       esac
done


#exit 
Menu_Build ${Selected_Menu_items[@]}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Menu_Build
{
#|# Var to set  :
#|# args        : Use this var to set all array of the menu be sure the var is an array
#|#
#|# Base usage  : Menu_Build "Name ov the var type array" ( without $ )
#|#
#|# Description : This function create interactive menu from array parameters
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
args=""
value=""
title=""
prompt=""
limit=""
options=""
case_seq=""
PS3=""


  args=("$@")
  
 
  
  #Elimine la partie entre crochets
  args=$( echo  "$args[@]" | sed -e 's/[[][^]]*[]]//' -e 's/[[:blank:]]*$//' )
  echo  "[$args]" | sed  -e 's/[_]/ /g'

   
  case $args in
  CHANGE\ *)    args="${args#CHANGE }"
                args="${args//[^=]*/}"  #Elimine la partie a droite de =
                while true
                     do
                       echo "Read ${args} value"
                       read ${args}
                       eval value="\${$args}"
                       if [ -z "${value}" ]
                          then
                              MSG_DISPLAY "info" "1" "ERROR : ${args} environment variable value [ Null ] "
                              MSG_DISPLAY "Menu" "RETRY : type a new value of ${args}"
                          else
                              MSG_DISPLAY "info" "1" "OVERRIDE: ${args} environment. New value [${value}]"
                              break
                        fi
		        done
                ;;
             *) clear
                title="$(echo ${args[0]} | sed  -e 's/[_]/ /g')"
                prompt="Pick a choice : "
                #unset 'args[1]'
                unset 'args[0]'
                limit=$((${#args[@]}))
                options=()
                for i in $(seq ${limit[@]});
                  do 
                      options+=(${args[i]})
                      
                done 
                case_seq=$( echo  $( echo \"${options[@]}\") | sed -e 's/ /\"|\"/g' )
                while true
                do 
                  clear
                  echo "${title}"
                  PS3="${prompt}"
                  eval "select opt in \"\${options[@]}\" \"back\";
                  do
                    case \"\${opt}\" in
                          ${case_seq}) \${opt};
                                    break ;
                                    ;;
                    \"back\"|\"exit\") echo \"You picked \${opt}, option out\";
                                    return ;
                                    ;;
                                    *)  echo \"You picked invalid \${opt} choice\"
                        ;;
                     esac; 
      done"
                done 
                ;;
  esac
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function ecMenu
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 
Mnu=""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Menu_select_item_from_file
{
#|# Var to set  : None
#|#             : Use this var to set
#|#             : Use this var to set
#|# ${1}        : Use this var to set [ ]
#|# ${2}        : Use this var to set [ ]
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
limit=$((${#args[@]}-1))
for i in $(seq ${limit}); do
    select_args="${select_args}\"${args[i]}\" ";
done
#Prepare les parametres du case
case_seq=$( echo  $(seq ${limit}) | sed -e 's/ /|/g' )
case_return=$((${#args[@]}))
select REPLY in ${RPM_SEND_BACK_LIST}
     do
      case \${REPLY} in
                          ${case_seq})    Menu_Build \${choice}
                                          break  ;;
                          ${case_return}) return ;;
                          *)              echo invalid choice: \${REPLY}.;;
     esac
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Menu_Change_Conf_item
#|# Var to set  : None
#|# Base_item_Name                  : use this var to set item name to change
#|# Base_item_to_change             : use this var to set the item to change
#|# ${1}                  : Use this var to set [ Base_item_Name ]
#|# ${2}                  : Use this var to set [ Base_item_to_change ]
#|#
#|# Base usage  : Menu_Change_Conf_item "Base_item_Name" "Base_item_to_change"
#|#
#|# Description : None
#|#
#|# Send Back   : Value in a var
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 
Base_item_Name="${1}"
Base_item_to_change="${2}"

MSG_DISPLAY "info" "1" "type new value for ${Base_item_Name} : Type enter to keep value "

MSG_DISPLAY "info" "1" "Actual ${Base_item_Name} value  : [ ${Base_item_to_change} ]"
read New_item_Value_install
Empty_Var_Control "${New_item_Value_install}" "${My_VAR}" "ErrorN" "0" "" "eval ${Base_item_Name}=${Base_item_to_change}" "eval ${Base_item_Name}=${New_item_Value_install}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Menu_List_spliter
{
#|# Var to set  :
#|# Array_To_SPLIT                   : Use this var to set the name of the Array var to split in many vars
#|# Internal vars :
#|# Result_Base_array                : This var is used in exit of the function to provide the list of array to use for generating menu entry
#|# Base_screen_Menu_Limit           : This var seted in Generics.cnf is used to set screen limit for menu
#|# ${1}                             : Use this var to set [ Array_To_SPLIT ]
#|#
#|# Base usage  : Menu_List_spliter " var name without $ and {} "
#|# Description : This fuction help to split too long menu
#|#
#|# Send Back   : splited menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
Array_To_SPLIT="${1}"

set -A Internal_Working_Array $( eval echo "\${${Array_To_SPLIT}[@]}")

Menu_List_spliter_sub_Get_limit

Menu_List_spliter_sub_Gen_array_of_array

Array_Gen_count="0"
for Arrays_gen in ${Menu_Array_list[@]}
   do
      Array_Gen_count="$(expr ${Array_Gen_count} + 1 )"
      Array_gets_max="$( expr ${Array_Gen_count} \*  ${Base_screen_Menu_Limit} )"
      Array_gets_min="$( expr ${Array_gets_max} \-   ${Base_screen_Menu_Limit} )"
      In_array_count="${Array_gets_min}"
      if [ "${In_array_count}" = "0" ]
         then
             In_array_count="$( expr ${In_array_count} + 1 )"
      fi
      until [ "${In_array_count}" = "${Array_gets_max}" ]
           do
             Internal_Array_gen="${Internal_Working_Array[In_array_count]} \n ${Internal_Array_gen}"
             In_array_count="$( expr ${In_array_count} + 1 )"
      done
      MSG_DISPLAY "debug" "0" "Array : [ ${Arrays_gen} ]"
      eval set \-A ${Arrays_gen} \$\( echo "\${Internal_Array_gen}" \)
       Basic_internal_counter="1"
       for Items_print in $( eval print \${${Arrays_gen}[@]} )
              do
                MSG_DISPLAY "debug" "0" "Found In array ${Basic_internal_counter} : [ ${Items_print} ]"
                Basic_internal_counter=$( expr ${Basic_internal_counter} + 1 )
           done
       Global_Counter=$( expr ${Basic_internal_counter} + ${Global_Counter} )
#      eval echo "\${${Arrays_gen}[@]}"
done
MSG_DISPLAY "info" "1" "Number of found Objects : [ ${Global_Counter} ]"
#print "	${Internal_Working_Array[@]} "
#${Base_screen_Menu_Limit}
#print



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Menu_List_spliter_sub_Get_limit
{
#|# Var to set  : None
#|#             : Use this var to set
#|#             : Use this var to set
#|# ${1}        : Use this var to set [ ]
#|# ${2}        : Use this var to set [ ]
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

BASE_limite_spliter=$( expr ${#Internal_Working_Array[@]} / ${Base_screen_Menu_Limit})
MSG_DISPLAY "debug" "0" "Base split number : [ ${BASE_limite_spliter} ]"
Control_limit_spliter="$( expr ${BASE_limite_spliter} \* ${Base_screen_Menu_Limit} )"
Control_limit_spliter="$( expr ${#Internal_Working_Array[@]} \- ${Control_limit_spliter} )"
MSG_DISPLAY "debug" "0" "Rest after first fplit duty :[ ${Control_limit_spliter} ]"

if [ "${Control_limit_spliter}" > "0" ]
   then
   	   BASE_limite_spliter="$( expr ${BASE_limite_spliter} + 1 )"
   	   MSG_DISPLAY "debug" "0" "Final value for split number : [ ${BASE_limite_spliter} ]"
   else
       MSG_DISPLAY "debug" "0" "Final value for split number : [ ${BASE_limite_spliter} ]"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Menu_List_spliter_sub_Gen_array_of_array
{
#|# Var to set  : None
#|#             : Use this var to set
#|#             : Use this var to set
#|# ${1}        : Use this var to set [ ]
#|# ${2}        : Use this var to set [ ]
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

Split_Counter="0"
until [ "${Split_Counter}" = "${BASE_limite_spliter}" ]
    do
      Split_Counter=$( expr ${Split_Counter} + 1 )
      Menu_Array_Name="Auto_array_${Split_Counter}"
      Menu_Array_list_WRK="${Menu_Array_Name} \n ${Menu_Array_list_WRK}"
done
set -A  Menu_Array_list $( echo "${Menu_Array_list_WRK}" )
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Menu_interactive_Set_conf
{
#|# Var to set  : None
#|# LST_PARAMS  : Use this var to set an array of variables name to set
#|# ${1}        : Use this var to set [ ]
#|#
#|# Base usage  : Menu_interactive_Set_conf "My array var"
#|#
#|# Description : This function is used to set or reset live configuration parameter
#|#
#|# Send Back   : Updated vars
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 

LST_PARAMS="${1}"

for ISC_itemps_to_change in ${LST_PARAMS[@]}
   do
      ISC_itemps_to_change_Name="${ISC_itemps_to_change}"
      eval ISC_itemps_to_change_Value="\$\{${ISC_itemps_to_change}\}"
      Menu_Change_Conf_item "${ISC_itemps_to_change_Name}" "${ISC_itemps_to_change_Value}"
      MSG_DISPLAY "debug" "0" "${ISC_itemps_to_change_Name} : [ ${ISC_itemps_to_change_Name} ]"
done


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"


