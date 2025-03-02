###############################################################################
#  HTML.lib                                              Version : 1.1.2.2    #
#                                                                             #
# Creation Date : 08/12/2006                                                  #
# Team          : Only me after all                                                                     #
# Support mail  : doraken@doraken.net                                          #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provide base html generate runtime                   #
#                                                                             #
###############################################################################
####
# INFO


################### File system reports functions #############################

function HTML_Table_Head_Report_FS
{
#|# Var to set  :
#|# HTML_File_to_export       : Use this var to set name of the report file
#|# Server_Name_To_report     : Use this var to set name of server on which we report
#|#
#|# Base usage  : HTML_Table_Head_Report_FS "Html file to generate" "Server"
#|#
#|# Description : This fuction create Table header in HTML code for FS reporting
#|#
#|# Send Back   : HTML code
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

local HTML_File_to_export="${1}"
local Server_Name_To_report="${2}"
local HTML_Table_Head_Report_FS="${3}"

Empty_Var_Control "${HTML_File_to_export}"       "HTML_File_to_export"       "4"
Empty_Var_Control "${Server_Name_To_report}"     "Server_Name_To_report"     "4"
Empty_Var_Control "${HTML_Table_Head_Report_FS}" "HTML_Table_Head_Report_FS" "4"


echo  "<table style=\"text-align: left; width: 750px; border-width:1px;\" cellpadding=\"2\" cellspacing=\"2\">"         >> ${HTML_File_to_export}
echo  "<tbody>"                                                                                                         >> ${HTML_File_to_export}
echo  "<tr>"                                                                                                            >> ${HTML_File_to_export}
echo  "    <td width=\'450\'>Mount Point </td>"                                                                         >> ${HTML_File_to_export}
echo  "    <td >Status </td>"                                                                                           >> ${HTML_File_to_export}
echo  "    <td >Space used in percent</td>"                                                                             >> ${HTML_File_to_export}
echo  "    <td >Free space </td>"                                                                                       >> ${HTML_File_to_export}
echo  "    </td>"                                                                                                       >> ${HTML_File_to_export}
echo  "</tr>"                                                                                                           >> ${HTML_File_to_export}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function HTML_Table_Close_Report_FS
{
#|# Var to set  :
#|# HTML_File_to_export       : Use this var to set name of the report file
#|# Server_Name_To_report     : Use this var to set name of server on which we report
#|#
#|# Base usage  : HTML_Table_Close_Report_FS "Html file to generate" "Server"
#|#
#|# Description : This fuction create Table end in HTML code for FS reporting
#|#
#|# Send Back   : HTML code
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

HTML_File_to_export="${1}"

Empty_Var_Control "${HTML_File_to_export}"       "HTML_File_to_export"       "4"


echo  " </tbody>" >> ${HTML_File_to_export}
echo  "</table>"  >> ${HTML_File_to_export}
echo  "<br>"      >> ${HTML_File_to_export}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function HTML_Error_Html_Report_FS
{
#|# Var to set  :
#|# HTML_File_to_export  : Use this var to set name of the report file
#|#
#|# Base usage  : HTML_Error_Html_Report_FS "Html file to generate"
#|#
#|# Description : This fuction create Table end in HTML code for FS reporting
#|#
#|# Send Back   : HTML code
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

HTML_File_to_export="${1}"
Empty_Var_Control "${HTML_File_to_export}"       "HTML_File_to_export"       "4"

echo  "<tr> <td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 0, 0);\"> ${Device_Mnts_To_State} </td>"  >> ${HTML_File_to_export}
echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 0, 0);\"> ${State_Case} </td>"                 >> ${HTML_File_to_export}
echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 0, 0);\"> ${Device_perc_To_State} </td>"       >> ${HTML_File_to_export}
echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 0, 0);\"> ${Device_Free_To_State} </td></tr>"  >> ${HTML_File_to_export}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function HTML_Warn_Html_Report_FS
{
#|# Var to set  :
#|# HTML_File_to_export  : Use this var to set name of the report file
#|#
#|# Base usage  : HTML_Warn_Html_Report_FS "Html file to generate"
#|#
#|# Description : This fuction create Table end in HTML code for FS reporting
#|#
#|# Send Back   : HTML code
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

HTML_File_to_export="${1}"
Empty_Var_Control "${HTML_File_to_export}"       "HTML_File_to_export"       "4"

echo  "<tr> <td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 153, 0);\"> ${Device_Mnts_To_State} </td>"    >> ${HTML_File_to_export}
echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 153, 0);\"> ${State_Case} </td>"                   >> ${HTML_File_to_export}
echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 153, 0);\"> ${Device_perc_To_State} </td>"         >> ${HTML_File_to_export}
echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 153, 0);\"> ${Device_Free_To_State} </td></tr>"    >> ${HTML_File_to_export}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function HTML_Good_Html_Report_FS
{
#|# Var to set  :
#|# HTML_File_to_export  : Use this var to set name of the report file
#|# ${1}                 : Use this var to set [ HTML_File_to_export ]
#|#
#|# Base usage  : HTML_Good_Html_Report_FS "Html file to generate"
#|#
#|# Description : This fuction Table HTML code for Good state FS
#|#
#|# Send Back   : HTML code
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

HTML_File_to_export="${1}"
Empty_Var_Control "${HTML_File_to_export}"       "HTML_File_to_export"       "4"

echo  "<tr> <td style=\"vertical-align: top; color: rgb(0, 0, 0);\"> ${Device_Mnts_To_State} </td>"    >> ${HTML_File_to_export}
echo  "<td style=\"vertical-align: top; color: rgb(0, 0, 0);\"> ${State_Case} </td>"                   >> ${HTML_File_to_export}
echo  "<td style=\"vertical-align: top; color: rgb(0, 0, 0);\"> ${Device_perc_To_State} </td>"         >> ${HTML_File_to_export}
echo  "<td style=\"vertical-align: top; color: rgb(0, 0, 0);\"> ${Device_Free_To_State} </td> </tr>"   >> ${HTML_File_to_export}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

#################### generics HTML function

function HTML_Head_Report
{
#|# Var to set  :
#|# HTML_File_to_export  : Use this var to set name of the report file
#|#
#|# Base usage  : HTML_Good_Html_Report_FS "Html file to generate"
#|#
#|# Description : This fuction header HTML code for reports
#|#
#|# Send Back   : HTML code
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

HTML_File_to_export="${1}"
Empty_Var_Control "${HTML_File_to_export}"       "HTML_File_to_export"       "4"

echo  "<html>"                                                                                                              > ${HTML_File_to_export}
echo  "<head>"                                                                                                             >> ${HTML_File_to_export}
echo  "<Style type=\"text/css\"> td { border:thin dotted blue; font-weight: bold;} </style>"                               >> ${HTML_File_to_export}
echo  "<meta content=\"text/html; charset=ISO-8859-1\" http-equiv=\"content-type\">"                                       >> ${HTML_File_to_export}
echo  "<title></title>"                                                                                                    >> ${HTML_File_to_export}
echo  "</head>"                                                                                                            >> ${HTML_File_to_export}
echo  "<body>"                                                                                                             >> ${HTML_File_to_export}
echo  "Config and Deploy PF report ON ${CURENT_WORK_DIR} for server ${current_server} <br>"                                >> ${HTML_File_to_export}
echo  "<br>"                                                                                                               >> ${HTML_File_to_export}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}



function HTML_footer_report_gen
{
#|# Var to set  :
#|# HTML_File_to_export  : Use this var to set name of the report file
#|#
#|# Base usage  : HTML_footer_report_gen "Html file to generate"
#|#
#|# Description : This fuction footer HTML code for reports
#|#
#|# Send Back   : HTML code
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

HTML_File_to_export="${1}"
Empty_Var_Control "${HTML_File_to_export}"       "HTML_File_to_export"       "4"

echo  "</tbody>"    >> ${HTML_File_to_export}
echo  "</table>"    >> ${HTML_File_to_export}
echo  "<br>"        >> ${HTML_File_to_export}
echo  "</body>"     >> ${HTML_File_to_export}
echo  "</html>"     >> ${HTML_File_to_export}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function HTML_int_Menu_Generator_GEN
{
#|# Var to set  : None
#|# HIMGG_Base_Menu_Directory   : use this var to set chere to create the menu file
#|# HIMGG_INT_lst               : use this var to set the ints list
#|# ${1}                        : use this var to set HIMGG_Base_Menu_Directory
#|# ${2}                        : use this var to set HIMGG_INT_lst
#|#
#|# Base usage  : HTML_int_Menu_Generator_GEN "my_full_path" "int1 int2 intxxx"
#|#
#|# Description : This fuction create report menu
#|#
#|# Send Back   : HTML code
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

HIMGG_Base_Menu_Directory="${1}"
HIMGG_INT_lst="${2}"
 
Empty_Var_Control "${HIMGG_Base_Menu_Directory}" "HIMGG_Base_Menu_Directory" "4"


HTML_File_to_export="${HIMGG_Base_Menu_Directory}/index.html"

echo  "<html>"                                                                         >  ${HTML_File_to_export}
echo  "<head>"                                                                        >>  ${HTML_File_to_export}
echo  "<meta content=\"text/html; charset=ISO-8859-1\" http-equiv=\"content-type\">"  >>  ${HTML_File_to_export}
echo  "<title></title>"                                                               >>  ${HTML_File_to_export}
echo  "</head>"                                                                       >>  ${HTML_File_to_export}
echo  "<body>"                                                                        >>  ${HTML_File_to_export}
for ints in ${HIMGG_INT_lst}
   do
     echo  "<a href=\"${ints}/index.html\">${ints}</a><br>"                           >>  ${HTML_File_to_export}
done
echo  "</body>"                                                                       >>  ${HTML_File_to_export}
echo  "</html>"                                                                       >>  ${HTML_File_to_export}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function HTML_Internal_HTML_int_Menu_Generator_GEN
{
#|# Var to set  :
#|# HIHIMGG_Base_PATH_OF_FILES_INTS   : use this var to set chere to create the menu file
#|# HIMGG_INT_lst                     : use this var to set the ints list
#|# ${1}                              : use this var to set HIMGG_Base_Menu_Directory
#|# ${2}                              : use this var to set HIMGG_INT_lst
#|#
#|# Base usage  : HTML_Internal_HTML_int_Menu_Generator_GEN  "my_full_path" "int1 int2 intxxx"
#|#
#|# Description : This fuction create report menu
#|#
#|# Send Back   : HTML code
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

HIHIMGG_Base_PATH_OF_FILES_INTS="${1}"
HIHIMGG_INT_lst="${2}"

for HIHIMGG_ints in ${HIHIMGG_INT_lst}
    do
      HIHIMGG_HTML_File_to_export="${HIHIMGG_Base_PATH_OF_FILES_INTS}/${HIHIMGG_ints}/index.html"
      MSG_DISPLAY "debug" "0" "HTML File to export is set to : [ ${HIHIMGG_HTML_File_to_export} ] "

      echo  "<html>"                                                                         >  ${HIHIMGG_HTML_File_to_export}
      echo  "<head>"                                                                        >>  ${HIHIMGG_HTML_File_to_export}
      echo  "<meta content=\"text/html; charset=ISO-8859-1\" http-equiv=\"content-type\">"  >>  ${HIHIMGG_HTML_File_to_export}
      echo  "<title></title>"                                                               >>  ${HIHIMGG_HTML_File_to_export}
      echo  "</head>"                                                                       >>  ${HIHIMGG_HTML_File_to_export}
      echo  "<body>"                                                                        >>  ${HIHIMGG_HTML_File_to_export}
      for HIHIMGG_files in `ls ${HIHIMGG_Base_PATH_OF_FILES_INTS}/${HIHIMGG_ints}/ | egrep -v index `
          do
            HIHIMGG_File_Name_To_lnk=$( echo ${HIHIMGG_files} | awk -F\. '{ print $1 }' )
            echo  "<a href=\"./${HIHIMGG_files}\">${HIHIMGG_File_Name_To_lnk}</a><br>"      >>  ${HIHIMGG_HTML_File_to_export}
          done
      done
      echo  "</body>"                                                                       >>  ${HIHIMGG_HTML_File_to_export}
      echo  "</html>"                                                                       >>  ${HIHIMGG_HTML_File_to_export}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function HTML_Std_table_start
{
#|# Base_Menu_Directory   : use this var to set chere to create the menu file
#|# INT_lst               : use this var to set the ints list
#|# Base use              :
#|#                          Base_Menu_Directory="my_full_path"
#|#                          INT_lst="int1 int2 intxxx"
#|#                          HTML_int_Menu_Generator_GEN
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 


HTML_File_to_export="${Base_Menu_Directory}/index.html"

echo  "<html>"                                                                         >  ${HTML_File_to_export}
echo  "<head>"                                                                        >>  ${HTML_File_to_export}
echo  "<meta content=\"text/html; charset=ISO-8859-1\" http-equiv=\"content-type\">"  >>  ${HTML_File_to_export}
echo  "<title></title>"                                                               >>  ${HTML_File_to_export}
echo  "</head>"                                                                       >>  ${HTML_File_to_export}
echo  "<body>"                                                                        >>  ${HTML_File_to_export}
for ints in ${INT_lst}
   do
     echo  "<a href=\"${ints}/index.html\">${ints}</a><br>"                           >>  ${HTML_File_to_export}
done
echo  "</body>"                                                                       >>  ${HTML_File_to_export}
echo  "</html>"                                                                       >>  ${HTML_File_to_export}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function HTML_create_Frame
{
#|# Description : This fucnction create all needed frame for autodoc site

############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

HCF_Number_Frame="${1}"
HCF_Name_Frame="${2}"

HCF_NUM_From_Name="$(echo  ${HCF_Name_Frame} | awk '{ print NF }')"
if [ "${HCF_NUM_From_Name}"	= "${HCF_Name_Frame}" ]
   then
   	    MSG_DISPLAY "debug" "0" "Number of frame : [ ${HCF_Number_Frame} ]"
   	    HCF_Fnumb="1"
   	    for HCF_FName in
   	       do
   	       	  MSG_DISPLAY "debug" "0" "Name of frame number ${HCF_Fnumb} : [ ${HCF_Name_Frame} ] "
        done
   else
        MSG_DISPLAY "EdEMessage" "2" "Number of frame : [ ${HCF_Number_Frame} ] is not equal to : [ ${HCF_NUM_From_Name} ] "
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}



# Sourcing control variable 
LibState="OK"