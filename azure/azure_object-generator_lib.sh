#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure object generator tool from CAST 

# Liste des objets Azure avec leurs bigrammes


function Get_Azure_Resource_Types
{
#|# Var to set  : None
#|# Base usage  : Get_Azure_Resource_Types
#|# Description : Cette fonction génère la liste des types d'objets disponibles sous Azure
#|# Send Back   : Liste des objets disponibles

############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

# Vérification que l'utilisateur est connecté à Azure
MSG_DISPLAY "check" "0" "Vérification de la connexion Azure"
az account show > /dev/null 2>&1
CTRL_Result_func "${?}" "Vérification de la connexion Azure" "Impossible de vérifier la connexion à Azure. Veuillez vous connecter." "1"

# Récupération de la liste des types de ressources disponibles sous Azure
MSG_DISPLAY "info" "0" "Récupération de la liste des types de ressources disponibles sous Azure"
RESOURCE_TYPES=$(az provider list --query "[].resourceTypes[].resourceType" -o json)

# Vérification du succès de la récupération des types de ressources
CTRL_Result_func "${?}" "Récupération des types de ressources" "Impossible de récupérer la liste des types de ressources disponibles sous Azure." "1"

# Affichage des types de ressources
MSG_DISPLAY "info" "0" "Liste des types de ressources disponibles sous Azure :"
echo "${RESOURCE_TYPES}" | jq -r '.[]'

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_Azure_Resource_Types_As_Array ()
{
#|# Var to set  : None
#|# Base usage  : Get_Azure_Resource_Types_As_Array
#|# Description : This function populates an existing associative array with Azure resource types, using modified names (with underscores instead of slashes) as keys and original names as values.
#|# Send Back   : An associative array with modified resource names as keys and original names as values.
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################

# Clear the existing associative array
RESOURCE_TYPES_ARRAY=()

# Check if the user is logged into Azure
MSG_DISPLAY "check" "0" "Checking Azure login status"
az account show > /dev/null 2>&1
CTRL_Result_func "${?}" "Checking Azure login" "Unable to verify Azure login. Please log in." "1"

# Retrieve the list of available Azure resource types
MSG_DISPLAY "info" "0" "Retrieving list of available Azure resource types"
RESOURCE_TYPES=$(az provider list --query "[].resourceTypes[].resourceType" -o json )

# Check if the resource types retrieval was successful
CTRL_Result_func "${?}" "Retrieving resource types" "Failed to retrieve the list of available Azure resource types." "1"

# Use a for loop to iterate over the unique sorted resource types
for RESOURCE_TYPE in $(echo "${RESOURCE_TYPES}" | jq -r '.[]' | sort -u )
 do
    RESOURCE_KEY=$(echo "${RESOURCE_TYPE}" | sed 's/\//_/g')
    
    # Check if the modified name (key) already exists in the array
        echo "RESOURCE_TYPES_ARRAY[${RESOURCE_KEY}]=${RESOURCE_TYPE}"
        RESOURCE_TYPES_ARRAY["${RESOURCE_KEY}"]="${RESOURCE_TYPE}"

done

############### STACK_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}






function Display_Azure_Resource_Types ()
{
#|# Var to set  : Associative array to display
#|# Base usage  : Display_Azure_Resource_Types "Associative array"
#|# Description : This function displays the content of an associative array in a formatted table.
#|# Send Back   : Displays the key-value pairs of the associative array in a table format

############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

# Retrieve the associative array passed as an argument
# Get_Azure_Resource_Types_As_Array

# Determine the maximum length of keys and values for formatting
max_key_length=0
max_value_length=0

for key in "${!RESOURCE_TYPES_ARRAY[@]}"
do
    # Update max length for keys
    if [[ ${#key} -gt $max_key_length ]]; then
        max_key_length=${#key}
    fi
    
    # Update max length for values
    if [[ ${#RESOURCE_TYPES_ARRAY[$key]} -gt $max_value_length ]]; then
        max_value_length=${#RESOURCE_TYPES_ARRAY[$key]}
    fi
done

# Adjust column widths to the maximum lengths, adding some padding
key_column_width=$((max_key_length + 2))
value_column_width=$((max_value_length + 2))

# Display the associative array in a formatted table
MSG_DISPLAY "info" "0" "Azure Resource Types Associative Array:"

# Table headers with dynamic width
printf "%-${key_column_width}s | %-${value_column_width}s\n" "Original Object Name" "Modified Object Name"
printf "%-${key_column_width}s | %-${value_column_width}s\n" "$(printf '%.s-' $(seq $key_column_width))" "$(printf '%.s-' $(seq $value_column_width))"

# Iterate and display key-value pairs with dynamic width
for key in "${!RESOURCE_TYPES_ARRAY[@]}"
do
    printf "%-${key_column_width}s | %-${value_column_width}s\n" "${key}" "${RESOURCE_TYPES_ARRAY[$key]}"
done

############### STACK_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}




function object_creation () 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

  local_bigramme "${1}"  

   case ${local_bigramme} in 
        vn) MSG_DISPLAY "EdSMessage" "0" "Virtual Network"
        ;;
        sn) MSG_DISPLAY "EdSMessage" "0" "Subnet"
        ;;
        ni) MSG_DISPLAY "EdSMessage" "0" "Network Interface"
        ;;
        ns) MSG_DISPLAY "EdSMessage" "0" "Network Security Group"
        ;;
        pi) MSG_DISPLAY "EdSMessage" "0" "Public IP Address"
        ;;
        il) MSG_DISPLAY "EdSMessage" "0" "Internal Load Balancer"
        ;;
        el) MSG_DISPLAY "EdSMessage" "0" "External Load Balancer"
        ;;
        ag) MSG_DISPLAY "EdSMessage" "0" "Azure Application Gateway"
        ;;
        pe) MSG_DISPLAY "EdSMessage" "0" "Peering"
        ;;
        gw) MSG_DISPLAY "EdSMessage" "0" "Gateway"
        ;;
        nr) MSG_DISPLAY "EdSMessage" "0" "Network Security Group Rule"
        ;;
        rt) MSG_DISPLAY "EdSMessage" "0" "Route Table"
        ;;
        er) MSG_DISPLAY "EdSMessage" "0" "ExpressRoute Circuit"
        ;;
        tm) MSG_DISPLAY "EdSMessage" "0" "Traffic Manager Profile"
        ;;
        cn) MSG_DISPLAY "EdSMessage" "0" "Connection"
        ;;
        as) MSG_DISPLAY "EdSMessage" "0" "Application Security Group"
        ;;
        mg) MSG_DISPLAY "EdSMessage" "0" "Management Groups"
        ;;
        lb) MSG_DISPLAY "EdSMessage" "0" "Load Balancer"
        ;;
        di) MSG_DISPLAY "EdSMessage" "0" "Zone DNS interne"
        ;;
        dp) MSG_DISPLAY "EdSMessage" "0" "Zone DNS public"
        ;;
        fw) MSG_DISPLAY "EdSMessage" "0" "Firewall service"
        ;;
        pr) MSG_DISPLAY "EdSMessage" "0" "Proxy"
        ;;
        ok) MSG_DISPLAY "EdSMessage" "0" "Disk"
        ;;
        st) MSG_DISPLAY "EdSMessage" "0" "Storage"
        ;;
        sa) MSG_DISPLAY "EdSMessage" "0" "Storage Account"
        ;;
        rv) MSG_DISPLAY "EdSMessage" "0" "Recovery Service Vault"
        ;;
        kv) MSG_DISPLAY "EdSMessage" "0" "Key Vault"
        ;;
        io) MSG_DISPLAY "EdSMessage" "0" "Image OS"
        ;;
        fs) MSG_DISPLAY "EdSMessage" "0" "Filer, files server, NAS"
        ;;
        bk) MSG_DISPLAY "EdSMessage" "0" "Backup"
        ;;
        ad) MSG_DISPLAY "EdSMessage" "0" "Active Directory"
        ;;
        av) MSG_DISPLAY "EdSMessage" "0" "Anti-Virus, Anti-Spam"
        ;;
        ar) MSG_DISPLAY "EdSMessage" "0" "Archivage, archive solution"
        ;;
        bt) MSG_DISPLAY "EdSMessage" "0" "Batch server, ETL"
        ;;
        ft) MSG_DISPLAY "EdSMessage" "0" "FTP service, SFTP"
        ;;
        ls) MSG_DISPLAY "EdSMessage" "0" "License server"
        ;;
        ms) MSG_DISPLAY "EdSMessage" "0" "Monitoring server"
        ;;
        or) MSG_DISPLAY "EdSMessage" "0" "Orchestration"
        ;;
        up) MSG_DISPLAY "EdSMessage" "0" "Patching, Update, fixing"
        ;;
        rg) MSG_DISPLAY "EdSMessage" "0" "Resource Group"
        ;;
        rd) MSG_DISPLAY "EdSMessage" "0" "RDP, PMAD, srv de rebond"
        ;;
        sc) MSG_DISPLAY "EdSMessage" "0" "Scheduler server"
        ;;
        ss) MSG_DISPLAY "EdSMessage" "0" "Security for server, audit, compliance"
        ;;
        sm) MSG_DISPLAY "EdSMessage" "0" "SMTP"
        ;;
        ws) MSG_DISPLAY "EdSMessage" "0" "Web Server"
        ;;
        ap) MSG_DISPLAY "EdSMessage" "0" "Application Server"
        ;;
        db) MSG_DISPLAY "EdSMessage" "0" "DB Server"
        ;;
        ma) MSG_DISPLAY "EdSMessage" "0" "Master"
        ;;
esac
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}



LibState="OK"

