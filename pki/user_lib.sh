#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024  
# INFO                                                             
# Subject : This library provides functions to manage user TLS certificates.

function Create_user_cert() {
#|# Var to set  : 
#|# ${1}        : Mandatory - User FQDN (e.g., "user.domain.com")
#|# ${2}        : Mandatory - Certificate Authority (CA) (e.g., "CA_Name")
#|# ${3}        : Mandatory - Common Name (CN) for the certificate (e.g., "User Name")
#|# ${4}        : Mandatory - Key Usage (e.g., "digitalSignature, keyEncipherment")
#|# ${5}        : Mandatory - Extended Key Usage (e.g., "clientAuth, serverAuth")
#|# ${6}        : Mandatory - Subject Alternative Name (SAN) (e.g., "DNS:user.domain.com")
#|#
#|# Base usage  : Create_user_cert "user.domain.com" "CA_Name" "User Name" "digitalSignature, keyEncipherment" "clientAuth, serverAuth" "DNS:user.domain.com"
#|#
#|# Description : This function creates a TLS certificate for a user by generating the key, CSR, and the final certificate. It ensures the proper directory structure and checks for existing files before creation.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

  local _userFQDN="${1}"
  local _Authority="${2}"
  local _CommonName="${3}"
  local _KeyUsage="${4}"
  local _ExtKeyUsage="${5}"
  local _UserSAN="${6}"
  
  local _CerName="${_userFQDN}.crt"
   
  _sub_01_G_Create_user_cert

  MSG_DISPLAY "Info" "1" "Checking key for ${_userFQDN}" 
  File_Ctrl_Exist "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/${_userFQDN}/private/${_userFQDN}.key" "Dont_Create_file" "0" "_sub_01_F_Create_user_key" ""

  MSG_DISPLAY "Info" "1" "Checking CSR for ${_userFQDN}"
  File_Ctrl_Exist "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/csr/${_userFQDN}.csr" "Dont_Create_file" "0" "_sub_01_F_Create_user_csr" ""

  MSG_DISPLAY "Info" "1" "Checking certificate for ${_userFQDN}"
  File_Ctrl_Exist "${BDir_Data_Security_pki_deleg_ac}/${_IntermediagSign}/certs/${_IntermediagSign}.crt" "Dont_Create_file" "0" "_sub_01_F_Create_user_crt" ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_G_Create_user_cert() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_G_Create_user_cert
#|#
#|# Description : Creates the directory structure needed for the user's certificate files.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

  Directory_CRT "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts"
  Directory_CRT "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}"
  Directory_CRT "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/certs"
  Directory_CRT "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/private"
  Directory_CRT "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/csr"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_F_Create_user_key() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_F_Create_user_key
#|#
#|# Description : Generates a private key for the user. The key size varies based on the authority.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    MSG_DISPLAY "Info" "1" "Generating key"
    CTRL_Result_func "_sub_01_sub_01_F_Create_user_key" "1" "Generating user key" "" "" "" ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_sub_01_F_Create_user_key() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_sub_01_F_Create_user_key
#|#
#|# Description : Generates the private key file with the appropriate encryption and size.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    if [ "${_Authority}" = "vmintra.plume.spa.indus.cs-novidys.tech" ]; then
      openssl genrsa -aes256 -out "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/private/${_userFQDN}.key" -passout file:"${BDir_Data_Security_pki_configuration}/passphrase.txt" 4096
    else
      openssl genrsa -aes256 -out "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/private/${_userFQDN}.key" -passout file:"${BDir_Data_Security_pki_configuration}/passphrase.txt" 8192
    fi
    Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_F_Create_user_csr() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_F_Create_user_csr
#|#
#|# Description : Generates a Certificate Signing Request (CSR) for the user.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    MSG_DISPLAY "Info" "1" "Generating CSR"
    CTRL_Result_func "_sub_01_sub_01_F_Create_user_csr" "1" "Generating user CSR" "" "" "" ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_sub_01_F_Create_user_csr() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_sub_01_F_Create_user_csr
#|#
#|# Description : Uses OpenSSL to generate the CSR based on the provided parameters.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    _cmd="UserSAN=${_UserSAN} ExtKeyUsage=${_ExtKeyUsage} KeyUsage=${_KeyUsage} CommonName=${_userFQDN} openssl req -new -config ${BDir_Data_Security_pki_configuration}/users/${_Authority}.conf -out ${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/csr/${_userFQDN}.csr -passin file:${BDir_Data_Security_pki_configuration}/passphrase.txt -key ${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/private/${_userFQDN}.key"
    eval "${_cmd}"
    Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_F_Create_user_crt() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_F_Create_user_crt
#|#
#|# Description : Generates the user certificate and optionally creates a PKCS#12 file for easy import into user applications.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    MSG_DISPLAY "Info" "1" "Generating certificate"
    CTRL_Result_func "_sub_01_sub_01_F_Create_user_crt" "1" "Generating user certificate" "" "" "" ""
    CTRL_Result_func "_sub_01_sub_01_F_Create_user_p12" "1" "Generating PKCS#12 file" "" "" "" ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_sub_01_F_Create_user_crt() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_sub_01_F_Create_user_crt
#|#
#|# Description : Uses OpenSSL to sign the CSR and create the certificate.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    _cmd="UserSAN=${_UserSAN} ExtKeyUsage=${_ExtKeyUsage} KeyUsage=${_KeyUsage} CommonName=${_userFQDN} openssl ca -config ${BDir_Data_Security_pki_configuration}/users/${_Authority}.conf -in ${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/csr/${_userFQDN}.csr -passin file:${BDir_Data_Security_pki_configuration}/passphrase.txt -out ${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/certs/${_userFQDN}.crt -extensions user_ext -batch"
    eval "${_cmd}"
    Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_sub_01_F_Create_user_p12() {
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_sub_01_F_Create_user_p12
#|#
#|# Description : Creates a PKCS#12 file from the user's private key and certificate for easy import.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

  openssl pkcs12 -export -in "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/certs/${_userFQDN}.crt" -inkey "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/private/${_userFQDN}.key" -out "${BDir_Data_Security_pki_deleg_ac}/${_Authority}/childcerts/${_userFQDN}/private/${_userFQDN}.p12" -passin file:"${BDir_Data_Security_pki_configuration}/passphrase.txt" -passout file:"${BDir_Data_Security_pki_configuration}/password.txt"
  Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function generate_users_configs() {
#|# Var to set  : 
#|# ${1}        : Mandatory - Fully Qualified Domain Name (FQDN) of the user (e.g., "user.domain.com")
#|#
#|# Base usage  : generate_users_configs "user.domain.com"
#|#
#|# Description : Generates the configuration file required for creating user certificates, based on the FQDN and other user-specific data.
#|#
#|# Send Back   : Configuration file content
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    _PAth_Deph="$(echo "${glb_FQDN}" | awk -F '.' '{ print NF }' )"
    _PAth_Deph="$((${_PAth_Deph}-2))"

    # Configuration content starts here
    echo "# User certificate request"
    echo "# Simple Signing CA"
    echo ""
    echo "# The [default] section contains global constants that can be referred to from"
    echo "# the entire configuration file."
    echo "[ default ]"
    echo "ca                      = ${glb_FQDN}"
    echo "dir                     = \$ENV::BASE_CA_DIR"    
    echo ""
    echo "# The next part of the configuration file is used by the openssl req command."
    echo "# It defines the user's key pair, its DN, and the desired extensions."
    echo "[ req ]"
    if [ "${glb_FQDN}" = "vmintra.plume.spa.indus.cs-novidys.tech" ]; then
      echo "default_bits            = 4096"
    else
      echo "default_bits            = 8192"
    fi
    echo "default_md              = sha512"
    echo "utf8                    = yes"
    echo "string_mask             = utf8only"
    echo "prompt                  = no"
    echo "distinguished_name      = user_dn"
    echo "req_extensions          = user_reqext"
    echo ""
    echo "[ ca_dn ]"
    gen_domain "${glb_FQDN}"
    echo "commonName              = \"${glb_FQDN}\""
    echo "emailAddress            = \"pki@cs-novidys.tech\""
    echo ""
    echo "[ ca_reqext ]"
    echo "keyUsage                = critical,keyCertSign,cRLSign"
    echo "basicConstraints        = critical,CA:true,pathlen:${_PAth_Deph}"
    echo "subjectKeyIdentifier    = hash"
    echo "subjectAltName          = DNS:${glb_FQDN}"
    echo ""
    echo "# The remainder of the configuration file is used by the openssl ca command."
    echo "[ ca ]"
    echo "default_ca              = signing_ca"
    echo ""
    echo "[ signing_ca ]"
    echo "certificate             = \$dir/generated_certs/intermediates/\$ca/certs/\$ca.crt"
    echo "private_key             = \$dir/generated_certs/intermediates/\$ca/private/\$ca.key"
    echo "new_certs_dir           = \$dir/generated_certs/intermediates/\$ca"
    echo "serial                  = \$dir/generated_certs/intermediates/\$ca/db/\$ca.crt.srl"
    echo "crlnumber               = \$dir/generated_certs/intermediates/\$ca/db/\$ca.crl.srl"
    echo "database                = \$dir/generated_certs/intermediates/\$ca/db/\$ca.db"
    echo "unique_subject          = no"
    echo "default_days            = 2920"
    echo "default_md              = sha512"
    echo "policy                  = match_pol"
    echo "email_in_dn             = no"
    echo "preserve                = no"
    echo "name_opt                = ca_default"
    echo "cert_opt                = ca_default"
    echo "copy_extensions         = copy"
    echo "x509_extensions         = signing_ca_ext"
    echo "default_crl_days        = 7"
    echo "crl_extensions          = crl_ext"
    echo ""
    echo "[ match_pol ]"
    echo "domainComponent         = supplied"
    echo "organizationalUnitName  = optional"
    echo "commonName              = supplied"
    echo ""
    echo "[ signing_ca_ext ]"
    echo "subjectKeyIdentifier    = hash"
    echo "authorityKeyIdentifier  = keyid:always,issuer"
    echo "basicConstraints        = critical, CA:true, pathlen:${_PAth_Deph}"
    echo "keyUsage                = critical, digitalSignature, cRLSign, keyCertSign"
    echo ""
    echo "[ user_dn ]"
    gen_domain "${glb_FQDN}"
    echo "commonName              = \$ENV::CommonName"
    echo "emailAddress            = \"${glb_FQDN}@cs-novidys.tech\""
    echo ""
    echo "[ user_reqext ]"
    echo "keyUsage                = \$ENV::KeyUsage"
    if [ "$ExtKeyUsage" != "empty" ]; then
      echo "extendedKeyUsage        = \$ENV::ExtKeyUsage"
    fi
    echo "subjectKeyIdentifier    = hash"
    echo "subjectAltName          = \$ENV::UserSAN"
    echo ""
    echo "[ user_ext ]"
    echo "keyUsage                = \$ENV::KeyUsage"
    if [ "$ExtKeyUsage" != "empty" ]; then
      echo "extendedKeyUsage        = \$ENV::ExtKeyUsage"
    fi
    echo "basicConstraints        = CA:false"
    echo "subjectKeyIdentifier    = hash"
    echo "authorityKeyIdentifier  = keyid:always"
}

# Sourcing control variable 
LibState="OK"  

