#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
 
# INFO                                                                                  #
# Subject : This library provide base Main menu for all generic ation using   
#           C.A.S.T.                                                          
 

############################


function Ctrl_Depth
{
#|#  Ctrl_Depth : use this var to 
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 


CheckApp=$( echo ${Keyword}|awk -F \/ '{ print $2 }') 
if [ "${CheckApp}" != "keywordValues.txt" ]
  then
     MSG_DISPLAY "info" "1" "${CheckApp} est une appli"
     cd ${CheckApp}
     Ctrl_Depth
  else
  MSG_DISPLAY "info" "1" "$CheckDepth est une le racine" 
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################  
} 

# Sourcing control variable 
LibState="OK"