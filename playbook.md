Parts of a Playbook
===================

* List of hosts
* Variable definitions
* Roles to apply
* Tasks
* Handlers

The only part that is mandatory is the list of hosts. However, a list of hosts without anything else is a very boring play.

## List of hosts
*mandatory*

The start of any play is the list of hosts the play is to run against. It can be a single host, a list of hosts, a group of hosts, or "all" hosts in a given inventory.

```YAML
- hosts: all
```

## Variable definitions
*optional*

This section contains variables that can be used later.

```YAML
vars:
  foo: bar
  many_foos:
    - foo1
    - foo2
  group_of_foos:
    - { key: foo, value: bar }
    - { key: baz: value: qux }
```

## Roles to apply
*optional*

This section lists all the roles that apply to the hosts of the play.

```YAML
roles:
  - webserver
  - app_server
  - dev_login
```

## Tasks
*optional, but rarely missing*

This section lists all the tasks, or actions, to apply to the hosts for the play.

```YAML
tasks:
  - name: Get hostname
    command: hostname -f
    changed_when: false
    register: remote_hostname
  - name: Verify hostname
    assert:
      that: remote_hostname.stdout != ( ansible_hostname ~ "." ~ ansible_domain )
      msg: Hostname mismatch
```    

## Handlers
*optional*

Handlers are tasks that are run after all other tasks, but only if a dependent task notifies if of a change.

```YAML
handlers:
  - name: Restart Apache
    service:
      name: httpd
      state: restarted
```
