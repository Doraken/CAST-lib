#!/bin/bash 
# author : Arnaud Crampet 
# Date : 13/10/2006  
# From C.A.S.T.                                                                             #
# Subject : This library provide base runtime to manage FIFO input and output #
#                                                                             #
###############################################################################
####
# INFO 


function Set_new_fifo
{
#|# /**
#|#  * Set_new_fifo
#|#  * @author Arnaud Crampet      
#|#  * @see fifo_lib::UnSet_fifo()
#|#  * @see fifo_lib::Do_fifo_init()
#|#  * @param name		objectname 'fifo'
#|#  * @param attribut	first attribut
#|#  * @param ...		optional attribut
#|#  *
#|#  * List of attributs:
#|#  * - filename=...		the filename of fifo
#|#  * - eof="..."          end of line (used to close the fifo)
#|#  * 
#|#  * Usage:
#|#  * - Create a FIFO
#|#  *
#|#  * Examples:
#|#  * - Set_new_fifo my_fifo filename=/tmp/my_fifo
#|#  * - Set_new_fifo my_fifo filename=/tmp/my_fifo eof="END_OF_FILE"
#|#  **/
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
  
  nameref self="${1}"
  Empty_Var_Control "${self}"    "self"    "4"
  Do_fifo_init $@
  
  if [ "${self.filename}" = "" ]; then
     MSG_DISPLAY "EdEMessage" "1" " Fifo ${1} not defined"
  fi  
  if [ -p "${self.filename}" ]; then
     MSG_DISPLAY "EdEMessage" "1" " ${self.filename} is not a fifo"
  fi
  
  if mkfifo ${self.filename} 2>/dev/null; then
  	 :
  else
     MSG_DISPLAY "EdEMessage" "1" " mkfifo ${self.filename} return code $?"
  fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function UnSet_fifo
{
#|# /**
#|#  * UnSet_fifo
#|#  * @author Arnaud Crampet      
#|#  * @see fifo_lib::Set_new_fifo()
#|#  * @param name		objectname 'fifo'
#|#  *
#|#  * Usage:
#|#  * - Delete a FIFO
#|#  *
#|#  * Examples:
#|#  * - UnSet_fifo my_fifo
#|#  **/
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

  nameref self="${1}"
  Empty_Var_Control "${self}"    "self"    "4"

  if [ "${self.filename}" = "" ]; then
     MSG_DISPLAY "EdEMessage" "1" " Fifo ${1} not defined"
  fi  
  if [ ! -p "${self.filename}" ]; then
     MSG_DISPLAY "EdEMessage" "1" " ${self.filename} is not a fifo"
  fi
  
  rm ${self.filename}
  unset self.filename
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Do_fifo_init
{
#|# /**
#|#  * Do_fifo_init
#|#  * @author Arnaud Crampet      
#|#  * @see fifo_lib::Set_new_fifo()
#|#  * @param name		objectname 'fifo'
#|#  * @param attribut	first attribut
#|#  * @param ...		optional attribut
#|#  *
#|#  * List of attributs:
#|#  * - filename=...		the filename of fifo
#|#  * - eof="..."          end of line (used to close the fifo)
#|#  * 
#|#  * Usage:
#|#  * - Initialise a FIFO (Doesn't create the fifo file)
#|#  *
#|#  * Examples:
#|#  * - Do_fifo_init my_fifo filename=/tmp/my_fifo
#|#  * - Do_fifo_init my_fifo filename=/tmp/my_fifo eof="END_OF_FILE"
#|#  **/
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

  local self="${1}"; shift 
  nameref self=${self}
  eval "self=( $@ )"
  
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Get_fifo_line
{
#|# /**
#|#  * Get_fifo_line
#|#  * @author Arnaud Crampet      
#|#  * @see fifo_lib::Set_fifo_line()
#|#  * @param name		objectname 'fifo'
#|#  *
#|#  * Usage:
#|#  * - Read a set of lines in the FIFO
#|#  *
#|#  * Examples:
#|#  * - Get_fifo_line my_fifo | wc -l
#|#  **/
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 
  nameref self="${1}"
  Empty_Var_Control "${self}"    "self"    "4"

  if [ "${self.filename}" = "" ]; then
    MSG_DISPLAY "EdEMessage" "1" " Fifo ${1} not defined" "1"
  fi  
  if [ ! -p "${self.filename}" ]; then
    MSG_DISPLAY "EdEMessage" "1" " ${self.filename} is not a fifo" "1"
  fi  

  while true
        do
  	       [ ! -p "${self.filename}" ] && break
           while read -u3 -- line; do
           echo  ${line}
           done < ${self.filename}
   	    sleep 2
  done
  
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Set_fifo_line
{
#|# /**
#|#  * Set_fifo_line
#|#  * @author Arnaud Crampet      
#|#  * @see fifo_lib::Get_fifo_line()
#|#  * @param name		objectname 'fifo'
#|#  *
#|#  * Usage:
#|#  * - Write a set of lines in the FIFO
#|#  *
#|#  * Examples:
#|#  * -  cat - | Get_fifo_line my_fifo 
#|#  **/
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "
 

  nameref self="${1}"
  Empty_Var_Control "${self}"    "self"    "4"


  if [ "${self.filename}" = "" ]; then
     MSG_DISPLAY "EdEMessage" "1" " Fifo ${1} not defined"
  fi  
  if [ ! -p "${self.filename}" ]; then
     MSG_DISPLAY "EdEMessage" "1" " ${self.filename} is not a fifo"
  fi  

  cat - > ${self.filename}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

# Sourcing control variable 
LibState="OK"