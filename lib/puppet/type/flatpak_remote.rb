Puppet::Type.newtype(:flatpak_remote) do
  @doc = <<-MANIFEST
    @summary Provide capabilities to manage Flatpak remotes

    @example Add Flatpak remote
      flatpak_remote { 'gnome':
        ensure => present,
        url    => 'https://sdk.gnome.org/repo/',
      }
  MANIFEST

  ensurable

  newparam(:name, namevar: true) do
    desc 'Name of the remote'
    newvalues(%r{\A[a-zA-Z0-9.\-_]*\Z})
  end

  newproperty(:url) do
    isrequired
    desc 'Location of the remote repo'
    newvalues(%r{\Ahttps?://.*\Z})
  end

  newproperty(:gpg_verify) do
    desc 'Verify GPG signatures'
    newvalues(:true, :false)
    defaultto true
  end

  newproperty(:gpg_verify_summary) do
    desc 'Verify summary GPG signatures'
    newvalues(:true, :false)
    defaultto true
  end

  newproperty(:remote_title) do
    desc 'A nice name to use for this remote'
    defaultto 'default!'
  end

  newproperty(:default_branch) do
    desc 'Default branch to use for this remote'
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
