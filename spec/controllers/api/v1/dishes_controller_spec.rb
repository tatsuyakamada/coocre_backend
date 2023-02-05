require 'rails_helper'

module Api
  module V1
    describe DishesController do
      describe 'GET #index' do
        let!(:dishes) { create_list(:dish, 5) }

        before { get :index, format: :json }

        it 'returns dishes' do
          expect(response_body.length).to eq dishes.length
        end
      end

      describe 'GET #show' do
        let(:dishes) { create_list(:dish, 5) }
        let(:dish) { dishes.sample }
        let!(:menus) { create_list(:menu, 2, dish_id: dish.id) }

        before  { get :show, params: { id:, format: :json } }

        context 'with not existence id' do
          let(:id) { -1 }

          it_behaves_like 'not found record'
        end

        context 'with valid id' do
          let(:id) { dish.id }

          it 'returns dish & menu' do
            expect(response_body[:dish][:name]).to eq dish.name
            expect(response_body[:dish][:category]).to eq dish.category
            expect(response_body[:dish][:genre]).to eq dish.genre
            expect(response_body[:schedules][0][:menus][0][:id]).to eq menus.first.id
            expect(response_body[:schedules][1][:menus][0][:id]).to eq menus.last.id
          end
        end
      end

      describe 'POST #create' do
        let(:params) do
          {
            name: dish.name,
            category: dish.category,
            genre: dish.genre,
            dish_stuffs: dish_stuff_params
          }
        end
        let(:dish) { build(:dish, name:) }
        let(:dish_stuffs) { build_list(:dish_stuff, 2) }
        let(:dish_stuff_params) { dish_stuffs.map { |ds| ds.slice(:stuff_id, :category) } }

        before do
          create_list(:dish, 5)

          post :create, params: { dish: params }
        end

        context 'with invalid params' do
          let(:name) { Dish.first.name }

          it_behaves_like 'invalid parameter'
        end

        context 'with valid params' do
          let(:name) { Faker::Food.dish }

          it 'returns created dish' do
            expect(response_body[:name]).to eq name
            expect(response_body[:category]).to eq dish.category
            expect(response_body[:genre]).to eq dish.genre
          end

          it 'created by params' do
            expect(Dish.last.name).to eq name
            expect(Dish.last.category).to eq dish.category
            expect(Dish.last.genre).to eq dish.genre
            expect(Dish.last.dish_stuffs.count).to eq dish_stuffs.count
          end
        end
      end

      describe 'PUT #update' do
        let(:dish) { create_list(:dish, 5).sample }
        let(:dish_stuffs) { create_list(:dish_stuff, 2, dish_id: dish.id) }
        let(:dish_stuff1) { dish_stuffs.first }
        let(:dish_stuff1_stuff_id) { create(:stuff).id }
        let(:dish_stuff1_category) { DishStuff.categories.keys.sample }
        let(:dish_stuff2) { build(:dish_stuff) }
        let(:category) { Dish.categories.keys.sample }
        let(:genre) { Dish.genres.keys.sample }

        before do
          put(
            :update,
            params: {
              id:,
              dish: {
                id: dish.id,
                name:,
                category:,
                genre:,
                dish_stuffs: [
                  { id: dish_stuff1.id, stuff_id: dish_stuff1_stuff_id, category: dish_stuff1_category },
                  { id: nil, stuff_id: dish_stuff2.stuff_id, category: dish_stuff2.category }
                ]
              }
            }
          )
        end

        context 'with not existence id' do
          let(:id) { -1 }
          let(:name) { Faker::Food.unique.dish }

          it_behaves_like 'not found record'
        end

        context 'with existence id' do
          let(:id) { dish.id }

          context 'with invalid params' do
            let(:name) { nil }

            it_behaves_like 'invalid parameter'
          end

          context 'with valid params' do
            let(:name) { Faker::Food.unique.dish }

            it 'returns updated dish' do
              expect(response_body[:name]).to eq name
              expect(response_body[:category]).to eq category
              expect(response_body[:genre]).to eq genre
            end

            it 'updated by params' do
              expect(dish.reload.name).to eq name
              expect(dish.reload.category).to eq category
              expect(dish.reload.genre).to eq genre
            end

            it 'deleted dish_stuff' do
              expect(DishStuff.find_by(id: dish_stuffs.last.id)).to be_nil
            end

            it 'created dish_stuff' do
              expect(DishStuff.last.dish_id).to eq dish.id
              expect(DishStuff.last.stuff_id).to eq dish_stuff2.stuff_id
              expect(DishStuff.last.category).to eq dish_stuff2.category
            end
          end
        end
      end

      describe 'DELETE #destroy' do
        let(:dish) { create_list(:dish, 5).sample }
        let(:dish_stuffs) { create_list(:dish_stuffs, 3, dish_id: dish.id) }

        before { delete :destroy, params: { id: dish.id } }

        it 'deleted dish' do
          expect(Dish.find_by(id: dish.id)).to be_nil
        end

        it 'returns deleted dish' do
          expect(response_body[:id]).to eq dish.id
          expect(response_body[:name]).to eq dish.name
          expect(response_body[:category]).to eq dish.category
          expect(response_body[:genre]).to eq dish.genre
        end
      end

      describe 'GET #dish_list_for_selector' do
        let!(:dishes) { create_list(:dish, 5) }

        before { get :dish_list_for_selector, format: :json }

        it 'returns dish all' do
          expect(response_body.length).to eq dishes.length
        end
      end
    end
  end
end
