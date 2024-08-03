#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure object generator tool from CAST 

# Liste des objets Azure avec leurs bigrammes

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

