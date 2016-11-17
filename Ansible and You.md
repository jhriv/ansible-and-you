Ansible and You
===============
A Primer

## What is Ansible?

1. Configuration Management
2. Orhchestration
3. Application Deployment

### Configuration Manangement

Also called Change Manangement, ensures that parameters and configuration files on a managed system don't change.

### Orhchestration

Run a command, or series of commands, on multiple systems simultaneously.

`$ for i in $hosts; do ssh $i uptime; done`

### Application Deployment

Check out a codebase from a repository, or copying a compiled artifact to a destination system.

## Major Parts

1. Inventory
2. Playbooks

### Inventory

An INI-file style list of all managed hosts. Hosts can be assembled into groups, and a signle host can be in multiple groups. Multiple inventories are allowed, and encouraged.

Example:

> hosts

```INI
web1
web2
db1
db2

[webservers]
web1
web2

[eastcoast]
web1
db1
```


### Playbooks

A YAML file containing one or more plays. A play is a list of hosts to run a set of tasks against.

A playbook can be simple, containing a single play with a single task.

A task is an optional name, with a module to perform an action. Modules range from simple debug, to more complicated parsing a Jinja2 template and copying it to a remote system, to very complicated arbitrary shell commands.


Simple playbook:

> simple.yml

```YAML
---
- hosts: localhost
  tasks:
    - debug:
```

Result:

```
$ ansible-playbook example.yml

PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [debug] *******************************************************************
ok: [localhost] => {
    "msg": "Hello world!"
}

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0
```

A playbook can also be complicated, having multiple plays, each with multiple tasks.

Example:

> complicated.yml

```YAML
---
- hosts: webservers
  vars:
    home_page: /var/www/html/index.html
  tasks:
    - name: Install Apache
      package: name=httpd state=installed
    - name: Set Landing Page
      template: src=home.html.j2 dest={{ home_page }}

- hosts: eastcoast
  vars:
    motd: "This is located on the east coast"
  tasks:
    - name: Update MOTD
      lineinfile:
        dest: /etc/motd
        state: present
        line: '{{ motd }}'
```

A YAML gotcha is YAML sees a beginning `{` as starting a dictionary, so Jinja2 variable expanstions have to be quoted. When using the equals syntax `dest={{ home_page }}` quoting is unnecessary.


Parts of a playbook:



## Other Parts

1. Modules
2. Variables
3. Templates
4. Roles

###

Modules do the heavy lifting, and there are over 300 that are included. The [modules index](http://docs.ansible.com/ansible/modules_by_category.html) has a comprehensive list.

### Variables

Allows Don't Repeat Yourself (DRY) and/or Single Source of Truth (SSOT)

Variables can be defined as part of an inventory, in a playbook, as part of a group, or specific to a particular host. They can also be asked for at run time, or be passed as command-line arguments.

Variables can be a simple string or number, or as complicated as a list or dictionary.

### Templates

Ansible uses the Jinja2 templating system. Playbooks are passed through Jinja2 prior to running so variables are expanded at run time.

Example:

> greetings.yml

```YAML
---
- hosts: localhost
  vars:
    message: "Greetings, Earth!"

  tasks:
    - debug:
      msg: '{{ message }}'
```

Result:
```
ok: [localhost] => {
    "msg": "Greetings, Earth!"
}
```

The `{{ message }}` was expanded out to `Greetings, Earth!`

### Roles

Roles combine tasks, variables, templates, and files in a unit that can be applied to systems and other roles. A role has all the parts of a playbook, minus the hosts. Each part is separated out into its own file. A single role should do a single thing, and do it well.

A simple layout would be:

```
role-name
├── defaults
│   └── main.yml
└── tasks
    └── main.yml
```

Roles can contain:

* List of plays
* Default values
* Static variable definitions
* Handlers
* Meta information
