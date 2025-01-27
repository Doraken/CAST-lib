#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024  
# INFO                                                             
# Subject : This library provides functions to create and manage email certificates.

function do_Create_email_cert() 
{
#|# Var to set  : 
#|# ${1}        : Mandatory - Path to the CSR file (e.g., "certs/fred.csr")
#|# ${2}        : Mandatory - Path to the output certificate file (e.g., "certs/fred.crt")
#|# ${3}        : Optional - Configuration file (default: "etc/signing-ca.conf")
#|#
#|# Base usage  : do_Create_email_cert "certs/fred.csr" "certs/fred.crt"
#|#
#|# Description : This function creates an email certificate by signing the provided CSR using the specified configuration file.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "Current function path: [ ${Function_PATH} ] | Function Name: [ ${Function_Name} ]"

    local csr_file="${1}"
    local cert_file="${2}"
    local config_file="${3:-etc/signing-ca.conf}"

    if [[ -z "${csr_file}" || -z "${cert_file}" ]]; then
        MSG_DISPLAY "Error" "1" "CSR file and certificate output file are mandatory."
        return 1
    fi

    if [[ ! -f "${csr_file}" ]]; then
        MSG_DISPLAY "Error" "1" "CSR file not found: ${csr_file}"
        return 1
    fi

    if [[ ! -f "${config_file}" ]]; then
        MSG_DISPLAY "Error" "1" "Configuration file not found: ${config_file}"
        return 1
    fi

    MSG_DISPLAY "Info" "1" "Creating email certificate from CSR: ${csr_file}"
    openssl ca -config "${config_file}" -in "${csr_file}" -out "${cert_file}" -extensions email_ext -batch

    if [[ $? -eq 0 ]]; then
        MSG_DISPLAY "Success" "1" "Email certificate created successfully: ${cert_file}"
    else
        MSG_DISPLAY "Error" "1" "Failed to create email certificate."
        return 1
    fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"  
