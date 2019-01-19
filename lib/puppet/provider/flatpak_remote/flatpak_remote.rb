require 'puppet/util/ini_file'

Puppet::Type.type(:flatpak_remote).provide(:flatpak_remote) do
  desc('Default provider for `flatpak_remote` resource')
  commands flatpak: '/usr/bin/flatpak'
  commands gpg: '/usr/bin/gpg'

  def initialize(value = {})
    debug('[INITIALIZE]')
    super(value)

    @property_flush = {
      :ensure => :absent
    }
  end

  def self.get_remote(remote)
    debug('[GET_REMOTE]')
    section_name = "remote \"#{remote}\""

    config_file = Puppet::Util::IniFile.new('/var/lib/flatpak/repo/config', '=')

    if config_file.section_names.include? section_name
      settings = config_file.get_settings(section_name)
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
    debug('[INSTANCES]')
    remotes = []

    config_file = Puppet::Util::IniFile.new('/var/lib/flatpak/repo/config', '=')

    config_file.section_names.each do |section_name|
      match = section_name.match(%r{\Aremote "([^"]*)"\Z})
      if match
        remotes << new(get_remote(match.captures[0]))
      end
    end

    remotes.compact
  end

  def self.prefetch(resources)
    debug('[PREFETCH]')
    instances.each do |instance|
      resource = resources[instance.name]
      if resource
        resource.provider = instance
      end
    end
  end

  def create
    debug('[CREATE]')
    if resource[:url].nil?
      fail('URL is required')
    end
    @property_flush[:ensure] = :present
  end

  def destroy
    debug('[DESTROY]')
    @property_flush[:ensure] = :absent
  end

  def exists?
    debug('[EXISTS]')
    @property_hash[:ensure] == :present
  end

  def flush
    debug('[FLUSH]')
    debug("Property_hash: #{@property_hash}")
    config_file = Puppet::Util::IniFile.new('/var/lib/flatpak/repo/config', '=')

    section_name = "remote \"#{resource['name']}\""

    for setting in config_file.get_settings(section_name) do
      config_file.remove_setting(section_name, setting)
    end

    if @property_hash[:ensure] == :present
      config_file.set_value(section_name, 'url', resource['url'])
      config_file.set_value(section_name, 'gpg-verify', resource['gpg_verify'].to_s)
      config_file.set_value(section_name, 'gpg-verify-summary', resource['gpg_verify_summary'].to_s)
    end

    config_file.save()

    @property_hash = self.class.get_remote(resource[:name])
  end

  mk_resource_methods
end

# vim: ts=2 sts=2 sw=2 expandtab
