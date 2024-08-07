#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                        #
# Subject : This library provide base loop device manipulation runtimes       #
#                                                                             #
###############################################################################
####
# INFO 

function Do_device_loop_Create_base_file
{
#|# Base_Var_File_Loop_To_Create       : use this var to set the loop file to create 
#|# Base_Var_File_Loop_Size_To_Create  : Use this var to set the size of the lopp file to create
#|# Base usage : 
#|#              Base_Var_File_Loop_To_Create="My_device_file" ( full path ) 
#|#              Base_Var_File_Loop_Size_To_Create="My_size" (for  100 mo = 100 * 1000 = 100000 ) 
#|#              Device_loop_Create
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 


File_Exist "${Base_Var_File_Loop_To_Create}" "Create_File" "2" 
if [ "${RETURNVAR_Test_file_presence}" = "1" ]
    then 
     MSG_TO_Display="the loop file already existe do you want to continue and overwrite ?"
     USER_Continue_ON_ERR
    else 
    dd if=/dev/zero of=${Base_Var_File_Loop_To_Create} bs=1k count=${Base_Var_File_Loop_Size_To_Create}
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
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