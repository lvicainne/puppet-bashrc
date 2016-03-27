# BashRC

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with BashRC](#setup)
    * [What bashrc module affects](#what-bashrc-module-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with bashrc](#beginning-with-bashrc)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

A Puppet module to manage the files used by BashRC

## Setup

### What BashRC module affects 

* modify the files for the machine linked to BashRC in /etc (/etc/bashrc and /etc/profile)
* modify the  skelton files used for new created users in /etc/skel
* according to your configuration, modify the bashrc files for the selected users
Warning : this package will modify the bashrc files (and its skelton files) ! Your console may be directly affected if you already customized it !
Otherwise, you can use it safely.

### Beginning with BashRC	

A basic example is as follows:

```puppet
  include ::bashrc
```

## Usage

You can also use natively Hiera :


```puppet
  include ::bashrc
```

```yaml
bashrc::aliases:
    - 'sayhello="echo Bonjour"'
bashrc::users:
    - username: 'root'
      homedirectory: '/root'
      managelocalbashrc: true
    - username: 'myotherusername'
      homedirectory: '/home/myotherusername'
      managelocalbashrc: true
```

If you use Hiera and you want to use the hierarchy using this Puppet syntax :

```puppet
  class { '::bashrc':
    aliases    => hiera_array('bashrc::aliases'),
    users      => hiera_array('bashrc::users'),
    extensions => hiera_array('bashrc::extensions'),
  }
```

In this way, you can merge (with `hiera_array`) the parameters

## Reference

### Public Classes

* [bashrc](#class-bashrc)

### Class: bashrc

A class for managing the bashrc configuration files

#### Attributes

##### `aliases`
##### `bashrcdirectory`
##### `bashrcd_puppet_filename`
##### `etcbashfile`
##### `extensions`
##### `grep_color_value`
##### `maildirectory`
##### `manage_custom_bashrc`
##### `manage_etc_file`
##### `manage_skeltons`
##### `profileddirectory`
##### `ps1_colored`
##### `ps1_default`
##### `ps1_screen`
##### `selected_pager`
##### `selected_editor`
##### `selected_editor_path`
##### `skeldirectory`
##### `template_etc_bashrc`
##### `template_etc_profile`
##### `users`

## Limitations

This module has only been tested on my Debian and Centos servers. I can not guarantee for any other Operating System

## Development

You are pleased to fork this module and adapt it for you needs. I am open to any Pull Request :-)

## Release Notes/Contributors/Etc. 

* v0.0.1 First Running version

