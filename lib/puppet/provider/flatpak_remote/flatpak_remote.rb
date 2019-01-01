require 'puppet/util/ini_file'

Puppet::Type.type(:flatpak_remote).provide(:flatpak_remote) do
  desc('Default provider for `flatpak_remote` resource')
  commands flatpak: '/usr/bin/flatpak'
  commands gpg: '/usr/bin/gpg'

  @config_file = Puppet::Util::IniFile.new('/var/lib/flatpak/repo/config', '=')

  def initialize(value = {})
    super(value)
    @property_flush = {}
  end

  def self.get_remote(remote)
    section_name = "remote \"#{remote}\""

    if @config_file.section_names.include? section_name
      settings = @config_file.get_settings(section_name)
      {
        name: remote,
        ensure: :present,
        url: settings['url'],
        gpg_verify: settings['gpg-verify'].to_s.casecmp('true').zero?,
        gpg_verify_summary: settings['gpg-verify-summary'].to_s.casecmp('true').zero?,
      }
    else
      {
        name: remote,
        ensure: :absent,
      }
    end
  end

  def self.instances
    remotes = []

    @config_file.section_names.each do |section_name|
      match = section_name.match(%r{\Aremote "([^"]*)"\Z})
      if match
        remotes << new(get_remote(match.captures[0]))
      end
    end

    remotes.compact
  end

  def self.prefetch(resources)
    instances.each do |instance|
      resource = resources[instance.name]
      if resource
        resource.provider = instance
      end
    end
  end

  def create
    @property_flush[:ensure] = :present
  end

  def destroy
    @property_flush[:ensure] = :absent
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def flush
    if @property_flush[:ensure] == :absent
    end

    @property_hash = self.class.get_remote(resource[:name])
  end

  mk_resource_methods
end

# vim: ts=2 sts=2 sw=2 expandtab
