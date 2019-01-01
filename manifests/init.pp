# @summary Install and configure Flatpak
#
# @example Basic use
#   include ::flatpak
#
class flatpak (){
  include ::flatpak::repo
  include ::flatpak::install
  include ::flatpak::config
}

# vim: ts=2 sts=2 sw=2 expandtab
