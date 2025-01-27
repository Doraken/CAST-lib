#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure ressource group managment from CAST

# generate Ressource Group config file with config.cnf
function generate_rg_config_file() 
{
#|#  Nom de la fonction    : generate_rg_config_file
#|#  Description           : Génère un fichier de configuration pour un groupe de ressources basé sur les variables fournies.
#|#  Paramètres:
#|#      _id                : L'ID du groupe de ressources (obligatoire).
#|#      _location          : La localisation du groupe de ressources (obligatoire).
#|#      _managedBy         : Le gestionnaire du groupe de ressources (optionnel).
#|#      _name              : Le nom du groupe de ressources (optionnel).
#|#      _tags              : Les tags associés au groupe de ressources (optionnel).
#|#  Utilisation           : generate_rg_config_file "id" "location" "managedBy" "name" "tags"
#|#  Retour                : Génère un fichier de configuration et affiche les messages de succès ou d'erreur.
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _id="${1}"
local _location="${2}"
local _managedBy="${3:-NotSet}"
local _name="${4:-NotSet}"
local _tags="${5:-NotSet}"

# Contrôle des variables vides
Empty_Var_Control "${_id}" "_id" "2" "L'ID du groupe de ressources est requis."
Empty_Var_Control "${_location}" "_location" "2" "La localisation du groupe de ressources est requise."
Empty_Var_Control "${_managedBy}" "_managedBy" "2" "Le champ 'managedBy' est requis."
Empty_Var_Control "${_tags}" "_tags" "2" "Les tags du groupe de ressources sont requis."

# Définition du fichier de configuration
local _config_file="./config/config.sh"

# Création du fichier de configuration
MSG_DISPLAY "check" "0" "Génération du fichier de configuration : ${_config_file}"
cat <<EOL > "${_config_file}"
resourceGroup="$(basename $(pwd))"    
ID="${_id}"
LOCATION="${_location}"
MANAGEDBY="${_managedBy}"
NAME="${_name}"
TAGS="${_tags}"
ConfigRessourceGroupeState="OK"
EOL
CTRL_Result_func "${?}" "Génération du fichier de configuration réussie" "Échec de la génération du fichier de configuration" "1"

if [[ "${?}" -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Fichier de configuration généré avec succès : ${_config_file}"
else
    MSG_DISPLAY "error" "1" "Erreur lors de la génération du fichier de configuration : ${_config_file}"
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Fonction pour scanner le groupe de ressources et générer le fichier de configuration
function scan_resource_group() 
{
#|#  Nom de la fonction    : scan_resource_group
#|#  Description           : Scanne le groupe de ressources spécifié, récupère ses informations et génère un fichier de configuration avec les détails du groupe de ressources.
#|#  Paramètres:
#|#      _rg                : Le nom du groupe de ressources à scanner (obligatoire).
#|#  Utilisation           : scan_resource_group "_rg"
#|#  Retour                : Aucun (génère un fichier de configuration avec les détails du groupe de ressources).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "

    # Assign the resource group name passed as a parameter
    local _rg="${1}"

    # Check if the resource group name variable is empty
    Empty_Var_Control "${_rg}" "_rg" "" "2"

    # Display a message indicating the start of the resource group scan
    echo "Scanning resource group: ${_rg}"
    
    # Retrieve the information of the specified resource group
    rg_info=$(az group show --name $_rg --query "{id:id, location:location, managedBy:managedBy, name:name, tags:tags}" -o json)
    
    # Extract details from the JSON response and assign them to variables
    id=$(jq -r '.id' <<< "$rg_info")
    location=$(jq -r '.location' <<< "$rg_info")
    managedBy=$(jq -r '.managedBy' <<< "$rg_info")
    name=$(jq -r '.name' <<< "$rg_info")
    tags=$(jq -r '.tags' <<< "$rg_info")
    
    # Generate a configuration file with the resource group details
    generate_rg_config_file "$id" "$location" "$managedBy" "$name" "$tags"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# create Ressource Group config's directories first
function create_rg_config_dir() 
{
#|#  Nom de la fonction    : create_rg_config_dir
#|#  Description           : Vérifie si un répertoire de configuration existe pour un groupe de ressources spécifié. Si ce n'est pas le cas, la fonction crée le répertoire et initie un scan du groupe de ressources. La fonction empêche également de relancer la configuration plus d'une fois.
#|#  Paramètres:
#|#      _Rgname           : Le nom du groupe de ressources passé en paramètre (obligatoire).
#|#      Runned_config     : Compteur pour suivre le nombre de fois que la configuration a été exécutée.
#|#  Utilisation           : create_rg_config_dir "_Rgname"
#|#  Retour                : Aucun (Crée le répertoire de configuration et scanne les ressources si nécessaire).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Assigner le nom du groupe de ressources passé en paramètre
local _Rgname="${1}"

# Vérifier si la fonction a déjà été exécutée plusieurs fois
if [[ ${Runned_config} -gt 1 ]]; then 
    MSG_DISPLAY "check" "0" "Vérification de la fonction create_rg_config_dir"
    MSG_DISPLAY "EdEMessage" "2" "La configuration a déjà été exécutée plusieurs fois."  # Exit avec un message d'erreur si exécutée plusieurs fois
else 
    MSG_DISPLAY "check" "0" "Vérification du répertoire de configuration pour le groupe de ressources ${_Rgname}"
    
    # Vérifier si le répertoire de configuration pour le groupe de ressources existe déjà
    if [[ ! -d ./RGRoot/${_Rgname}/config ]]; then 
        MSG_DISPLAY "EdWMessage" "1" "Création du répertoire de configuration."
        
        # Créer le répertoire de configuration pour le groupe de ressources
        mkdir -p ./RGRoot/${_Rgname}/config
        
        # Changer de répertoire pour le groupe de ressources et initier un scan des ressources
        cd ./RGRoot/${_Rgname} || exit
        scan_resource_group "${_Rgname}"
        
        # Retourner au répertoire d'origine
        cd - > /dev/null
    else 
        # Si le répertoire de configuration existe déjà, réinitialiser le compteur d'exécution
        MSG_DISPLAY "EdSMessage" "1" "Répertoire de configuration déjà existant."
        Runned_config="0"
    fi 
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# create Ressource Group directories
function create_rg_dir() 
{
#|#  Nom de la fonction    : create_rg_dir
#|#  Description           : Vérifie si une structure de répertoire existe pour un groupe de ressources spécifié. Si elle n'existe pas, la fonction crée le répertoire et y copie les fichiers nécessaires. La fonction empêche également de relancer la configuration plus d'une fois.
#|#  Paramètres:
#|#      _Rgname           : Le nom du groupe de ressources passé en paramètre (obligatoire).
#|#      Runned_config     : Compteur pour suivre le nombre de fois que la configuration a été exécutée.
#|#  Utilisation           : create_rg_dir "_Rgname"
#|#  Retour                : Aucun (Crée la structure de répertoire et copie les fichiers si nécessaire).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Assigner le nom du groupe de ressources passé en paramètre
local _Rgname="${1}"

# Vérifier si la fonction a déjà été exécutée plusieurs fois
if [[ ${Runned_config} -gt 1 ]]; then 
    MSG_DISPLAY "check" "0" "Vérification de la fonction create_rg_dir"
    MSG_DISPLAY "EdEMessage" "2" "La configuration a déjà été exécutée plusieurs fois."  # Exit avec un message d'erreur si exécutée plusieurs fois
else 
    MSG_DISPLAY "check" "0" "Vérification du répertoire pour le groupe de ressources ${_Rgname}"
    
    # Vérifier si le répertoire pour le groupe de ressources existe déjà
    if [[ ! -d ./RGRoot/${_Rgname} ]]; then 
        MSG_DISPLAY "EdWMessage" "1" "Création du répertoire pour le groupe de ressources."

        # Créer la structure de répertoire pour le groupe de ressources
        mkdir -p ./RGRoot/${_Rgname}/log
        
        # Copier les fichiers nécessaires dans le répertoire nouvellement créé
        cp ./lib/generics/rg/*.sh ./RGRoot/${_Rgname}/
        cp ./lib/generics/rg/gitignore-tpl ./RGRoot/${_Rgname}/.gitignore
        
        # Incrémenter le compteur d'exécution et relancer la fonction
        Runned_config=$((Runned_config + 1))
        create_rg_dir "${_Rgname}"
    else 
        # Si le répertoire existe déjà, réinitialiser le compteur d'exécution
        MSG_DISPLAY "EdSMessage" "1" "Le répertoire de configuration existe déjà."
        Runned_config="0"
    fi 
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# create Ressource Groupe object ?
function create_rg_subobject() 
{
#|#  Nom de la fonction    : create_rg_subobject
#|#  Description           : Récupère la liste des ressources au sein d'un groupe de ressources spécifié, crée des répertoires pour chaque ressource, et génère des fichiers de configuration contenant les détails de chaque ressource.
#|#  Paramètres:
#|#      _Rgname           : Le nom du groupe de ressources passé en paramètre (obligatoire).
#|#      OBJECTS           : Variable pour stocker la liste des objets du groupe de ressources.
#|#      OBJECT_NAME       : Variable pour stocker le nom de chaque objet de ressource.
#|#      OBJECT_TYPE       : Variable pour stocker le type de chaque objet de ressource.
#|#      OBJECT_DETAILS    : Variable pour stocker les informations détaillées sur chaque objet de ressource.
#|#  Utilisation           : create_rg_subobject "_Rgname"
#|#  Retour                : Aucun (Effectue des actions basées sur les ressources dans le groupe de ressources spécifié).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Assigner le nom du groupe de ressources passé en paramètre
local _Rgname="${1}"

# Récupérer la liste des objets de ressources dans le groupe de ressources spécifié
OBJECTS=$(az resource list --resource-group "${_Rgname}" --query "[].{name:name, type:type}" -o json)

# Boucle à travers chaque objet pour générer la structure de répertoire et les fichiers de configuration
echo "${OBJECTS}" | jq -c '.[]' | while read -r OBJECT; do
    # Extraire le nom et le type de l'objet de ressource
    OBJECT_NAME=$(echo "${OBJECT}" | jq -r '.name')
    OBJECT_TYPE=$(echo "${OBJECT}" | jq -r '.type')
    
    # Créer un répertoire pour l'objet de ressource
    mkdir -p "${OBJECT_NAME}/config"
    
    # Récupérer les détails de l'objet de ressource
    OBJECT_DETAILS=$(az resource show --resource-group "${_Rgname}" --name "${OBJECT_NAME}" --resource-type "${OBJECT_TYPE}" -o json)
    
    # Convertir les détails de l'objet en variables shell et les écrire dans config.sh
    echo "# Configuration pour l'objet ${OBJECT_NAME}" > "${OBJECT_NAME}/config/config.sh"
    echo "${OBJECT_DETAILS}" | jq -r 'to_entries | .[] | "" + (.key | ascii_upcase) + "=" + "\"" + (.value | tostring) + "\""' >> "${OBJECT_NAME}/config/config.sh"
    
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Fonction pour vérifier l'existence d'un groupe de ressources
function get_all_resource_group() 
{
#|#  Nom de la fonction    : get_all_resource_group
#|#  Description           : Récupère et affiche la liste de tous les groupes de ressources disponibles dans l'abonnement Azure.
#|#  Paramètres:
#|#      _resource_group_name : Nom du groupe de ressources à rechercher (facultatif).
#|#  Utilisation           : get_all_resource_group "resource_group_name"
#|#  Retour                : Affiche la liste de tous les groupes de ressources.
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _resource_group_name="${1:-}"

# Vérification de la connexion à Azure
MSG_DISPLAY "check" "0" "Vérification de la connexion à Azure"
az account show &> /dev/null
CTRL_Result_func "${?}" "Connexion à Azure vérifiée" "Non connecté à Azure. Exécutez 'az login' pour vous connecter." "1"

if [[ $? -ne 0 ]]; then
    MSG_DISPLAY "error" "1" "Non connecté à Azure. Exécutez 'az login' pour vous connecter."
    exit 1
fi

# Récupération de la liste de tous les groupes de ressources dans l'abonnement Azure
MSG_DISPLAY "check" "0" "Récupération de la liste des groupes de ressources"
local _resource_groups
_resource_groups=$(az group list --query "[].name" --output tsv)
CTRL_Result_func "${?}" "Récupération des groupes de ressources réussie" "Échec de la récupération des groupes de ressources" "1"

# Affichage des groupes de ressources récupérés
if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Liste des groupes de ressources trouvés :"
    echo "${_resource_groups}"
else
    MSG_DISPLAY "error" "1" "Erreur lors de la récupération des groupes de ressources."
    exit 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}
 
#TODO [X] create function to check if ressource group is present
function Check_ressource_group() 
{
#|#  Nom de la fonction    : Check_ressource_group
#|#  Description           : Vérifie si un groupe de ressources existe. Si ce n'est pas le cas, l'utilisateur est invité à en créer un. La fonction gère également le cas où la vérification a été effectuée plusieurs fois pour éviter les boucles infinies.
#|#  Paramètres:
#|#      Runned_on_ok       : Variable pour suivre le nombre de fois que la vérification a été effectuée.
#|#      resource_exists    : Variable pour vérifier si un groupe de ressources existe.
#|#      create_ressource_choice : Variable pour stocker le choix de l'utilisateur pour créer un groupe de ressources.
#|#  Utilisation           : Check_ressource_group
#|#  Retour                : Aucun (Effectue des actions basées sur l'entrée de l'utilisateur et l'état du groupe de ressources).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Vérifier si la fonction a déjà été exécutée plusieurs fois pour éviter les boucles infinies
if [[ ${Runned_on_ok} -gt 1 ]]; then
    MSG_DISPLAY "check" "0" "Vérification des états du groupe de ressources"
    MSG_DISPLAY "EdWMessage" "1" "La fonction a déjà été exécutée plusieurs fois, arrêt."
    exit 1
else
    MSG_DISPLAY "check" "0" "Vérification des états du groupe de ressources"
    
    # Récupérer tous les groupes de ressources disponibles
    get_all_resource_group

    # Vérifier si aucun groupe de ressources n'existe
    if [[ -z "$resource_exists" ]]; then
        MSG_DISPLAY "EdWMessage" "1" "Aucun groupe de ressources trouvé."
        echo "Il n'existe aucun groupe de ressources."
        
        # Demander à l'utilisateur s'il souhaite créer un groupe de ressources
        read -p "Voulez-vous créer un groupe de ressources ? [y/n] " create_ressource_choice
        
        # Si l'utilisateur choisit de créer un groupe de ressources
        if [[ "$create_ressource_choice" =~ ^[Yy]$ ]]; then
            az login
            read -p "Entrer un nom pour le groupe de ressources : " ressource_groupe_name
            read -p "Choisir un emplacement pour le groupe de ressources : " ressource_groupe_location 
            
            # Créer le groupe de ressources
            az group create --name "${ressource_groupe_name}" --location "${ressource_groupe_location}"
            
            # Incrémenter le compteur et relancer la vérification
            Runned_on_ok=$((Runned_on_ok + 1))
            Check_ressource_group

        elif [[ "$create_ressource_choice" =~ ^[Nn]$ ]]; then
            # Si l'utilisateur ne veut pas créer un groupe de ressources, relancer la fonction avec le compteur mis à jour
            Runned_on_ok=$((Runned_on_ok + 1))
            Check_ressource_group
        fi
    else
        MSG_DISPLAY "EdSMessage" "1" "Un groupe de ressources existe déjà."
        Runned_on_ok="0"
    fi
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function create_ressource_group() 
{
#|#  Nom de la fonction    : create_ressource_group
#|#  Description           : Vérifie si un groupe de ressources existe dans Azure. Si le groupe n'existe pas, il est créé à l'emplacement spécifié.
#|#  Paramètres:
#|#      _ressource_group_name : Nom du groupe de ressources à créer ou vérifier (obligatoire).
#|#      _location             : Localisation pour la création du groupe de ressources (obligatoire).
#|#  Utilisation           : create_ressource_group "ressource_group_name" "location"
#|#  Retour                : Aucun (affiche les messages de déploiement ou d'erreur).
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

MSG_DISPLAY "debug" "0" "Chemin actuel de la fonction : [ ${Function_PATH} ] | Nom de la fonction : [ ${Function_Name} ]"

# Variables locales assignées par les paramètres
local _ressource_group_name="${1}"
local _location="${2}"

# Contrôle des variables vides
Empty_Var_Control "${_ressource_group_name}" "_ressource_group_name" "2" "Le nom du groupe de ressources est requis."
Empty_Var_Control "${_location}" "_location" "2" "La localisation est requise."

# Vérification de l'existence du groupe de ressources
MSG_DISPLAY "check" "0" "Vérification de la présence du groupe de ressources '${_ressource_group_name}'"
az group show --name "${_ressource_group_name}" &>> ${log_file}

if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Le groupe de ressources '${_ressource_group_name}' est déjà déployé."
else
    MSG_DISPLAY "info" "0" "Le groupe de ressources '${_ressource_group_name}' n'existe pas. Création en cours..."
    
    # Création du groupe de ressources
    az group create --name "${_ressource_group_name}" --location "${_location}" &>> ${log_file}
    CTRL_Result_func "${?}" "Création du groupe de ressources" "Échec de la création du groupe de ressources" "1"
    
    if [[ $? -eq 0 ]]; then
        MSG_DISPLAY "info" "0" "Groupe de ressources '${_ressource_group_name}' déployé avec succès."
    else
        MSG_DISPLAY "error" "1" "Erreur lors du déploiement du groupe de ressources '${_ressource_group_name}'."
        exit 1
    fi
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"