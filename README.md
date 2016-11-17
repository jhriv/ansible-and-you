Ansible and You
===============
A Primer

## What is Ansible?

1. Configuration Management
2. Orchestration
3. Application Deployment

### Configuration Manangement

Also called Change Manangement, ensures that parameters and configuration files on a managed system don't change.

### Orchestration

Run a command, or series of commands, on multiple systems simultaneously.

`$ for i in $hosts; do ssh $i uptime; done`

### Application Deployment

Check out a codebase from a repository, or copying a compiled artifact to a destination system.
