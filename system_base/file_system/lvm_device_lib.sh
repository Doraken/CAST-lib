#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                  #
# Subject : This library provide base loop device manipulation runtimes       #
#                                                                             #
###############################################################################
####
# INFO 

function Do_lvm_device_create
{
#|# Var to set  : 
#|# LVMDC_Name_lv : Use this var to set name of the created lv ( Mandatory )
#|# LVMDC_Size_lv : Use this var to set size of the created lv ( Mandatory )
#|# LVMDC_VG_NAME : Use this var to set name of the used vg    ( Mandatory )
#|# ${1}          : Use this var to set [ LVMDC_Name_lv ]                   
#|# ${2}          : Use this var to set [ LVMDC_Size_lv ]
#|# ${3}          : Use this var to set [ LVMDC_VG_NAME ]                 
#|#
#|# Base usage  : Do_lvm_device_create "LVMDC_Name_lv" "LVMDC_Size_lv" "LVMDC_VG_NAME" 
#|#
#|# Description : This function is used to creat lvm logical volume
#|#
#|# Send Back   : lvm logical volume
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local LVMDC_Name_lv="${1}"                    
local LVMDC_Size_lv="${2}" 
local LVMDC_VG_NAME="${3}"  

Empty_Var_Control "${LVMDC_Name_lv}" "LVMDC_Name_lv"  "4" " logical volume name is a mandatory parameter "
Empty_Var_Control "${LVMDC_Size_lv}" "LVMDC_Size_lv"  "4" " logical volume size is a mandatory parameter "
Empty_Var_Control "${LVMDC_VG_NAME}" "LVMDC_VG_NAME"  "4" " volume group name is a mandatory parameter "

lvcreate -L ${LVMDC_Size_lv} -n ${LVMDC_Name_lv} ${LVMDC_VG_NAME} 
CTRL_Result_func "${?}" "Creation of logical volume ${LVMDC_Name_lv} on vg ${LVMDC_VG_NAME}" " [ can't create ] " "2" "" ""
Test_lvm_device_presence "${LVMDC_Name_lv}" "${LVMDC_VG_NAME}"  "2" "" ""
################# Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
###################################################### 	
}

function Do_lvm_device_delete
{
#|# Var to set  : 
#|# LVMDD_Name_lv : Use this var to set ( Mandatory )
#|# LVMDD_VG_NAME : Use this var to set ( Mandatory )
#|# ${1}          : Use this var to set [ LVMDD_Name_lv ]                   
#|# ${2}          : Use this var to set [ LVMDD_VG_NAME ]                 
#|#
#|# Base usage  : Do_lvm_device_delete "LVMDD_Name_lv" "LVMDD_VG_NAME" 
#|#
#|# Description : This function is used to delete lvm logical volume
#|#
#|# Send Back   : lvm logical volume deletion
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local LVMDD_Name_lv="${1}"                    
local LVMDD_VG_NAME="${2}" 

Empty_Var_Control "${LVMDD_Name_lv}" "LVMDD_Name_lv"  "4" " logical volume name is a mandatory parameter "
Empty_Var_Control "${LVMDD_VG_NAME}" "LVMDD_VG_NAME"  "4" " volume group name is a mandatory parameter "

lvremove  /dev/${LVMDD_VG_NAME}/${LVMDD_Name_lv}

CTRL_Result_func "${?}" "Deletion of logical volume ${LVMDC_Name_lv} on vg ${LVMDC_VG_NAME}" " [ can't create ] " "2" "" ""
################# Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
###################################################### 	
}

function Test_lvm_device_presence
{
#|# Var to set  : 
#|# LVMDEX_Name_lv        : Use this var to set Logical volume name to check ( Mandatory )
#|# LVMDEX_VG_NAME        : Use this var to set Volume group name of the lv  ( Mandatory )
#|# LVMDEX_err_level      : Use this var to set error level of the check     ( Mandatory )
#|# LVMDEX_On_Fail_Action : Use this var to set on chek fail action          ( Optional )
#|# LVMDEX_On_ok_Action   : Use this var to set on check ok action           ( Optional )
#|# ${1}          : Use this var to set [ LVMDEX_Name_lv ]                   
#|# ${2}          : Use this var to set [ LVMDEX_VG_NAME ]
#|# ${3}          : Use this var to set [ LVMDEX_err_level ]                   
#|# ${4}          : Use this var to set [ LVMDEX_On_Fail_Action ]
#|# ${5}          : Use this var to set [ LVMDEX_On_ok_Action ]              
#|#
#|# Base usage  : Do_lvm_device_delete "LVMDEX_Name_lv" "LVMDEX_VG_NAME"  "LVMDEX_err_level" "LVMDEX_On_Fail_Action" "LVMDEX_On_ok_Action"
#|#
#|# Description : This function is used to check existance of a lvm logical volume
#|#
#|# Send Back   : lvm logical volume Information and action 
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local LVMDEX_Name_lv="${1}"                 
local LVMDEX_VG_NAME="${2}"
local LVMDEX_err_level="${3}"                
local LVMDEX_On_Fail_Action="${4}"
local LVMDEX_On_ok_Action="${5}"   

Empty_Var_Control "${LVMDEX_Name_lv}"   "LVMDEX_Name_lv"    "4" " logical volume name is a mandatory parameter "
Empty_Var_Control "${LVMDEX_VG_NAME}"   "LVMDEX_VG_NAME"    "4" " volume group name is a mandatory parameter "
Empty_Var_Control "${LVMDEX_err_level}" "LVMDEX_err_level"  "4" " error level is a mandatory parameter "

lvdisplay  /dev/${LVMDEX_VG_NAME}/${LVMDEX_Name_lv} > /dev/null
CTRL_Result_func "${?}" "Status of logical volume ${LVMDEX_Name_lv} on vg ${LVMDEX_VG_NAME}" " [ Not present ] " "${LVMDEX_err_level}" "${LVMDEX_On_Fail_Action}" "${LVMDEX_On_ok_Action}"

################# Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
###################################################### 	
}

function Get_lvm_volume_group_status
{
#|# LVM_device_vg_name          : Use this var to set the name of the checked VG
#|# LVM_device_vg_Status_action : Use this var to set the action chek to do 
#|# ${1}                        : To set LVM_device_vg_name
#|# ${2}                        : To set LVM_device_vg_Status_action
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local LVM_device_vg_name="${1}"

case ${LVM_device_vg_Status_action} in 
                 free_space) vgdisplay ${LVM_device_vg_name} | grep "VG Name" 
						     vgdisplay ${LVM_device_vg_name} | grep "Free  PE"  | awk '{ print $1 " " $4 " " $7 " " $8 }'
						     ;;
                 list) vgdisplay  | grep "VG Name" 
                 ;;
                 *)
esac

################# Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
###################################################### 	
}

function Get_lvm_volume_volume_liste
{
#|# This function is used to get full list of all LV device on the computer.
#|# LVM_device_VAR          : This var is user to store the name of var used to send back data.
#|# 
#|# ${1}                        : To set LVM_device_vg_name
#|# ${2}                        : To set LVM_device_vg_Status_action
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

LVM_device_VAR="${1}"

MSG_DISPLAY "debug" "0" "Send back var is : [ ${LVM_device_VAR} ]"
	
################# Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
######################################################
}


function Loop_linker_format
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 


MSG_DISPLAY "info" "1" "Creating links between loop and files  : [ Started ] "

last_att_loop=$(cat ${Base_Chroot_catalog_file} | grep last_loop | awk '{ print $2 }')
New_att_loop=$(expr ${last_att_loop} + 1) 
echo "${Chroot_Name}| created on $(date) | | |D|" >> ${Base_Chroot_catalog_file}
echo " echo \" regenerating configuration loop device for ${Chroot_Name}\"" >> ${BDir_Tmp_Auto_Lib}/Loop_configuration.ksh
for Loops_to_map in ${Loops_File_Liste}
do 
   echo "losetup /dev/loop${New_att_loop} ${Loops_to_map}"
   losetup /dev/loop${New_att_loop} ${Loops_to_map}
   echo "${Chroot_Name}| loop Device loop${New_att_loop} | file   |  ${Loops_to_map}|T|" >> ${Base_Chroot_catalog_file}
   echo "losetup /dev/loop${New_att_loop} ${Loops_to_map}" >> ${Base_Scriptname_auto_loop_conf}
   echo "losetup -d /dev/loop${New_att_loop} "   >> ${Base_Scriptname_auto_loop_deconf}
   mkfs.ext2 /dev/loop${New_att_loop} 
   New_att_loop=$(expr ${New_att_loop} + 1) 
done
echo "" >>  ${Base_Chroot_catalog_file}  
cat ${Base_Chroot_catalog_file} | egrep -v last_loop > ${Base_Chroot_catalog_tmp_file}
cat ${Base_Chroot_catalog_tmp_file} > ${Base_Chroot_catalog_file}
echo "last_loop ${New_att_loop}" >> ${Base_Chroot_catalog_file}
MSG_DISPLAY "info" "1" "Creating links between loop and files  : [ Started ] "


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}


# Sourcing control variable 
LibState="OK"