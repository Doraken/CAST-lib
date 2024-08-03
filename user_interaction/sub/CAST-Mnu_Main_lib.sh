#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                      #
# Subject : This library provide base menu functions to deploy chroots on     #
#           server                                                            #
###############################################################################
####
# INFO 

function certificates_managment ()                                               # In_main_Menu
{
#|# Var to set  : None             
#|#
#|# Base usage  : certificates_managment
#|#
#|# Description : this function launche the certificate managment sytem
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

Menu_Get_items "# In_certificate_Menu" "2" "${Base_Dir_Scripts_Lib}/user_interaction/sub/CAST-Mnu_certificates_managment.lib" "certificate_Menu_:"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# Sourcing control variable 
LibState="OK"