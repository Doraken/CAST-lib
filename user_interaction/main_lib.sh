#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                    #
# Subject : This library provide base functions to create main menu for cast  #
#                                                                             #
###############################################################################
####
# INFO

function Main_Menu
{
#|# Var to set  : None
#|#
#|# Base usage  : Main_Menu
#|#
#|# Description : This function is used to launche Main menu
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Menu_Get_items "# In_main_Menu" "2" "${Base_Dir_Scripts_Lib}/user_interaction/sub/CAST-Mnu_Main.lib" "Main_Menu_:"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

###################################### INSTALL #################################

function Install_Menu                                            # In_main_Menu
{
#|# Var to set  : None
#|#
#|# Base usage  : Install_packages
#|#
#|# Description : This function is used to launche install env menu
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Menu_Get_items "# In_main_install_Menu" "2" "${Base_Dir_Scripts_Lib}/user_interaction/main.lib" "Install Packages :"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Install_packages                                # In_main_install_Menu
{
#|# Var to set  : None
#|#
#|# Base usage  : Install_packages
#|#
#|# Description : This function is used to launche install env menu
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Menu_Get_items "# Install_pkg_type" "2" "${Base_Dir_Scripts_Lib}/user_interaction/main.lib" "Install Packages :"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Install_packages_in_chroot                          # Install_pkg_type
{
#|# Var to set  : None
#|#
#|# Base usage  : Install_packages_chroot
#|#
#|# Description : This function is used to launche install env menu in a chroot
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Menu_Get_items "# PKG_installable_ok" "2" "${Base_Dir_Scripts_Lib}/build/pkg_install.lib" "Menu install Package in Chroot :"


############### Stack_TRACE_BUILDR ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Install_packages_in_system                          # Install_pkg_type
{
#|# Var to set  : None
#|#
#|# Base usage  : Install_packages_env
#|#
#|# Description : This function is used to launche install env menu out of an chroot
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Menu_Get_items "# PKG_installable_ok" "2" "${Base_Dir_Scripts_Lib}/build/pkg_install.lib" "Menu install Package in System :"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


################################### CHROOT #####################################

function Install_chroot                                          # In_main_Menu
{
#|# Var to set  : None
#|#
#|# Base usage  : Install_chroot
#|#
#|# Description : This function is used to launche install env menu in a chroot
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Install_chroot_from_tarball
{
#|# Var to set  : None
#|#
#|# Base usage  : Install_chroot_from_tarball
#|#
#|# Description : This function is used to launche install env menu in a chroot
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Install_chroot_from_system
{
#|# Var to set  : None
#|#
#|# Base usage  : Install_chroot_from_system
#|#
#|# Description : This function is used to launche install env menu in a chroot
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

################################## CVS #########################################

function Main_Sources_server                               # Sources_server_main
{
#|# Var to set  : None
#|#
#|# Base usage  : Main_Sources_server
#|#
#|# Description : This function is used to sources server manager
#|#               menu out of an chroot
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Menu_Get_items "# Sources_server_sub" "2" "${Base_Dir_Scripts_Lib}/user_interaction/main.lib" "Sources server Menu :"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Main_CVS                                          # Sources_server_sub
{
#|# Var to set  : None
#|#
#|# Base usage  : Main_CVS
#|#
#|# Description : This function is used to launche CVS manager menu
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Menu_Get_items "# CVS_Launch_Menu" "2" "${Base_Dir_Scripts_Lib}/sources_server/cvs/cvs_menu.lib" "Menu cvs manager :"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Main_SVN                                         # Sources_server_main
{
#|# Var to set  : None
#|#
#|# Base usage  : Main_SVN
#|#
#|# Description : This function is used to launche svn server menu
#|#
#|# Send Back   : Menu
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

Menu_Get_items "# SVN_Launch_Menu" "2" "${Base_Dir_Scripts_Lib}/sources_server/svn/svn.lib" "Menu svn manager :"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

################################################################################
function Dummy_function
{
#|# Var to set  : None
#|#             : Use this var to set
#|#             : Use this var to set
#|# ${1}        : Use this var to set [  ]
#|# ${2}        : Use this var to set [  ]
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
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

MSG_DISPLAY "info" "1" "this is a model function"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"