require 'spec_helper'

describe Puppet::Type.type(:flatpak_remote) do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with only name' do
        subject { -> { described_class.new(name: 'name_test') } }

        it { is_expected.not_to raise_exception }
      end

      describe 'url format validation' do
        subject do
          -> {
            described_class.new(
              name: 'url_test',
              url: url,
            )
          }
        end

        valid_urls = [
          'http://example.net/some/path',
          'https://example.net/some/path',
          'http://example.net:8080/some/path',
          'https://example.net:8443/some/path',
        ]

        invalid_urls = [
          '/some/path',
          'some/path',
          'ftp://example.net/some/path',
        ]

        valid_urls.each do |url|
          context "with url => #{url}" do
            let(:url) { url }

            it { is_expected.not_to raise_exception }
          end
        end

        invalid_urls.each do |url|
          context "with url => #{url}" do
            let(:url) { url }

            it { is_expected.to raise_exception }
          end
        end
      end
    end
  end
end

# vim: ts=2 sts=2 sw=2 expandtab
