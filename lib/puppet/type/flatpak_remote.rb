Puppet::Type.newtype(:flatpak_remote) do

  @doc = <<-EOS
    This type provides Puppet with the capabilities to manage flatpak
    remotes.
    flatpak { '':
    }
  EOS

  ensurable

  validate do
  end

  newparam(:name, :namevar => true) do
    desc 'Name of the remote'
    newvalues(/\A[a-zA-Z0-9.\-_]*\Z/)
  end

  newparam(:location) do
    desc 'Location of the remote repo'
  end

  newparam(:from) do
    desc 'If true, specifies that `location` is a repo config file, not the repo location'

    defaultto false
  end

end

# vim: ts=2 sts=2 sw=2 expandtab
