require 'spec_helper'

describe 'flatpak::repo::apt' do
	on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('apt') }
      it { is_expected.to contain_class('flatpak::install') }

      case facts[:os]['family']
      when 'Debian'
        dist = facts[:os]['distro']['codename']
        reponame = "alexlarsson-ubuntu-flatpak-#{dist}"
        it { is_expected.to contain_apt__source(reponame).with(
          :ensure => 'present',
          :location => 'http://ppa.launchpad.net/alexlarsson/flatpak/ubuntu',
          :release => dist,
          :repos => 'main',
        )}

        keyid = '690951F1A4DE0F905496E8C6C793BFA2FA577F07'
        it { is_expected.to contain_apt__key(
          "Add key: #{keyid} from Apt::Source #{reponame}"
        ).with(
          :ensure => 'present',
          :id => keyid,
          :server => 'keyserver.ubuntu.com',
        )}
      end
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
