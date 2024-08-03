function set_word_title() 
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

local _file="${1}"
local _text="${2}"
local _title_level="${3}"

Empty_Var_Control "${_file}"         "_file"         "4"
Empty_Var_Control "${_text}"         "_text"         "4"
Empty_Var_Control "${_title_level}"  "_title_level"  "4"


printf "     <w:p w14:paraId=\"643DEAB8\"                               " >> ${_file}
printf "              w14:textId=\"77777777\"                           " >> ${_file}
printf "              w:rsidR=\"00913340\"                              " >> ${_file}
printf "              w:rsidRDefault=\"00913340\"                       " >> ${_file}
printf "              w:rsidP=\"00913340\">                             " >> ${_file}
printf "             <w:pPr>                                            " >> ${_file}
printf "                 <w:pStyle w:val=\"Titre${_title_level}\" />    " >> ${_file}
printf "             </w:pPr>                                           " >> ${_file}
printf "             <w:r>                                              " >> ${_file}
printf "                 <w:t>${_text}</w:t>                            " >> ${_file}
printf "             </w:r>                                             " >> ${_file}
printf "         </w:p>                                                 " >> ${_file}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function set_word_text_chapter()
{
############ STACK_TRACE_BUILDER #####################
Function_Name="${FUNCNAME[0]}"
Function_PATH="${Function_PATH}/${Function_Name}"
######################################################
MSG_DISPLAY "debug" "0" "current function path : [ ${Function_PATH} ]  | function Name [ ${Function_Name} ] "

local _file="${1}"
local _text="${2}"
 

Empty_Var_Control "${_file}"         "_file"         "4"
Empty_Var_Control "${_text}"         "_text"         "4"
 

printf "        <w:p w14:paraId=\"4B4CAE2E\"                        " >> ${_file}
printf "             w14:textId=\"049C0C5D\"                        " >> ${_file}
printf "             w:rsidR=\"00913340\"                           " >> ${_file}
printf "             w:rsidRDefault=\"00913340\">                   " >> ${_file}
printf "            <w:r>                                           " >> ${_file}
printf "                <w:t xml:space=\"preserve\">${_text}</w:t>  " >> ${_file}
printf "            </w:r>                                          " >> ${_file}
printf "        </w:p>                                              " >> ${_file}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function do_add_table_columns()
{
local _file="${1}"
local _colum_number="${2}"
 
Empty_Var_Control "${_file}"         "_file"          "4"
Empty_Var_Control "${_colum_number}" "_colum_number"  "4"

printf "            <w:tblGrid>                                                     " >> ${_file}
for columns in {1..${_colum_number}}
    do
        printf "                <w:gridCol w:w=\"2265\" />                                  " >> ${_file}
done
printf "            </w:tblGrid>                                                    " >> ${_file}
}

function do_add_start_table_row()
{
printf "            <w:tr w:rsidR=\"00913340\"                                      " >> ${_file}
printf "                  w14:paraId=\"7B8A2F36\"                                   " >> ${_file}
printf "                  w14:textId=\"77777777\"                                   " >> ${_file}
printf "                  w:rsidTr=\"00913340\">                                    " >> ${_file}
}

function do_add_end_table_row() 
{
printf "            </w:tr>                                                         " >> ${_file}
}

function do_add_cell()
{

local _file="${1}"
local _colum_number="${2}"
 
Empty_Var_Control "${_file}" "_file"  "4"
Empty_Var_Control "${_text}" "_text"  "4"

printf "                <w:tc>                                                      " >> ${_file}
printf "                    <w:tcPr>                                                " >> ${_file}
printf "                        <w:tcW w:w=\"2265\"                                 " >> ${_file}
printf "                               w:type=\"dxa\" />                            " >> ${_file}
printf "                    </w:tcPr>                                               " >> ${_file}
printf "                    <w:p w14:paraId=\"73448C25\"                            " >> ${_file}
printf "                         w14:textId=\"0DCCF4B0\"                            " >> ${_file}
printf "                         w:rsidR=\"00913340\"                               " >> ${_file}
printf "                         w:rsidRDefault=\"00913340\"                        " >> ${_file}
printf "                         w:rsidP=\"00913340\">                              " >> ${_file}
printf "                        <w:r>                                               " >> ${_file}
printf "                            <w:t>${_text}</w:t>                             " >> ${_file}
printf "                        </w:r>                                              " >> ${_file}
printf "                    </w:p>                                                  " >> ${_file}
printf "                </w:tc>                                                     " >> ${_file}
}


function do_add_start_table()
{
local _file="${1}"
 
Empty_Var_Control "${_file}" "_file"  "4"
printf "   <w:tbl>                                                                  " >> ${_file}
printf "            <w:tblPr>                                                       " >> ${_file}
printf "                <w:tblStyle w:val=\"Grilledutableau\" />                    " >> ${_file}
printf "                <w:tblW w:w=\"0\"                                           " >> ${_file}
printf "                        w:type=\"auto\" />                                  " >> ${_file}
printf "                <w:tblLook w:val=\"04A0\"                                   " >> ${_file}
printf "                           w:firstRow=\"1\"                                 " >> ${_file}
printf "                           w:lastRow=\"0\"                                  " >> ${_file}
printf "                           w:firstColumn=\"1\"                              " >> ${_file}
printf "                           w:lastColumn=\"0\"                               " >> ${_file}
printf "                           w:noHBand=\"0\"                                  " >> ${_file}
printf "                           w:noVBand=\"1\" />                               " >> ${_file}
printf "            </w:tblPr>                                                      " >> ${_file}
}

function do_add_end_table() 
{
local _file="${1}"
 
Empty_Var_Control "${_file}" "_file"  "4"

printf "        </w:tbl>                                                            " >> ${_file}

}
 

function Set_word_neutral_table_test()
{
local _file="${1}" 
add_start_table         "${_file}"

do_add_table_columns     "${_file}" "5"
do_add_start_table_row   "${_file}" 
do_add_cell              "${_file}" "column 1 line header" 
do_add_cell              "${_file}" "column 2 line header"
do_add_cell              "${_file}" "column 3 line header"
do_add_cell              "${_file}" "column 4 line header"
do_add_cell              "${_file}" "column 5 line header"
do_add_end_table_row     "${_file}"


do_add_start_table_row  
do_add_cell              "${_file}" "column 1 line 1" 
do_add_cell              "${_file}"  "column 2 line 1"
do_add_cell              "${_file}" "column 3 line 1"
do_add_cell              "${_file}" "column 4 line 1"
do_add_cell              "${_file}" "column 5 line 1"
do_add_end_table_row

do_add_start_table_row   "${_file}"
do_add_cell              "${_file}" "column 1 line 2" 
do_add_cell              "${_file}" "column 2 line 2"
do_add_cell              "${_file}" "column 3 line 2"
do_add_cell              "${_file}" "column 4 line 2"
do_add_cell              "${_file}" "column 5 line 2"
do_add_end_table_row     "${_file}"

do_add_start_table_row   "${_file}"
do_add_cell              "${_file}" "column 1 line 3" 
do_add_cell              "${_file}" "column 2 line 3"
do_add_cell              "${_file}" "column 3 line 3"
do_add_cell              "${_file}" "column 4 line 3"
do_add_cell              "${_file}" "column 5 line 3"
do_add_end_table_row     "${_file}"

do_add_end_table         "${_file}"
}


# Sourcing control variable 
LibState="OK"  