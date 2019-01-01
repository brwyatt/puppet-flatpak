require 'spec_helper'

describe Puppet::Type.type(:flatpak_remote) do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
