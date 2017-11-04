require 'spec_helper'
describe 'flatpak' do
  context 'with default values for all parameters' do
    it { is_expected.to contain_class('flatpak') }
  end
end
