#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024  
# INFO                                                             
# Subject : This library provides functions to manage server TLS certificates.

function Create_server_cert() {
#|# Var to set  : 
#|# ${1}        : Mandatory - Server FQDN (e.g., "server.domain.com")
#|# ${2}        : Mandatory - Certificate Authority (CA) (e.g., "CA_Name")
#|#
#|# Base usage  : Create_server_cert "server.domain.com" "CA_Name"
#|#
#|# Description : This function creates a TLS certificate for a server by generating the key, CSR, and the final certificate. It ensures the proper directory structure and checks for existing files before creation.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    local _serverFQDN="${1}"
    local _Authority="${2}"
    local _CerName="${_serverFQDN}.crt"
   
    _sub_01_G_Create_server_cert

    MSG_DISPLAY "Info" "1" "Checking key for ${_serverFQDN}" 
    File_Ctrl_Exist "${ROOT_SERVER_CERT}/${_serverFQDN}/private/${_serverFQDN}.key" "Dont_Create_file" "0"  "_sub_01_F_Create_server_key"  ""

    MSG_DISPLAY "Info" "1" "Checking CSR for ${_serverFQDN}"
    File_Ctrl_Exist "${ROOT_SERVER_CERT}/${_serverFQDN}/csr/${_serverFQDN}.csr" "Dont_Create_file" "0"  "_sub_01_F_Create_server_csr"  ""

    MSG_DISPLAY "Info" "1" "Checking certificate for ${_Authority}"  
    File_Ctrl_Exist "${ROOT_CA_INTERMEDIATE_dir}/${_Authority}/certs/${_Authority}.crt" "Dont_Create_file" "0"  "_sub_01_F_Create_server_crt"  ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_G_Create_server_cert() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_G_Create_server_cert
#|#
#|# Description : Creates the directory structure needed for the server's certificate files.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    Directory_CRT "${ROOT_SERVER_CERT}/${_serverFQDN}"
    Directory_CRT "${ROOT_SERVER_CERT}/${_serverFQDN}/certs"
    Directory_CRT "${ROOT_SERVER_CERT}/${_serverFQDN}/private"
    Directory_CRT "${ROOT_SERVER_CERT}/${_serverFQDN}/csr"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_F_Create_server_key() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_F_Create_server_key
#|#
#|# Description : Generates a private key for the server. The key is encrypted with AES256.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    CTRL_Result_func "_sub_01_sub_01_F_Create_server_key" "1" "Generating RSA KEY" "" "" "" ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_sub_01_F_Create_server_key() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_sub_01_F_Create_server_key
#|#
#|# Description : Generates the private key file with the appropriate encryption and size (8192 bits).
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    echo "openssl genrsa -aes256 -out ${ROOT_SERVER_CERT}/${_serverFQDN}/private/${_serverFQDN}.key -passout file:${BASE_CA_DIR}/config/passphrase.txt 8192" >> ${Base_Log_File}
    openssl genrsa -aes256 -out "${ROOT_SERVER_CERT}/${_serverFQDN}/private/${_serverFQDN}.key" -passout file:"${BASE_CA_DIR}/config/passphrase.txt" 8192
    Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_F_Create_server_csr() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_F_Create_server_csr
#|#
#|# Description : Generates a Certificate Signing Request (CSR) for the server.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    CTRL_Result_func "_sub_01_sub_01_F_Create_server_csr" "1" "Generating CSR" "" "" "" ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_sub_01_F_Create_server_csr() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_sub_01_F_Create_server_csr
#|#
#|# Description : Uses OpenSSL to generate the CSR based on the provided parameters.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    echo "openssl req -new -config ${BASE_CA_CONFIG_DIR}/servers/${_serverFQDN}.conf -out ${ROOT_SERVER_CERT}/${_serverFQDN}/csr/${_serverFQDN}.csr -passin file:${BASE_CA_DIR}/config/passphrase.txt -key ${ROOT_SERVER_CERT}/${_serverFQDN}/private/${_serverFQDN}.key" >> ${Base_Log_File}
    openssl req -new -config "${BASE_CA_CONFIG_DIR}/servers/${_serverFQDN}.conf" -out "${ROOT_SERVER_CERT}/${_serverFQDN}/csr/${_serverFQDN}.csr" -passin file:"${BASE_CA_DIR}/config/passphrase.txt" -key "${ROOT_SERVER_CERT}/${_serverFQDN}/private/${_serverFQDN}.key"
    Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_F_Create_server_crt() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_F_Create_server_crt
#|#
#|# Description : Generates the server certificate and optionally creates a PKCS#12 file for easy import into server applications.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    CTRL_Result_func "_sub_01_sub_01_F_Create_server_crt" "1" "Generating CRT file" "" "" "" ""
    CTRL_Result_func "_sub_02_sub_01_F_Create_server_crt" "1" "Generating PKCS#12 file" "" "" "" ""  

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_sub_01_F_Create_server_crt() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_sub_01_F_Create_server_crt
#|#
#|# Description : Uses OpenSSL to sign the CSR and create the certificate.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    echo "openssl ca -config ${BASE_CA_CONFIG_DIR}/intermediates/${_Authority}.conf -in ${ROOT_SERVER_CERT}/${_serverFQDN}/csr/${_serverFQDN}.csr -passin file:${BASE_CA_DIR}/config/passphrase.txt -out ${ROOT_SERVER_CERT}/${_serverFQDN}/certs/${_serverFQDN}.crt -extensions server_ext -batch" >> ${Base_Log_File}
    openssl ca -config "${BASE_CA_CONFIG_DIR}/intermediates/${_Authority}.conf" -in "${ROOT_SERVER_CERT}/${_serverFQDN}/csr/${_serverFQDN}.csr" -passin file:"${BASE_CA_DIR}/config/passphrase.txt" -out "${ROOT_SERVER_CERT}/${_serverFQDN}/certs/${_serverFQDN}.crt" -extensions server_ext -batch
    Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_02_sub_01_F_Create_server_crt() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_02_sub_01_F_Create_server_crt
#|#
#|# Description : Creates a PKCS#12 file from the server's private key and certificate for easy import.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    echo "openssl pkcs12 -export -in ${ROOT_SERVER_CERT}/${_serverFQDN}/certs/${_serverFQDN}.crt -inkey ${ROOT_SERVER_CERT}/${_serverFQDN}/private/${_serverFQDN}.key -out ${ROOT_SERVER_CERT}/${_serverFQDN}/private/${_serverFQDN}.p12 -passin file:${BASE_CA_DIR}/config/passphrase.txt -passout file:${BASE_CA_DIR}/config/password.txt" >> ${Base_Log_File}
    openssl pkcs12 -export -in "${ROOT_SERVER_CERT}/${_serverFQDN}/certs/${_serverFQDN}.crt" -inkey "${ROOT_SERVER_CERT}/${_serverFQDN}/private/${_serverFQDN}.key" -out "${ROOT_SERVER_CERT}/${_serverFQDN}/private/${_serverFQDN}.p12" -passin file:"${BASE_CA_DIR}/config/passphrase.txt" -passout file:"${BASE_CA_DIR}/config/password.txt"
    Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function generate_server_configs() {
#|# Var to set  : 
#|# ${1}        : Mandatory - Server FQDN (e.g., "server.domain.com")
#|#
#|# Base usage  : generate_server_configs "server.domain.com"
#|#
#|# Description : Generates the configuration file required for creating server certificates, based on the FQDN and other server-specific data.
#|#
#|# Send Back   : Configuration file content
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    local _PAth_Deph="$(echo "${glb_FQDN}" | awk -F '.' '{ print NF }')"
    local _PAth_Deph="$((${_PAth_Deph}-2))"

    # Configuration content starts here
    echo "# TLS server certificate request"
    echo "# Simple Signing CA"
    echo ""
    echo "# The [default] section contains global constants that can be referred to from"
    echo "# the entire configuration file."
    echo "[ default ]"
    echo "ca                      = ${glb_FQDN}"
    echo "dir                     = \$ENV::BASE_CA_DIR"    
    echo ""
    echo "# The next part of the configuration file is used by the openssl req command."
    echo "# It defines the server's key pair, its DN, and the desired extensions."
    echo "[ req ]"
    echo "default_bits            = 8192"
    echo "default_md              = sha512"
    echo "utf8                    = yes"
    echo "string_mask             = utf8only"
    echo "prompt                  = no"
    echo "distinguished_name      = server_dn"
    echo "req_extensions          = server_reqext"
    echo ""
    echo "[ server_dn ]"
    gen_domain "${glb_FQDN#*.}"
    echo "commonName              = \"${glb_FQDN%%.*}\""
    echo "emailAddress            = \"${GLB_PKI_MAIL}\""
    echo ""
    echo "[ server_reqext ]"
    echo "keyUsage                = critical,digitalSignature,keyEncipherment"
    echo "extendedKeyUsage        = serverAuth,clientAuth"
    echo "subjectKeyIdentifier    = hash"
    echo "subjectAltName          = DNS:${glb_FQDN}"
    echo ""
    echo "[ server_ext ]"
    echo "keyUsage                = critical,digitalSignature,keyEncipherment"
    echo "basicConstraints        = CA:false"
    echo "extendedKeyUsage        = serverAuth,clientAuth"
    echo "subjectKeyIdentifier    = hash"
    echo "authorityKeyIdentifier  = keyid:always"
}

# Sourcing control variable 
LibState="OK"  

