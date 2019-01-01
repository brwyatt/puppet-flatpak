require 'spec_helper'

describe 'flatpak::repo::yum' do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile.and_raise_error(%r{Not implemented or supported}) }
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
