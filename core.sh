#!/bin/bash 
check_az_cli_run="0"
logfile="./default.log"


# show azure tenant configuration/infos
function show_configuration ()
{
    MSG_DISPLAY "info" "0"  " tenant : ${subscriptionId}                   "
    MSG_DISPLAY "info" "0"  " -------------------------------------------- " 
    MSG_DISPLAY "info" "0"  " ressource goupe : [ ${resourceGroup} ]       "
    MSG_DISPLAY "info" "0"  " location        : [ ${location} ]            "
    MSG_DISPLAY "info" "0"  " object name     : [ ${ObjectName} ]          " 
}


# just to give some space to read log and terminal
function show_spacer () 
{
    MSG_DISPLAY "info" "0"  " " 
    MSG_DISPLAY "info" "0"  " -------------------------------------------- "
    MSG_DISPLAY "info" "0"  " " 
}


# liste of all files in the repertory call in ../config/conf.cnf
function Do_source_all_libs ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "
  _local_lib_dir="${1}"
  for libs in $(find  ${_local_lib_dir} -type f -name "*_lib.sh" ) 
     do 
       MSG_DISPLAY "check" "0" "sourcing lib  ${libs} "
       . ${libs}
       if [[ ${LibState} = "OK" ]]
          then 
              echo " : [ SUCESS ] "
              LibState=""
          else 
              echo " : [ ERROR  ] "
              echo " must check ./log/default.log " 
              exit 1  
        fi 
done 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# set result checked success/error
function error_CTRL()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "
# manage besi error controle
local _result="${1}"
if [ ${_result} = "0" ]
   then 
       echo "Success" 
   else 
       echo "Error" 
       exit 2
fi 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# check if azure client is installed in environnement
function check_az_cli () 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "
    if ! command -v az &> /dev/null
        then
            echo "Azure CLI (az) could not be found, please install it."
            exit 2
    fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# check if az login is logged in/ logged out / error by check tenantId
function check_az_login () 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "
if [ ${check_az_cli_run} -gt 1 ]
   then 
       echo "error login on azure tenant"
       exit 2 
   else 
        local CurrentTenantId="$(az account show --query tenantId --output tsv | grep ${subscriptionId} )"
        if [ ${CurrentTenantId} = ${CurrentTenantId} ]
            then 
                echo "currently loged on tenant   : ${subscriptionId}"
            else 
                echo "you are not loged on tenant : ${subscriptionId}"
                check_az_cli_run=$(expr ${check_az_cli_run} + 1 )
                az login 
                check_az_login
        fi  
 fi 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# this function init a log file, his name and his name in any folder which call thi function
function init_log_fileName ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "
  # generating log file name and path
  logfile="./log/${resourceGroup}_${current_date}_${script_name}.log"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# read Description
function MSG_DISPLAY
{
#|# Var to set     :
#|# MD_Type_Msg       : Use this var to set
#|# MD_Level_Code     : Use this var to set
#|# MD_Msg_To_Display : Use this var to set
#|# ${1}     : Use this var to set [ MD_Type_Msg ]
#|# ${2}     : Use this var to set [ Level_Code ] 
#|# ${3}     : Use this var to set [ MD_Msg_To_Display ]
#|#
#|# Base usage  : MSG_DISPLAY "MD_Type_Msg" "Level_Code" "MD_Msg_To_Display" 
#|#
#|# Description : This function is used for every messaging and error service
#|#
#|# Send Back   : Message or exit level
###############################################################################
local MD_Type_Msg="${1}"
local MD_Level_Code="${2}"
local MD_Msg_To_Display="${3}"
Set_terminal_properties
Set_Message_Type_Display

case ${MD_Type_Msg} in
     check) printf "${GLB_PRINTCOL_2_NE}" "${MD_Msg_To_Display}"   "-->"
     ;;
     EdSMessage) FONT_set_Ok_Font
              if [ "${MD_Msg_To_Display}" == "" ]
                 then 
                   printf "[ SUCCESS ] " 
                 else 
                   printf "[ ${MD_Msg_To_Display} ] " 
              fi 
              FONT_set_Basic_Font
              printf " \n" 
     ;; 
     EdWMessage) FONT_set_Warn_Font
               if [ "${MD_Msg_To_Display}" == "" ]
                 then 
                   printf  "[ WARNING ] " 
                 else 
                   printf "[ ${MD_Msg_To_Display} ] " 
              fi 
              FONT_set_Basic_Font
              printf " \n" 
     ;;
     EdEMessage) FONT_set_Error_Font
               if [ "${MD_Msg_To_Display}" = "" ]
                 then 
                   printf  "[ FAILLED ]" 
                 else 
                   printf  "[ ${MD_Msg_To_Display} ]" 
              fi 
              FONT_set_Basic_Font
              printf " \n" 
              if [ ! ${MD_Level_Code} = 0 ]
                 then 
                     exit ${MD_Level_Code}
              fi
     ;;
     info) FONT_set_Basic_Font
           printf  "${MD_Msg_To_Display} \n "
     ;;
     debug) if [[ ${DEBUG_STATE} = "1"  ]]
               then 
                  printf  "${MD_Msg_To_Display}  \n"
            fi
     ;;
     *) FONT_set_Error_Font
       printf  " FATAL ERROR ON MGS FUNCTION USE         \n"
       printf  " FUNCTION     = [ ${Function_PATH} ]     \n"
       printf  " SUB FUNCTION = [ ${SUB_Function_Name} ] \n"
       printf  " Debug type   = [ ${MD_Type_Msg}  ]      \n"
       printf  " have a nice day .... :-p                \n"
     FONT_set_Basic_Font
     eval printf "\\\033\\[K"
     exit 2
     ;;
esac


FONT_set_Basic_Font
echo -n ""
}


# better count on Bot to make CSS than you ;)
function Set_terminal_properties () 
{
# Get the width of the terminal
terminal_width=$(tput cols)

# Calculate column widths based on the terminal width
# Adjust these percentages to suit your needs
col1_width=$(($terminal_width - 30 ))
col2_width=4
col3_width=26
col4_width=$(($terminal_width * 2 / 100))

col1_ne_width=$(($terminal_width - 30 ))
col2_ne_width=15

col1_1_ne_width=$(($terminal_width - 10 ))
col2_1_ne_width=10

# Set the format strings
GLB_PRINTCOL_4="%-${col1_width}s %-${col2_width}s %-${col3_width}s %-${col4_width}s\n"
GLB_PRINTCOL_2_NE="%-${col1_ne_width}s %-${col2_ne_width}s"
GLB_PRINTCOL_1_NE="%-${col1_1_ne_width}s %-${col2_1_ne_width}s\n"

# Example usage with printf
#printf "$GLB_PRINTCOL_4" "Column1" "Column2" "Column3" "Column4"
#printf "$GLB_PRINTCOL_2_NE" "Column1_NE" "Column2_NE"
#printf "$GLB_PRINTCOL_1_NE" "Column1_1_NE" "Column2_1_NE"
}


# "which CSS" ask the chatMaid-chan bot
function Set_Message_Type_Display
{
#|# Var to set     :
#|# MD_Type_Msg       : Use this var to set
#|# MD_Msg_To_Display : Use this var to set
#|# MD_Level_Code     : Use this var to set
#|# ${1}     : Use this var to set" "_Message_Type ]
#|#
#|# Base usage  : Set_Message_Type_Display "Message type"  
#|#
#|# Description : This function is used set display color for using type of message
#|#
#|# Send Back   : Console Colour  
###############################################################################
_Message_Type="${1}"
case ${_Message_Type} in 
       "info") FONT_set_info_Font
         ;;
      "debug") if [[ ${DEBUG_STATE} = "1"  ]]
                then
                  eval printf "\\\033\\[K"
              fi
         ;;
    "message") FONT_set_message_Font
         ;;
      "check") FONT_set_check_Font
         ;;
    "warning") FONT_set_warning_Font
         ;;
      "error") FONT_set_error_Font
         ;;
 "EdSMessage") FONT_set_Ok_Font
         ;; 
 "EdEMessage") FONT_set_error_Font
         ;;
         *) FONT_set_Message_Font
          ;;
esac
}


# part of css function, here font color
function FONT_get_Color
{
#|# Echoes the basic color attribute number given by color name
#|# $1 is the color name
#|#    it can be one of (black, red, green, yellow, blue, magenta, cyan, white)
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

COLOR_ATTR=""
case $1 in
    [Bb]lack) COLOR_ATTR=0 ;;
    [Rr]ed) COLOR_ATTR=1 ;;
    [Gg]reen) COLOR_ATTR=2 ;;
    [Yy]ellow) COLOR_ATTR=3 ;;
    [Bb]lue) COLOR_ATTR=4 ;;
    [Mm]agenta) COLOR_ATTR=5 ;;
    [Cc]yan) COLOR_ATTR=6 ;;
    [Ww]hite) COLOR_ATTR=7 ;;
    *) ;;
esac

echo "${COLOR_ATTR}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# part of css function, here font attribute
function FONT_set_Font
{
#|# Changes the font properties by attributes given
#|# $1 is the attribute to set to the font
#|#    it can be one of (default, bright, dim, underscore, blink, reverse, hidden, foreground, background)
#|#       default : to reset all font attributes to default values
#|#       bright : to enlight font
#|#       dim : to darken font
#|#       underscore : no comment
#|#       blink : depends on terminal
#|#       reverse : no comment
#|#       hidden : depends on terminal
#|#       foreground : to change foreground color
#|#              needs the second argument
#|#       background : to change background color
#|#              needs the second argument
#|# $2 is the attribute name for color setting
#|#    it is mandatory and used only if foreground or background is chosen in first argument
#|#    see function FONT_get_Color for details
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

FONT_ATTR=""
Type_Font_Def="${1}"
case ${Type_Font_Def} in
        default) FONT_ATTR="0"
              ;;
         bright) FONT_ATTR="1" 
              ;;
            dim) FONT_ATTR="2" 
              ;;
     underscore) FONT_ATTR="4" 
              ;;
          blink) FONT_ATTR="5" 
              ;;
        reverse) FONT_ATTR="7" 
              ;;
         hidden) FONT_ATTR="8" 
              ;;
     foreground) FONT_ATTR=$(( $( FONT_get_Color ${2} ) +30 ))
             ;;
     background) FONT_ATTR=$(( $( FONT_get_Color ${2} ) +40 )) 
              ;;
           *) 
              ;;
esac

printf "\033[%sm" "${FONT_ATTR}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# part of css function, here set properties
function FONT_display_Basic_Colors
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 
for BGC in black red green yellow blue magenta cyan white
do
    FONT_set_Font background ${BGC}
    for FGC in black red green yellow blue magenta cyan white
    do
     FONT_set_Font foreground ${FGC}
     printf " %s " ${FGC}
    done
    printf "\n"
done
FONT_set_Font default

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# part of css function, here set Basic Font properties 
function FONT_set_Basic_Font
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 
FONT_set_Font default
FONT_set_Font foreground White
FONT_set_Font background Black

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# part of css function, here set Error Font properties 
function FONT_set_Error_Font
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
 
FONT_set_Font default
FONT_set_Font bright
FONT_set_Font foreground White
FONT_set_Font background Red

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# part of css function, here set Warm Font properties 
function FONT_set_Warn_Font
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

FONT_set_Font default
FONT_set_Font foreground Black
FONT_set_Font background Yellow
FONT_set_Font blink

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function FONT_set_Message_Font
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

FONT_set_Font default
FONT_set_Font foreground Green
FONT_set_Font background Black
FONT_set_Font blink

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# part of css function, here set Ok Font properties 
function FONT_set_Ok_Font
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

FONT_set_Font default
FONT_set_Font bright
FONT_set_Font foreground White
FONT_set_Font background Green

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# part of css function, here set Info Font properties 
function FONT_set_Info_Font
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

FONT_set_Font default
FONT_set_Font bright
FONT_set_Font foreground Green
FONT_set_Font background Black

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# get "tag" of repertories in ../config/conf.cnf and sort
function init_directory ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
for directories in $(cat ../config/config.cnf | grep "###_ " | awk -F\= '{ print "${" $1 "}"  }' | sed -e 's/\ //g' | sort)   
  do 
    eval Create_Directory=${directories}
    Set_new_directory "${Create_Directory}" 
done 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# launch functions to set progression states of repertories and files installation with az and git
# call in set_paths in ../config/config.cnf 
function init_all () 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
    Set_terminal_properties
    #init catalogue files vars 
    Set_catalog_files
    
    #init_directory
    Get_system_tunning
    SANITY_CHECK_Base_env_directory_check
    SANITY_CHECK_tools
    SANITY_CHECK_Check_Language
    check_az_cli
    check_az_login
    show_configuration
    # generating log file name and path
    init_log_fileName
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Interleave_MSG
{
 echo  ""                                                                                  
 echo  "###############################################################################"
 echo  ""                                                                               
}

function Spacer_MSG
{
 echo  ""       
 echo  ""       
}



# Sourcing control variable 
CoreState="OK"
LibState="OK"