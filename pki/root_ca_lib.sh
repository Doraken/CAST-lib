#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024  
# INFO                                                             
# Subject : This library provides functions to create and manage a Root Certificate Authority (CA).

function Create_Root_CA () 
{
#|# Var to set  : None
#|# ${1}        : None
#|#
#|# Base usage  : Create_Root_CA
#|#
#|# Description : This function creates the Root Certificate Authority (CA) by generating the key, CSR, and the final certificate. It ensures the proper directory structure and checks for existing files before creation.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    printf "Generating root authority\n"
    _sub_01_G_Create_Root_CA

    MSG_DISPLAY "Info" "1" "Checking for root key"
    File_Ctrl_Exist "${BDir_Data_Security_pki_root_ac}/private/root-ca.key" "Dont_Create_file" "0" "_sub_01_F_Create_Root_CA_key" ""

    MSG_DISPLAY "Info" "1" "Checking for root cert"
    File_Ctrl_Exist "${BDir_Data_Security_pki_root_ac}/certs/root-ca.crt" "Dont_Create_file" "0" "_sub_01_F_Create_Root_CA_crt" ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_G_Create_Root_CA () 
{
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_G_Create_Root_CA
#|#
#|# Description : Creates the directory structure needed for the Root CA files.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    Directory_CRT "${BDir_Data_Security_pki_root_ac}"
    Directory_CRT "${BDir_Data_Security_pki_root_ac}/db"
    Directory_CRT "${BDir_Data_Security_pki_root_ac}/crl"
    Directory_CRT "${BDir_Data_Security_pki_root_ac}/certs"
    Directory_CRT "${BDir_Data_Security_pki_root_ac}/csr"
    Directory_CRT "${BDir_Data_Security_pki_root_ac}/private"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_F_Create_Root_CA_key () 
{
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_F_Create_Root_CA_key
#|#
#|# Description : Generates the private key for the Root CA.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    printf "[GENERATING]\n"
    MSG_DISPLAY "Info" "1" "Initializing DB for Root CA"
    File_Ctrl_Exist "${BDir_Data_Security_pki_root_ac}/db/root-ca.db" "Create_file" "1"
    File_Ctrl_Exist "${BDir_Data_Security_pki_root_ac}/db/root-ca.db.attr" "Create_file" "1"
    MSG_DISPLAY "Info" "1" "Initializing serial number for Root CA"
    printf "01" > "${BDir_Data_Security_pki_root_ac}/db/root-ca.crt.srl"
    printf "01" > "${BDir_Data_Security_pki_root_ac}/root-ca.crl.srl"
    _sub_00_sub_01_F_Create_Root_CA_conf 
    CTRL_Result_func "_sub_01_sub_01_F_Create_Root_CA_key" "1" "Generating ROOT RSA KEY" "" "" "" ""
    CTRL_Result_func "_sub_02_sub_01_F_Create_Root_CA_key" "1" "Generating ROOT CERT" "" "" "" ""

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_00_sub_01_F_Create_Root_CA_conf () 
{
#|# Var to set  : None
#|#
#|# Base usage  : _sub_00_sub_01_F_Create_Root_CA_conf
#|#
#|# Description : Checks for the existence of the configuration file for the Root CA. If it doesn't exist, it generates a new one.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    MSG_DISPLAY "Check" "1" "Checking configuration file: [ ${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf ]"
    if [ -f "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf" ]; then 
        MSG_DISPLAY "EdSMessage" "1" "OK"
    else 
        generate_rootca_configs 
        if [ -f "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf" ]; then 
            MSG_DISPLAY "EdSMessage" "1" "OK"
        else 
            MSG_DISPLAY "EdEMessage" "1" "KO"
        fi 
    fi  

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_sub_01_F_Create_Root_CA_key () 
{
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_sub_01_F_Create_Root_CA_key
#|#
#|# Description : Uses OpenSSL to generate the RSA key for the Root CA.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    openssl genrsa -aes256 -out "${BDir_Data_Security_pki_root_ac}/private/root-ca.key" -passout file:"${BDir_Data_Security_pki_configuration}/passphrase.txt" 8192
    Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_02_sub_01_F_Create_Root_CA_key () 
{
#|# Var to set  : None
#|#
#|# Base usage  : _sub_02_sub_01_F_Create_Root_CA_key
#|#
#|# Description : Uses OpenSSL to create the CSR for the Root CA.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    export CA_NAME=root-ca
    openssl req -new -config "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf" -out "${BDir_Data_Security_pki_root_ac}/csr/root-ca.csr" -passin file:"${BDir_Data_Security_pki_configuration}/passphrase.txt" -key "${BDir_Data_Security_pki_root_ac}/private/root-ca.key"
    Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function _sub_01_F_Create_Root_CA_crt () 
{
#|# Var to set  : None
#|#
#|# Base usage  : _sub_01_F_Create_Root_CA_crt
#|#
#|# Description : Uses OpenSSL to generate the Root CA certificate.
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    printf "[GENERATING ROOT_CA]\n"
    CA_NAME=root-ca openssl ca -selfsign -config "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf" -in "${BDir_Data_Security_pki_root_ac}/csr/root-ca.csr" -passin file:"${BDir_Data_Security_pki_configuration}/passphrase.txt" -out "${BDir_Data_Security_pki_root_ac}/certs/root-ca.crt" -extensions root_ca_ext -batch
    Global_Exec_stat="${?}"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function get_root_conf_state () 
{
#|# Var to set  : None
#|#
#|# Base usage  : get_root_conf_state
#|#
#|# Description : Checks if the Root CA configuration file exists and returns its state.
#|#
#|# Send Back   : Sets the variable `ca_root_state` to "READY" or "NOT READY".
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    MSG_DISPLAY "Check" "1" "Sourcing sub configuration: [ ${confs} ]"
    if [ -f "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf" ]
        then 
            local ca_root_state="READY"
            MSG_DISPLAY "EdSMessage" "1" "${ca_root_state}"
        else 
            local ca_root_state="NOT READY"
            MSG_DISPLAY "End_Global" "1" "${ca_root_state}"
    fi 

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function generate_rootca_configs () 
{
#|# Var to set  : 
#|# ${1}        : None
#|#
#|# Base usage  : generate_rootca_configs
#|#
#|# Description : Generates a configuration file for the Root CA.
#|#
#|# Send Back   : Generates a root-ca.conf file in the configuration directory.
############ STACK_TRACE_BUILDER #####################
local Function_Name="${FUNCNAME[0]}"
local Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ] | function Name [ ${Function_Name} ]"

    printf "# Simple Root CA\n"                                                                            > "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "# The [default] section contains global constants that can be referred to from\n"             >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "# the entire configuration file. It may also hold settings pertaining to more\n"              >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "# than one openssl command.\n"                                                                >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ default ]\n"                                                                              >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "ca                      = root-ca         # CA name\n"                                        >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "dir                     = ..     # Top dir\n"                                                 >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ req ]\n"                                                                                  >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "default_bits            = ${pki_cert_length}    # RSA key size\n"                             >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "encrypt_key             = yes                   # Protect private key\n"                      >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "default_md              = ${pki_cert_encode}    # MD to use\n"                                >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "utf8                    = yes                   # Input is UTF-8\n"                           >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "string_mask             = ${pki_string_match}   # Emit UTF-8 strings\n"                       >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "prompt                  = no                    # Don't prompt for DN\n"                      >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "distinguished_name      = ca_dn                 # DN section\n"                               >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "req_extensions          = ca_reqext             # Desired extensions\n"                       >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ ca_dn ]\n"                                                                                >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "0.domainComponent        = \"tech\"\n"                                                        >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "#1.domainComponent       = \"cs-novidys\"\n"                                                  >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "#organizationName        = ${pki_organizationName}\n"                                         >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "#organizationalUnitName  = \"CS novidys SPD\"\n"                                              >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "commonName               = \"cs-novidys\"\n"                                                  >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "#countryName             = \"FR\"\n"                                                          >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "#stateOrProvinceName     = \"IDF\"\n"                                                         >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "#localityName            = \"Paris\"\n"                                                       >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "emailAddress             = \"${pki_mail_default}\"\n"                                         >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ ca_reqext ]\n"                                                                            >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "keyUsage                = critical,keyCertSign,cRLSign\n"                                     >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "basicConstraints        = critical,CA:true\n"                                                 >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "subjectKeyIdentifier    = hash\n"                                                             >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ ca ]\n"                                                                                   >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "default_ca              = root_ca               # The default CA section\n"                   >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ root_ca ]\n"                                                                              >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "certificate             = \$dir/generated_certs/\$ca/certs/\$ca.crt   # The CA cert\n"        >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "private_key             = \$dir/generated_certs/\$ca/private/\$ca.key # CA private key\n"     >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "new_certs_dir           = \$dir/generated_certs/\$ca                 # Certificate archive\n" >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "serial                  = \$dir/generated_certs/\$ca/db/\$ca.crt.srl  # Serial number file\n" >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "crlnumber               = \$dir/generated_certs/\$ca/db/\$ca.crl.srl  # CRL number file\n"    >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "database                = \$dir/generated_certs/\$ca/db/\$ca.db    # Index file\n"            >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "unique_subject          = no                    # Require unique subject\n"                   >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "default_days            = 3652                  # How long to certify for\n"                  >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "default_md              = sha512                # MD to use\n"                                >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "policy                  = match_pol             # Default naming policy\n"                    >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "email_in_dn             = no                    # Add email to cert DN\n"                     >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "preserve                = no                    # Keep passed DN ordering\n"                  >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "name_opt                = ca_default            # Subject DN display options\n"               >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "cert_opt                = ca_default            # Certificate display options\n"              >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "copy_extensions         = none                  # Copy extensions from CSR\n"                 >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "x509_extensions         = signing_ca_ext        # Default cert extensions\n"                  >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "default_crl_days        = 365                   # How long before next CRL\n"                 >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "crl_extensions          = crl_ext               # CRL extensions\n"                           >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ match_pol ]\n"                                                                            >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "domainComponent          = optional              # Must match 'simple.org'\n"                 >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "#organizationName        = match                 # Must match 'Simple Inc'\n"                 >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "#organizationalUnitName  = optional              # Included if present\n"                     >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "commonName               = supplied              # Must be present\n"                         >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ root_ca_ext ]\n"                                                                          >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "keyUsage                = critical,keyCertSign,cRLSign\n"                                     >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "basicConstraints        = critical,CA:true\n"                                                 >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "subjectKeyIdentifier    = hash\n"                                                             >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "authorityKeyIdentifier  = keyid:always,issuer\n"                                              >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ signing_ca_ext ]\n"                                                                       >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "keyUsage                = critical,keyCertSign,cRLSign\n"                                     >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "basicConstraints        = critical,CA:true\n"                                                 >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "subjectKeyIdentifier    = hash\n"                                                             >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "authorityKeyIdentifier  = keyid:always,issuer\n"                                              >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ v3_ca ]\n"                                                                                >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "# Extensions for a typical CA.\n"                                                             >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "subjectKeyIdentifier = hash\n"                                                                >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "authorityKeyIdentifier = keyid:always,issuer\n"                                               >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "basicConstraints = critical, CA:true\n"                                                       >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "keyUsage = critical, digitalSignature, cRLSign, keyCertSign\n"                                >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "\n[ crl_ext ]\n"                                                                              >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"
    printf "authorityKeyIdentifier  = keyid:always\n"                                                     >> "${BDir_Data_Security_pki_configuration}/${ROOT_CA}/root-ca.conf"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"  
