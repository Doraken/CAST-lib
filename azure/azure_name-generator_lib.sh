#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure naming tool from CAST 

# functions to generate and set azure ressource name by user with interface

# set app code
function get_app_code ()
{
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

