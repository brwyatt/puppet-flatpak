require 'spec_helper'

describe 'flatpak::install' do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('flatpak::repo') }
      it {
        is_expected.to contain_package('flatpak').with(
          ensure: 'latest',
        )
      }

      case facts[:os]['family']
      when 'Debian'
        it {
          is_expected.to contain_package('flatpak').with(
            name: 'flatpak',
          )
        }
      end

      context 'with package_name test_name' do
        let(:params) do
          {
            package_name: 'test_name',
          }
        end

        it {
          is_expected.to contain_package('flatpak').with(
            name: 'test_name',
          )
        }
      end

      context 'with package_ensure purged' do
        let(:params) do
          {
            package_ensure: 'purged',
          }
        end

        it {
          is_expected.to contain_package('flatpak').with(
            ensure: 'purged',
          )
        }
      end
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
