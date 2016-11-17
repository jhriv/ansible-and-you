Infrastructure
==============

Replicates a production environment on two coasts, with redundant webservers and database servers. It incluse a tomcat and redis server.

Uses helper scripts to set up a useable ansible configuration, allowing us to use ansible on the host system, just as we would do for a real production environment.


## Requirements

* Ansible installed (apt-get, yum install, pip install, etc)
* VirtualBox
* Vagrant

## To start

`./setup.sh`

