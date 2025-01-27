#!/bin/bash
# author: Arnaud Crampet
# Date: 04/08/2024
# Description: Library for interacting with GitHub API
#|# lib usage : 
#|#  Source the GitHub library
#|# source /path/to/github.lib.sh
#|# 
#|#  Set the GitHub API token
#|# Set_GitHub_Token "your_personal_access_token"
#|#  Create a new repository
#|# Do_GitHub_create_repo "new-repo" "This is a new repository" "false"



# Function to set the GitHub API token
function Set_GitHub_Token () 
{
    #|# GITHUB_API_TOKEN: Personal access token for GitHub API authentication
    #|# ${1}: Use this var to set [ GITHUB_API_TOKEN ]
    #|#
    #|# Base usage: Set_GitHub_Token "your_token_here"
    #|#
    #|# Description: This function sets the GitHub API token for authentication.

    local GITHUB_API_TOKEN="${1}"
    if [ -z "${GITHUB_API_TOKEN}" ]; then
        echo "GitHub API token is required."
        exit 1
    fi
    export GITHUB_API_TOKEN
}

# Function to create a GitHub repository
function Do_GitHub_create_repo () 
{
    #|# GITHUB_REPO_NAME: Name of the repository to be created
    #|# GITHUB_REPO_DESC: Description of the repository (optional)
    #|# GITHUB_REPO_PRIVATE: Privacy setting of the repository (true for private, false for public)
    #|# ${1}: Use this var to set [ GITHUB_REPO_NAME ]
    #|# ${2}: Use this var to set [ GITHUB_REPO_DESC ]
    #|# ${3}: Use this var to set [ GITHUB_REPO_PRIVATE ]
    #|#
    #|# Base usage: Do_GitHub_create_repo "repo_name" "repo_description" "true"
    #|#
    #|# Description: This function creates a GitHub repository using the GitHub API.

    local GITHUB_REPO_NAME="${1}"
    local GITHUB_REPO_DESC="${2}"
    local GITHUB_REPO_PRIVATE="${3:-false}"

    # Check for required arguments
    if [ -z "${GITHUB_REPO_NAME}" ]
     then
        echo "Repository name is required."
        exit 1
    fi

    # Construct the API request
    local API_URL="https://api.github.com/user/repos"
    local DATA=$(cat <<EOF
{
    "name": "${GITHUB_REPO_NAME}",
    "description": "${GITHUB_REPO_DESC}",
    "private": ${GITHUB_REPO_PRIVATE}
}
EOF
)

    # Make the API request
    curl -H "Authorization: token ${GITHUB_API_TOKEN}" \
         -H "Content-Type: application/json" \
         -d "${DATA}" \
         ${API_URL}
}

# Function to handle errors
function Manage_GitHub_Error () 
{
    #|# ERROR_MESSAGE: Error message to display
    #|# ${1}: Use this var to set [ ERROR_MESSAGE ]
    #|#
    #|# Base usage: Manage_GitHub_Error "An error occurred"
    #|#
    #|# Description: This function handles errors by displaying a message and exiting.

    local ERROR_MESSAGE="${1}"
    echo "Error: ${ERROR_MESSAGE}"
    exit 1
}

# Sourcing control variable 
LibState="OK"

