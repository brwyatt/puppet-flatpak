# Class: flatpak
# ===========================
#
# Main class to install and manage Flatpak
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `package_ensure`
# Ensure value for the Flatpack package. Should be 'installed', 'latest', or a
# version. Defaults to 'installed'.
#
# Examples
# --------
#
# @example
#    class { 'flatpak':
#      package_ensure => 'latest',
#    }
#
# Authors
# -------
#
# Bryan Wyatt <brwyatt@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2017 Bryan Wyatt, unless otherwise noted.
#
# This file is part of brwyatt-flatpak.
#
# brwyatt-flatpak is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# brwyatt-flatpak is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with brwyatt-flatpak.  If not, see <http://www.gnu.org/licenses/>.

class flatpak (
  String $package_ensure = 'installed',
){
  include ::apt

  apt::source { 'flatpak':
    location => 'http://ppa.launchpad.net/alexlarsson/flatpak/ubuntu',
    release  => $::os['distro']['codename'],
    repos    => 'main',
    key      => {
      id     => '690951F1A4DE0F905496E8C6C793BFA2FA577F07',
      server => 'keyserver.ubuntu.com',
    },
  }

  package { 'flatpak':
    ensure => $package_ensure,
  }

  Apt::Source['flatpak'] -> Package['flatpak']
}

# vim: ts=2 sts=2 sw=2 expandtab
