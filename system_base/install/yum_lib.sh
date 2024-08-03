#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                     #
# Subject : This library provide base elements needed by C.A.S.T. scripts     #
#           this lib is based on C.A.S.T. framwork created by ARNAUD CRAMPET  #
###############################################################################
####
# INFO 
#      this lib is for all linux based systems ( may run on solaris and AIX but not supported in this version )




function Do_yum_install_package
{
#|# Description : This function is used to manage installation of yum packages on system. 
#|#
#|# Var to set    :
#|#                 YumPackageToInstall  : Use this var to set wiche package to install with yum
#|#                 ${1}            : Use this var to set [ YumPackageToInstall ]
#|#
#|# Base usage  : Do_yum_install_package "My_package_to_install"
#|#
#|# Send Back   : Installed package
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


local YumPackageToInstall="${1}"
Empty_Var_Control "${YumPackageToInstall}" "YumPackageToInstall"  "4" "package name is a mandatory parameter "
Test_yum_package_presence ${YumPackageToInstall}
if [ "${YumPackageStatus}" = "NOT INSTALLED" ] 
then 
    yum install ${YumPackageToInstall} -y> /dev/null 2>&1 
    CTRL_Result_func "${?}" "status for package : [ ${YumPackageToCheck}] " "Not Installed" "4" "" "" "nomsg"
else
    MSG_DISPLAY "debug" "0" "Package ${YumPackageStatus} : [ INSTALLED ] "
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
} 

function Do_yum_uninstall_package
{
#|# Description         : This function is used to manage uninstallation of yum packages on system.
#|# 
#|# Var to set            : 
#|#                            YumPackageToUnInstall Use this var to set which package to uninstall
#|#                         ${1}                 : use this var to set YumPackageToUnInstall
#|#
#|# Basic use             : Do_yum_install_package "My_package_to_uninstall" 
#|#
#|# Send Back       : Unsinstalled package
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


local YumPackageToUnInstall="${1}"
Test_yum_package_presence ${YumPackageToUnInstall}
if [ "${YumPackageStatus}" = "INSTALLED" ] 
then 
    yum erase  ${YumPackageToUnInstall} -y -q> /dev/null 2>&1
    CTRL_Result_func "${?}" "status for package : [ ${YumPackageToUnInstall}] " "Can t uninstall" "4" "" "" "nomsg"
else
    MSG_DISPLAY "debug" "Package ${YumPackageStatus} : [ NOT INSTALLED ] "
fi
yum update -y> /dev/null 2>&1 1> /dev/null 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
} 

function Test_yum_package_presence
{
#|# Var to set  : YumPackageToCheck             
#|#
#|# Base usage  : CTest_yum_package_presence PackageName
#|#
#|# Description : This function Check package instalation status.
#|#
#|# Send Back   : Info and action ( execution of other fcntion to set many information about the system) 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


local YumPackageToCheck="${1}"


Empty_Var_Control "${YumPackageToCheck}" "YumPackageToCheck"  "4" "package name is a mandatory parameter "
yum list installed ${YumPackageToCheck} -q> /dev/null 2>&1
CTRL_Result_func "${?}" "status for package : [ ${YumPackageToCheck}] " "Not Installed" "0" "Test_yum_package_presence_sub_u" "Test_yum_package_presence_sub_i" "nomsg"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
} 

function Test_yum_package_presence_sub_i
{
#|# Description : This function is used with CTRL_Result_func as success or error result
#|#
#|# Var to set  : None             
#|#
#|# Base usage  : Test_yum_package_presence_sub_i 
#|#
#|# Send Back   : YumPackageStatus seted at INSTALLED
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


YumPackageStatus="INSTALLED"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Test_yum_package_presence_sub_u
{
#|# Description : This function is used with CTRL_Result_func as success or error result
#|#
#|# Var to set  : None             
#|#
#|# Base usage  : Test_yum_package_presence_sub_u 
#|#
#|# Send Back   : YumPackageStatus seted at NOT INSTALLED
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "


YumPackageStatus="NOT INSTALLED"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"