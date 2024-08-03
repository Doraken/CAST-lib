#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic autodocumentation abstraction menu  from CAST 
function document_Base_menu                                  # DOC_Base_MENU_L0
{
#|# Var to set  : None
#|#
#|# Base usage  : document_Base_menu
#|#
#|# Description : This function generate menu to manage autodoc functions
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Menu_Get_items "# DOC_Base_MENU_L1" "2" "${Base_Dir_Scripts_Lib}/doc/menu/document_menu.lib" "Autodoc menu :"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Document_generate_XML                               # DOC_Base_MENU_L1
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_generate_XML
#|#
#|# Description : This function generate autodoc in XML format by calling
#|#               Do_document_generate
#|# Send Back   : function call with parameter
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Do_document_generate "xml"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Document_generate_Text                              # DOC_Base_MENU_L1
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_generate_Text
#|#
#|# Description : This function generate autodoc in txt format by calling
#|#               Do_document_generate
#|# Send Back   : function call with parameter
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
  

Do_document_generate "txt"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Document_generate_HTML                              # DOC_Base_MENU_L1
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_generate_HTML
#|#
#|# Description : This function generate autodoc in HTML format by calling
#|#               Do_document_generate
#|# Send Back   : function call with parameter
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
  

Do_document_generate "MANHTML"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Document_Generate_Catalogues                        # DOC_Base_MENU_L1
{
#|# Var to set  : None
#|#
#|# Base usage  : Document_Generate_Catalogues
#|#
#|# Description : This function generate autodoc cata by callilogues by calling
#|#               Get_all_function_names_to_document
#|# Send Back   : function call with parameter
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


Get_all_function_names_to_document

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"

