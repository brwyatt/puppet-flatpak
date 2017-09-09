require 'pathname'

Puppet::Type.newtype(:flatpak) do

  @doc = <<-EOS
    This type provides Puppet with the capabilities to manage flatpak apps.
    flatpak { '':
    }
  EOS

  ensurable

end

# vim: ts=2 sts=2 sw=2 expandtab
