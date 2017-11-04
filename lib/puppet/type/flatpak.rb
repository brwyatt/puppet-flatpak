# Copyright
# ---------
#
# Copyright 2017 Bryan Wyatt, unless otherwise noted.
#
# This file is part of brwyatt-flatpak.
#
# brwyatt-flatpak is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# brwyatt-flatpak is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with brwyatt-flatpak.  If not, see <http://www.gnu.org/licenses/>.

Puppet::Type.newtype(:flatpak) do
  @doc = <<-EOS
    This type provides Puppet with the capabilities to manage flatpak apps.
    flatpak { 'org.gnome.Platform':
      ensure => installed,
      arch   => 'x86_64',
      branch => '3.2',
      remote => 'gnome',
    }
  EOS

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
