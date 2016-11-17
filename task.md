Parts of a Task
===============

At its simplest, a task is similar to an ad-hoc instance of the `ansible` command. The biggest advantage is a task can take advantage of discovered facts and defined variables to save additional typing. A task can also notify a handler to take action at the end of the playbook's run.

* Name
* Module
* Module arguments
* Conditional test to run
* Conditional test to mark as "changed"
* Conditional to skip errors
* List of handlers to notify
* List of items to act upon or with
* Variable name to save result to
* Alternative host to run on
* Connection type
* Run once per set of hosts

## Name

> `name: Displayable title here`

While strictly not required, this is highly recommended. It is displayed when this task is run. If this is missing, the default display is the name of the module.

## Module

This is the only mandatory part of a task. This is the task to take place.
There are over 300 core modules, each with their own arguments.

[Comprhensive list of modules](http://docs.ansible.com/ansible/modules_by_category.html)

> `debug:`  
> `package:`  
> `file:`

## Module Arguments

The allowed arguments depend upon the module, some are mandatory and others are  optional. Some have default values.

Best practice recommends that if a module takes a `state` argument, always specify it even if the task is performing the default.

```YAML
- package:
    name: ntp
    state: present

- file:
    path: /home/user/.ssh/authorized_keys
    state: file
    mode: 0600
```

## Conditional test to run

`when: condition to test`

If present, the task will run only when the `condition to test` is true. `when` can also take a YAML list, and each item is logically ANDed.

```YAML
- name: Shut down Debian systems
  command: /sbin/shutdown -t now
  when: ansible_os_family == 'Debian'

- name: Shut down RHEL 5 systems
  command: /sbin/shutdown -t now
  when:
    - ansible_distribution == 'Redhat'
    - ansible_distribution_major_version == '5'
```    
