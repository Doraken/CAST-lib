#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure naming tool from CAST 

# functions to generate and set azure ressource name by user with interface

# set app code
function get_app_code ()
{
#|# Var to set  :
#|# CODE_APPLI      : Variable to store the application code
#|#
#|# Description : This function prompts the user to enter an application code.
#|# If the user does not provide any input, a default application code is used.
#|#
#|# Send Back   : CODE_APPLI
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
read -p "Entrez le code de l'application (par défaut: $CODE_APPLI): " user_code_appli
CODE_APPLI=${user_code_appli:-$CODE_APPLI}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# set env for coding
function gen_env_code ()
{
#|# Var to set  :
#|# ENVIRONMENTS  : Associative array containing environment codes
#|# ENV           : Variable to store the selected environment code
#|#
#|# Description : This function allows the user to select an environment from a predefined list.
#|# The selected environment code is stored in the ENV variable.
#|#
#|# Send Back   : ENV
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
    echo "Sélectionnez l'environnement: "
    select env in "${!ENVIRONMENTS[@]}"; do
        if [[ -n "$env" ]]
         then
            ENV=${ENVIRONMENTS[$env]}
            break
        else
            echo "Sélection invalide. Veuillez réessayer."
        fi
    done
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# set localisation
function get_localisation ()
{
#|# Var to set  :
#|# COUNTRIES     : Associative array containing deployment locations
#|# LOCALISATION  : Variable to store the selected deployment location
#|#
#|# Description : This function allows the user to select a deployment location
#|# from a predefined list. If the user does not make a selection, a default value
#|# of "France Central" (represented as "fc") is assigned.
#|#
#|# Send Back   : LOCALISATION
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
  echo "Select the deployment location (default: France Central): "
    select loc in "${!COUNTRIES[@]}"
     do
        if [[ -n "$loc" ]]; then
            LOCALISATION=${COUNTRIES[$loc]}
            break
        else
            echo "Invalid selection. Please try again."
        fi
    done
    LOCALISATION=${LOCALISATION:-fc}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# select azure object
function get_object_type ()
{
#|# Var to set  :
#|# AZURE_OBJECTS : Associative array containing Azure object types
#|# CATEGORIES    : Associative array containing categories of Azure objects
#|# BIGRAMME      : Variable to store the selected bigram
#|# CATEGORIE     : Variable to store the corresponding category
#|#
#|# Description : This function allows the user to select an Azure object type
#|# and stores the associated bigram and category.
#|#
#|# Send Back   : BIGRAMME, CATEGORIE
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
    echo "Sélectionnez le type d'objet Azure: "
    select obj in "${!AZURE_OBJECTS[@]}"
     do
        if [[ -n "$obj" ]]
         then
            BIGRAMME=${AZURE_OBJECTS[$obj]}
            CATEGORIE=${CATEGORIES[$obj]}
            break
        else
            echo "Sélection invalide. Veuillez réessayer."
        fi
    done
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# select index
function get_index()
{
#|# Var to set  :
#|# INDEX          : Variable to store the selected index
#|#
#|# Description : This function allows the user to select an index value from 01 to 10.
#|# If the user does not make a selection, a default value of "01" is assigned.
#|#
#|# Send Back   : INDEX
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
    echo "Select the index (default: 01): "
    select idx in {01..10}
     do
        if [[ -n "$idx" ]]
         then
            INDEX=$idx
            break
        else
            echo "Invalid selection. Please try again."
        fi
    done
    INDEX=${INDEX:-01}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# Fonction pour poser des questions et obtenir les entrées utilisateur
function ask_questions()
{
#|# Var to set  :
#|# None
#|#
#|# Description : This function orchestrates the sequence of user prompts to gather
#|# necessary information for setting up Azure resources. It calls multiple functions
#|# that each prompt the user for specific details, such as application code, environment,
#|# location, object type, and index.
#|#
#|# Send Back   : None (Relies on other functions to set global variables)
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
    get_app_code
    gen_env_code
    get_localisation
    get_object_type
    get_index
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

LibState="OK"

