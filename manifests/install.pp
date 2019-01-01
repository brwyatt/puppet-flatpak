# @summary Configure repo and install Flatpak
#
# @param package_ensure Ensure value of the package
# @param package_name Name of the package in the repo
#
# @example Basic use
#   include ::flatpak::install
#
class flatpak::install (
  String $package_ensure,
  String $package_name,
){
  include ::flatpak::repo

  package { 'flatpak':
    ensure => $package_ensure,
    name   => $package_name,
  }
}

# vim: ts=2 sts=2 sw=2 expandtab
