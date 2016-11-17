#!/bin/sh

echo Starting Vagrant boxes

vagrant up

echo Setting up Vagrant environment for Ansible

vagrant ssh-config > .ssh-config

cat > ansible.cfg <<EOF
[defaults]
inventory = hosts

[ssh_connection]
ssh_args = -C -o ControlMaster=auto -o ControlPersist=60s -F .ssh-config
EOF

./list-hosts Vagrantfile > hosts

echo All done.
