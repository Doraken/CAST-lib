#!/bin/bash
# author : David Cheong
# Date : 06/08/2024
# generic azure devops tool from CAST 


function az_networknsg() 
{
#|#  Nom de la fonction    : az_networknsg
#|#  Description           : Gère les groupes de sécurité réseau Azure.
#|#  Utilisation           : az_networknsg "commande"
#|#  Paramètres:
#|#      $1               : Commande à exécuter avec `az network nsg`
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

# Afficher la trace de la pile d'exécution de la fonction
MSG_DISPLAY "debug" "0" "Chemin de la fonction actuelle : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Définir une variable locale pour la commande
local _COMMAND="${1}"

# Vérifier que le paramètre commande n'est pas vide
Empty_Var_Control "${_COMMAND}" "_COMMAND" "4"

# Enregistrer et exécuter la commande az network nsg
MSG_DISPLAY "check" "0" "Exécution de la commande : az network nsg ${_COMMAND}"
az network nsg "${_COMMAND}" &>> "${log_file}"

# Vérification du résultat et gestion des erreurs
CTRL_Result_func "${?}" "Exécution de la commande NSG" "Échec de l'exécution : az network nsg ${_COMMAND}" "1"

# Fournir un retour final en fonction du résultat de l'exécution
if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "La commande az network nsg ${_COMMAND} a été exécutée avec succès."
else
    MSG_DISPLAY "error" "1" "Erreur lors de l'exécution de la commande az network nsg ${_COMMAND}."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_create() 
{
#|#  Nom de la fonction    : az_networknsg_create
#|#  Description           : Crée un groupe de sécurité réseau.
#|#  Paramètres:
#|#      --name            : Le nom du NSG.
#|#      --resource-group   : Le nom du groupe de ressources.
#|#      --location         : La localisation.
#|#      --tags             : Les tags associés au NSG.
#|#      --subscription     : L'ID de l'abonnement.
#|#  Utilisation           : az_networknsg_create --name "NSGName" --resource-group "ResourceGroupName" --location "Location" --tags "Tags" --subscription "SubscriptionID"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _NAME="${1}"
local _RESOURCE_GROUP="${2}"
local _LOCATION="${3}"
local _TAGS="${4}"
local _SUBSCRIPTION="${5}"

Empty_Var_Control "${_NAME}" "_NAME" "4"
Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "4"
Empty_Var_Control "${_LOCATION}" "_LOCATION" "4"
Empty_Var_Control "${_TAGS}" "_TAGS" "4"
Empty_Var_Control "${_SUBSCRIPTION}" "_SUBSCRIPTION" "4"

# Vérification et création du NSG
MSG_DISPLAY "check" "0" "Création du Network Security Group '${_NAME}' dans le groupe de ressources '${_RESOURCE_GROUP}'"
az network nsg create \
    --name "${_NAME}" \
    --resource-group "${_RESOURCE_GROUP}" \
    --location "${_LOCATION}" \
    --tags "${_TAGS}" \
    --subscription "${_SUBSCRIPTION}" &>> "${log_file}"
CTRL_Result_func "${?}" "Création du NSG" "Échec lors de la création du NSG '${_NAME}' dans le groupe de ressources '${_RESOURCE_GROUP}'" "1"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Network Security Group '${_NAME}' créé avec succès dans le groupe de ressources '${_RESOURCE_GROUP}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la création du Network Security Group '${_NAME}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_delete() 
{
#|#  Nom de la fonction    : az_networknsg_delete
#|#  Description           : Supprime un groupe de sécurité réseau.
#|#  Paramètres:
#|#      --name            : Le nom du NSG.
#|#      --resource-group   : Le nom du groupe de ressources.
#|#      --subscription     : L'ID de l'abonnement.
#|#  Utilisation           : az_networknsg_delete --name "NSGName" --resource-group "ResourceGroupName" --subscription "SubscriptionID"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _NAME="${1}"
local _RESOURCE_GROUP="${2}"
local _SUBSCRIPTION="${3}"

Empty_Var_Control "${_NAME}" "_NAME" "4"
Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "4"
Empty_Var_Control "${_SUBSCRIPTION}" "_SUBSCRIPTION" "4"

# Vérification et suppression du NSG
MSG_DISPLAY "check" "0" "Suppression du Network Security Group '${_NAME}' dans le groupe de ressources '${_RESOURCE_GROUP}'"
az network nsg delete \
    --name "${_NAME}" \
    --resource-group "${_RESOURCE_GROUP}" \
    --subscription "${_SUBSCRIPTION}" &>> "${log_file}"
CTRL_Result_func "${?}" "Suppression du NSG" "Échec lors de la suppression du NSG '${_NAME}' dans le groupe de ressources '${_RESOURCE_GROUP}'" "1"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Network Security Group '${_NAME}' supprimé avec succès du groupe de ressources '${_RESOURCE_GROUP}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la suppression du Network Security Group '${_NAME}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_list() 
{
#|#  Nom de la fonction    : az_networknsg_list
#|#  Description           : Liste les groupes de sécurité réseau.
#|#  Paramètres:
#|#      --resource-group   : Le nom du groupe de ressources.
#|#      --subscription     : L'ID de l'abonnement.
#|#  Utilisation           : az_networknsg_list --resource-group "ResourceGroupName" --subscription "SubscriptionID"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _RESOURCE_GROUP="${1}"
local _SUBSCRIPTION="${2}"

Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "4"
Empty_Var_Control "${_SUBSCRIPTION}" "_SUBSCRIPTION" "4"

# Vérification et affichage de la liste des NSGs
MSG_DISPLAY "check" "0" "Liste des Network Security Groups dans le groupe de ressources '${_RESOURCE_GROUP}'"
az network nsg list \
    --resource-group "${_RESOURCE_GROUP}" \
    --subscription "${_SUBSCRIPTION}" -o table &>> "${log_file}"
CTRL_Result_func "${?}" "Listing des NSGs" "Échec lors du listing des NSGs dans le groupe de ressources '${_RESOURCE_GROUP}'" "0"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Liste des Network Security Groups dans le groupe de ressources '${_RESOURCE_GROUP}' affichée avec succès."
else
    MSG_DISPLAY "error" "1" "Erreur lors de l'affichage des Network Security Groups dans le groupe de ressources '${_RESOURCE_GROUP}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_show() 
{
#|#  Nom de la fonction    : az_networknsg_show
#|#  Description           : Affiche les détails d'un groupe de sécurité réseau.
#|#  Paramètres:
#|#      --name            : Le nom du NSG.
#|#      --resource-group   : Le nom du groupe de ressources.
#|#      --subscription     : L'ID de l'abonnement.
#|#  Utilisation           : az_networknsg_show --name "NSGName" --resource-group "ResourceGroupName" --subscription "SubscriptionID"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _NAME="${1}"
local _RESOURCE_GROUP="${2}"
local _SUBSCRIPTION="${3}"

Empty_Var_Control "${_NAME}" "_NAME" "4"
Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "4"
Empty_Var_Control "${_SUBSCRIPTION}" "_SUBSCRIPTION" "4"

# Vérification et affichage des détails du NSG
MSG_DISPLAY "check" "0" "Affichage des détails du Network Security Group '${_NAME}' dans le groupe de ressources '${_RESOURCE_GROUP}'"
az network nsg show \
    --name "${_NAME}" \
    --resource-group "${_RESOURCE_GROUP}" \
    --subscription "${_SUBSCRIPTION}" -o table &>> "${log_file}"
CTRL_Result_func "${?}" "Affichage des détails du NSG" "Échec lors de l'affichage des détails du NSG '${_NAME}'" "0"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Détails du Network Security Group '${_NAME}' affichés avec succès."
else
    MSG_DISPLAY "error" "1" "Erreur lors de l'affichage des détails du Network Security Group '${_NAME}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_update() 
{
#|#  Nom de la fonction    : az_networknsg_update
#|#  Description           : Met à jour un groupe de sécurité réseau.
#|#  Paramètres:
#|#      --name            : Le nom du NSG.
#|#      --resource-group   : Le nom du groupe de ressources.
#|#      --tags             : Les tags associés au NSG.
#|#      --subscription     : L'ID de l'abonnement.
#|#      --set              : Les valeurs à définir.
#|#      --add              : Les valeurs à ajouter.
#|#      --remove           : Les valeurs à retirer.
#|#      --force-string     : Forcer les valeurs de chaîne.
#|#  Utilisation           : az_networknsg_update --name "NSGName" --resource-group "ResourceGroupName" --tags "Tags" --subscription "SubscriptionID" --set "SetValues" --add "AddValues" --remove "RemoveValues" --force-string
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _NAME="${1}"
local _RESOURCE_GROUP="${2}"
local _TAGS="${3}"
local _SUBSCRIPTION="${4}"
local _SET="${5}"
local _ADD="${6}"
local _REMOVE="${7}"
local _FORCE_STRING="${8}"

Empty_Var_Control "${_NAME}" "_NAME" "4"
Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "4"
Empty_Var_Control "${_TAGS}" "_TAGS" "4"
Empty_Var_Control "${_SUBSCRIPTION}" "_SUBSCRIPTION" "4"
Empty_Var_Control "${_SET}" "_SET" "4"
Empty_Var_Control "${_ADD}" "_ADD" "4"
Empty_Var_Control "${_REMOVE}" "_REMOVE" "4"
Empty_Var_Control "${_FORCE_STRING}" "_FORCE_STRING" "4"

# Vérification et mise à jour du NSG
MSG_DISPLAY "check" "0" "Mise à jour du Network Security Group '${_NAME}' dans le groupe de ressources '${_RESOURCE_GROUP}'"
az network nsg update \
    --name "${_NAME}" \
    --resource-group "${_RESOURCE_GROUP}" \
    --tags "${_TAGS}" \
    --subscription "${_SUBSCRIPTION}" \
    --set "${_SET}" \
    --add "${_ADD}" \
    --remove "${_REMOVE}" \
    --force-string "${_FORCE_STRING}" &>> "${log_file}"
CTRL_Result_func "${?}" "Mise à jour du NSG" "Échec lors de la mise à jour du NSG '${_NAME}' dans le groupe de ressources '${_RESOURCE_GROUP}'" "1"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Network Security Group '${_NAME}' mis à jour avec succès dans le groupe de ressources '${_RESOURCE_GROUP}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la mise à jour du Network Security Group '${_NAME}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_rule() 
{
#|#  Nom de la fonction    : az_networknsg_rule
#|#  Description           : Gère les règles du groupe de sécurité réseau Azure.
#|#  Utilisation           : az_networknsg_rule [commande]
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _COMMAND="${1}"

Empty_Var_Control "${_COMMAND}" "_COMMAND" "4"

# Vérification et exécution de la commande NSG rule
MSG_DISPLAY "check" "0" "Exécution de la commande az network nsg rule ${_COMMAND}"
az network nsg rule "${_COMMAND}" &>> "${log_file}"
CTRL_Result_func "${?}" "Exécution de la commande NSG rule" "Échec lors de l'exécution de la commande az network nsg rule ${_COMMAND}" "1"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "La commande az network nsg rule ${_COMMAND} a été exécutée avec succès."
else
    MSG_DISPLAY "error" "1" "Erreur lors de l'exécution de la commande az network nsg rule ${_COMMAND}."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_rule_create() 
{
#|#  Nom de la fonction    : az_networknsg_rule_create
#|#  Description           : Crée une règle de groupe de sécurité réseau.
#|#  Paramètres:
#|#      --nsg-name                : Le nom du NSG.
#|#      --resource-group           : Le nom du groupe de ressources.
#|#      --name                     : Le nom de la règle.
#|#      --access                   : Le type d'accès (Allow/Deny).
#|#      --direction                : La direction de la règle (Inbound/Outbound).
#|#      --priority                 : La priorité de la règle.
#|#      --protocol                 : Le type de protocole.
#|#      --source-address-prefixes   : Les préfixes d'adresses source.
#|#      --source-port-ranges        : Les plages de ports source.
#|#      --destination-address-prefixes : Les préfixes d'adresses de destination.
#|#      --destination-port-ranges   : Les plages de ports de destination.
#|#      --description              : La description de la règle.
#|#      --subscription             : L'ID de l'abonnement.
#|#  Utilisation           : az_networknsg_rule_create --nsg-name "NSGName" --resource-group "ResourceGroupName" --name "RuleName" --access "AccessType" --direction "Direction" --priority "Priority" --protocol "Protocol" --source-address-prefixes "SourcePrefixes" --source-port-ranges "SourcePorts" --destination-address-prefixes "DestinationPrefixes" --destination-port-ranges "DestinationPorts" --description "Description" --subscription "SubscriptionID"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _NSG_NAME="${1}"
local _RESOURCE_GROUP="${2}"
local _RULE_NAME="${3}"
local _ACCESS="${4}"
local _DIRECTION="${5}"
local _PRIORITY="${6}"
local _PROTOCOL="${7}"
local _SOURCE_PREFIXES="${8}"
local _SOURCE_PORTS="${9}"
local _DESTINATION_PREFIXES="${10}"
local _DESTINATION_PORTS="${11}"
local _DESCRIPTION="${12}"
local _SUBSCRIPTION="${13}"

Empty_Var_Control "${_NSG_NAME}" "_NSG_NAME" "4"
Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "4"
Empty_Var_Control "${_RULE_NAME}" "_RULE_NAME" "4"
Empty_Var_Control "${_ACCESS}" "_ACCESS" "4"
Empty_Var_Control "${_DIRECTION}" "_DIRECTION" "4"
Empty_Var_Control "${_PRIORITY}" "_PRIORITY" "4"
Empty_Var_Control "${_PROTOCOL}" "_PROTOCOL" "4"
Empty_Var_Control "${_SOURCE_PREFIXES}" "_SOURCE_PREFIXES" "4"
Empty_Var_Control "${_SOURCE_PORTS}" "_SOURCE_PORTS" "4"
Empty_Var_Control "${_DESTINATION_PREFIXES}" "_DESTINATION_PREFIXES" "4"
Empty_Var_Control "${_DESTINATION_PORTS}" "_DESTINATION_PORTS" "4"
Empty_Var_Control "${_DESCRIPTION}" "_DESCRIPTION" "4"
Empty_Var_Control "${_SUBSCRIPTION}" "_SUBSCRIPTION" "4"

# Vérification et création de la règle NSG
MSG_DISPLAY "check" "0" "Création de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}' du groupe de ressources '${_RESOURCE_GROUP}'"
az network nsg rule create \
    --nsg-name "${_NSG_NAME}" \
    --resource-group "${_RESOURCE_GROUP}" \
    --name "${_RULE_NAME}" \
    --access "${_ACCESS}" \
    --direction "${_DIRECTION}" \
    --priority "${_PRIORITY}" \
    --protocol "${_PROTOCOL}" \
    --source-address-prefixes "${_SOURCE_PREFIXES}" \
    --source-port-ranges "${_SOURCE_PORTS}" \
    --destination-address-prefixes "${_DESTINATION_PREFIXES}" \
    --destination-port-ranges "${_DESTINATION_PORTS}" \
    --description "${_DESCRIPTION}" \
    --subscription "${_SUBSCRIPTION}" &>> "${log_file}"
CTRL_Result_func "${?}" "Création de la règle NSG" "Échec lors de la création de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}'" "1"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Règle '${_RULE_NAME}' créée avec succès dans le NSG '${_NSG_NAME}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la création de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_rule_delete() 
{
#|#  Nom de la fonction    : az_networknsg_rule_delete
#|#  Description           : Supprime une règle du groupe de sécurité réseau.
#|#  Paramètres:
#|#      --name            : Le nom de la règle.
#|#      --nsg-name        : Le nom du NSG.
#|#      --resource-group   : Le nom du groupe de ressources.
#|#      --subscription     : L'ID de l'abonnement.
#|#  Utilisation           : az_networknsg_rule_delete --name "RuleName" --nsg-name "NSGName" --resource-group "ResourceGroupName" --subscription "SubscriptionID"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _RULE_NAME="${1}"
local _NSG_NAME="${2}"
local _RESOURCE_GROUP="${3}"
local _SUBSCRIPTION="${4}"

Empty_Var_Control "${_RULE_NAME}" "_RULE_NAME" "4"
Empty_Var_Control "${_NSG_NAME}" "_NSG_NAME" "4"
Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "4"
Empty_Var_Control "${_SUBSCRIPTION}" "_SUBSCRIPTION" "4"

# Vérification et suppression de la règle NSG
MSG_DISPLAY "check" "0" "Suppression de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}' du groupe de ressources '${_RESOURCE_GROUP}'"
az network nsg rule delete \
    --name "${_RULE_NAME}" \
    --nsg-name "${_NSG_NAME}" \
    --resource-group "${_RESOURCE_GROUP}" \
    --subscription "${_SUBSCRIPTION}" &>> "${log_file}"
CTRL_Result_func "${?}" "Suppression de la règle NSG" "Échec lors de la suppression de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}'" "1"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Règle '${_RULE_NAME}' supprimée avec succès du NSG '${_NSG_NAME}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la suppression de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_rule_list() 
{
#|#  Nom de la fonction    : az_networknsg_rule_list
#|#  Description           : Liste les règles d'un groupe de sécurité réseau.
#|#  Paramètres:
#|#      --nsg-name        : Le nom du NSG.
#|#      --resource-group   : Le nom du groupe de ressources.
#|#      --subscription     : L'ID de l'abonnement.
#|#  Utilisation           : az_networknsg_rule_list --nsg-name "NSGName" --resource-group "ResourceGroupName" --subscription "SubscriptionID"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _NSG_NAME="${1}"
local _RESOURCE_GROUP="${2}"
local _SUBSCRIPTION="${3}"

Empty_Var_Control "${_NSG_NAME}" "_NSG_NAME" "4"
Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "4"
Empty_Var_Control "${_SUBSCRIPTION}" "_SUBSCRIPTION" "4"

# Vérification et affichage de la liste des règles du NSG
MSG_DISPLAY "check" "0" "Affichage de la liste des règles dans le NSG '${_NSG_NAME}' du groupe de ressources '${_RESOURCE_GROUP}'"
az network nsg rule list \
    --nsg-name "${_NSG_NAME}" \
    --resource-group "${_RESOURCE_GROUP}" \
    --subscription "${_SUBSCRIPTION}" -o table &>> "${log_file}"
CTRL_Result_func "${?}" "Listing des règles NSG" "Échec lors de l'affichage des règles dans le NSG '${_NSG_NAME}'" "0"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Liste des règles du NSG '${_NSG_NAME}' affichée avec succès."
else
    MSG_DISPLAY "error" "1" "Erreur lors de l'affichage des règles du NSG '${_NSG_NAME}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_rule_show() 
{
#|#  Nom de la fonction    : az_networknsg_rule_show
#|#  Description           : Affiche les détails d'une règle d'un groupe de sécurité réseau.
#|#  Paramètres:
#|#      --name            : Le nom de la règle.
#|#      --nsg-name        : Le nom du NSG.
#|#      --resource-group   : Le nom du groupe de ressources.
#|#      --subscription     : L'ID de l'abonnement.
#|#  Utilisation           : az_networknsg_rule_show --name "RuleName" --nsg-name "NSGName" --resource-group "ResourceGroupName" --subscription "SubscriptionID"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _RULE_NAME="${1}"
local _NSG_NAME="${2}"
local _RESOURCE_GROUP="${3}"
local _SUBSCRIPTION="${4}"

Empty_Var_Control "${_RULE_NAME}" "_RULE_NAME" "4"
Empty_Var_Control "${_NSG_NAME}" "_NSG_NAME" "4"
Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "4"
Empty_Var_Control "${_SUBSCRIPTION}" "_SUBSCRIPTION" "4"

# Vérification et affichage des détails de la règle NSG
MSG_DISPLAY "check" "0" "Affichage des détails de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}' du groupe de ressources '${_RESOURCE_GROUP}'"
az network nsg rule show \
    --name "${_RULE_NAME}" \
    --nsg-name "${_NSG_NAME}" \
    --resource-group "${_RESOURCE_GROUP}" \
    --subscription "${_SUBSCRIPTION}" -o table &>> "${log_file}"
CTRL_Result_func "${?}" "Affichage des détails de la règle NSG" "Échec lors de l'affichage des détails de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}'" "0"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Détails de la règle '${_RULE_NAME}' affichés avec succès dans le NSG '${_NSG_NAME}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de l'affichage des détails de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function az_networknsg_rule_update() 
{
#|#  Nom de la fonction    : az_networknsg_rule_update
#|#  Description           : Met à jour une règle d'un groupe de sécurité réseau.
#|#  Paramètres:
#|#      --name                     : Le nom de la règle.
#|#      --nsg-name                 : Le nom du NSG.
#|#      --resource-group            : Le nom du groupe de ressources.
#|#      --access                   : Le type d'accès (Allow/Deny).
#|#      --description              : La description de la règle.
#|#      --direction                : La direction de la règle (Inbound/Outbound).
#|#      --priority                 : La priorité de la règle.
#|#      --protocol                 : Le type de protocole.
#|#      --source-address-prefixes   : Les préfixes d'adresses source.
#|#      --source-port-ranges        : Les plages de ports source.
#|#      --destination-address-prefixes : Les préfixes d'adresses de destination.
#|#      --destination-port-ranges   : Les plages de ports de destination.
#|#      --subscription              : L'ID de l'abonnement.
#|#      --set                      : Les valeurs à définir.
#|#      --add                      : Les valeurs à ajouter.
#|#      --remove                   : Les valeurs à retirer.
#|#      --force-string             : Forcer les valeurs de chaîne.
#|#  Utilisation           : az_networknsg_rule_update --name "RuleName" --nsg-name "NSGName" --resource-group "ResourceGroupName" --access "AccessType" --description "Description" --direction "Direction" --priority "Priority" --protocol "Protocol" --source-address-prefixes "SourcePrefixes" --source-port-ranges "SourcePorts" --destination-address-prefixes "DestinationPrefixes" --destination-port-ranges "DestinationPorts" --subscription "SubscriptionID" --set "SetValues" --add "AddValues" --remove "RemoveValues" --force-string
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

local _RULE_NAME="${1}"
local _NSG_NAME="${2}"
local _RESOURCE_GROUP="${3}"
local _ACCESS="${4}"
local _DESCRIPTION="${5}"
local _DIRECTION="${6}"
local _PRIORITY="${7}"
local _PROTOCOL="${8}"
local _SOURCE_PREFIXES="${9}"
local _SOURCE_PORTS="${10}"
local _DESTINATION_PREFIXES="${11}"
local _DESTINATION_PORTS="${12}"
local _SUBSCRIPTION="${13}"
local _SET="${14}"
local _ADD="${15}"
local _REMOVE="${16}"
local _FORCE_STRING="${17}"

Empty_Var_Control "${_RULE_NAME}" "_RULE_NAME" "4"
Empty_Var_Control "${_NSG_NAME}" "_NSG_NAME" "4"
Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "4"
Empty_Var_Control "${_ACCESS}" "_ACCESS" "4"
Empty_Var_Control "${_DESCRIPTION}" "_DESCRIPTION" "4"
Empty_Var_Control "${_DIRECTION}" "_DIRECTION" "4"
Empty_Var_Control "${_PRIORITY}" "_PRIORITY" "4"
Empty_Var_Control "${_PROTOCOL}" "_PROTOCOL" "4"
Empty_Var_Control "${_SOURCE_PREFIXES}" "_SOURCE_PREFIXES" "4"
Empty_Var_Control "${_SOURCE_PORTS}" "_SOURCE_PORTS" "4"
Empty_Var_Control "${_DESTINATION_PREFIXES}" "_DESTINATION_PREFIXES" "4"
Empty_Var_Control "${_DESTINATION_PORTS}" "_DESTINATION_PORTS" "4"
Empty_Var_Control "${_SUBSCRIPTION}" "_SUBSCRIPTION" "4"
Empty_Var_Control "${_SET}" "_SET" "4"
Empty_Var_Control "${_ADD}" "_ADD" "4"
Empty_Var_Control "${_REMOVE}" "_REMOVE" "4"
Empty_Var_Control "${_FORCE_STRING}" "_FORCE_STRING" "4"

# Vérification et mise à jour de la règle NSG
MSG_DISPLAY "check" "0" "Mise à jour de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}' du groupe de ressources '${_RESOURCE_GROUP}'"
az network nsg rule update \
    --name "${_RULE_NAME}" \
    --nsg-name "${_NSG_NAME}" \
    --resource-group "${_RESOURCE_GROUP}" \
    --access "${_ACCESS}" \
    --description "${_DESCRIPTION}" \
    --direction "${_DIRECTION}" \
    --priority "${_PRIORITY}" \
    --protocol "${_PROTOCOL}" \
    --source-address-prefixes "${_SOURCE_PREFIXES}" \
    --source-port-ranges "${_SOURCE_PORTS}" \
    --destination-address-prefixes "${_DESTINATION_PREFIXES}" \
    --destination-port-ranges "${_DESTINATION_PORTS}" \
    --subscription "${_SUBSCRIPTION}" \
    --set "${_SET}" \
    --add "${_ADD}" \
    --remove "${_REMOVE}" \
    --force-string "${_FORCE_STRING}" &>> "${log_file}"
CTRL_Result_func "${?}" "Mise à jour de la règle NSG" "Échec lors de la mise à jour de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}'" "1"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Règle '${_RULE_NAME}' mise à jour avec succès dans le NSG '${_NSG_NAME}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la mise à jour de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

#########################################################################################################

# Function to check if a network security group exists
function check_nsg_exists() 
{
#|#  Nom de la fonction    : check_nsg_exists
#|#  Description           : Vérifie si un Network Security Group (NSG) existe dans un groupe de ressources.
#|#  Paramètres:
#|#      _resource_group    : Nom du groupe de ressources (obligatoire).
#|#      _nsg_name          : Nom du Network Security Group (NSG) à vérifier (obligatoire).
#|#  Utilisation           : check_nsg_exists "resource_group" "nsg_name"
#|#  Retour                : Affiche un message indiquant si le NSG existe ou non.
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _resource_group="${1}"
local _nsg_name="${2}"

# Contrôle des variables vides
Empty_Var_Control "${_resource_group}" "_resource_group" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_nsg_name}" "_nsg_name" "2" "Le nom du Network Security Group (NSG) est requis."

# Vérification de l'existence du NSG
MSG_DISPLAY "check" "0" "Vérification de l'existence du NSG '${_nsg_name}' dans le groupe de ressources '${_resource_group}'"
az network nsg list --resource-group "${_resource_group}" --query "[].name" -o tsv | grep -q "^${_nsg_name}$"
CTRL_Result_func "${?}" "Vérification de l'existence du NSG" "Échec lors de la vérification de l'existence du NSG" "0"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Le Network Security Group '${_nsg_name}' existe dans le groupe de ressources '${_resource_group}'."
else
    MSG_DISPLAY "info" "0" "Le Network Security Group '${_nsg_name}' n'existe pas dans le groupe de ressources '${_resource_group}'."
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Function to list all network security groups in a subscription or resource group
function list_nsgs() 
{
#|#  Nom de la fonction    : list_nsgs
#|#  Description           : Liste tous les Network Security Groups (NSGs) dans l'abonnement, ou dans un groupe de ressources spécifié.
#|#  Paramètres:
#|#      _resource_group    : Nom du groupe de ressources pour lister les NSGs (facultatif).
#|#  Utilisation           : list_nsgs "resource_group"
#|#  Retour                : Affiche une liste des NSGs dans un format tabulaire.
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _resource_group="${1}"

# Vérification et affichage des NSGs en fonction du groupe de ressources spécifié ou de l'abonnement
if [[ -z "${_resource_group}" ]]; then
    # Liste tous les NSGs dans l'abonnement
    MSG_DISPLAY "info" "0" "Listing all Network Security Groups in the subscription:"
    az network nsg list --query "[].{Name:name, ResourceGroup:resourceGroup}" -o table
    CTRL_Result_func "${?}" "Listing NSGs in the subscription" "Échec lors de la liste des NSGs dans l'abonnement" "0"
else
    # Liste tous les NSGs dans le groupe de ressources spécifié
    MSG_DISPLAY "info" "0" "Listing all Network Security Groups in resource group '${_resource_group}':"
    az network nsg list --resource-group "${_resource_group}" --query "[].{Name:name, ResourceGroup:resourceGroup}" -o table
    CTRL_Result_func "${?}" "Listing NSGs in resource group '${_resource_group}'" "Échec lors de la liste des NSGs dans le groupe de ressources '${_resource_group}'" "0"
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Example usage
_RESOURCE_GROUP="myResourceGroup"
_NSG_NAME="myNetworkSecurityGroup"

# Check if the NSG exists
check_nsg_exists $_RESOURCE_GROUP $_NSG_NAME

# List all NSGs in the subscription
list_nsgs

# List all NSGs in a specific resource group
list_nsgs $_RESOURCE_GROUP


# function create_networksecurity_group ()
# {
# ############ STACK_TRACE_BUILDER #####################
# Function_Name="${FUNCNAME[0]}"
# Function_PATH="${Function_PATH}/${Function_Name}"
# ######################################################

# # TODO call a function to check connection to az
# # az login 

# # Create a resource group
# az group create --name $_RESOURCE_GROUP --location $LOCATION

# # Create a virtual network and a subnet
# az network vnet create --resource-group $_RESOURCE_GROUP --name $VNET_NAME --address-prefix 10.0.0.0/16 --subnet-name $SUBNET_NAME --subnet-prefix 10.0.0.0/24

# # Create a network security group
# az network nsg create --resource-group $_RESOURCE_GROUP --name $_NSG_NAME --location $LOCATION

# # Create a network security group rule
# az network nsg rule create --resource-group $_RESOURCE_GROUP --nsg-name $_NSG_NAME --name $RULE_NAME --priority 1000 --direction Inbound --access Allow --protocol Tcp --source-address-prefixes '*' --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges 22

# # Create a network interface
# az network nic create --resource-group $_RESOURCE_GROUP --name $_NIC_NAME --vnet-name $VNET_NAME --subnet $SUBNET_NAME --network-security-group $_NSG_NAME

# # Associate the network security group with the subnet
# az network vnet subnet update --vnet-name $VNET_NAME --name $SUBNET_NAME --resource-group $_RESOURCE_GROUP --network-security-group $_NSG_NAME

# echo "Network security group and associated rules created successfully."

# ############### Stack_TRACE_BUILDER ################
# Function_PATH="$( dirname ${Function_PATH} )"
# ####################################################    
# }

function create_networksecurity_group() 
{
#|#  Nom de la fonction    : create_networksecurity_group
#|#  Description           : Crée un groupe de ressources, un réseau virtuel, un sous-réseau, un Network Security Group (NSG) avec une règle associée, et une interface réseau, en liant le NSG au sous-réseau spécifié.
#|#  Paramètres:
#|#      _RESOURCE_GROUP    : Nom du groupe de ressources à créer ou utiliser (obligatoire).
#|#      _LOCATION          : Localisation pour la création des ressources (obligatoire).
#|#      _VNET_NAME         : Nom du réseau virtuel à créer (obligatoire).
#|#      _SUBNET_NAME       : Nom du sous-réseau à créer (obligatoire).
#|#      _NSG_NAME          : Nom du Network Security Group (NSG) à créer (obligatoire).
#|#      _RULE_NAME         : Nom de la règle du NSG à créer (obligatoire).
#|#      _NIC_NAME          : Nom de l'interface réseau à créer (obligatoire).
#|#  Utilisation           : create_networksecurity_group "RESOURCE_GROUP" "LOCATION" "VNET_NAME" "SUBNET_NAME" "NSG_NAME" "RULE_NAME" "NIC_NAME"
#|#  Retour                : Aucun (affiche les messages de succès ou d'erreur pour chaque étape).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _RESOURCE_GROUP="${1}"
local _LOCATION="${2}"
local _VNET_NAME="${3}"
local _SUBNET_NAME="${4}"
local _NSG_NAME="${5}"
local _RULE_NAME="${6}"
local _NIC_NAME="${7}"

# Contrôle des variables vides avant utilisation
Empty_Var_Control "${_RESOURCE_GROUP}" "_RESOURCE_GROUP" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_LOCATION}" "_LOCATION" "2" "La localisation est requise."
Empty_Var_Control "${_VNET_NAME}" "_VNET_NAME" "2" "Le nom du réseau virtuel est requis."
Empty_Var_Control "${_SUBNET_NAME}" "_SUBNET_NAME" "2" "Le nom du sous-réseau est requis."
Empty_Var_Control "${_NSG_NAME}" "_NSG_NAME" "2" "Le nom du Network Security Group (NSG) est requis."
Empty_Var_Control "${_RULE_NAME}" "_RULE_NAME" "2" "Le nom de la règle NSG est requis."
Empty_Var_Control "${_NIC_NAME}" "_NIC_NAME" "2" "Le nom de l'interface réseau est requis."

# Vérification de la connexion Azure
MSG_DISPLAY "check" "0" "Vérification de la connexion à Azure"
check_az_login

# Création du groupe de ressources
MSG_DISPLAY "check" "0" "Création du groupe de ressources '${_RESOURCE_GROUP}' dans '${_LOCATION}'"
az group create --name "${_RESOURCE_GROUP}" --location "${_LOCATION}" &>> ${log_file}
CTRL_Result_func "${?}" "Création du groupe de ressources" "Échec de la création du groupe de ressources" "1"

# Création du réseau virtuel et du sous-réseau
MSG_DISPLAY "check" "0" "Création du réseau virtuel '${_VNET_NAME}' avec le sous-réseau '${_SUBNET_NAME}'"
az network vnet create --resource-group "${_RESOURCE_GROUP}" --name "${_VNET_NAME}" --address-prefix 10.0.0.0/16 --subnet-name "${_SUBNET_NAME}" --subnet-prefix 10.0.0.0/24 &>> ${log_file}
CTRL_Result_func "${?}" "Création du VNet et du sous-réseau" "Échec de la création du VNet ou du sous-réseau" "1"

# Création du Network Security Group (NSG)
MSG_DISPLAY "check" "0" "Création du Network Security Group '${_NSG_NAME}'"
az network nsg create --resource-group "${_RESOURCE_GROUP}" --name "${_NSG_NAME}" --location "${_LOCATION}" &>> ${log_file}
CTRL_Result_func "${?}" "Création du NSG" "Échec de la création du NSG" "1"

# Création d'une règle dans le NSG
MSG_DISPLAY "check" "0" "Création de la règle '${_RULE_NAME}' dans le NSG '${_NSG_NAME}'"
az network nsg rule create --resource-group "${_RESOURCE_GROUP}" --nsg-name "${_NSG_NAME}" --name "${_RULE_NAME}" --priority 1000 --direction Inbound --access Allow --protocol Tcp --source-address-prefixes '*' --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges 22 &>> ${log_file}
CTRL_Result_func "${?}" "Création de la règle NSG" "Échec de la création de la règle NSG" "1"

# Création de l'interface réseau
MSG_DISPLAY "check" "0" "Création de l'interface réseau '${_NIC_NAME}'"
az network nic create --resource-group "${_RESOURCE_GROUP}" --name "${_NIC_NAME}" --vnet-name "${_VNET_NAME}" --subnet "${_SUBNET_NAME}" --network-security-group "${_NSG_NAME}" &>> ${log_file}
CTRL_Result_func "${?}" "Création de l'interface réseau" "Échec de la création de l'interface réseau" "1"

# Association du NSG avec le sous-réseau
MSG_DISPLAY "check" "0" "Association du NSG '${_NSG_NAME}' avec le sous-réseau '${_SUBNET_NAME}'"
az network vnet subnet update --vnet-name "${_VNET_NAME}" --name "${_SUBNET_NAME}" --resource-group "${_RESOURCE_GROUP}" --network-security-group "${_NSG_NAME}" &>> ${log_file}
CTRL_Result_func "${?}" "Association du NSG avec le sous-réseau" "Échec de l'association du NSG avec le sous-réseau" "1"

MSG_DISPLAY "info" "0" "Network security group et règles associées créés avec succès."

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################    
}

function set_rt_to_subnet() 
{
#|#  Nom de la fonction    : set_rt_to_subnet
#|#  Description           : Met à jour un sous-réseau pour associer une table de routage spécifique dans Azure.
#|#  Paramètres:
#|#      _ressource_group_name  : Nom du groupe de ressources Azure où se trouve le sous-réseau (obligatoire).
#|#      _vnet_name             : Nom du réseau virtuel contenant le sous-réseau (obligatoire).
#|#      _subnet_name           : Nom du sous-réseau à mettre à jour (obligatoire).
#|#      _route_table           : Nom de la table de routage à associer au sous-réseau (obligatoire).
#|#      _location              : Localisation de la table de routage (obligatoire).
#|#  Utilisation           : set_rt_to_subnet "ressource_group_name" "vnet_name" "subnet_name" "route_table" "location"
#|#  Retour                : Aucun (affiche les messages de succès ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _ressource_group_name="${1}"
local _vnet_name="${2}"
local _subnet_name="${3}"
local _route_table="${4}"
local _location="${5}"

# Contrôle des variables vides
Empty_Var_Control "${_ressource_group_name}" "_ressource_group_name" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_vnet_name}" "_vnet_name" "2" "Le nom du réseau virtuel est requis."
Empty_Var_Control "${_subnet_name}" "_subnet_name" "2" "Le nom du sous-réseau est requis."
Empty_Var_Control "${_route_table}" "_route_table" "2" "La table de routage est requise."
Empty_Var_Control "${_location}" "_location" "2" "La localisation est requise."

# Mise à jour du sous-réseau avec la table de routage
MSG_DISPLAY "check" "0" "Mise à jour du sous-réseau '${_subnet_name}' dans le VNet '${_vnet_name}' avec la table de routage '${_route_table}'"
az network vnet subnet update --resource-group "${_ressource_group_name}" --vnet-name "${_vnet_name}" --name "${_subnet_name}" --route-table "${_route_table}" &>> ${log_file}
CTRL_Result_func "${?}" "Mise à jour du sous-réseau avec la table de routage" "Échec de la mise à jour du sous-réseau" "1"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Sous-réseau '${_subnet_name}' mis à jour avec succès."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la mise à jour du sous-réseau '${_subnet_name}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function create_vnet() 
{
#|#  Nom de la fonction    : create_vnet
#|#  Description           : Vérifie si un réseau virtuel (VNet) existe dans Azure. Si le VNet n'existe pas, il est créé avec les paramètres spécifiés.
#|#  Paramètres:
#|#      _vnet_name              : Nom du réseau virtuel (VNet) à créer ou vérifier (obligatoire).
#|#      _ressource_group_name    : Nom du groupe de ressources où créer le VNet (obligatoire).
#|#      _address_prefixes        : Préfixes d'adresses pour le VNet (obligatoire).
#|#      _location               : Localisation du VNet (obligatoire).
#|#  Utilisation           : create_vnet "vnet_name" "ressource_group_name" "address_prefixes" "location"
#|#  Retour                : Aucun (affiche les messages de déploiement ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _vnet_name="${1}"
local _ressource_group_name="${2}"
local _address_prefixes="${3}"
local _location="${4}"

# Contrôle des variables vides
Empty_Var_Control "${_vnet_name}" "_vnet_name" "2" "Le nom du réseau virtuel est requis."
Empty_Var_Control "${_ressource_group_name}" "_ressource_group_name" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_address_prefixes}" "_address_prefixes" "2" "Les préfixes d'adresses sont requis."
Empty_Var_Control "${_location}" "_location" "2" "La localisation est requise."

# Vérification de la présence du VNet
MSG_DISPLAY "check" "0" "Vérification de la présence du réseau virtuel '${_vnet_name}' dans le groupe de ressources '${_ressource_group_name}'"
az network vnet show --name "${_vnet_name}" --resource-group "${_ressource_group_name}" &>> ${log_file}
CTRL_Result_func "${?}" "Vérification de la présence du VNet" "Échec lors de la vérification de la présence du VNet" "0"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Le réseau virtuel '${_vnet_name}' est déjà déployé."
else
    MSG_DISPLAY "info" "0" "Le réseau virtuel '${_vnet_name}' n'existe pas. Création en cours..."
    az network vnet create --name "${_vnet_name}" --resource-group "${_ressource_group_name}" --address-prefixes "${_address_prefixes}" --location "${_location}" &>> ${log_file}
    CTRL_Result_func "${?}" "Création du réseau virtuel" "Échec de la création du réseau virtuel" "1"
    
    if [[ "${?}" -eq 0 ]]; then
        MSG_DISPLAY "info" "0" "Réseau virtuel '${_vnet_name}' déployé avec succès."
    else
        MSG_DISPLAY "error" "1" "Erreur lors du déploiement du réseau virtuel '${_vnet_name}'."
        exit 1
    fi
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function create_subnet() 
{
#|#  Nom de la fonction    : create_subnet
#|#  Description           : Vérifie si un sous-réseau existe dans un réseau virtuel (VNet) Azure. Si le sous-réseau n'existe pas, il est créé avec les préfixes d'adresses spécifiés.
#|#  Paramètres:
#|#      _subnet_name             : Nom du sous-réseau à créer ou vérifier (obligatoire).
#|#      _vnet_name               : Nom du réseau virtuel (VNet) contenant le sous-réseau (obligatoire).
#|#      _ressource_group_name     : Nom du groupe de ressources associé au VNet (obligatoire).
#|#      _address_prefixes         : Préfixe d'adresses à assigner au sous-réseau (obligatoire).
#|#  Utilisation           : create_subnet "subnet_name" "vnet_name" "ressource_group_name" "address_prefixes"
#|#  Retour                : Aucun (affiche les messages de déploiement ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _subnet_name="${1}"
local _vnet_name="${2}"
local _ressource_group_name="${3}"
local _address_prefixes="${4}"

# Contrôle des variables vides
Empty_Var_Control "${_subnet_name}" "_subnet_name" "2" "Le nom du sous-réseau est requis."
Empty_Var_Control "${_vnet_name}" "_vnet_name" "2" "Le nom du réseau virtuel est requis."
Empty_Var_Control "${_ressource_group_name}" "_ressource_group_name" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_address_prefixes}" "_address_prefixes" "2" "Le préfixe d'adresse est requis."

# Vérification de la présence du sous-réseau
MSG_DISPLAY "check" "0" "Vérification de la présence du sous-réseau '${_subnet_name}' dans le VNet '${_vnet_name}'"
az network vnet subnet show --name "${_subnet_name}" --vnet-name "${_vnet_name}" --resource-group "${_ressource_group_name}" &>> ${log_file}
CTRL_Result_func "${?}" "Vérification de la présence du sous-réseau" "Échec lors de la vérification du sous-réseau" "0"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Le sous-réseau '${_subnet_name}' est déjà déployé."
else
    MSG_DISPLAY "info" "0" "Le sous-réseau '${_subnet_name}' n'existe pas. Création en cours..."
    az network vnet subnet create --name "${_subnet_name}" --vnet-name "${_vnet_name}" --resource-group "${_ressource_group_name}" --address-prefix "${_address_prefixes}" --default-outbound-access false &>> ${log_file}
    CTRL_Result_func "${?}" "Création du sous-réseau" "Échec de la création du sous-réseau" "1"
    
    if [[ "${?}" -eq 0 ]]; then
        MSG_DISPLAY "info" "0" "Sous-réseau '${_subnet_name}' déployé avec succès."
    else
        MSG_DISPLAY "error" "1" "Erreur lors du déploiement du sous-réseau '${_subnet_name}'."
        exit 1
    fi
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function create_networkinterface() 
{
#|#  Nom de la fonction    : create_networkinterface
#|#  Description           : Vérifie si une interface réseau existe dans Azure. Si elle n'existe pas, elle est créée avec les paramètres spécifiés, y compris la possibilité d'activer le transfert IP.
#|#  Paramètres:
#|#      _nic_name              : Nom de l'interface réseau à créer ou vérifier (obligatoire).
#|#      _subnet_name           : Nom du sous-réseau auquel l'interface réseau sera associée (obligatoire).
#|#      _vnet_name             : Nom du réseau virtuel (VNet) contenant le sous-réseau (obligatoire).
#|#      _ressource_group_name   : Nom du groupe de ressources associé à l'interface réseau (obligatoire).
#|#      _private_ip            : Adresse IP privée à attribuer à l'interface réseau (obligatoire).
#|#      _nic_opts              : Options supplémentaires pour l'interface réseau, comme l'activation du transfert IP (facultatif).
#|#      _location              : Localisation de l'interface réseau (obligatoire).
#|#  Utilisation           : create_networkinterface "nic_name" "subnet_name" "vnet_name" "ressource_group_name" "private_ip" "nic_opts" "location"
#|#  Retour                : Aucun (affiche les messages de déploiement ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _nic_name="${1}"
local _subnet_name="${2}"
local _vnet_name="${3}"
local _ressource_group_name="${4}"
local _private_ip="${5}"
local _nic_opts="${6}"
local _location="${7}"

# Contrôle des variables vides
Empty_Var_Control "${_nic_name}" "_nic_name" "2" "Le nom de l'interface réseau est requis."
Empty_Var_Control "${_subnet_name}" "_subnet_name" "2" "Le nom du sous-réseau est requis."
Empty_Var_Control "${_vnet_name}" "_vnet_name" "2" "Le nom du réseau virtuel est requis."
Empty_Var_Control "${_ressource_group_name}" "_ressource_group_name" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_private_ip}" "_private_ip" "2" "L'adresse IP privée est requise."
Empty_Var_Control "${_location}" "_location" "2" "La localisation est requise."

# Vérification des options de transfert IP
local _opt_forward=""
if [[ ${_nic_opts} == "ipforwarding" ]]; then
    _opt_forward="--ip-forwarding true"
fi

# Vérification de la présence de l'interface réseau
MSG_DISPLAY "check" "0" "Vérification de l'existence de l'interface réseau '${_nic_name}'"
az network nic show --name "${_nic_name}" --resource-group "${_ressource_group_name}" &>> ${log_file}
CTRL_Result_func "${?}" "Vérification de l'interface réseau" "Échec lors de la vérification de l'interface réseau" "0"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "L'interface réseau '${_nic_name}' est déjà déployée."
else
    MSG_DISPLAY "info" "0" "L'interface réseau '${_nic_name}' n'existe pas. Création en cours..."
    az network nic create --name "${_nic_name}" --resource-group "${_ressource_group_name}" --subnet "$(get-subnet-id ${_ressource_group_name} ${_vnet_name} ${_subnet_name})" --private-ip-address "${_private_ip}" ${_opt_forward} --location "${_location}" &>> ${log_file}
    CTRL_Result_func "${?}" "Création de l'interface réseau" "Échec de la création de l'interface réseau" "1"

    if [[ "${?}" -eq 0 ]]; then
        MSG_DISPLAY "info" "0" "Interface réseau '${_nic_name}' déployée avec succès."
    else
        MSG_DISPLAY "error" "1" "Erreur lors du déploiement de l'interface réseau '${_nic_name}'."
        exit 1
    fi
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function rg_deserialize() 
{
#|#  Nom de la fonction    : rg_deserialize
#|#  Description           : Affiche les informations des groupes de ressources dans un format tabulaire et tente de les créer si nécessaire.
#|#  Paramètres:
#|#      _network_ressource_groupe  : Nom du groupe de ressources réseau à désérialiser (obligatoire).
#|#      _ressource_groupe          : Nom du groupe de ressources à désérialiser (obligatoire).
#|#      _default_location          : Localisation par défaut pour les groupes de ressources (obligatoire).
#|#  Utilisation           : rg_deserialize "network_ressource_groupe" "ressource_groupe" "default_location"
#|#  Retour                : Affiche les informations des groupes de ressources et l'état du déploiement.
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _network_ressource_groupe="${1}"
local _ressource_groupe="${2}"
local _default_location="${3}"

# Contrôle des variables vides
Empty_Var_Control "${_network_ressource_groupe}" "_network_ressource_groupe" "2" "Le nom du groupe de ressources réseau est requis."
Empty_Var_Control "${_ressource_groupe}" "_ressource_groupe" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_default_location}" "_default_location" "2" "La localisation par défaut est requise."

# Affichage des informations des groupes de ressources
echo "Loaded Resource Groups :"
# En-tête du tableau
printf "%-40s %-15s\n" "Resource Group" "Deployed"
printf "%-40s %-15s\n" "--------------" "--------"

# Création des groupes de ressources et récupération du statut de déploiement
local _deployment_status_network
_deployment_status_network=$(create_ressource_group "${_network_ressource_groupe}" "${_default_location}" 2>&1)

local _deployment_status
_deployment_status=$(create_ressource_group "${_ressource_groupe}" "${_default_location}" 2>&1)

# Affichage des détails des groupes de ressources dans un format tabulaire
printf "%-40s %-15s\n" "${_network_ressource_groupe}" "${_deployment_status_network}"
printf "%-40s %-15s\n" "${_ressource_groupe}" "${_deployment_status}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"