# Class: flatpak
# ===========================
#
# Main class to install and manage Flatpak
#
# Parameters
# ----------
#
# * `package_ensure`
# Ensure value for the Flatpack package. Should be 'installed', 'latest', or a
# version. Defaults to 'installed'.
#
# * `repo_file_name`
# Optional name for the repo source file. Defaults to the PPA naming scheme to
# avoid duplicate repository files.
#
# Examples
# --------
#
# @example
#    class { 'flatpak':
#      package_ensure => 'latest',
#      repo_file_name => 'flatpak',
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
  Optional[String] $repo_file_name = undef,
){
  include ::apt

  # If Facter is at least 3.0.0
  if versioncmp($::facterversion, '3.0.0') >= 0 {
    $dist_codename = $::os['distro']['codename']
  } elsif versioncmp($::facterversion, '2.2.0') >= 0 {
    # Version is at least 2.2.0
    $dist_codename = $::os['lsb']['distcodename']
  } else {
    # REALLY old version, use legacy fact
    $dist_codename = $::lsbdistcodename
  }

  if $repo_file_name {
    $repo_name = $repo_file_name
  } else {
    $repo_name = "alexlarsson-ubuntu-flatpak-${dist_codename}"
  }

  apt::source { $repo_name:
    location => 'http://ppa.launchpad.net/alexlarsson/flatpak/ubuntu',
    release  => $dist_codename,
    repos    => 'main',
    key      => {
      id     => '690951F1A4DE0F905496E8C6C793BFA2FA577F07',
      server => 'keyserver.ubuntu.com',
    },
  }

  package { 'flatpak':
    ensure => $package_ensure,
  }

  Flatpak_remote <| |> -> Flatpak <| |>

  Exec['apt_update'] -> Package['flatpak']
}

# vim: ts=2 sts=2 sw=2 expandtab
