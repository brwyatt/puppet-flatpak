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
