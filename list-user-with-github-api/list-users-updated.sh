#!/bin/bash

##################################
## Maintainer : Nanda Hein 
## How to use this script 
## export username=your_github_username
## export token=your_github_personal_access_token
## ./list-users-updated.sh <REPO_OWNER> <REPO_NAME>
##################################

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information (to be provided as arguments)
REPO_OWNER=$1
REPO_NAME=$2

# Helper function to check if the required two arguments are provided
function helper {
    if [[ -z "$REPO_OWNER" || -z "$REPO_NAME" ]]; then
        echo "Please run with 2 required arguments: REPO_OWNER and REPO_NAME"
        exit 1  # Exit the script if arguments are missing
    else
        # If arguments are provided, invoke the function to list users with read access
        list_users_with_read_access
    fi
}

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read or write access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read or write access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Main script

# Check if the required arguments are passed, if not show a message and exit
helper
