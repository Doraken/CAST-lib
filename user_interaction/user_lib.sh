#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                       #
# Subject : This lib is used to provide any function about user menu control  #
#                                                                             #
###############################################################################
####
# INFO

############################
function USER_Generic_continue_or_exit
{
#|# BASE_MSG_FOR_CHOICE : use this var to set the display message ( in warning mode only )
#|# BASE_MSG_FOR_MENU   : use this var to set the menu message
#|# ${1}                : use this var to set BASE_MSG_FOR_CHOICE
#|# ${2}                : use this var to set BASE_MSG_FOR_MENU
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "Warning1" "${BASE_MSG_FOR_CHOICE}"

PS3="${Base_Var_Menu_Message}"
select Result in Continue EXIT
do
   case ${Result} in
	      "1") MSG_DISPLAY "Warning1" "User select to user root account"
	         My_Ident="$(id -u)"
	         logger " $( date )  scripting user whith root account by [ ${My_Ident} ] "
	         ;;
	      "2") MSG_DISPLAY "EdEMessage" "1" "User select to exit" 
	         ;;
	      *) MSG_DISPLAY "EdEMessage" "1" "Bad input exit" 
	         ;;
     esac
done


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function USER_Continue_ON_ERR
{
#|# MSG_TO_Display : use this var to set the displayed message when an user action is needed
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 

if [ "${Redo_Last}" = "Dummy" ]
   then
       Type_Msg="Question"
       Err_Question_Msg="${MSG_TO_Display}"


       read Action_NUMBER
       case ${Action_NUMBER} in
           1)
              MSG_DISPLAY "info" "1" "User choice is [ IGNORE ERROR ]  "
               ;;
           2) MSG_DISPLAY "EdEMessage" "1" ""  
              MSG_DISPLAY "info" "1" "Retry choosen by user on : [ RETRY ${MSG_TO_Display} ]"

              ${Redo_Last} ;;
           *)
              MSG_DISPLAY "info" "1" "This choice is not supported  : [ ${Action_NUMBER} ] "


              MSG_DISPLAY "info" "1" "Please try again ..."

       USER_Continue_ON_ERR ;;
      esac
  else
      Type_Msg="Question2"
      Err_Question_Msg="${MSG_TO_Display}"


      read Action_NUMBER
      case ${Action_NUMBER} in
           1)
              MSG_DISPLAY "info" "1" "User choice is [ IGNORE ERROR ]  "
               ;;
           2) MSG_DISPLAY "EdEMessage" "1" "" "1"
              MSG_DISPLAY "info" "1" "Retry choosen by user on : [ RETRY ${MSG_TO_Display} ]"

              ${Redo_Last} ;;
           3)
  Err_Msg="Stopped by user on : [ ERROR ${MSG_TO_Display} ]"
               ;;
           *)
              MSG_DISPLAY "info" "1" "This choice is not supported  : [ ${Action_NUMBER} ] "


              MSG_DISPLAY "info" "1" "Please try again ..."

       USER_Continue_ON_ERR ;;
      esac
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function User_Hit_a_key
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 

FONT_set_Message_Font
MSG_DISPLAY "Message" "Please  : press enter to continue "
read dummy

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"