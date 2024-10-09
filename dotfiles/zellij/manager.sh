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

        project_name=$(echo "${ZJ_LAYOUT}" | cut -f 1 -d '.')

        #attach to session if it exists
        session_exists=$(zellij list-sessions | grep "${project_name}" || true)

        if [[ -n "${session_exists}" ]];then
            zellij attach "${project_name}"
            exit
        fi

        # open project
        zellij --layout "${ZJ_LAYOUT_DIR}/${ZJ_LAYOUT}" --session "${project_name}"
    fi
}

create_layout ()
{
    ZJ_LAYOUT_DIR=$(zellij setup --check \
        | grep "LAYOUT DIR" - \
        | grep -o '".*"' - | tr -d '"')

    layout_file_path="${ZJ_LAYOUT_DIR}/${1}.kdl"

    if [[ -f "${layout_file_path}" ]];then
        echo "Layout ${layout_file_path} already exists"
    fi

    if [[ -d "${ZJ_LAYOUT_DIR}" ]];then
        zellij setup --dump-layout "default" > "${layout_file_path}"
    fi
    should_edit
}

should_edit ()
{
    echo "Do you want to edit the layout?"
    echo "y/n"
    read -r answer

    if [[ "${answer}" == "y" ]];then
        nvim "${layout_file_path}"
    fi
}

dump_layout_cmd ()
{
    echo "zellij setup --dump-layout "default" > ${2}"
}

open_project ()
{
    local project_name=$1
    ZJ_LAYOUT_DIR=$(zellij setup --check \
        | grep "LAYOUT DIR" - \
        | grep -o '".*"' - | tr -d '"')

    layout_file_path="${ZJ_LAYOUT_DIR}/${project_name}.kdl"

    if [[ -f "${layout_file_path}" ]]; then
        zellij list-sessions | grep "${project_name}" && zellij --session "${project_name}" ||
        zellij --layout "${layout_file_path}" --session "${project_name}"
    else
        create_layout "${project_name}"
    fi
}

show_help ()
{
    echo "Usage: manager.sh [action]"
    echo "Actions:"
    echo "  --select: Select a layout"
    echo "  --create: Create a layout"
    echo "  --open: Open a project"
}

case $action in
    --select|-s)
        select_layout
        ;;
    --create|-c)
        create_layout $2
        ;;
    --open|-o)
        open_project $2
        ;;
    --help|-h)
        show_help
        ;;
    *)
        echo "Invalid action $action"
        show_help
        ;;
esac
