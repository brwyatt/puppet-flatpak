require 'spec_helper'

describe 'flatpak::remotes::gnome' do
  on_supported_os(facterversion: '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('flatpak') }
      it { is_expected.to contain_flatpak_remote('gnome') }
    end
  end
end
