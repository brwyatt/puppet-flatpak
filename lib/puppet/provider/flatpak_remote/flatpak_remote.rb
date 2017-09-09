Puppet::Type.type(:flatpak_remote).provide(:flatpak_remote) do

  commands :flatpak => '/usr/bin/flatpak'

  def create
    args = [ "remote-add" ]
    if resource[:from]
      args.push('--from')
    end
    args.push(resource[:name], resource[:location])
    flatpak(args)
  end

  def destroy
    flatpak "remote-delete", resource[:name]
  end

  def exists?
    r = execute(["#{command(:flatpak)} remote-ls #{resource[:name]}"], :failonfail => false)
    if r.exitstatus == 0
      true
    else
      false
    end
  end

end

# vim: ts=2 sts=2 sw=2 expandtab
