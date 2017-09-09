Puppet::Type.type(:flatpak).provide(:flatpak) do

  commands   :flatpak      => '/usr/bin/flatpak'

  def create
    args = [ "install", "--assumeyes", resource[:remote], resource[:ref] ]
    flatpak(args)
  end

  def destroy
    flatpak "uninstall", resource[:ref]
  end

  def exists?
    r = execute(["#{command(:flatpak)} info #{resource[:name]}"], :failonfail => false)
    if r.exitstatus == 0
      true
    else
      false
    end
  end

end

# vim: ts=2 sts=2 sw=2 expandtab
