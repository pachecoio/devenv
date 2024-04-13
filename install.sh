#!/usr/bin/env bash

tags=$1

if [ -z $tags ]; then
  tags="all"
fi

has_vault_file=$(ls .vault_pass 2> /dev/null | wc -l)
has_become_file=$(ls .become_pass 2> /dev/null | wc -l)

if [ $has_vault_file -eq 0 ]; then
  echo "Please create a .vault_pass file with the vault password"
  exit 1
fi

if [ $has_become_file -eq 0 ]; then
  echo "Please create a .become_pass file with the become password"
  exit 1
fi

ansible-playbook main.yaml --vault-password-file .vault_pass --become-password-file .become_pass --tags $tags
