#!/bin/bash 
# author : Arnaud Crampet 
# Date : 28/06/2024
# generic git ressource function.


function Do_git_pull_or_update () 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 
  local _RepoPath="${1}"
  
  if [[ -d ${_RepoPath}/.git ]] 
    then 
       cd ${_RepoPath}
       echo "found GIT" 
       git pull 
       cd ..
    else 
      git clone git@${GIT_SSH_URL}:v3/${GIT_GLB_ORGANISATION}/${GIT_GLB_PROJECT}/${repo}
      cd ${repo}
      git clone git@${GIT_SSH_URL}:v3/${GIT_GLB_ORGANISATION}/${GIT_GLB_PROJECT}/lib
      cd ..
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_clone_sub_gits 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 
if [ ${runned} -gt 1 ]
   then 
       MSG_DISPLAY "check" "0" "looping control on function Do_clone_sub_gits  "
       MSG_DISPLAY "EdEMessage" "1" ""
       exit 2 
   else 
        git clone git@${GIT_SSH_URL}:v3/${GIT_GLB_ORGANISATION}/${GIT_GLB_PROJECT}/lib
        MSG_DISPLAY "check" "0" "checking git sub root directory "
        if [ ! -d ./RGRoot ] 
          then 
              MSG_DISPLAY "EdWMessage" "1" ""
              mkdir ./RGRoot 
              runned="$( expr ${runned} + 1 )"
              Do_clone_sub_gits
          else 
              MSG_DISPLAY "EdSMessage" "1" ""
              runned=0
              cd ./RGRoot
              for repo in $( az group list --output table | awk '{ print $1 }' |  tail -n +3) 
                do 
                  Do_git_update_dir "${repo}"
              done 
        fi 
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_git_update_dir ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 
    local _git_dir="${1}"
    if [[ -d ${_git_dir}/.git ]] 
       then 
           oldpath="$( pwd )"
           cd  ${_git_dir} 
           git pull 
           cd ${oldpath}
       else 
            oldpath="$( pwd )"
            MSG_DISPLAY "check" "0" "checking git sub root directory ${_git_dir} :   "
            git clone git@${GIT_SSH_URL}:v3/${GIT_GLB_ORGANISATION}/${GIT_GLB_PROJECT}/${_git_dir}
            cd ${_git_dir}
            MSG_DISPLAY "check" "0" "checking git sub root directory ${_git_dir}/lib :   "
            git clone git@${GIT_SSH_URL}:v3/${GIT_GLB_ORGANISATION}/${GIT_GLB_PROJECT}/lib
            cd  ${oldpath}
    fi 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_git_add_directory ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 
  local _dir="${1}"
  local _pwd="$(pwd)"
  if [[ ! -d ${_dir}/.git ]]
    then 
       cd  ${_dir} 
       Do_git_init_gen
       git_az_devops_repo_create ${Rgname}
       git remote add origin git@${GIT_SSH_URL}:v3/${GIT_GLB_ORGANISATION}/${GIT_GLB_PROJECT}/${Rgname}
       git push --set-upstream origin main  --force       2>> ${logfile} 
       cd ${_pwd}
  fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Do_git_init_gen ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 
    git init                        2>> ${logfile} 
    git checkout -b main            2>> ${logfile} 
    git add .                       2>> ${logfile} 
    git commit -m "initial commit"  2>> ${logfile} 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function git_az_devops_repo_create ()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 
local repoName="${1}"
 az repos create --name ${repoName}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_get_git_clone 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 

local _base_clone_path="${1}"
local _Base_clone_URI="${2}"
local _Base_clone_repo="${3}"
local _automated=${4:-1}
local actual_path="$(pwd)"

Empty_Var_Control "${_base_clone_path}" "_base_clone_path" "4"
Empty_Var_Control "${_Base_clone_URI}"  "_Base_clone_URI"  "4"
Empty_Var_Control "${_Base_clone_repo}" "_Base_clone_repo" "4"


MSG_DISPLAY "check" "0" "git clone existance control and action"
if [ ${runned} -gt 1 ]
   then 
       MSG_DISPLAY "check" "0" "looping control on function Do_clone_sub_gits  "
       MSG_DISPLAY "EdEMessage" "1" ""
       exit 2 
   else
      if [[ -d ${_base_clone_path}/${_Base_clone_repo}/.git  ]]
        then 
            MSG_DISPLAY "EdSMessage" "1" "FOUND LOCAL COPY"
        else 
            MSG_DISPLAY "EdWMessage" "1" "NO LOCAL COPY"
            cd ${_base_clone_path}
            git clone ${_Base_clone_URI}/${_Base_clone_repo} 
            cd ${actual_path}
            Do_get_git_clone "${_base_clone_path}" "${_Base_clone_URI}" "${_Base_clone_repo}" "${_automated}"
            runned=$(expr  ${runned} + 1  )
      fi 
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Do_clone_git_repo_to_local () 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 

 local _actual_path="${1}"
 local  _base_clone_path="${2}"
 local  _Base_clone_URI="${3}"
 local  _Base_clone_repo="${4}"

  cd ${_base_clone_path}

  cd ${actual_path}
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}


function Get_git_root()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 

root_git="$(cat ./.git/config  | grep "url =" |awk '{ print $3 }')"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_git_organisation() 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 

Organame="$( cat ./.git/config  | grep "url =" |awk '{ print $3 }' | awk -F \@ '{ print $2 }' | awk -F \/ '{ print $2 }' )"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Get_git_project() 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ]  " 

project="$(cat ./.git/config  | grep "url =" |awk '{ print $3 }' | awk -F \/ '{ print $(NF - 1) }')"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

# Sourcing control variable 
LibState="OK"