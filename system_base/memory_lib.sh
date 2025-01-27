function Get_Top_Memory_Consumers_Associative_Array ()
{
#|# Var utilisée : 
#|#                declare -A Top_Memory_Consumers_Assoc_Array : tableau associatif contenant les noms des processus et leur occupation mémoire
#|# Usage : 
#|#              Get_Top_Memory_Consumers_Associative_Array
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

# Déclaration du tableau associatif
declare -A Top_Memory_Consumers_Assoc_Array

# Récupération des informations des processus
while read -r line; do
    Process_Name=$(echo $line | awk '{print $11}')
    Memory_Usage=$(echo $line | awk '{print $4}')
    
    # Accumuler l'utilisation mémoire pour chaque processus
    if [[ -n "${Top_Memory_Consumers_Assoc_Array[$Process_Name]}" ]]; then
        Top_Memory_Consumers_Assoc_Array[$Process_Name]=$(echo "${Top_Memory_Consumers_Assoc_Array[$Process_Name]} + $Memory_Usage" | bc)
    else
        Top_Memory_Consumers_Assoc_Array[$Process_Name]=$Memory_Usage
    fi
done < <(ps aux --sort=-%mem | awk 'NR>1')

MSG_DISPLAY "info" "0" "Top memory-consuming processes stored in associative array"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Display_Top_Memory_Consumers_Assoc ()
{
#|# Usage : 
#|#              Display_Top_Memory_Consumers_Assoc
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "

# Affichage des informations formatées
printf "%-20s %-10s\n" "Process Name" "Memory Usage (%)"
printf "%-20s %-10s\n" "--------------------" "----------"

for Process_Name in "${!Top_Memory_Consumers_Assoc_Array[@]}"; do
    Memory_Usage="${Top_Memory_Consumers_Assoc_Array[$Process_Name]}"
    
    # Affichage formaté
    printf "%-20s %10.2f%%\n" "$Process_Name" "$Memory_Usage"
done

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"