Puppet::Type.newtype(:flatpak) do

  @doc = <<-EOS
    This type provides Puppet with the capabilities to manage flatpak apps.
    flatpak { '':
    }
  EOS

  autorequire(:flatpak_remote) do
    self[:remote]
  end

  ensurable do
    newvalue(:present) do
      unless provider.exists?
        provider.create
      end
    end
    aliasvalue(:installed, :present)

    newvalue(:absent) do
      if provider.exists?
        provider.destroy
      end
    end
    aliasvalue(:uninstalled, :absent)
  end

  validate do
  end

  newparam(:ref, :namevar => true) do
    desc 'Package reference to install'
    newvalues(/\A[a-zA-Z0-9.\-_]*\Z/)
  end

  newparam(:remote) do
    desc 'Name of the remote repo to install from'
  end

end

# vim: ts=2 sts=2 sw=2 expandtab
