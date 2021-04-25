require 'rails_helper'

describe Menu do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:schedule_id) }
    it { is_expected.to validate_presence_of(:dish_id) }
    it { is_expected.to validate_presence_of(:category) }

    describe 'duplication' do
      subject { menu.valid? }

      let(:menu) { build(:menu, schedule_id: schedule_id, dish_id: dish_id) }
      let!(:registered_menu) { create(:menu) }

      context 'schedule_id' do
        context 'is same' do
          let(:schedule_id) { registered_menu.schedule.id }

          context 'dish_id' do
            context 'is same' do
              let(:dish_id) { registered_menu.dish.id }

              it { is_expected.to be_falsey }
            end

            context 'is not same' do
              let(:dish_id) { create(:dish).id }

              it { is_expected.to be_truthy }
            end
          end
        end

        context 'is not same' do
          let(:schedule_id) { create(:schedule).id }

          context 'dish_id' do
            context 'is same' do
              let(:dish_id) { registered_menu.dish.id }

              it { is_expected.to be_truthy }
            end

            context 'is not same' do
              let(:dish_id) { create(:dish).id }

              it { is_expected.to be_truthy }
            end
          end
        end
      end
    end
  end
end
