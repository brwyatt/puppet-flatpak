require 'spec_helper'

describe 'flatpak' do
  on_supported_os(facterversion: '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_package('flatpak') }
      it { is_expected.to contain_class('apt') }

      context 'with repo_file_name' do
        let(:params) { { 'repo_file_name' => 'TEST' } }

        it { is_expected.to contain_apt__source('TEST') }
        it { is_expected.to contain_file('/etc/apt/sources.list.d/TEST.list') }
      end
    end
  end
end
