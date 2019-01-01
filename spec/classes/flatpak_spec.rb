require 'spec_helper'

describe 'flatpak' do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('flatpak::repo') }
      it { is_expected.to contain_class('flatpak::install') }
      it { is_expected.to contain_class('flatpak::config') }
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
