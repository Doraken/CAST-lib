#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 

function set_vm_properties() 
{
#|#  Nom de la fonction    : set_vm_properties
#|#  Description           : Définit les propriétés d'une machine virtuelle en fonction des variables fournies.
#|#  Paramètres:
#|#      _vm_name          : Nom de la machine virtuelle (obligatoire).
#|#      _resource_group   : Groupe de ressources de la machine virtuelle (obligatoire).
#|#      _property_name    : Nom de la propriété à définir (obligatoire).
#|#      _property_value   : Valeur à définir pour la propriété (obligatoire).
#|#  Utilisation           : set_vm_properties "vm_name" "resource_group" "property_name" "property_value"
#|#  Retour                : Aucun (affiche les messages de mise à jour des propriétés de la VM).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _vm_name="${1}"
local _resource_group="${2}"
local _property_name="${3}"
local _property_value="${4}"

# Contrôle des variables vides
Empty_Var_Control "${_vm_name}" "_vm_name" "2" "Le nom de la machine virtuelle est requis."
Empty_Var_Control "${_resource_group}" "_resource_group" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_property_name}" "_property_name" "2" "Le nom de la propriété est requis."
Empty_Var_Control "${_property_value}" "_property_value" "2" "La valeur de la propriété est requise."

# Mise à jour des propriétés de la VM
MSG_DISPLAY "check" "0" "Mise à jour de la propriété '${_property_name}' de la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}'"
az vm update --resource-group "${_resource_group}" --name "${_vm_name}" --set "${_property_name}=${_property_value}" &>> ${log_file}
CTRL_Result_func "${?}" "Mise à jour de la propriété de la VM réussie" "Échec de la mise à jour de la propriété de la VM" "1"

if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Propriété '${_property_name}' mise à jour avec succès pour la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la mise à jour de la propriété '${_property_name}' pour la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_vm_create() 
{
#|#  Nom de la fonction    : do_vm_create
#|#  Description           : Crée une machine virtuelle en utilisant les variables fournies, y compris le nom de la VM, le groupe de ressources, et le modèle d'image.
#|#  Paramètres:
#|#      _vm_name          : Le nom de la machine virtuelle à créer (obligatoire).
#|#      _resource_group   : Le groupe de ressources où créer la VM (obligatoire).
#|#      _vm_template      : Modèle d'image à utiliser pour la création de la VM (obligatoire).
#|#  Utilisation           : do_vm_create "vm_name" "resource_group" "vm_template"
#|#  Retour                : Aucun (affiche les messages de création ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _vm_name="${1}"
local _resource_group="${2}"
local _vm_template="${3}"

# Contrôle des variables vides
Empty_Var_Control "${_vm_name}" "_vm_name" "2" "Le nom de la machine virtuelle est requis."
Empty_Var_Control "${_resource_group}" "_resource_group" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_vm_template}" "_vm_template" "2" "Le modèle d'image est requis."

# Création de la VM
MSG_DISPLAY "check" "0" "Création de la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}' avec le modèle '${_vm_template}'"
az vm create --resource-group "${_resource_group}" --name "${_vm_name}" --image "${_vm_template}" &>> ${log_file}
CTRL_Result_func "${?}" "Création de la VM réussie" "Échec de la création de la VM" "1"

if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Machine virtuelle '${_vm_name}' créée avec succès dans le groupe de ressources '${_resource_group}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la création de la machine virtuelle '${_vm_name}' dans le groupe de ressources '${_resource_group}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_vm_remove() 
{
#|#  Nom de la fonction    : do_vm_remove
#|#  Description           : Supprime une machine virtuelle en fonction des variables fournies.
#|#  Paramètres:
#|#      _vm_name          : Le nom de la machine virtuelle (obligatoire).
#|#      _resource_group   : Le groupe de ressources de la machine virtuelle (obligatoire).
#|#  Utilisation           : do_vm_remove "vm_name" "resource_group"
#|#  Retour                : Aucun (affiche les messages de suppression ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _vm_name="${1}"
local _resource_group="${2}"

# Contrôle des variables vides
Empty_Var_Control "${_vm_name}" "_vm_name" "2" "Le nom de la machine virtuelle est requis."
Empty_Var_Control "${_resource_group}" "_resource_group" "2" "Le nom du groupe de ressources est requis."

# Suppression de la VM
MSG_DISPLAY "check" "0" "Suppression de la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}'"
az vm delete --resource-group "${_resource_group}" --name "${_vm_name}" --yes &>> ${log_file}
CTRL_Result_func "${?}" "Suppression de la VM réussie" "Échec de la suppression de la VM" "1"

if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Machine virtuelle '${_vm_name}' supprimée avec succès dans le groupe de ressources '${_resource_group}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la suppression de la machine virtuelle '${_vm_name}' dans le groupe de ressources '${_resource_group}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_vm_stop() 
{
#|#  Nom de la fonction    : do_vm_stop
#|#  Description           : Arrête une machine virtuelle en fonction des variables fournies.
#|#  Paramètres:
#|#      _vm_name          : Le nom de la machine virtuelle (obligatoire).
#|#      _resource_group   : Le groupe de ressources de la machine virtuelle (obligatoire).
#|#  Utilisation           : do_vm_stop "vm_name" "resource_group"
#|#  Retour                : Aucun (affiche les messages d'arrêt ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _vm_name="${1}"
local _resource_group="${2}"

# Contrôle des variables vides
Empty_Var_Control "${_vm_name}" "_vm_name" "2" "Le nom de la machine virtuelle est requis."
Empty_Var_Control "${_resource_group}" "_resource_group" "2" "Le nom du groupe de ressources est requis."

# Arrêt de la VM
MSG_DISPLAY "check" "0" "Arrêt de la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}'"
az vm stop --resource-group "${_resource_group}" --name "${_vm_name}" &>> ${log_file}
CTRL_Result_func "${?}" "Arrêt de la VM réussi" "Échec de l'arrêt de la VM" "1"

if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Machine virtuelle '${_vm_name}' arrêtée avec succès dans le groupe de ressources '${_resource_group}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de l'arrêt de la machine virtuelle '${_vm_name}' dans le groupe de ressources '${_resource_group}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_vm_start() 
{
#|#  Nom de la fonction    : do_vm_start
#|#  Description           : Démarre une machine virtuelle en fonction des variables fournies.
#|#  Paramètres:
#|#      _vm_name          : Le nom de la machine virtuelle (obligatoire).
#|#      _resource_group   : Le groupe de ressources de la machine virtuelle (obligatoire).
#|#  Utilisation           : do_vm_start "vm_name" "resource_group"
#|#  Retour                : Aucun (affiche les messages de démarrage ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _vm_name="${1}"
local _resource_group="${2}"

# Contrôle des variables vides
Empty_Var_Control "${_vm_name}" "_vm_name" "2" "Le nom de la machine virtuelle est requis."
Empty_Var_Control "${_resource_group}" "_resource_group" "2" "Le nom du groupe de ressources est requis."

# Démarrage de la VM
MSG_DISPLAY "check" "0" "Démarrage de la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}'"
az vm start --resource-group "${_resource_group}" --name "${_vm_name}" &>> ${log_file}
CTRL_Result_func "${?}" "Démarrage de la VM réussi" "Échec du démarrage de la VM" "1"

if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Machine virtuelle '${_vm_name}' démarrée avec succès dans le groupe de ressources '${_resource_group}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors du démarrage de la machine virtuelle '${_vm_name}' dans le groupe de ressources '${_resource_group}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_vm_config() 
{
#|#  Nom de la fonction    : Get_vm_config
#|#  Description           : Récupère la configuration complète d'une machine virtuelle en fonction des variables fournies.
#|#  Paramètres:
#|#      _vm_name          : Le nom de la machine virtuelle (obligatoire).
#|#      _resource_group   : Le groupe de ressources de la machine virtuelle (obligatoire).
#|#  Utilisation           : Get_vm_config "vm_name" "resource_group"
#|#  Retour                : Aucun (affiche les messages de récupération ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _vm_name="${1}"
local _resource_group="${2}"

# Contrôle des variables vides
Empty_Var_Control "${_vm_name}" "_vm_name" "2" "Le nom de la machine virtuelle est requis."
Empty_Var_Control "${_resource_group}" "_resource_group" "2" "Le nom du groupe de ressources est requis."

# Récupération de la configuration de la VM
MSG_DISPLAY "check" "0" "Récupération de la configuration de la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}'"
az vm show --resource-group "${_resource_group}" --name "${_vm_name}" &>> ${log_file}
CTRL_Result_func "${?}" "Récupération de la configuration de la VM réussie" "Échec de la récupération de la configuration de la VM" "1"

if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Configuration de la machine virtuelle '${_vm_name}' récupérée avec succès dans le groupe de ressources '${_resource_group}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la récupération de la configuration de la machine virtuelle '${_vm_name}' dans le groupe de ressources '${_resource_group}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Set_vm_config() 
{
#|#  Nom de la fonction    : Set_vm_config
#|#  Description           : Modifie la configuration d'une machine virtuelle en fonction des variables fournies.
#|#  Paramètres:
#|#      _vm_name          : Le nom de la machine virtuelle (obligatoire).
#|#      _resource_group   : Le groupe de ressources de la machine virtuelle (obligatoire).
#|#      _config_name      : Le nom de la configuration à modifier (obligatoire).
#|#      _config_value     : La valeur à définir pour la configuration (obligatoire).
#|#  Utilisation           : Set_vm_config "vm_name" "resource_group" "config_name" "config_value"
#|#  Retour                : Aucun (affiche les messages de modification ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _vm_name="${1}"
local _resource_group="${2}"
local _config_name="${3}"
local _config_value="${4}"

# Contrôle des variables vides
Empty_Var_Control "${_vm_name}" "_vm_name" "2" "Le nom de la machine virtuelle est requis."
Empty_Var_Control "${_resource_group}" "_resource_group" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_config_name}" "_config_name" "2" "Le nom de la configuration est requis."
Empty_Var_Control "${_config_value}" "_config_value" "2" "La valeur de la configuration est requise."

# Modification de la configuration de la VM
MSG_DISPLAY "check" "0" "Modification de la configuration '${_config_name}' de la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}'"
az vm update --resource-group "${_resource_group}" --name "${_vm_name}" --set "${_config_name}=${_config_value}" &>> ${log_file}
CTRL_Result_func "${?}" "Modification de la configuration de la VM réussie" "Échec de la modification de la configuration de la VM" "1"

if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Configuration '${_config_name}' modifiée avec succès pour la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}'."
else
    MSG_DISPLAY "error" "1" "Erreur lors de la modification de la configuration '${_config_name}' pour la VM '${_vm_name}' dans le groupe de ressources '${_resource_group}'."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function create_vm() 
{
#|#  Nom de la fonction    : create_vm
#|#  Description           : Crée une machine virtuelle ou vérifie son existence en fonction des variables fournies.
#|#  Paramètres:
#|#      _vm_name          : Le nom de la machine virtuelle (obligatoire).
#|#      _resource_group   : Le groupe de ressources de la machine virtuelle (obligatoire).
#|#      _image            : L'image de la machine virtuelle (obligatoire).
#|#      _size             : La taille de la machine virtuelle (obligatoire).
#|#      _nic_name         : Le nom de l'interface réseau associée (obligatoire).
#|#      _location         : La localisation de la machine virtuelle (obligatoire).
#|#      _admin_username   : Le nom d'utilisateur administrateur (obligatoire).
#|#      _admin_password   : Le mot de passe administrateur (obligatoire).
#|#      _disk_size        : La taille du disque système en Go (facultatif).
#|#      _vm_opts          : Options supplémentaires telles que le réseau accéléré (facultatif).
#|#  Utilisation           : create_vm "vm_name" "resource_group" "image" "size" "nic_name" "location" "admin_username" "admin_password" ["disk_size"] ["vm_opts"]
#|#  Retour                : Aucun (affiche les messages de création ou d'existence).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _vm_name="${1}"
local _resource_group="${2}"
local _image="${3}"
local _size="${4}"
local _nic_name="${5}"
local _location="${6}"
local _admin_username="${7}"
local _admin_password="${8}"
local _disk_size="${9}"
local _vm_opts="${10}"

# Contrôle des variables vides
Empty_Var_Control "${_vm_name}" "_vm_name" "2" "Le nom de la machine virtuelle est requis."
Empty_Var_Control "${_resource_group}" "_resource_group" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_image}" "_image" "2" "L'image de la machine virtuelle est requise."
Empty_Var_Control "${_size}" "_size" "2" "La taille de la machine virtuelle est requise."
Empty_Var_Control "${_nic_name}" "_nic_name" "2" "Le nom de l'interface réseau est requis."
Empty_Var_Control "${_location}" "_location" "2" "La localisation est requise."
Empty_Var_Control "${_admin_username}" "_admin_username" "2" "Le nom d'utilisateur administrateur est requis."
Empty_Var_Control "${_admin_password}" "_admin_password" "2" "Le mot de passe administrateur est requis."

# Options supplémentaires pour le disque et le réseau accéléré
local _opt_disk_size=""
if [[ ! -z ${_disk_size} ]]; then
    _opt_disk_size="--os-disk-size-gb ${_disk_size}"
fi

local _opt_acc_net=""
if [[ ${_vm_opts} == "accelerated-networking" ]]; then
    _opt_acc_net="--accelerated-networking true"
fi

# Vérification de la présence de la machine virtuelle
MSG_DISPLAY "check" "0" "Vérification de l'existence de la VM '${_vm_name}'"
az vm show --name "${_vm_name}" --resource-group "${_resource_group}" &>> ${log_file}
CTRL_Result_func "${?}" "Vérification de la VM" "Échec lors de la vérification de la VM" "0"

if [[ ${?} -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "La machine virtuelle '${_vm_name}' est déjà déployée."
else
    MSG_DISPLAY "info" "0" "La machine virtuelle '${_vm_name}' n'existe pas. Création en cours..."
    az vm create --name "${_vm_name}" --resource-group "${_resource_group}" --image "${_image}" --size "${_size}" --nics "${_nic_name}" --location "${_location}" --admin-username "${_admin_username}" --admin-password "${_admin_password}" ${_opt_disk_size} ${_opt_acc_net} &>> ${log_file}
    CTRL_Result_func "${?}" "Création de la VM" "Échec de la création de la VM" "1"

    if [[ $? -eq 0 ]]; then
        MSG_DISPLAY "info" "0" "Machine virtuelle '${_vm_name}' déployée avec succès."
    else
        MSG_DISPLAY "error" "1" "Erreur lors du déploiement de la machine virtuelle '${_vm_name}'."
        exit 1
    fi
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function vnet_deserialize ()
{
#|#  Nom de la fonction    : vnet_deserialize
#|#  Description           : Affiche les informations d'un réseau virtuel (VNet) sous forme tabulaire et tente de le créer si nécessaire.
#|#  Paramètres:
#|#      _vnet_name              : Le nom du réseau virtuel (VNet) (obligatoire).
#|#      _network_resource_group : Le groupe de ressources du réseau (obligatoire).
#|#      _front_ranges           : Les plages d'adresses IP pour la partie front (obligatoire).
#|#      _back_ranges            : Les plages d'adresses IP pour la partie back (obligatoire).
#|#      _interface_ranges       : Les plages d'adresses IP pour les interfaces (obligatoire).
#|#      _default_location       : La localisation par défaut pour le VNet (obligatoire).
#|#  Utilisation           : vnet_deserialize "vnet_name" "network_resource_group" "front_ranges" "back_ranges" "interface_ranges" "default_location"
#|#  Retour                : Aucun (affiche les messages d'état ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

#|# Variables locales assignées par les paramètres
local _vnet_name="${1}"
local _network_resource_group="${2}"
local _front_ranges="${3}"
local _back_ranges="${4}"
local _interface_ranges="${5}"
local _default_location="${6}"

#|# Contrôle des variables vides
Empty_Var_Control "${_vnet_name}" "_vnet_name" "2" "Le nom du VNet est requis."
Empty_Var_Control "${_network_resource_group}" "_network_resource_group" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_front_ranges}" "_front_ranges" "2" "Les plages d'adresses front sont requises."
Empty_Var_Control "${_back_ranges}" "_back_ranges" "2" "Les plages d'adresses back sont requises."
Empty_Var_Control "${_interface_ranges}" "_interface_ranges" "2" "Les plages d'adresses d'interface sont requises."
Empty_Var_Control "${_default_location}" "_default_location" "2" "La localisation par défaut est requise."

#|# Affichage des informations du VNet
MSG_DISPLAY "info" "0" "Loaded VNet:"
# En-tête du tableau
printf "%-20s %-30s %-20s %-20s %-25s %-15s %-15s\n" "VNet Name" "Resource Group" "Front Ranges" "Back Ranges" "Interface Ranges" "Location" "Deployed"
printf "%-20s %-30s %-20s %-20s %-25s %-15s %-15s\n" "----------------" "--------------" "------------" "------------" "-----------------" "--------" "--------"

#|# Affichage des informations du VNet avec appel de création
MSG_DISPLAY "check" "0" "Tentative de création du VNet '${_vnet_name}'"
local _deployment_status
_deployment_status=$(create_vnet "${_vnet_name}" "${_network_resource_group}" "${_front_ranges} ${_back_ranges} ${_interface_ranges}" "${_default_location}" 2>&1)
CTRL_Result_func "${?}" "Création du VNet réussie" "Échec de la création du VNet" "1"

# Affichage des détails du VNet dans un format tabulaire
if [ $? -eq 0 ]; then
    MSG_DISPLAY "info" "0" "Le VNet '${_vnet_name}' a été traité avec succès."
else
    MSG_DISPLAY "error" "1" "Erreur lors du traitement du VNet '${_vnet_name}'."
    exit 1
fi

printf "%-20s %-30s %-20s %-20s %-25s %-15s %-15s\n" "${_vnet_name}" "${_network_resource_group}" "${_front_ranges}" "${_back_ranges}" "${_interface_ranges}" "${_default_location}" "${_deployment_status}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

LibState="OK"