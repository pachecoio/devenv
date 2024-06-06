#!/usr/bin/env bash

tags=$1

if [ -z $tags ]; then
  tags="all"
fi

has_vault_file=$(ls .vault_pass 2> /dev/null | wc -l)
has_become_file=$(ls .become_pass 2> /dev/null | wc -l)

if [ $has_vault_file -eq 0 ]; then
  # Ask for the vault password
  echo "Please create a .vault_pass file with the vault password"
  read -s -p "Vault password: " vault_pass
  echo $vault_pass > .vault_pass
fi

if [ $has_become_file -eq 0 ]; then
  # Ask for the become password
  echo "Please create a .become_pass file with the become password"
  read -s -p "Become password: " become_pass
  echo $become_pass > .become_pass
fi

# ansible-playbook main.yaml --vault-password-file .vault_pass --become-password-file .become_pass --tags $tags
# If arch, it can use password from files
if [ $ansible_os_family == "Archlinux" ]; then
  ansible-playbook main.yaml --vault-password-file .vault_pass --become-password-file .become_pass --tags $tags
else
  ansible-playbook main.yaml --vault-password-file .vault_pass -K --tags $tags
fi

