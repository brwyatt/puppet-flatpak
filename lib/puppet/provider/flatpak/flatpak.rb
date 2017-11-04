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

Puppet::Type.type(:flatpak).provide(:flatpak) do
  commands flatpak: '/usr/bin/flatpak'

  def resolve_ref(resource)
    if resource[:ref]
      ref = resource[:ref]
    else
      arch = resource[:arch].nil? ? '/' : "/#{resource[:arch]}"
      branch = resource[:branch].nil? ? '/' : "/#{resource[:branch]}"
      ref = resource[:name] + arch + branch
    end

    ref
  end

  def create
    ref = resolve_ref(resource)
    args = ['install', '--assumeyes', resource[:remote], ref]
    flatpak(args)
  end

  def destroy
    ref = resolve_ref(resource)
    flatpak 'uninstall', ref
  end

  def exists?
    ref = resolve_ref(resource)
    r = execute(["#{command(:flatpak)} info #{ref}"], failonfail: false)
    if r.exitstatus.zero?
      true
    else
      false
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
