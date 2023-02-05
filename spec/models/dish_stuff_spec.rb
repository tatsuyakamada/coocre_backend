require 'rails_helper'

describe DishStuff do
  describe 'validation' do
    describe 'duplication' do
      subject { dish_stuff.valid? }

      let(:dish_stuff) { build(:dish_stuff, dish_id:, stuff_id:) }
      let!(:registered_dish_stuff) { create(:dish_stuff) }

      context 'dish_id' do
        context 'is same' do
          let(:dish_id) { registered_dish_stuff.dish_id }

          context 'stuff_id' do
            context 'is same' do
              let(:stuff_id) { registered_dish_stuff.stuff_id }

              it { is_expected.to be_falsey }
            end

            context 'is not same' do
              let(:stuff_id) { create(:stuff).id }

              it { is_expected.to be_truthy }
            end
          end
        end

        context 'is not same' do
          let(:dish_id) { create(:dish).id }

          context 'stuff_id' do
            context 'is same' do
              let(:stuff_id) { registered_dish_stuff.stuff_id }

              it { is_expected.to be_truthy }
            end

            context 'is not same' do
              let(:stuff_id) { create(:stuff).id }

              it { is_expected.to be_truthy }
            end
          end
        end
      end
    end
  end
end
