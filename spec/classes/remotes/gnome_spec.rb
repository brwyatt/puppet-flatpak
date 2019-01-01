require 'spec_helper'

describe 'flatpak::remotes::gnome' do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('flatpak') }
      it {
        is_expected.to contain_flatpak_remote('gnome').with(
          ensure: 'present',
          url: 'https://sdk.gnome.org/repo/',
        )
      }
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
