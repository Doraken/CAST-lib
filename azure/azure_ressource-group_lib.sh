#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure ressource group managment from CAST


# generate Ressource Group config file with config.cnf
function generate_rg_config_file() 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "
    local id="${1}"
    local location="${2}"
    local managedBy="${3:-NotsSet}"
    local name="${4:-NotsSet}"
    local tags="${5:-NotsSet}"

    Empty_Var_Control "${id}"        "id"         "2" 
    Empty_Var_Control "${location}"  "location"   "2" 
    Empty_Var_Control "${managedBy}" "managedBy"  "2" 
    # Empty_Var_Control "${name}" ""  "2"
    Empty_Var_Control "${tags}"      "tags"       "2" 
 

    local config_file="./config/config.sh"


    echo "Generating configuration file: $config_file"
    
    cat <<EOL > $config_file
resourceGroup="$( basename $( pwd )) "    
ID="${id}"
LOCATION="${location}"
MANAGEDBY="${managedBy}"
NAME="${name}"
ConfigRessourceGroupeState="OK"
EOL
}

# Fonction pour scanner le groupe de ressources et générer le fichier de configuration
function scan_resource_group() 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "
    local rg="${1}"
    Empty_Var_Control "${rg}"        "rg"        "" "2" 

    echo "Scanning resource group: ${rg}"
    
    # Récupérer les informations du groupe de ressources
    rg_info=$(az group show --name $rg --query "{id:id, location:location, managedBy:managedBy, name:name, tags:tags}" -o json)
    
    # Lire les informations et générer le fichier de configuration
    id=$(jq -r '.id' <<< "$rg_info")
    location=$(jq -r '.location' <<< "$rg_info")
    managedBy=$(jq -r '.managedBy' <<< "$rg_info")
    name=$(jq -r '.name' <<< "$rg_info")
    tags=$(jq -r '.tags' <<< "$rg_info")
    generate_rg_config_file "$id" "$location" "$managedBy" "$name" "$tags"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# create Ressource Group config's directories first
function create_rg_config_dir ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "

  local Rgname="${1}"
  if [ ${Runned_config} -gt 1 ]
   then 
       MSG_DISPLAY "check" "0" "checking function create_rg_config_dir"
       MSG_DISPLAY "EdEMessage" "2" ""
   else 
      MSG_DISPLAY "check" "0" "checking configuration directory for ressource groupe ${Rgname}" 
      if  [ ! -d  ./RGRoot/${Rgname}/config ]
        then 
          MSG_DISPLAY "EdWMessage" "1" ""
          mkdir ./RGRoot/${Rgname}/config
          cd ./RGRoot/${Rgname}
          scan_resource_group ${Rgname}
          cd ../../
        else 
          MSG_DISPLAY "EdSMessage" "1" ""
          Runned_config="0"
      fi 
fi


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# create Ressource Group directories
function create_rg_dir ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "
  local Rgname="${1}"
  if [ ${Runned_config} -gt 1 ]
   then 
       MSG_DISPLAY "check" "0" "checking function create_rg_dir"
       MSG_DISPLAY "EdEMessage" "2" ""
   else 
      MSG_DISPLAY "check" "0" "checking directory for ressource groupe ${Rgname}" 
      if  [ ! -d ./RGRoot/${Rgname} ]
        then 
          MSG_DISPLAY "EdWMessage" "1" ""
          mkdir ./RGRoot/${Rgname}
          mkdir ./RGRoot/${Rgname}/log
          cp ./lib/generics/rg/*.sh ./RGRoot/${repo}/
          cp ./lib/generics/rg/gitignore-tpl ./RGRoot/${repo}/.gitignore
          Runned_config=$( expr ${Runned_config} + 1 )
          create_rg_dir "${Rgname}"
        else 
          MSG_DISPLAY "EdSMessage" "1" ""
          Runned_config="0"
      fi 
  fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# create Ressource Groupe object ?
function create_rg_subobject () 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "
  local Rgname="${1}"
  # gathering ressource group object list
  OBJECTS=$(az resource list --resource-group ${Rgname} --query "[].{name:name, type:type}" -o json)

  # Boucle sur chaque objet et génère la structure de répertoires et fichiers
  echo "${OBJECTS}" | jq -c '.[]' | while read -r OBJECT; do
    OBJECT_NAME=$(echo ${OBJECT} | jq -r '.name')
    OBJECT_TYPE=$(echo ${OBJECT} | jq -r '.type')
    
    # Crée le répertoire pour l'objet
    mkdir -p "$OBJECT_NAME/config"
    
    # Récupère les détails de l'objet
    OBJECT_DETAILS=$(az resource show --resource-group ${Rgname} --name ${OBJECT_NAME} --resource-type ${OBJECT_TYPE} -o json)
    
    # Convertit les détails de l'objet en variables shell et écrit dans config.sh
    echo "# Configuration pour l'objet ${OBJECT_NAME}" > "${OBJECT_NAME}/config/config.sh"
    echo "$OBJECT_DETAILS" | jq -r 'to_entries | .[] | "" + (.key | ascii_upcase) + "=" + "\"" + (.value | tostring) + "\""' >> "${OBJECT_NAME}/config/config.sh"
    
done
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Fonction pour vérifier l'existence d'un groupe de ressources
function get_all_resource_group() {
    local resource_group_name=$1

    # Obtenir la liste des groupes de ressources
    resource_groups=$(az group list --query "[].name" --output tsv)

    # Afficher tous les groupes de ressources
    echo "Liste des groupes de ressources trouvés :"
    echo "$resource_groups"

}
 
#TODO [X] create function to check if ressource group is present
function Check_ressource_group ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | Function Name [ ${Function_Name} ]  "

  if [ ${Runned_on_ok} -gt 1 ]
    then
      MSG_DISPLAY "check" "0" "checking states ressource groupe"
      MSG_DISPLAY "EdWMessage" "1" ""
      exit 1
    else
      MSG_DISPLAY "check" "0" "checking states ressource groupe"
      
      get_all_resource_group()

      if [ ! -z "$resource_exists" ]
        then
          MSG_DISPLAY "EdWMessage" "1" ""
          echo "Il n'existe aucune ressource groupe."
          read -p "Voulez-vous créer un groupe de ressource ? [y/n]" create_ressource_choice
            if [[ "$create_ressource_choice" =~ $y ]]
              then
              az login
              read -p "Entrer un nom : " ressource_groupe_name
              # TODO [] mettre un switch case pour emplacement voir la conf
              read -p "Choisir un emplacement : " ressource_groupe_location 
              az group create --name ${ressource_groupe_name} --location ${essource_groupe_location}

              Runned_on_ok=$( expr ${Runned_on_ok} + 1)
              Check_ressource_group
            fi
            if [[ "$create_ressource_choice" =~ $n ]]
              then
              Runned_on_ok=$( expr ${Runned_on_ok} + 1)
              Check_ressource_group
            fi
        else
          MSG_DISPLAY "EdSMessage" "1" ""
          Runned_on_ok="0"
      fi    
  fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# Sourcing control variable 
LibState="OK"