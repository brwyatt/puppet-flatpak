# @summary Configure Flatpak
#
# @example Basic use
#   include ::flatpak::config
#
class flatpak::config (){
  $repo_config_path = '/var/lib/flatpak/repo/config'

  concat { 'Flatpak repo config':
    ensure => present,
    path   => $repo_config_path,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  concat::fragment { 'Flatpak repo config core section':
    target  => $repo_config_path,
    order   => '01',
    content => join([
      '[core]',
      'repo_version=1',
      'mode=bare-user-only',
      'min-free-space-size=500MB',
      '',
    ], "\n")
  }
}

# vim: ts=2 sts=2 sw=2 expandtab
