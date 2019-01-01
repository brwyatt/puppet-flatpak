# @summary Configure Flatpak apt repo
#
# @param dist_codename Distro codename to use for the repo release
# @param repo_name Apt repo name (used for the sources.d file name)
#
# @example Basic use
#   include ::flatpak::repo::apt
#
class flatpak::repo::apt (
  String $dist_codename,
  String $repo_name,
){
  include ::apt
  include ::flatpak::install

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
