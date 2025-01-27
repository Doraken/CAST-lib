#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST 

# Liste des objets Azure avec leurs bigrammes

function azure_devops_init ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

Set_new_directory "${BDir_Data_Plateformes_Infrastruture_Azure}/${infra_organization}" 
Set_new_directory "${BDir_Data_Plateformes_Infrastruture_Azure}/${application_organization}" 

get_azure_devops_credential


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function get_azure_devops_credential ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

if [[ ! ${init_azure_devops} -ge 1 ]]
   then 
       MSG_DISPLAY "check" "0" "Checking credential store"
       if [[ -f ${Base_Dir_Scripts_cred}/running.cred ]]
          then 
              . ${Base_Dir_Scripts_cred}/running.cred
              MSG_DISPLAY "EdSMessage" "2" "FOUND"
          else 
              MSG_DISPLAY "EdWMessage" "2" "NOT FOUND"
       fi 
       MSG_DISPLAY "check" "0" "Checking credential PAT for devops"
       if [[ -z ${PAT_devops} ]] 
            then 
                MSG_DISPLAY "EdWMessage" "2" "NOT FOUND"
                read -p "Please give your personal access tocken: " PAT_devops
            else 
                MSG_DISPLAY "EdSMessage" "2" "FOUND"
        fi
        init_azure_devops="1"
    else 
        if [[ -z ${PAT_devops} ]] 
            then 
                MSG_DISPLAY "check" "0" "Checking azure personal access tocken"
                MSG_DISPLAY "EdEMessage" "2" "NOT FOUND"
        fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function get_azure_devops_organization ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

get_azure_devops_credential

   # Encode PAT for basic auth
    local encoded_pat=$(printf ":${PAT_devops}" | base64)

    # URL for Azure DevOps organizations API
    local api_url="https://app.vssps.visualstudio.com/_apis/accounts?memberId=${login_devop}&api-version=6.0"
   
    # Call the API and get the list of organizations
    local response=$(curl -s -H "Authorization: Basic ${encoded_pat}" "${api_url}")

    # Parse and print the organization names
    echo "List of Azure DevOps organizations:"
    echo "${response}" | jq -r '.value[].accountName'



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function get_all_azure_gits ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
    
    local GIT_BASE_ORGA_NAME="${1}"
    local project_list
    local repo_list

    
    

    # Set the organization for Azure DevOps
    az devops configure --defaults organization=https://${GIT_BASE_DNS}/${GIT_BASE_ORGA_NAME}


    # Get a list of all projects in the organization
    project_list=$(az devops project list --query "value[].name" -o tsv)




    MSG_DISPLAY "info" "0" "List of projects in the Azure DevOps subscription:"
    # Loop through each project and get the list of repositories
    for project in ${project_list}
    do
        MSG_DISPLAY "info" "0" "    Project ${project}"

        Set_new_directory "${BDir_Data_Plateformes_Infrastruture_Azure}/${GIT_BASE_ORGA_NAME}/${project}"
        # Get the list of repositories for the current project
        repo_list=$(az repos list --project "${project}" --query "[].name" -o tsv)
        
        # Check if the project has repositories
        MSG_DISPLAY "check" "0" "Check if the project has repositories"
        if [ -z "${repo_list}" ]
        then
            MSG_DISPLAY "EdWMessage" "2" "NOT FOUND"
        else
            MSG_DISPLAY "EdSMessage" "2" "FOUND"
            # Loop through each repository and print its name
            for repo in ${repo_list}
            do
                MSG_DISPLAY "info" "0" " Repository: ${repo}"
                Do_get_git_clone "GIT_BASE_SSH_URL/${GIT_BASE_ORGA_NAME}/${project}" " ${BDir_Data_Plateformes_Infrastruture_Azure}/${GIT_BASE_ORGA_NAME}/${project}" "${repo}"
            done
        fi
    done


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

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

