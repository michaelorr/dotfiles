require 'spec_helper'
describe 'flywheel' do

  context 'with defaults for all parameters' do
    it { should contain_class('flywheel') }
  end
end
