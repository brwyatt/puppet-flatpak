# flatpak

[![Build Status](https://travis-ci.com/brwyatt/puppet-flatpak.svg?branch=master)](https://travis-ci.com/brwyatt/puppet-flatpak)

[![GitHub license](https://img.shields.io/badge/license-GPL-blue.svg)](https://raw.githubusercontent.com/brwyatt/puppet-flatpak/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/brwyatt/puppet-flatpak.svg)](https://github.com/brwyatt/puppet-flatpak/issues)
[![GitHub forks](https://img.shields.io/github/forks/brwyatt/puppet-flatpak.svg)](https://github.com/brwyatt/puppet-flatpak/network)
[![GitHub stars](https://img.shields.io/github/stars/brwyatt/puppet-flatpak.svg)](https://github.com/brwyatt/puppet-flatpak/stargazers)

[![Puppet Forge](https://img.shields.io/puppetforge/v/brwyatt/flatpak.svg)](https://forge.puppetlabs.com/brwyatt/flatpak)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/brwyatt/flatpak.svg)](https://forge.puppetlabs.com/brwyatt/flatpak)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/brwyatt/flatpak.svg)](https://forge.puppetlabs.com/brwyatt/flatpak)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with flatpak](#setup)
    * [What flatpak affects](#what-flatpak-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with flatpak](#beginning-with-flatpak)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
1. [Contributors - List of those who've helped to make the module better](#contributors)

## Description

This module (optionally) installs Flatpak from the developer's PPA on
Launchpad and offers two defined types, one for adding/removing
Remotes and another for installing/removing Flatpak applications.

This module was created to allow for managing/installing Flatpak-based
application distributions, as some developers have started to move away from
more traditional system packages such as apt/deb and rpm/yum, instead leveraging
Flatpak's ability to be one-size-fits all.

## Setup

### What flatpak affects

This module (optionally) adds the Flatpak PPA on Launchpad to the system's repository
(if `manage_repo` is true - default for Debian family) and installs Flatpak.

### Setup Requirements

Currently, this module only supports Ubuntu and RedHat, but may work with other Debian-
based or RedHat-based distributions.

This module requires the `puppetlabs-apt` module in order to manage
Apt repos (if `manage_repo` is true).

### Beginning with flatpak

To install this module, call:

```bash
puppet module install brwyatt-flatpak
```

## Usage

To install Flatpak for use in your Puppet manifests, simply include it into
your manifests.

```puppet
include ::flatpak
```

## Reference

* [Classes](#classes)
* [Defined Types](#defined-types)
* [Providers](#providers)

### Classes

#### `flatpak`

Installs the Flatpak PPA and installs Flatpak

Parameters:
* `package_ensure`: Ensure value for the Flatpak package. Default: 'installed'
* `repo_file_name`: Optional name for the repo source file. Defaults to the PPA
  naming scheme to avoid duplicate repository files.

#### `flatpak::remotes::gnome`

Adds the Gnome SDK remote to Flatpak. Includes the `flatpak` class to ensure
Flatpak is installed first.

This class has no parameters.

### Defined Types

#### `flatpak`

This type installs (or uninstalls) Flatpak apps.

Parameters:
* `ensure`: If the package should be `present` (or `installed`) or `absent` (or
  `uninstalled`)
* `arch`: The package architecture to be installed. Cannot be used if `ref` is
  defined.
* `branch`: The package branch to be installed. Cannot be used if `ref` is
  defined.
* `name`: (namevar) The name of the package to be installed (or removed)
* `ref`: The package ref to install. This can be any valid pakcage ref, from
  simply the package name up to a full Identifier Triple ("name/arch/branch").
  Cannot be used if `branch` or `arch` are defined.
* `remote`: The name of the remote repo to install the package from. Required
  if `ensure` is "installed" or "present".

If defined, this type will install the package identified in the `ref`
parameter. Otherwise, it will attempt to generate an Identifier Triple from
the values of `name`/`arch`/`branch`. If no parameters are explicitly defined,
this will result in attempting to install the package with the resource's name
and the remote's default architecture and branch.

#### `flatpak_remote`

This type adds and removes Flatpak remotes.

Parameters:
* `ensure`: If the remote should be `present` or `absent`
* `name`: (namevar) The name of the remote
* `location`: The location for the remote
* `from`: if `true`, it specifies that location is a repo config file.
* `gpg_import`: If defined, imports the gpg-file with the remote. The gpg file needs to exist already
   and should probably be placed in /var/lib/flatpak/repo diretory.

### Providers

#### `flatpak`

Implements the `flatpak` type. Default provider.

#### `flatpak_remote`

Implements the `flatpak_remote` type. Default provider.

## Limitations

Currently, this module can only install on Debian-based systems and has not been
tested on distributions other than Ubuntu 16.04. It may or may not work on other
Debian-based distributions, but makes no claims regarding such. This will not
currently work at all on RHEL-based systems.

## Development

Feel free to file issues in the GitHub [issue tracker](https://github.com/brwyatt/puppet-flatpak/issues) for the repository, or
submit [Pull Requests](https://github.com/brwyatt/puppet-flatpak/pulls).

I may not have much time to work on (or test) this myself, so help to expand
current functionality (especially to make it work for more people) is greatly
appreciated and encouraged.

## Contributors

The list of contributors can be found at: [https://github.com/brwyatt/puppet-flatpak/graphs/contributors](https://github.com/brwyatt/puppet-flatpak/graphs/contributors).
