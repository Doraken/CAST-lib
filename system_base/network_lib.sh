function Get_Network_Interfaces_Mac_Address ()
{
#|# Var utilisée : 
#|#                declare -A Network_Interfaces_Mac_Array : tableau associatif contenant les noms des interfaces réseau et leur adresse MAC
#|# Usage : 
#|#              Get_Network_Interfaces_Mac_Address
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

# Déclaration du tableau associatif
declare -A Network_Interfaces_Mac_Array

# Récupération des informations des interfaces réseau
while read -r line; do
    Interface_Name=$(echo $line | awk '{print $1}')
    Mac_Address=$(echo $line | awk '{print $2}')
    
    # Ajout de l'interface et de son adresse MAC au tableau associatif
    Network_Interfaces_Mac_Array[$Interface_Name]=$Mac_Address
done < <(ip link show | awk '/^[0-9]/ {getline; print $2, $2}' | awk '{print $1, $3}')

MSG_DISPLAY "info" "0" "Network interfaces with MAC addresses stored in associative array"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Display_Network_Interfaces_Mac ()
{
#|# Usage : 
#|#              Display_Network_Interfaces_Mac
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

# Affichage des informations formatées
printf "%-20s %-20s\n" "Interface Name" "MAC Address"
printf "%-20s %-20s\n" "--------------------" "--------------------"

for Interface_Name in "${!Network_Interfaces_Mac_Array[@]}"; do
    Mac_Address="${Network_Interfaces_Mac_Array[$Interface_Name]}"
    
    # Affichage formaté
    printf "%-20s %-20s\n" "$Interface_Name" "$Mac_Address"
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Display_IP_Addresses_Interface_With_MAC ()
{
#|# Usage : 
#|#              Display_IP_Addresses_Interface_With_MAC
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

# Affichage des informations formatées
printf "%-20s %-20s %-20s\n" "IP Address" "Interface Name" "MAC Address"
printf "%-20s %-20s %-20s\n" "--------------------" "--------------------" "--------------------"

for IP_Address in "${!IP_Addresses_Interface_Array[@]}"; do
    Interface_Name="${IP_Addresses_Interface_Array[$IP_Address]}"
    Mac_Address=$(ip link show "$Interface_Name" | awk '/ether/ {print $2}')
    
    # Affichage formaté
    printf "%-20s %-20s %-20s\n" "$IP_Address" "$Interface_Name" "$Mac_Address"
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Get_Destination_Networks_By_Interface ()
{
#|# Var utilisée : 
#|#                declare -A Destination_Networks_Interface_Array : tableau associatif contenant les interfaces réseau et les réseaux de destination
#|# Usage : 
#|#              Get_Destination_Networks_By_Interface
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

# Déclaration du tableau associatif
declare -A Destination_Networks_Interface_Array

# Récupération des informations des réseaux de destination et des interfaces
while read -r line; do
    Network_Destination=$(echo $line | awk '{print $1}')
    Interface_Name=$(echo $line | awk '{print $3}')
    
    # Ajout du réseau de destination à l'interface correspondante
    if [[ -n "${Destination_Networks_Interface_Array[$Interface_Name]}" ]]; then
        Destination_Networks_Interface_Array[$Interface_Name]+=" $Network_Destination"
    else
        Destination_Networks_Interface_Array[$Interface_Name]="$Network_Destination"
    fi
done < <(ip route | awk '$1 ~ /^[0-9]/ {print $1, $3}')

MSG_DISPLAY "info" "0" "Destination networks by interface stored in associative array"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Get_Gateways_By_Interface ()
{
#|# Var utilisée : 
#|#                declare -A Gateways_Interface_Array : tableau associatif contenant les interfaces réseau et les passerelles associées
#|# Usage : 
#|#              Get_Gateways_By_Interface
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

# Déclaration du tableau associatif
declare -A Gateways_Interface_Array

# Récupération des informations des routes et des interfaces
while read -r line; do
    Gateway=$(echo $line | awk '{print $2}')
    Interface_Name=$(echo $line | awk '{print $4}')
    
    # Ajout de la passerelle à l'interface correspondante
    if [[ -n "${Gateways_Interface_Array[$Interface_Name]}" ]]; then
        Gateways_Interface_Array[$Interface_Name]+=" $Gateway"
    else
        Gateways_Interface_Array[$Interface_Name]="$Gateway"
    fi
done < <(ip route | awk '/via/ {print $1, $3, $5}')

MSG_DISPLAY "info" "0" "Gateways by interface stored in associative array"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Get_Destination_Networks_By_Gateway ()
{
#|# Var utilisée : 
#|#                declare -A Destination_Networks_Gateway_Array : tableau associatif contenant les passerelles et les réseaux de destination
#|# Usage : 
#|#              Get_Destination_Networks_By_Gateway
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

# Déclaration du tableau associatif
declare -A Destination_Networks_Gateway_Array

# Récupération des informations des réseaux de destination et des passerelles
while read -r line; do
    Network_Destination=$(echo $line | awk '{print $1}')
    Gateway=$(echo $line | awk '{print $2}')
    
    # Ajout du réseau de destination à la passerelle correspondante
    if [[ -n "${Destination_Networks_Gateway_Array[$Gateway]}" ]]; then
        Destination_Networks_Gateway_Array[$Gateway]+=" $Network_Destination"
    else
        Destination_Networks_Gateway_Array[$Gateway]="$Network_Destination"
    fi
done < <(ip route | awk '/via/ {print $1, $3}')

MSG_DISPLAY "info" "0" "Destination networks by gateway stored in associative array"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Display_Routes_Network_Gateway_Interface ()
{
#|# Usage : 
#|#              Display_Routes_Network_Gateway_Interface
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

# Affichage des informations formatées
printf "%-20s %-20s %-20s\n" "Network" "Gateway" "Interface"
printf "%-20s %-20s %-20s\n" "--------------------" "--------------------" "--------------------"

# Boucle sur les routes pour afficher réseau, gateway, et interface
while read -r line; do
    Network_Destination=$(echo $line | awk '{print $1}')
    Gateway=$(echo $line | awk '{print $2}')
    Interface_Name=$(echo $line | awk '{print $3}')
    
    # Affichage formaté
    printf "%-20s %-20s %-20s\n" "$Network_Destination" "$Gateway" "$Interface_Name"
done < <(ip route | awk '/via/ {print $1, $3, $5}')

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Modify_Network_Route ()
{
#|# Paramètres : 
#|#                $1 - Réseau cible (ex: 192.168.1.0/24)
#|#                $2 - Nouvelle passerelle (ex: 192.168.1.1)
#|#                $3 - Interface (ex: eth0)
#|# Usage : 
#|#              Modify_Network_Route "réseau_cible" "nouvelle_passerelle" "interface"
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

# Vérification des paramètres
if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
    echo "Usage: Modify_Network_Route <réseau_cible> <nouvelle_passerelle> <interface>"
    return 1
fi

# Paramètres d'entrée
Network_Target="$1"
New_Gateway="$2"
Interface_Name="$3"

# Suppression de l'ancienne route
ip route del "$Network_Target" &>/dev/null
if [[ $? -ne 0 ]]; then
    MSG_DISPLAY "error" "0" "Failed to delete the existing route for $Network_Target"
    return 1
fi

# Ajout de la nouvelle route
ip route add "$Network_Target" via "$New_Gateway" dev "$Interface_Name"
if [[ $? -eq 0 ]]; then
    MSG_DISPLAY "info" "0" "Successfully updated the route for $Network_Target to go via $New_Gateway on $Interface_Name"
else
    MSG_DISPLAY "error" "0" "Failed to add the new route for $Network_Target"
    return 1
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


# Sourcing control variable 
LibState="OK"