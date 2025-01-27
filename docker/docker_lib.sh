#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# INFO                                                             
# Subject : This library provides base functions to manage Docker

function get_docker_running_images() 
{
#|# Var to set  : None
#|# ${1}        : Optional - Filter by image name [e.g., "nginx"]
#|#
#|# Base usage  : get_docker_running_images [image_name]
#|#
#|# Description : This function lists all running Docker containers, optionally filtered by image name.
#|#
#|# Send Back   : List of running containers
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

docker ps --filter "ancestor=${1}" --format "{{.ID}}: {{.Image}}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function get_docker_images_stored() 
{
#|# Var to set  : None
#|# ${1}        : Optional - Filter by image name [e.g., "nginx"]
#|#
#|# Base usage  : get_docker_images_stored [image_name]
#|#
#|# Description : This function lists all Docker images stored locally, optionally filtered by image name.
#|#
#|# Send Back   : List of stored images
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

local _image_filter="${1}"


docker images --filter "reference=${_image_filter}" --format "{{.Repository}}:{{.Tag}}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_clear_docker_local_images_stored() 
{
#|# Var to set  : None
#|# ${1}        : Optional - Force removal (set to "force" to remove even if running)
#|#
#|# Base usage  : do_clear_docker_local_images_stored [force]
#|#
#|# Description : This function removes all Docker images stored locally. Use the "force" option to remove even if they are being used.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

local _force_flag="${1}"

if [[ "${_force_flag}" == "force" ]]; then
    docker rmi $(docker images -q) --force
else
    docker rmi $(docker images -q)
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_stop_image() 
{
#|# Var to set  : None
#|# ${1}        : Optional - Filter by image name [e.g., "nginx"]
#|#
#|# Base usage  : do_stop_all_images [image_name]
#|#
#|# Description : This function stops all running Docker containers, optionally filtered by image name.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

image_name="${1}"


docker stop $(docker ps --filter "ancestor=${image_name}" -q)

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"
