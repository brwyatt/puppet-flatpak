require 'puppet/util/ini_file'

Puppet::Type.type(:flatpak_remote).provide(:flatpak_remote) do
  desc('Default provider for `flatpak_remote` resource')
  commands flatpak: '/usr/bin/flatpak'
  commands gpg: '/usr/bin/gpg'

  def initialize(value = {})
    debug('[INITIALIZE]')
    super(value)
    debug("Resource[name]: #{value[:name]}")
    debug("Resource[url]: #{value[:url]}")
    debug("Resource[remote_title]: #{value[:remote_title]}")

    @remote_title = nil
    @default_branch = nil

    @property_flush = {}
  end

  def self.get_remote(remote)
    debug('[GET_REMOTE]')
    section_name = "remote \"#{remote}\""

    config_file = Puppet::Util::IniFile.new('/var/lib/flatpak/repo/config', '=')

    if config_file.section_names.include? section_name
      settings = config_file.get_settings(section_name)
      values = {
        name: remote,
        ensure: :present,
        url: settings['url'],
        gpg_verify: settings['gpg-verify'],
        gpg_verify_summary: settings['gpg-verify-summary'],
        remote_title: nil,
        default_branch: nil,
      }

      if settings.key?('xa.title') then
        values[:remote_title] = settings['xa.title']
      end
      if settings.key?('xa.default-branch') then
        values[:default_branch] = settings['xa.default-branch']
      end
    else
      values = {
        name: remote,
        ensure: :absent,
      }
    end

    debug("Values: #{values}")

    values
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
    debug("Property_hash: #{@property_hash}")
    debug("Resource[name]: #{resource[:name]}")
    debug("Resource[url]: #{resource[:url]}")
    debug("Resource[remote_title]: #{resource[:remote_title]}")
    @property_hash[:ensure] == :present
  end

  def flush
    debug('[FLUSH]')
    debug("Property_hash: #{@property_hash}")

    if @property_flush[:ensure] == :absent then
      flatpak 'remote-delete', '--force', resource[:name]
    else
      config_file = Puppet::Util::IniFile.new('/var/lib/flatpak/repo/config', '=')
      section_name = "remote \"#{resource['name']}\""

      config_file.set_value(section_name, 'url', resource['url'])
      config_file.set_value(section_name, 'gpg-verify', resource['gpg_verify'].to_s)
      config_file.set_value(section_name, 'gpg-verify-summary', resource['gpg_verify_summary'].to_s)

      if not resource[:remote_title].nil? then
        config_file.set_value(section_name, 'xa.title', resource['remote_title'])
        config_file.set_value(section_name, 'xa.title-is-set', 'true')
      else
        config_file.remove_setting(section_name, 'xa.title')
        config_file.remove_setting(section_name, 'xa.title-is-set')
      end

      if not resource[:default_branch].nil? then
        config_file.set_value(section_name, 'xa.default-branch', resource['default_branch'])
        config_file.set_value(section_name, 'xa.default-branch-is-set', 'true')
      else
        config_file.remove_setting(section_name, 'xa.default-branch')
        config_file.remove_setting(section_name, 'xa.default-branch-is-set')
      end

      config_file.save()
    end

    @property_hash = self.class.get_remote(resource[:name])
  end

  mk_resource_methods
end

# vim: ts=2 sts=2 sw=2 expandtab
