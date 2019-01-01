Puppet::Type.type(:flatpak).provide(:flatpak) do
  desc('Default provider for `flatpak` resource')
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
