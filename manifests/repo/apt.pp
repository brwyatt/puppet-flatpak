# == Class: flatpak::repo::apt
#
# @summary Configure Flatpak apt repo
#
# === Parameters
#
# @param dist_name Distro codename to use for the repo release
# @param repo_name Apt repo name (used for the sources.d file name)
#
# @example
#   include ::flatpak::repo::apt
#
# === Authors
#
# Bryan Wyatt <brwyatt@gmail.com>
#
# === Copyright
#
# Copyright 2018 Bryan Wyatt, unless otherwise noted.
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

class flatpak::repo::apt (
  String $dist_name,
  String $repo_name,
){
  include ::apt

  apt::source { $repo_name:
    location => 'http://ppa.launchpad.net/alexlarsson/flatpak/ubuntu',
    release  => $dist_codename,
    repos    => 'main',
    key      => {
      id     => '690951F1A4DE0F905496E8C6C793BFA2FA577F07',
      server => 'keyserver.ubuntu.com',
    },
  }

  Apt::Source[$repo_name] -> Exec['apt_update']
  Exec['apt_update'] -> Package['flatpak']
}

# vim: ts=2 sts=2 sw=2 expandtab
