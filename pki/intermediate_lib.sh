#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024  
# INFO                                                             
# Subject : This library provides functions to create and manage Intermediate Certificate Authority (CA) configurations and certificates.

function generate_intermediate_configs() 
{
#|# Var to set  : 
#|# ${1}        : Mandatory - FQDN for the Intermediate CA (e.g., "intermediate.example.com")
#|#
#|# Base usage  : generate_intermediate_configs "intermediate.example.com"
#|#
#|# Description : Generates the configuration file for an Intermediate CA based on the provided FQDN.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "Current function path: [ ${Function_PATH} ] | Function Name: [ ${Function_Name} ]"

    local CommonName="${1%%.*}"
    local configs="${1#*.}"
    
    local config_file="${BDir_Data_Security_pki_configuration}/intermediates/${CommonName}.conf"
    printf "# Simple Signing CA\n" > "${config_file}"
    printf "# This configuration file defines the Intermediate CA settings.\n\n" >> "${config_file}"

    printf "[ default ]\n" >> "${config_file}"
    printf "ca = ${CommonName}.${configs}\n" >> "${config_file}"
    printf "dir = \$ENV::BASE_CA_DIR\n\n" >> "${config_file}"

    printf "[ req ]\n" >> "${config_file}"
    printf "default_bits = 8192\n" >> "${config_file}"
    printf "default_md = sha512\n" >> "${config_file}"
    printf "utf8 = yes\n" >> "${config_file}"
    printf "string_mask = utf8only\n" >> "${config_file}"
    printf "prompt = no\n" >> "${config_file}"
    printf "distinguished_name = ca_dn\n" >> "${config_file}"
    printf "req_extensions = ca_reqext\n\n" >> "${config_file}"

    printf "[ ca_dn ]\n" >> "${config_file}"
    gen_domain "${configs}" >> "${config_file}"
    printf "commonName = \"${CommonName}\"\n" >> "${config_file}"
    printf "emailAddress = \"${GLB_PKI_MAIL}\"\n\n" >> "${config_file}"

    printf "[ ca_reqext ]\n" >> "${config_file}"
    printf "keyUsage = critical,keyCertSign,cRLSign\n" >> "${config_file}"
    printf "basicConstraints = critical,CA:true\n" >> "${config_file}"
    printf "subjectKeyIdentifier = hash\n" >> "${config_file}"
    printf "subjectAltName = DNS:${configs}\n\n" >> "${config_file}"

    printf "[ ca ]\n" >> "${config_file}"
    printf "default_ca = signing_ca\n\n" >> "${config_file}"

    printf "[ signing_ca ]\n" >> "${config_file}"
    printf "certificate = \$dir/generated_certs/intermediates/\$ca/certs/\$ca.crt\n" >> "${config_file}"
    printf "private_key = \$dir/generated_certs/intermediates/\$ca/private/\$ca.key\n" >> "${config_file}"
    printf "new_certs_dir = \$dir/generated_certs/intermediates/\$ca\n" >> "${config_file}"
    printf "serial = \$dir/generated_certs/intermediates/\$ca/db/\$ca.crt.srl\n" >> "${config_file}"
    printf "crlnumber = \$dir/generated_certs/intermediates/\$ca/db/\$ca.crl.srl\n" >> "${config_file}"
    printf "database = \$dir/generated_certs/intermediates/\$ca/db/\$ca.db\n" >> "${config_file}"
    printf "unique_subject = no\n" >> "${config_file}"
    printf "default_days = 2920\n" >> "${config_file}"
    printf "default_md = sha512\n" >> "${config_file}"
    printf "policy = match_pol\n" >> "${config_file}"
    printf "email_in_dn = no\n" >> "${config_file}"
    printf "preserve = no\n" >> "${config_file}"
    printf "name_opt = ca_default\n" >> "${config_file}"
    printf "cert_opt = ca_default\n" >> "${config_file}"
    printf "copy_extensions = copy\n" >> "${config_file}"
    printf "x509_extensions = signing_ca_ext\n" >> "${config_file}"
    printf "default_crl_days = 183\n" >> "${config_file}"
    printf "crl_extensions = crl_ext\n\n" >> "${config_file}"

    printf "[ match_pol ]\n" >> "${config_file}"
    printf "domainComponent = supplied\n" >> "${config_file}"
    printf "organizationalUnitName = optional\n" >> "${config_file}"
    printf "commonName = supplied\n\n" >> "${config_file}"

    printf "[ signing_ca_ext ]\n" >> "${config_file}"
    printf "subjectKeyIdentifier = hash\n" >> "${config_file}"
    printf "authorityKeyIdentifier = keyid:always,issuer\n" >> "${config_file}"
    printf "basicConstraints = critical, CA:true\n" >> "${config_file}"
    printf "keyUsage = critical, digitalSignature, cRLSign, keyCertSign\n\n" >> "${config_file}"

    printf "[ crl_ext ]\n" >> "${config_file}"
    printf "authorityKeyIdentifier = keyid:always\n\n" >> "${config_file}"

    printf "[ server_ext ]\n" >> "${config_file}"
    printf "keyUsage = critical,digitalSignature,keyEncipherment\n" >> "${config_file}"
    printf "basicConstraints = CA:false\n" >> "${config_file}"
    printf "extendedKeyUsage = serverAuth,clientAuth\n" >> "${config_file}"
    printf "subjectKeyIdentifier = hash\n" >> "${config_file}"
    printf "authorityKeyIdentifier = keyid:always\n\n" >> "${config_file}"

    printf "[ root_ca_ext ]\n" >> "${config_file}"
    printf "keyUsage = critical,keyCertSign,cRLSign\n" >> "${config_file}"
    printf "basicConstraints = critical,CA:true\n" >> "${config_file}"
    printf "subjectKeyIdentifier = hash\n" >> "${config_file}"
    printf "authorityKeyIdentifier = keyid:always,issuer\n" >> "${config_file}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"  
