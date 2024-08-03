###############################################################################
# DateTime.lib                                                                #
# Creation Date : 28/12/2022                                                  #
# Support mail  : doraken@doraken.net                                         #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provide base element to manage Date and Time Fomatin # 
#           Vars                                                              #
###############################################################################
####
# INFO

GLB_USE_DATE="$(date +%Y_%m_%d-%HH_%MM)"
GLB_HORODATE="$(date +%Y_%m_%d-%HH_%MM)"
GLB_DATEDAY="$(date +%Y_%m_%d)"

function Get_horodate ()
{
    #|# Update GLB_HORODATE with the current date and time
    #|# Usage: 
    #|#   Get_horodate
    ############ STACK_TRACE_BUILDER #####################
    Function_Name="${FUNCNAME[0]}"
    Function_PATH="${Function_PATH}/${Function_Name}"
    ######################################################

    GLB_HORODATE="$(date +%Y_%m_%d-%H_%M)"

    ############### Stack_TRACE_BUILDER ################
    Function_PATH="$( dirname ${Function_PATH} )"
    ####################################################
}

function Get_dateDay()
{
    #|# Update GLB_DATEDAY with the current date and time
    #|# Usage: 
    #|#   Get_dateDay
    ############ STACK_TRACE_BUILDER #####################
    Function_Name="${FUNCNAME[0]}"
    Function_PATH="${Function_PATH}/${Function_Name}"
    ######################################################

    GLB_DATEDAY="$(date +%Y_%m_%d)"

    ############### Stack_TRACE_BUILDER ################
    Function_PATH="$( dirname ${Function_PATH} )"
    ####################################################
}

function Get_UseDate()
{
    #|# Update GLB_USE_DATE with the current date and time
    #|# Usage: 
    #|#   Get_UseDate
    ############ STACK_TRACE_BUILDER #####################
    Function_Name="${FUNCNAME[0]}"
    Function_PATH="${Function_PATH}/${Function_Name}"
    ######################################################

    GLB_USE_DATE="$(date +%Y_%m_%d-%H_%M)"

    ############### Stack_TRACE_BUILDER ################
    Function_PATH="$( dirname ${Function_PATH} )"
    ####################################################
}

LibState="OK"

