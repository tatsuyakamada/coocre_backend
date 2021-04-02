require 'rails_helper'

describe SubCategory do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
