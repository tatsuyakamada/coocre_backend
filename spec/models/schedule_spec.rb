require 'rails_helper'

describe Schedule do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:category) }
  end
end
