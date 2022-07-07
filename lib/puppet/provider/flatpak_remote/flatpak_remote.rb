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

Puppet::Type.type(:flatpak_remote).provide(:flatpak_remote) do
  commands flatpak: '/usr/bin/flatpak'

  def create
    if disabled?
      return enable
    end

    args = ['remote-add']
    if resource[:from]
      args.push('--from')
    end
    args.push(resource[:name], resource[:location])

    flatpak args
  end

  def destroy
    flatpak 'remote-delete', resource[:name]
  end

  def enable
    flatpak 'remote-modify', '--enable', resource[:name]
  end

  def disabled?
    method(:flatpak).call(['remotes', '--show-disabled']).split("\n").each do |line|
      if %r{^#{Regexp.escape(resource[:name])}\s}.match?(line)
          return line.match('disabled')
      end
    end
    false
  end

  def exists?
    method(:flatpak).call(['remotes']).split("\n").each do |line|
      if %r{^#{Regexp.escape(resource[:name])}\s}.match?(line)
        return true
      end
    end
    false
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
