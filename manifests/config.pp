# @summary Configure Flatpak
#
# @example Basic use
#   include ::flatpak::config
#
class flatpak::config (
  Boolean $purge_remotes = false,
){
  $repo_config_path = '/var/lib/flatpak/repo/config'

  file { 'Flatpak repo config':
    path  => $repo_config_path,
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  Ini_setting {
    path      => $repo_config_path,
    section   => 'core',
    show_diff => true,
  }

  ini_setting { 'Flatpak repo config - core:repo_version':
    ensure  => present,
    setting => 'repo_version',
    value   => '1',
  }

  ini_setting { 'Flatpak repo config - core:mode':
    ensure  => present,
    setting => 'mode',
    value   => 'bare-user-only',
  }

  ini_setting { 'Flatpak repo config - core:min-free-space-size':
    ensure  => present,
    setting => 'min-free-space-size',
    value   => '500MB',
  }

  if $purge_remotes {
    resources { 'flatpak_remote':
      purge => true,
    }
  }
}

# vim: ts=2 sts=2 sw=2 expandtab
