#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic auto documentation from CAST 
# Subject : This library provide base bdd automaintenance                     #
#                                                                             #
###############################################################################
####
# Info

function SQL_Server_Connect
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

INTERNAM_ITERAT_SQL_CONNECT="0"

case ${EXTERNAL_SQL_IS_CONNECTED} in
            OnLine) MSG_DISPLAY "Info" "1" "SQL Session id ${EXTERNAL_SQL_session_ID} status : [ Allready connected ] "
                           ;;
            OffLine) MSG_DISPLAY "Info" "1" "SQL Session id ${EXTERNAL_SQL_session_ID} status : [ Not connected ] "
                     Get_system_random_,number
                     EXTERNAL_SQL_current_FIFO_file="${Base_SQL_Fifo_FileName}_${EXTERNAL_randomized_var}"
                     EXTERNAL_SQL_current_Log_File="${Base_SQL_Log_FileName}_${EXTERNAL_randomized_var}"
                     MSG_DISPLAY "Debug" "6" "Current SQL FIFO file : [ ${EXTERNAL_SQL_current_FIFO_file} ] "
                     MSG_DISPLAY "Debug" "6" "Current SQL Log file : [ ${EXTERNAL_SQL_current_Log_File} ] "
                     Do_SQL_Sub_connect_Server
                     Set_new_fifo SQL_fifo filename="${EXTERNAL_SQL_current_FIFO_file}"
                     ${Base_mysql_bin_proc_use} < ${EXTERNAL_SQL_current_FIFO_file} > ${EXTERNAL_SQL_current_Log_File} &
                     echo $?
                     EXTERNAL_SQL_IS_CONNECTED="OnLine"
                     EXTERNAL_SQL_session_ID="${EXTERNAL_randomized_var}"
                     MSG_DISPLAY "Info" "1" "SQL Session id ${EXTERNAL_SQL_session_ID} status : [ connected ] "
                     ;;
                  *) MSG_DISPLAY "ErrorN" "1" "Internal Error in function var  : [ EXTERNAL_SQL_IS_CONNECTED ]"
                     ;;
esac
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function SQL_Server_Disconnect
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
case ${EXTERNAL_SQL_IS_CONNECTED} in
     OnLine) MSG_DISPLAY "Debug" "6" "SQL Session id ${EXTERNAL_SQL_session_ID} status : [ Connected ] "
             MSG_DISPLAY "Debug" "6" "Current SQL FIFO file : [ ${EXTERNAL_SQL_current_FIFO_file} ] "
             MSG_DISPLAY "Debug" "6" "Current SQL Log file : [ ${EXTERNAL_SQL_current_Log_File} ] "
             echo  " exit " > ${EXTERNAL_SQL_current_FIFO_file}
             sleep 2
             UnSet_fifo SQL_fifo
             MSG_DISPLAY "Debug" "6" "SQL Session id ${EXTERNAL_SQL_session_ID} status : [ Disconnected ] "
             EXTERNAL_SQL_IS_CONNECTED="OffLine"
             ;;
    OffLine) MSG_DISPLAY "Info" "1" "SQL Session id ${EXTERNAL_SQL_session_ID} status : [ Not connected ] "
             MSG_DISPLAY "Info" "1" "you con't disconnect an not connected session "
             ;;
esac
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SQL_DATABASE_connect
{
#|# DATABASE_To_connect     : Use this var to set on witch database yuou want to connect
#|# ${1}                    :  use this var to set DATABASE_To_connect
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
DATABASE_To_connect="${1}"

echo  " CONNECT ${DATABASE_To_connect}; " >> ${EXTERNAL_SQL_current_FIFO_file}
echo  " show tables ; " >> ${EXTERNAL_SQL_current_FIFO_file}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SQL_CONNECT_CHECK
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

if [ ${EXTERNAL_SQL_IS_CONNECTED} = "OnLine" ]
   then
          MSG_DISPLAY "Debug" "6" "Connection to DATABASE server : [ OK ] "
   else
          MSG_DISPLAY "ErrorN" "1" "Connection to DATABASE server : [ not Connected] "
          MSG_DISPLAY "ErrorN" "1" "Please ensure you have called  function  [ SQL_Server_Connect  ]  "
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SQL_GET_PKG_liste
{
#|# Base_Database_Type
#|# Base_Database_Host
#|# Base_Database_Port
#|# Base_Database_proc_Username
#|# Base_Database_TempDir
#|# Base_Database_Default
#|# packageTable="ARPCOM_PKG_CAT"
#|# typePackageTable="ARPCOM_PKG_TYPE_CAT"
#|# omImportTable="ARPCOM_OM_IMPORT"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
Get_system_random_,number
INTERNAL_ID_READ_ITEM="#-#-${EXTERNAL_randomized_var}"

SQL_CMD="select DISTINCT '${INTERNAL_ID_READ_ITEM}' as 'BACKTRACE', \`PKG_NAME\`,\`ID_PKG\`  FROM  \`${Base_Database_Default}\`.\`${packageTable}\` ; "


echo  "select '${INTERNAL_ID_READ_ITEM}' as 'BACKTRACE', 'Debut' as 'status' ; " >> ${EXTERNAL_SQL_current_FIFO_file}
echo  "${SQL_CMD}" >> ${EXTERNAL_SQL_current_FIFO_file}
echo  "select '${INTERNAL_ID_READ_ITEM}' as 'BACKTRACE', 'fin' as 'status' ; " >> ${EXTERNAL_SQL_current_FIFO_file}
SQL_Server_Disconnect

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SQL_USE_PKG_liste
{
for PKGS in $( cat ${EXTERNAL_SQL_current_Log_File} | grep ${INTERNAL_ID_READ_ITEM} | awk  '{print  $2 "|" $3 }' ) 
   do 
   	 INTERNAL_VALUS_STATUS="$(print  "${PKGS} " | awk -F\| '{print $1}')"
   	 case ${INTERNAL_VALUS_STATUS} in 
   	                  debut) MSG_DISPLAY "Debug" "4" "Internal ddb proc generator  : [ Start ] " 
   	                         ;;
                        fin) MSG_DISPLAY "Debug" "4" "Internal ddb proc generator  : [ done ] " 
                             ;;
                          *) SQL_Server_Connect
                             SQL_DATABASE_connect "ARPCOM"
                             echo  "${PKGS} " | awk -F\| '{print $1 " " $2 }'
                             INTERNAL_PKG_NAME="$(print  "${PKGS} " | awk -F\| '{ print $1 }')"
                             INTERNAL_LAST_do_action="${INTERNAL_LAST_do_action}"
                             PROC_NAME="${Base_PROC_Name}_${INTERNAL_PKG_NAME}"
                             TABLE_NAME="${Base_TABLE_Name}_${INTERNAL_PKG_NAME}"
                             MSG_DISPLAY "Debug" "5" "Table Name : [ ${TABLE_NAME} ] "
                             MSG_DISPLAY "Debug" "5" "Procedure Name : [ ${PROC_NAME} ] "
                             SQL_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE >> ${EXTERNAL_SQL_current_FIFO_file} &
                             SQL_Server_Disconnect
                             ;;
  ${INTERNAL_LAST_do_action}) MSG_DISPLAY "Debug" "4" "Package ${INTERNAL_LAST_do_action} : [ Allready done ] "
                             ;;
       esac
done 

}

function TITI
{
${Base_mysql_bin_proc_use} < ${INTERNAL_IN_FILE} > ${INTERNAL_OUT_FILE}
cat ${EXTERNAL_SQL_current_Log_File} | egrep -v "PKG_NAME" | grep  "\." > ${INTERNAL_OUT_FILE}.tmp.nok
cat ${EXTERNAL_SQL_current_Log_File} | egrep -v "PKG_NAME" |egrep -v "\."   > ${INTERNAL_OUT_FILE}.tmp


cat ${INTERNAL_OUT_FILE}.tmp > ${INTERNAL_OUT_FILE}

cat  ${INTERNAL_OUT_FILE} | while read line
do  INTERNAL_PKG_NAME="$( echo  "$line" | awk '{ print $1 }')"
    INTERNAL_PKD_ID="$( echo "$line" | awk '{ print $2 }')"
    
 
    SQL_GENERATE_PROC >> ${SQL_MASTER_PROC_SCRIPT}
    SQL_Run_ALL_PROCS_GEN_SUB1 > ${INTERNAL_IN_FILE}_RUN_PROCS.tmp

done
echo  " exit "  > ${INTERNAL_IN_FILE}_RUN_PROCS.tmp
rm ${INTERNAL_IN_FILE}_RUN_PROCS.tmp
#${Base_mysql_bin_proc_use} < ${SQL_MASTER_PROC_SCRIPT}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function SQL_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE
{
#|# Base_Database_Type
#|# Base_Database_Host
#|# Base_Database_Port
#|# Base_Database_proc_Username
#|# Base_Database_TempDir
#|# Base_Database_Default
#|# packageTable="ARPCOM_PKG_CAT"
#|# typePackageTable="ARPCOM_PKG_TYPE_CAT"
#|# omImportTable="ARPCOM_OM_IMPORT"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

echo  "DELIMITER \$\$"
echo  "DROP PROCEDURE IF EXISTS \`${Base_Database_Default}\`.\`${PROC_NAME}\`\$\$"
echo  "CREATE DEFINER=\`admdb\`@\`%\` PROCEDURE \`${PROC_NAME}\`"
echo  "(  versionGeneral varchar(16)"
echo  " , versionRelease  varchar(16)"
echo  " , versionCorrectif varchar(16)"
echo  " , versionPatch varchar(16)"
echo  " , nomPF varchar(16)"
echo  " , nomMachine varchar(16)"
echo  " , nomInstance varchar(16)"
echo  " , nomInstanceSub1 varchar(50)"
echo  " , nomInstanceSub2 varchar(50)"
echo  " , numstage varchar(32)"
echo  ")"
echo  "BEGIN"
echo  ""
echo  "DROP TABLE IF EXISTS  \`${Base_Database_Default}\`.\`${Base_TABLE_Name}_${INTERNAL_PKG_NAME}\`;"
echo  "CREATE TABLE IF NOT EXISTS  \`${Base_Database_Default}\`.\`${Base_TABLE_Name}_${INTERNAL_PKG_NAME}\` ("
echo  "  \`ID_PKG\`               int(11)       NOT NULL,"
echo  "  \`PKG_GENERAL\`          varchar(8)    NOT NULL,"
echo  "  \`PKG_RELEASE\`          varchar(8)    NOT NULL,"
echo  "  \`PKG_CORRECTIF\`        varchar(8)    NOT NULL,"
echo  "  \`PKG_PATCH\`            varchar(8)    default NULL,"
echo  "  \`keywords_root_path\`   varchar(32)   default 'INFRA',"
echo  "  \`keywords_level1_PATH\` varchar(32)   default NULL,"
echo  "  \`keywords_level2_PATH\` varchar(32)   default NULL,"
echo  "  \`keywords_level3_PATH\` varchar(32)   default NULL,"
echo  "  \`keywords_level4_PATH\` varchar(32)   default NULL,"
echo  "  \`keywords_level5_PATH\` varchar(32)   default NULL,"
echo  "  \`keywords_level6_PATH\` varchar(32)   default NULL,"
echo  "  \`Keyword_Name\`         varchar(100)  NOT NULL,"
echo  "  \`Keyword_Value\`        varchar(2142) default NULL,"
echo  "  \`stage\`                varchar(32)   default NULL,"
echo  "  PRIMARY KEY  (\`Keyword_Name\`)"
echo  ") ENGINE=MyISAM DEFAULT CHARSET=latin1 ;"
echo  ""

SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_1

echo  "SELECT  \`${Base_Database_Default}_PKG_CAT\`.\`ID_PKG\` AS 'ID_PKG'"
echo  "       ,\`PKG_GENERAL\`"
echo  "       ,\`PKG_RELEASE\`"
echo  "       ,\`PKG_CORRECTIF\`"
echo  "       ,\`PKG_PATCH\`"
echo  "       ,'INFRA' AS 'keywords_root_path'"
echo  "       ,'' AS 'keywords_level1_PATH'"
echo  "       ,'' AS 'keywords_level2_PATH'"
echo  "       ,'' AS 'keywords_level3_PATH'"
echo  "       ,'' AS 'keywords_level4_PATH'"
echo  "       ,'' AS 'keywords_level5_PATH'"
echo  "       ,'' AS 'keywords_level6_PATH'"
echo  "       ,\`PKG_File_Keyword\` AS 'Keywod_Name'"
echo  "       ,'' AS 'Keyword_Value'"
echo  "       ,'' AS stage"
echo  "     FROM  ( \`${Base_Database_Default}_PKG_CAT\` LEFT JOIN \`${Base_Database_Default}_PKG_FILE_CAT\`"
echo  "         ON (\`${Base_Database_Default}_PKG_CAT\`.\`ID_PKG\` = \`${Base_Database_Default}_PKG_FILE_CAT\`.\`ID_PKG\`))"
echo  "            WHERE \`PKG_NAME\`    =  '${INTERNAL_PKG_NAME}' "
echo  "               AND \`PKG_GENERAL\` =  \`versionGeneral\`"
echo  "               AND \`PKG_RELEASE\` =  \`versionRelease\`"
echo  "               AND \`PKG_CORRECTIF\` =  \`versionCorrectif\`"
echo  "               AND \`PKG_PATCH\` = \`versionPatch\`"
echo  "          ORDER BY  \`${Base_Database_Default}_PKG_FILE_CAT\`.\`PKG_File_Keyword\`;"
echo  ""

SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_1
SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_2



echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level1_PATH\` = '' "
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level2_PATH\` = '' "
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level3_PATH\` = '' "
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level4_PATH\` = '' "
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level5_PATH\` = '' "
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`stage\` = \`numStage\` ; "
echo  ""


SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_1
SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_2


echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level1_PATH\` = \`nomMachine\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level2_PATH\` = ''"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level3_PATH\` = ''"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level4_PATH\` = ''"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level5_PATH\` = ''"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`stage\` = \`numStage\` ;"
echo  ""
SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_1
SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_2


echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level1_PATH\` = \`nomMachine\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level2_PATH\` = '${INTERNAL_PKG_NAME}'"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level3_PATH\` = ''"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level4_PATH\` = ''"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level5_PATH\` = ''"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`stage\` = \`numStage\` ;"
echo  ""

SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_1
SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_2

echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level1_PATH\` = \`nomMachine\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level2_PATH\` = '${INTERNAL_PKG_NAME}'"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level3_PATH\` = \`nomInstance\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level4_PATH\` = ''"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level5_PATH\` = ''"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`stage\` = \`numStage\` ;"
echo  ""

SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_1
SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_2


echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level1_PATH\` = \`nomMachine\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level2_PATH\` = '${INTERNAL_PKG_NAME}'"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level3_PATH\` = \`nomInstance\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level4_PATH\` = \`nomInstanceSub1\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level5_PATH\` = ''"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`stage\` = \`numStage\` ;"
echo  ""

SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_1
SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_2


echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level1_PATH\` = \`nomMachine\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level2_PATH\` = '${INTERNAL_PKG_NAME}' "
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level3_PATH\` = \`nomInstance\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level4_PATH\` = \`nomInstanceSub1\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level5_PATH\` = \`nomInstanceSub2\`"
echo  "            AND \`${Base_Database_Default}_OM_IMPORT\`.\`stage\` = \`numStage\` ;"
echo  "END\$\$"
echo  "DELIMITER ;"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_1
{
echo  "REPLACE into \`${Base_Database_Default}\`.\`${Base_TABLE_Name}_${INTERNAL_PKG_NAME}\`"
echo  "   (\`ID_PKG\`"
echo  "   ,\`PKG_GENERAL\`"
echo  "   ,\`PKG_RELEASE\`"
echo  "   ,\`PKG_CORRECTIF\`"
echo  "   ,\`PKG_PATCH\`"
echo  "   ,\`keywords_root_path\`"
echo  "   ,\`keywords_level1_PATH\`"
echo  "   ,\`keywords_level2_PATH\`"
echo  "   ,\`keywords_level3_PATH\`"
echo  "   ,\`keywords_level4_PATH\`"
echo  "   ,\`keywords_level5_PATH\`"
echo  "   ,\`keywords_level6_PATH\`"
echo  "   ,\`Keyword_Name\`"
echo  "   ,\`Keyword_Value\`"
echo  "   ,\`stage\`"
echo  ")"
}

function SQL_Sub_GENERATE_PROCS_OM_PKG_KEY_CATALOGUE_2
{
echo  "SELECT \`ID_PKG\`"
echo  "     ,\`PKG_GENERAL\`"
echo  "      ,\`PKG_RELEASE\`"
echo  "      ,\`PKG_CORRECTIF\`"
echo  "      ,\`PKG_PATCH\`"
echo  "      ,\`${Base_Database_Default}_OM_IMPORT\`.\`keywords_root_path\`"
echo  "      ,\`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level1_PATH\`"
echo  "      ,\`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level2_PATH\`"
echo  "      ,\`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level3_PATH\`"
echo  "      ,\`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level4_PATH\`"
echo  "      ,\`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level5_PATH\`"
echo  "      ,\`${Base_Database_Default}_OM_IMPORT\`.\`keywords_level6_PATH\`"
echo  "      ,\`${Base_TABLE_Name}_${INTERNAL_PKG_NAME}\`.\`Keyword_Name\` AS \`Keyword_Name\`"
echo  "      ,\`${Base_Database_Default}_OM_IMPORT\`.\`Keyword_Value\`"
echo  "      ,\`${Base_Database_Default}_OM_IMPORT\`.\`stage\`"
echo  " FROM ( \`${Base_TABLE_Name}_${INTERNAL_PKG_NAME}\` LEFT JOIN \`${Base_Database_Default}_OM_IMPORT\`"
echo  "      ON ( \`${Base_Database_Default}_OM_IMPORT\`.\`Keyword_Name\` = \`${Base_TABLE_Name}_${INTERNAL_PKG_NAME}\`.\`Keyword_Name\` ))"
echo  "         WHERE  \`${Base_Database_Default}_OM_IMPORT\`.\`keywords_root_path\` = 'INFRA'"
}


function SQL_Run_ALL_PROCS_GEN_SUB
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
print "CALL \`PKG_proc_from_OM_ContentAdaptation\`( '${INTERNAL_GO}','${INTERNAL_RO}','${INTERNAL_CO}','${INTERNAL_PO}','${INTERNAL_PFNAME}','${INTERNAL_SERVER_NAME}','${INTERNAL_INST1}','${INTERNAL_INST2}','${INTERNAL_INST3}','${INTERNAL_STAGE}')"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function SQL_Run_ALL_PROCS
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

SQL_Run_ALL_PROCS_GEN_SUB1 > ${INTERNAL_IN_FILE}_RUN_PROCS.tmp
${Base_mysql_bin_proc_use} < ${INTERNAL_IN_FILE}_RUN_PROCS.tmp >> ${INTERNAL_OUT_FILE}_TUN_PROCS.tmp


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SQL_GET_ALL_INFO_FOR_PROCS
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

INTERNAL_IN_FILE_GET_ALL="${Base_Database_TempDir}/GET_ALL_tmp_in.sql"
INTERNAL_OUT_FILE_GET_ALL="${Base_Database_TempDir}/GET_ALL_outfile.file"
SQL_CMD="select * from \`ARPCOM_VIEW_PKG_FOR_PROC\` ;"

echo  "${SQL_CMD}" EXTERNAL_SQL_current_FIFO_file
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"  
