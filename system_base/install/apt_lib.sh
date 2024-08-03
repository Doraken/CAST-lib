#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                 #
# Subject : This library provide base elements needed by C.A.S.T. scripts     #
#           tto deploy or install packages on debian like systems             #
###############################################################################
####
# INFO 
#      this lib is for all linux based systems ( may run on solaris and AIX but not supported in this version )

function Do_apt_autoupdate ()
{
#|# Description : This function is used to update all package definition on debian like system. 
#|#
#|# Var to set    : none
#|#
#|# Base usage  : Do_apt_autoupdate "
#|#
#|# Send Back   : system updated package catalogue 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


if [ ${_apt_update_runed} = 1 ]
   then 
        MSG_DISPLAY "debug" "0" "Package Catalogue update : [ DONE ] "
   else
        MSG_DISPLAY "debug" "0" "Package ${aptPackageStatus} : [ RUN ] " 
        apt-get update > /dev/null 2>&1 
        CTRL_Result_func "${?}" "status for package catalogue update : " "Not Installed" "4" "" "" "nomsg"
fi 

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 

}


function Do_apt_install_package
{
#|# Description : This function is used to manage installation of apt packages on system. 
#|#
#|# Var to set    :
#|#                 aptPackageToInstall  : Use this var to set wiche package to install with apt
#|#                 ${1}            : Use this var to set [ aptPackageToInstall ]
#|#
#|# Base usage  : Do_apt_install_package "My_package_to_install"
#|#
#|# Send Back   : Installed package
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


local aptPackageToInstall="${1}"
Empty_Var_Control "${aptPackageToInstall}" "aptPackageToInstall"  "4" "package name is a mandatory parameter "
Test_apt_package_presence ${aptPackageToInstall}
if [ "${aptPackageStatus}" = "NOT INSTALLED" ] 
then 
    apt-get install ${aptPackageToInstall} -y> /dev/null 2>&1 
    CTRL_Result_func "${?}" "status for package : [ ${aptPackageToCheck}] " "Not Installed" "4" "" "" "nomsg"
else
    MSG_DISPLAY "debug" "0" "Package ${aptPackageStatus} : [ INSTALLED ] "
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
} 

function Do_apt_uninstall_package
{
#|# Description         : This function is used to manage uninstallation of apt packages on system.
#|# 
#|# Var to set            : 
#|#                            aptPackageToUnInstall Use this var to set which package to uninstall
#|#                         ${1}                 : use this var to set aptPackageToUnInstall
#|#
#|# Basic use             : Do_apt_install_package "My_package_to_uninstall" 
#|#
#|# Send Back       : Unsinstalled package
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


local aptPackageToUnInstall="${1}"

Test_apt_package_presence ${aptPackageToUnInstall}
if [ "${aptPackageStatus}" = "INSTALLED" ] 
then 
    apt-get remove  ${aptPackageToUnInstall} -y -q> /dev/null 2>&1
    CTRL_Result_func "${?}" "status for package : [ ${aptPackageToUnInstall}] " "Can t uninstall" "4" "" "" "nomsg"
else
    MSG_DISPLAY "debug" "Package ${aptPackageStatus} : [ NOT INSTALLED ] "
fi
apt-get update -y> /dev/null 2>&1 1> /dev/null 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
} 

function Test_apt_package_presence
{
#|# Var to set  : aptPackageToCheck             
#|#
#|# Base usage  : CTest_apt_package_presence PackageName
#|#
#|# Description : This function Check package instalation status.
#|#
#|# Send Back   : Info and action ( execution of other fcntion to set many information about the system) 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


local aptPackageToCheck="${1}"
Empty_Var_Control "${aptPackageToCheck}" "aptPackageToCheck"  "4" "package name is a mandatory parameter "


dpkg-query --show ${aptPackageToCheck} > /dev/null 2>&1
CTRL_Result_func "${?}" "status for package : [ ${aptPackageToCheck}] " "Not Installed" "0" "Test_apt_package_presence_sub_u" "Test_apt_package_presence_sub_i" "nomsg"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
} 

function Test_apt_package_presence_sub_i
{
#|# Description : This function is used with CTRL_Result_func as success or error result
#|#
#|# Var to set  : None             
#|#
#|# Base usage  : Test_apt_package_presence_sub_i 
#|#
#|# Send Back   : aptPackageStatus seted at INSTALLED
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


aptPackageStatus="INSTALLED"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Test_apt_package_presence_sub_u
{
#|# Description : This function is used with CTRL_Result_func as success or error result
#|#
#|# Var to set  : None             
#|#
#|# Base usage  : Test_apt_package_presence_sub_u 
#|#
#|# Send Back   : aptPackageStatus seted at NOT INSTALLED
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


aptPackageStatus="NOT INSTALLED"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"