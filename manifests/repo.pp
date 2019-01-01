# @summary Configure Flatpak repo(s)
#
# @param apt Install/configure apt repo
# @param yum Install/configure yum repo
#
# @example Basic use
#   include ::flatpak::repo
#
class flatpak::repo (
  Boolean $apt,
  Boolean $yum,
){
  if $apt {
    include ::flatpak::repo::apt
  }

  if $yum {
    include ::flatpak::repo::yum
  }
}

# vim: ts=2 sts=2 sw=2 expandtab
