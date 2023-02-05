require 'rails_helper'

module Api
  module V1
    describe SchedulesController do
      describe 'GET #index' do
        let(:schedule1) { create(:schedule, date: Time.zone.today + 1.day, category: 'lunch') }
        let!(:schedule2) { create(:schedule, date: Time.zone.today, category: 'dinner') }
        let!(:schedule3) { create(:schedule, date: Time.zone.today, category: 'morning') }
        let!(:schedule4) { create(:schedule, date: Time.zone.today + 1.day, category: 'morning') }
        let!(:menus) { create_list(:menu, 2, schedule_id: schedule1.id) }

        before { get :index, format: :json }

        it 'returns schedules order by date & category' do
          expect(response_body[0][:schedule][:id]).to eq schedule3.id
          expect(response_body[1][:schedule][:id]).to eq schedule2.id
          expect(response_body[2][:schedule][:id]).to eq schedule4.id
          expect(response_body[3][:schedule][:id]).to eq schedule1.id
          expect(response_body[3][:menus].length).to eq menus.length
        end
      end

      describe 'POST #create' do
        let(:params) do
          {
            schedule: {
              date: schedule.date,
              category: schedule.category,
              memo: schedule.memo
            },
            menus: {
              '0': { dish_id: menu1.dish.id, category: menu1.category, memo: menu1.memo },
              '1': { dish_id: menu2.dish.id, category: menu2.category, memo: menu2.memo }
            }
          }
        end
        let(:schedule) { build(:schedule, date:) }
        let(:menu1) { build(:menu) }
        let(:menu2) { build(:menu) }

        before { post :create, params: { scheduled_menu: params } }

        context 'with invalid params' do
          let(:date) { nil }

          it_behaves_like 'invalid parameter'
        end

        context 'with valid params' do
          let(:date) { Time.zone.today }

          it 'returns created schedule' do
            expect(response_body[:date]).to eq schedule.date.to_s
            expect(response_body[:category]).to eq schedule.category
            expect(response_body[:memo]).to eq schedule.memo
          end

          it 'created schedule & menus' do
            expect(Schedule.last.date).to eq schedule.date
            expect(Schedule.last.category).to eq schedule.category
            expect(Schedule.last.memo).to eq schedule.memo
            expect(Schedule.last.menus.length).to eq 2
            expect(Schedule.last.menus[0].dish_id).to eq menu1.dish_id
            expect(Schedule.last.menus[0].category).to eq menu1.category
            expect(Schedule.last.menus[0].memo).to eq menu1.memo
            expect(Schedule.last.menus[1].dish_id).to eq menu2.dish_id
            expect(Schedule.last.menus[1].category).to eq menu2.category
            expect(Schedule.last.menus[1].memo).to eq menu2.memo
          end
        end
      end

      describe 'PUT #update' do
        let(:schedule) { create_list(:schedule, 5).sample }
        let(:menus) { create_list(:menu, 2, schedule_id: schedule.id) }
        let(:params) do
          {
            schedule: { date:, category:, memo: },
            menus: {
              '0': { id: menu1.id, dish_id: menu1.dish.id, category: menu1.category, memo: menu1.memo },
              '1': { id: menu2.id, dish_id: menu2.dish.id, category: menu2.category, memo: menu2.memo }
            }
          }
        end
        let(:category) { Schedule.categories.keys.sample }
        let(:memo) { Faker::Lorem.sentence }
        let(:menu1) { menus.first }
        let(:menu2) { build(:menu) }

        before { put :update, params: { id:, scheduledMenu: params } }

        context 'with not existence id' do
          let(:id) { -1 }
          let(:date) { Time.zone.today }

          it_behaves_like 'not found record'
        end

        context 'with existence id' do
          let(:id) { schedule.id }

          context 'with invalid params' do
            let(:date) { nil }

            it_behaves_like 'invalid parameter'
          end

          context 'with valid params' do
            let(:date) { Time.zone.today }

            it 'returns updated schedule' do
              expect(response_body[:date]).to eq date.to_s
              expect(response_body[:category]).to eq category
              expect(response_body[:memo]).to eq memo
            end

            it 'update schedule & menus' do
              expect(Schedule.find(id).date).to eq date
              expect(Schedule.find(id).category).to eq category
              expect(Schedule.find(id).memo).to eq memo
              expect(Menu.find(menus.first.id).dish_id).to eq menu1.dish_id
              expect(Menu.find(menus.first.id).category).to eq menu1.category
              expect(Menu.find(menus.first.id).memo).to eq menu1.memo
            end

            it 'deleted menu' do
              expect(Menu.find_by(id: menus.last.id)).to be_nil
            end

            it 'created menu' do
              expect(Menu.last.dish_id).to eq menu2.dish_id
              expect(Menu.last.category).to eq menu2.category
              expect(Menu.last.memo).to eq menu2.memo
            end
          end
        end
      end

      describe 'DELETE #destroy' do
        let(:schedule) { create_list(:schedule, 5).sample }
        let!(:menus) { create_list(:menu, 2, schedule_id: schedule.id) }

        before { delete :destroy, params: { id: } }

        context 'with not existence id' do
          let(:id) { -1 }

          it_behaves_like 'not found record'
        end

        context 'with existence id' do
          let(:id) { schedule.id }

          it 'returns deleted schedule' do
            expect(response_body[:id]).to eq schedule.id
          end

          it 'deleted schedule & menu' do
            expect(Schedule.find_by(id:)).to be_nil
            expect(Menu.find_by(id: menus.first.id)).to be_nil
            expect(Menu.find_by(id: menus.last.id)).to be_nil
          end
        end
      end
    end
  end
end
