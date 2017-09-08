require 'spec_helper'
describe 'flatpak' do
  context 'with default values for all parameters' do
    it { should contain_class('flatpak') }
  end
end
