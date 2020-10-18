require 'spec_helper'

describe 'flatpak' do
  on_supported_os(facterversion: '2.4').each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile }
      it { is_expected.to contain_package('flatpak') }

      if facts[:osfamily] == 'Debian'
        it { is_expected.to contain_class('apt') }

        context 'with repo_file_name' do
          let(:params) { { 'repo_file_name' => 'TEST' } }

          it { is_expected.to contain_apt__source('TEST') }
          it { is_expected.to contain_file('/etc/apt/sources.list.d/TEST.list') }
        end
      elsif facts[:osfamily] == 'RedHat'
        it { is_expected.not_to contain_class('apt') }
      end
    end
  end
end
