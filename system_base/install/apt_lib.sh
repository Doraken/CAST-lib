#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                             #
# Subject : This library provides base elements needed by C.A.S.T. scripts #
#           to deploy or install packages on Debian-like systems.          #
###############################################################################
####
# INFO 
#      This library is intended for use on all Linux-based systems (it may run on Solaris and AIX, but these are not supported in this version).

################################## Functions ##################################

function Do_apt_autoupdate ()
{
#|# Description : This function updates the package definition files on Debian-like systems, ensuring the package catalog is up to date.
#|#
#|# Variables    : None
#|#
#|# Base usage   : Do_apt_autoupdate
#|#
#|# Send Back    : Updates the system's package catalog.
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

    if [ ${_apt_update_runed} = 1 ]; then 
        MSG_DISPLAY "debug" "0" "Package Catalogue update: [ DONE ] "
    else
        MSG_DISPLAY "debug" "0" "Package ${aptPackageStatus}: [ RUN ] " 
        apt-get update > /dev/null 2>&1 
        CTRL_Result_func "${?}" "status for package catalogue update: " "Not Installed" "4" "" "" "nomsg"
    fi 

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Do_apt_install_package ()
{
#|# Description : This function installs a specified package using the apt package manager on Debian-like systems.
#|#
#|# Variables    :
#|#     aptPackageToInstall  : The package to be installed using apt.
#|#     ${1}                 : The first parameter, used to set aptPackageToInstall.
#|#
#|# Base usage   : Do_apt_install_package "My_package_to_install"
#|#
#|# Send Back    : Installs the specified package if it is not already installed.
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

    local aptPackageToInstall="${1}"
    Empty_Var_Control "${aptPackageToInstall}" "aptPackageToInstall" "4" "Package name is a mandatory parameter."
    Test_apt_package_presence "${aptPackageToInstall}"
    
    if [ "${aptPackageStatus}" = "NOT INSTALLED" ]; then 
        apt-get install "${aptPackageToInstall}" -y > /dev/null 2>&1 
        CTRL_Result_func "${?}" "status for package: [ ${aptPackageToInstall}] " "Not Installed" "4" "" "" "nomsg"
    else
        MSG_DISPLAY "debug" "0" "Package ${aptPackageStatus}: [ INSTALLED ] "
    fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Do_apt_uninstall_package ()
{
#|# Description : This function uninstalls a specified package using the apt package manager on Debian-like systems.
#|#
#|# Variables    :
#|#     aptPackageToUnInstall : The package to be uninstalled using apt.
#|#     ${1}                  : The first parameter, used to set aptPackageToUnInstall.
#|#
#|# Base usage   : Do_apt_uninstall_package "My_package_to_uninstall"
#|#
#|# Send Back    : Uninstalls the specified package if it is currently installed.
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

    local aptPackageToUnInstall="${1}"

    Test_apt_package_presence "${aptPackageToUnInstall}"
    
    if [ "${aptPackageStatus}" = "INSTALLED" ]
     then 
        apt-get remove "${aptPackageToUnInstall}" -y -q > /dev/null 2>&1
        CTRL_Result_func "${?}" "status for package: [ ${aptPackageToUnInstall}] " "Can't uninstall" "4" "" "" "nomsg"
    else
        MSG_DISPLAY "debug" "Package ${aptPackageStatus}: [ NOT INSTALLED ] "
    fi
    
    apt-get update -y > /dev/null 2>&1
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Test_apt_package_presence ()
{
#|# Description : This function checks if a specified package is installed on the system using the apt package manager.
#|#
#|# Variables    :
#|#     aptPackageToCheck : The package whose installation status is being checked.
#|#     ${1}              : The first parameter, used to set aptPackageToCheck.
#|#
#|# Base usage   : Test_apt_package_presence "PackageName"
#|#
#|# Send Back    : Sets the variable aptPackageStatus to either "INSTALLED" or "NOT INSTALLED".
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

    local aptPackageToCheck="${1}"
    Empty_Var_Control "${aptPackageToCheck}" "aptPackageToCheck" "4" "Package name is a mandatory parameter."

    dpkg-query --show "${aptPackageToCheck}" > /dev/null 2>&1
    CTRL_Result_func "${?}" "status for package: [ ${aptPackageToCheck}] " "Not Installed" "0" "Test_apt_package_presence_sub_i" "Test_apt_package_presence_sub_u" "nomsg"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Test_apt_package_presence_sub_i ()
{
#|# Description : This function is called by CTRL_Result_func when a package is found to be installed.
#|#
#|# Variables    : None
#|#
#|# Base usage   : Test_apt_package_presence_sub_i
#|#
#|# Send Back    : Sets aptPackageStatus to "INSTALLED".
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

    aptPackageStatus="INSTALLED"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Test_apt_package_presence_sub_u ()
 {
#|# Description : This function is called by CTRL_Result_func when a package is found to be not installed.
#|#
#|# Variables    : None
#|#
#|# Base usage   : Test_apt_package_presence_sub_u
#|#
#|# Send Back    : Sets aptPackageStatus to "NOT INSTALLED".
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
