# @summary Helper class to include popular remote for Gnome runtimes
#
# @example Basic use
#   include ::flatpak::remotes::gnome
#
class flatpak::remotes::gnome {
  include ::flatpak

  flatpak_remote { 'gnome':
    ensure => present,
    url    => 'https://sdk.gnome.org/repo/',
  }
}

# vim: ts=2 sts=2 sw=2 expandtab
