require 'spec_helper'

describe 'flatpak::repo' do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile }

      case facts[:os]['family']
      when 'Debian'
        it { is_expected.to contain_class('flatpak::repo::apt') }
        it { is_expected.not_to contain_class('flatpak::repo::yum') }
      end
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
