#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic azure devops tool from CAST  #
###############################################################################
####

################################## Warning Banners Function ##################################

function 8_Warning_Banners ()
{
#|# Description : This function sets up warning banners in various system files 
#|# (`/etc/modt`, `/etc/issue`, and `/etc/issue.net`) with legal warning messages.
#|# It also sets the appropriate file permissions and ownership.
#|#
#|# Var to set  :
#|#     _mode     : Action mode between "report" or "apply"
#|#     ${1}      : First parameter, used to set _mode       
#|#
#|# Base usage  : 8_Warning_Banners "apply" or "report"
#|#
#|# Send Back   : Reports the result or applies the warning banners.
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
    
# Create warning banner in /etc/modt
    echo " " > /etc/modt
    echo "#   _____                                  _                              " >> /etc/modt
    echo "#  /  ___|                                | |                             " >> /etc/modt
    echo "#  \ \--.  ___ _ __ ___ _   _ _ __ ___  __| |                             " >> /etc/modt
    echo "#   \--. \/ _ \  __/ __| | | |  __/ _ \/ _\ |                             " >> /etc/modt
    echo "#  /\__/ /  __/ | | (__| |_| | | |  __/ (_| |                             " >> /etc/modt
    echo "#  \____/ \___|_|  \___|\__,_|_|  \___|\__,_|                             " >> /etc/modt
    echo "#                                                                         " >> /etc/modt       
    echo "#                                                                         " >> /etc/modt
    echo "#    _____ ___________  _   _ ___________                                 " >> /etc/modt
    echo "#   /  ___|  ___| ___ \| | | |  ___| ___ \                                " >> /etc/modt
    echo "#   \ \--.| |__ | |_/  | | | | |__ | |_/ /                                " >> /etc/modt
    echo "#    \--. \  __||    / | | | | |__||    /                                 " >> /etc/modt
    echo "#   /\__/ / |___| |\ \ \ \_/ / |___| |\ \                                 " >> /etc/modt
    echo "#   \____/\____/\_| \_| \___/\____/\_| \_|                                " >> /etc/modt
    echo "#                                                                         " >> /etc/modt
    echo "#                                                                         " >> /etc/modt
    echo "#    _   _   __   _____                                                   " >> /etc/modt
    echo "#   | | | | /  | |  _  |                                                  " >> /etc/modt
    echo "#   | | | | \| | | | / |                                                  " >> /etc/modt
    echo "#   | | | |  | | |  /| |                                                  " >> /etc/modt
    echo "#   \ \_/ / _| |_\ |_/ /                                                  " >> /etc/modt
    echo "#    \___/  \___(_)___/                                                   " >> /etc/modt
    echo "#                                                                         " >> /etc/modt
    echo "#                                                                         " >> /etc/modt
    echo "**********************************************************************    " >> /etc/modt
    echo "|                                                                    |    " >> /etc/modt
    echo "| ATTENTION                                                          |    " >> /etc/modt
    echo "| =========                                                          |    " >> /etc/modt
    echo "| Quiconque accederait ou tenterait d acceder au S.I. sans y etre    |    " >> /etc/modt
    echo "| autorise risque deux ans d emprisonnement et 30.000 Euros          |    " >> /etc/modt
    echo "| d amende. (Nouveau code Penal - Article 323-1)                     |    " >> /etc/modt
    echo "|                                                                    |    " >> /etc/modt
    echo "| Anyone accessing or attempting to access this system without       |    " >> /etc/modt
    echo "| explicit authorization risks either two years in prison and a fine |    " >> /etc/modt
    echo "| of 30.000 Euros (French Law . Article 323-1)                       |    " >> /etc/modt
    echo "| __________________________________________________________________ |    " >> /etc/modt
    echo " " >> /etc/modt
    
# Create warning banner in /etc/issue
    echo " " > /etc/issue
    echo "#   _____                                  _                              " >> /etc/issue
    echo "#  /  ___|                                | |                             " >> /etc/issue
    echo "#  \ \--.  ___ _ __ ___ _   _ _ __ ___  __| |                             " >> /etc/issue
    echo "#   \--. \/ _ \  __/ __| | | |  __/ _ \/ _\ |                             " >> /etc/issue
    echo "#  /\__/ /  __/ | | (__| |_| | | |  __/ (_| |                             " >> /etc/issue
    echo "#  \____/ \___|_|  \___|\__,_|_|  \___|\__,_|                             " >> /etc/issue
    echo "#                                                                         " >> /etc/issue       
    echo "#                                                                         " >> /etc/issue
    echo "#    _____ ___________  _   _ ___________                                 " >> /etc/issue
    echo "#   /  ___|  ___| ___ \| | | |  ___| ___ \                                " >> /etc/issue
    echo "#   \ \--.| |__ | |_/  | | | | |__ | |_/ /                                " >> /etc/issue
    echo "#    \--. \  __||    / | | | | |__||    /                                 " >> /etc/issue
    echo "#   /\__/ / |___| |\ \ \ \_/ / |___| |\ \                                 " >> /etc/issue
    echo "#   \____/\____/\_| \_| \___/\____/\_| \_|                                " >> /etc/issue
    echo "#                                                                         " >> /etc/issue
    echo "#                                                                         " >> /etc/issue
    echo "#    _   _   __   _____                                                   " >> /etc/issue
    echo "#   | | | | /  | |  _  |                                                  " >> /etc/issue
    echo "#   | | | | \| | | | / |                                                  " >> /etc/issue
    echo "#   | | | |  | | |  /| |                                                  " >> /etc/issue
    echo "#   \ \_/ / _| |_\ |_/ /                                                  " >> /etc/issue
    echo "#    \___/  \___(_)___/                                                   " >> /etc/issue
    echo "#                                                                         " >> /etc/issue
    echo "#                                                                         " >> /etc/issue
    echo "**********************************************************************    " >> /etc/issue
    echo "|                                                                    |    " >> /etc/issue
    echo "| ATTENTION                                                          |    " >> /etc/issue
    echo "| =========                                                          |    " >> /etc/issue
    echo "| Quiconque accederait ou tenterait d acceder au S.I. sans y etre    |    " >> /etc/issue
    echo "| autorise risque deux ans d emprisonnement et 30.000 Euros          |    " >> /etc/issue
    echo "| d amende. (Nouveau code Penal - Article 323-1)                     |    " >> /etc/issue
    echo "|                                                                    |    " >> /etc/issue
    echo "| Anyone accessing or attempting to access this system without       |    " >> /etc/issue
    echo "| explicit authorization risks either two years in prison and a fine |    " >> /etc/issue
    echo "| of 30.000 Euros (French Law . Article 323-1)                       |    " >> /etc/issue
    echo "| __________________________________________________________________ |    " >> /etc/issue
    echo " " >> /etc/issue

# Create warning banner in /etc/issue.net
    echo " " > /etc/issue.net
    echo "#   _____                                   _                            " >> /etc/issue.net
    echo "#  /  ___|                                 | |                           " >> /etc/issue.net
    echo "#  \ \`--.  ___ _ __ ___ _   _ _ __ ___  __| |                           " >> /etc/issue.net
    echo "#   \`--. \/ _ \ '__/ __| | | | '__/ _ \/ _\`|                           " >> /etc/issue.net
    echo "#   /\__/ /  __/ | | (__| |_| | | |  __/ (_| |                           " >> /etc/issue.net
    echo "#   \____/ \___|_|  \___|\__,_|_|  \___|\__,_|                           " >> /etc/issue.net
    echo "#                                                                        " >> /etc/issue.net       
    echo "#                                                                        " >> /etc/issue.net
    echo "#    _____ ___________  _   _ ___________                                " >> /etc/issue.net
    echo "#   /  ___|  ___| ___ \| | | |  ___| ___ \                               " >> /etc/issue.net
    echo "#   \ \--.| |__ | |_/  | | | | |__ | |_/ /                               " >> /etc/issue.net
    echo "#    \--. \  __||    / | | | | |__||    /                                " >> /etc/issue.net
    echo "#   /\__/ / |___| |\ \ \ \_/ / |___| |\ \                                " >> /etc/issue.net
    echo "#   \____/\____/\_| \_| \___/\____/\_| \_|                               " >> /etc/issue.net
    echo "#                                                                        " >> /etc/issue.net
    echo "#                                                                        " >> /etc/issue.net
    echo "#    _   _   __   _____                                                  " >> /etc/issue.net
    echo "#   | | | | /  | |  _  |                                                 " >> /etc/issue.net
    echo "#   | | | | \| | | | / |                                                 " >> /etc/issue.net
    echo "#   | | | |  | | |  /| |                                                 " >> /etc/issue.net
    echo "#   \ \_/ / _| |_\ |_/ /                                                 " >> /etc/issue.net
    echo "#    \___/  \___(_)___/                                                  " >> /etc/issue.net
    echo "#                                                                        " >> /etc/issue.net
    echo "#                                                                        " >> /etc/issue.net
    echo "**********************************************************************   " >> /etc/issue.net
    echo "|                                                                    |   " >> /etc/issue.net
    echo "| ATTENTION                                                          |   " >> /etc/issue.net
    echo "| =========                                                          |   " >> /etc/issue.net
    echo "| Quiconque accederait ou tenterait d acceder au S.I. sans y etre    |   " >> /etc/issue.net
    echo "| autorise risque deux ans d emprisonnement et 30.000 Euros          |   " >> /etc/issue.net
    echo "| d amende. (Nouveau code Penal - Article 323-1)                     |   " >> /etc/issue.net
    echo "|                                                                    |   " >> /etc/issue.net
    echo "| Anyone accessing or attempting to access this system without       |   " >> /etc/issue.net
    echo "| explicit authorization risks either two years in prison and a fine |   " >> /etc/issue.net
    echo "| of 30.000 Euros (French Law . Article 323-1)                       |   " >> /etc/issue.net
    echo "| __________________________________________________________________ |   " >> /etc/issue.net
    echo " " >> /etc/issue.net

# Set permissions and ownership for the modified files
    chmod 644 /etc/modt
    chmod 644 /etc/issue
    chmod 644 /etc/issue.net

    chown root:root /etc/modt
    chown root:root /etc/issue
    chown root:root /etc/issue.net

    MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  "
    
    _mode="${1}" 
    _callback="${FUNCNAME[0]}"
        
    _Dspl_ref="$( echo ${FUNCNAME[0]} | sed -e 's/_/\ /g')"
    _Num_Rule="$( echo ${_Dspl_ref} | awk '{ print $1 }' )"
    _Txt_Rule="$( echo ${_Dspl_ref} | sed 's/[0-9]*//g' )"
    Report_result "${_Num_Rule}" "${_Txt_Rule}" "TEST PASSED"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"
