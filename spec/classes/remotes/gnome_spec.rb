require 'spec_helper'

describe 'flatpak::remotes::gnome' do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
    end
  end
end
