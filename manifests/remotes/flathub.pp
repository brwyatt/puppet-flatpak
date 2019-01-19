# @summary Helper class to include popular Flathub remote
#
# @example Basic use
#   include ::flatpak::remotes::flathub
#
class flatpak::remotes::flathub {
  include ::flatpak

  flatpak_remote { 'flathub':
    ensure             => present,
    url                => 'https://dl.flathub.org/repo/',
    gpg_verify         => true,
    gpg_verify_summary => true,
  }
  # xa.title = "Flathub"
}

# vim: ts=2 sts=2 sw=2 expandtab
