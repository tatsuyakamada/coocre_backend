require 'rails_helper'

describe Stuff do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }

    describe 'uniqueness' do
      subject { build(:stuff) }

      it { is_expected.to validate_uniqueness_of(:name) }
    end
  end
end
