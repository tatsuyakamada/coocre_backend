require 'rails_helper'

describe Dish do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:genre) }
    it { is_expected.to validate_presence_of(:category) }

    describe 'uniqueness' do
      subject { build(:dish) }

      it { is_expected.to validate_uniqueness_of(:name) }
    end
  end
end
