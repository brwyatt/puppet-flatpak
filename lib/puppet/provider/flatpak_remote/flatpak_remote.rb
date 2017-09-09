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
    flatpak "remote-ls", resource[:name]
  end

end

# vim: ts=2 sts=2 sw=2 expandtab
