Puppet::Type.newtype(:flatpak) do
  @doc = <<-MANIFEST
    @summary Provide capabilities to install/manage Flatpak apps

    @example Install Flatpak app
      flatpak { 'org.gnome.Platform':
        ensure => installed,
        arch   => 'x86_64',
        branch => '3.2',
        remote => 'gnome',
      }
  MANIFEST

  ensurable do
    desc('The basic property that the resource should be in.') # Just to shutup `puppet strings`
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
    if self[:ref] && (self[:arch] || self[:branch])
      raise(['Use of `ref` with `arch` and `branch` is ambiguous. Package arch',
             'and branch should be defined in `ref` as an Identifier Triple if',
             '`ref` is defined, or package name should be defined with `name`',
             'or namevar instead of with `ref`. See README.md for more',
             'information.'].join(' '))
    end

    if self[:remote].nil? && [:present, :installed].include?(self[:ensure])
      raise(['Parameter `remote` must be defined if `ensure` is "present" or',
             '"installed".'].join(' '))
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name of package to install. (namevar)'
    newvalues(%r{\A[a-zA-Z0-9.\-_]*\Z})
  end

  newparam(:ref) do
    desc <<-EOS
      Reference of package to install. May be full Identifier Triple.
      Incompatable with `arch` and `branch`.
    EOS

    newvalues(%r{\A[a-zA-Z0-9.\-_]+(?:/[a-zA-Z0-9.\-_]*){0,2}\Z})
  end

  newparam(:arch) do
    desc 'Architecture of package to install. Incompatable with `ref`.'
    newvalues(:aarch64, :arm, :i386, :x86_64)
  end

  newparam(:branch) do
    desc 'Branch of package to install, Incompatable with `ref`.'
    newvalues(%r{\A[a-zA-Z0-9.\-_]+\Z})
  end

  newparam(:remote) do
    desc 'Name of the remote repo to install from.'
    newvalues(%r{\A[a-zA-Z0-9.\-_]*\Z})
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
