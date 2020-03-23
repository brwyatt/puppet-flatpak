require 'spec_helper'

describe 'flatpak' do
  on_supported_os(facterversion: '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_package('flatpak') }
      case os_facts[:os]['family']
      when 'Debian'
        it { is_expected.to contain_class('apt') }
      else
        it { is_expected.not_to contain_class('apt') }
      end
      context 'with repo_file_name' do
        let(:params) { { 'repo_file_name' => 'TEST' } }

        case os_facts[:os]['family']
        when 'Debian'
          it { is_expected.to contain_apt__source('TEST') }
          it { is_expected.to contain_file('/etc/apt/sources.list.d/TEST.list') }
        else
          it { is_expected.not_to contain_apt__source('TEST') }
          it { is_expected.not_to contain_file('/etc/apt/sources.list.d/TEST.list') }
        end
      end
    end
  end
end
