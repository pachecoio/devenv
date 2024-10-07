#!/usr/bin/env bash
set -euo pipefail

action=$1

select_layout ()
{
    ZJ_LAYOUT_DIR=$(zellij setup --check \
        | grep "LAYOUT DIR" - \
        | grep -o '".*"' - | tr -d '"')

    if [[ -d "${ZJ_LAYOUT_DIR}" ]];then
        ZJ_LAYOUT="$(fd --type file . "${ZJ_LAYOUT_DIR}" \
        | sed 's|.*/||' \
        | sk \
        || exit)"
        zellij --layout "${ZJ_LAYOUT_DIR}/${ZJ_LAYOUT}"
    fi
}

create_layout ()
{
    ZJ_LAYOUT_DIR=$(zellij setup --check \
        | grep "LAYOUT DIR" - \
        | grep -o '".*"' - | tr -d '"')

    if [[ -d "${ZJ_LAYOUT_DIR}" ]];then
        zellij setup --dump-layout "default" > "${ZJ_LAYOUT_DIR}/${1}.kdl"
        nvim "${ZJ_LAYOUT_DIR}/${1}.kdl"
    fi
}

dump_layout_cmd ()
{
    echo "zellij setup --dump-layout ${1} > ${2}"
}

open_nvim_in_new_zellij_tab ()
{
    file_path=$1
    is_in_zellij=$(ps -o comm= -p $PPID | grep zellij || true)
    if [[ -z "${is_in_zellij}" ]];then
        zellij -e nvim "${file_path}"
    else
        zellij -e nvim "${file_path}"
    fi
}

case $action in
    --select)
        select_layout
        ;;
    --create)
        create_layout $2
        ;;
    *)
        echo "Invalid argument"
        ;;
esac
