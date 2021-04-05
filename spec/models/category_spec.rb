require 'rails_helper'

describe Category do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }

    describe 'uniqueness' do
      subject { build(:category) }

      it { is_expected.to validate_uniqueness_of(:name) }
    end
  end
end
