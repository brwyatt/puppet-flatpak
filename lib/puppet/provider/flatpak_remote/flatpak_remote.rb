# Copyright
# ---------
#
# Copyright 2017, 2018 Bryan Wyatt, unless otherwise noted.
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

require File.expand_path('../../../../../../inifile/lib/puppet/util/ini_file', __FILE__)

Puppet::Type.type(:flatpak_remote).provide(:flatpak_remote) do
  commands flatpak: '/usr/bin/flatpak'
  commands gpg: '/usr/bin/gpg'

  @config_file = Puppet::Util::IniFile.new('/var/lib/flatpak/repo/config', '=')

  def initialize(value={})
    puts("initialize: #{value}")
    super(value)
    @property_flush = {}
  end

  def self.get_remote(remote)
    puts('get_remote')
    section_name = "remote \"#{remote}\""

    if @config_file.section_names.include? section_name then
      settings = @config_file.get_settings(section_name)
      {
        name: remote,
        ensure: :present,
        url: settings['url'],
        gpg_verify: settings['gpg-verify'].to_s.downcase == 'true',
        gpg_verify_summary: settings['gpg-verify-summary'].to_s.downcase == 'true',
      }
    else
      {
        name: remote,
        ensure: :absent,
      }
    end
  end

  def self.instances
    puts('instances')
    remotes = []

    @config_file.section_names.each do |section_name|
      if match = section_name.match(%r{\Aremote "([^"]*)"\Z})
        remotes << new(get_remote(match.captures[0]))
      end
    end

    puts('end::instances')
    puts("Remotes: #{remotes}")
    remotes.compact
  end

  def self.prefetch(resources)
    puts('prefetch')
    instances.each do |instance|
      if resource = resources[instance.name]
        resource.provider = instance
      end
    end
  end

  def create
    puts('create')
    @property_flush[:ensure] = :present
  end

  def destroy
    puts('destroy')
    @property_flush[:ensure] = :absent
  end

  def exists?
    puts("exists: #{@property_flush[:ensure]}")
    @property_hash[:ensure] == :present
  end

  def flush
    puts('flush')
    if @property_flush[:ensure] == :absent
    end

    @property_hash = self.class.get_remote(resource[:name])
  end

  mk_resource_methods
end

# vim: ts=2 sts=2 sw=2 expandtab
