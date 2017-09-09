Puppet::Type.newtype(:flatpak_remote) do

  @doc = <<-EOS
    This type provides Puppet with the capabilities to manage flatpak
    remotes.
    flatpak { '':
    }
  EOS

  ensurable

end

# vim: ts=2 sts=2 sw=2 expandtab
