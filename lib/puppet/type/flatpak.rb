Puppet::Type.newtype(:flatpak) do

  @doc = <<-EOS
    This type provides Puppet with the capabilities to manage flatpak apps.
    flatpak { '':
    }
  EOS

  ensurable do
    newvalues(:installed, :present) do
      provider.create
    end

    newvalues(:uninstalled, :absent, :purged) do
      provider.destroy
    end
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
