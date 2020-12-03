require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:schedule_id) }
    it { is_expected.to validate_presence_of(:dish_id) }
    it { is_expected.to validate_presence_of(:category) }

    describe 'duplication' do
      subject { menu.valid? }

      let(:menu) { build(:menu, schedule_id: schedule_id, dish_id: dish_id) }

      before do
        2.times { |i| create(:dish, id: i + 1) }
        schedule = create(:schedule, id: 1)
        schedule.menus = [create(:menu)]
        create(:schedule, id: 2)
      end

      context 'schedule_id' do
        context 'is same' do
          let(:schedule_id) { 1 }

          context 'and dish_id' do
            context 'is same' do
              let(:dish_id) { 1 }

              it { is_expected.to be_falsey }
            end

            context 'is not same' do
              let(:dish_id) { 2 }

              it { is_expected.to be_truthy }
            end
          end
        end

        context 'is not same' do
          let(:schedule_id) { 2 }

          context 'and dish_id' do
            context 'is same' do
              let(:dish_id) { 1 }

              it { is_expected.to be_truthy }
            end

            context 'is not same' do
              let(:dish_id) { 2 }

              it { is_expected.to be_truthy }
            end
          end
        end
      end
    end
  end
end