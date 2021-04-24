require 'rails_helper'

module Api
  module V1
    describe CategoriesController do
      describe 'GET #index' do
        let(:categories) { create_list(:category, 5) }
        let(:category) { categories.sample }

        before do
          create_list(:sub_category, 3, category_id: category.id)

          get :index, format: :json
        end

        it 'returns categories' do
          expect(response_body.length).to eq categories.length
        end

        it 'returns sub_categories order by id' do
          sub_categories = response_body.find { |rb| rb[:id] == category.id }[:childs]
          expect(sub_categories[0][:id] < sub_categories[1][:id]).to be_truthy
          expect(sub_categories[0][:id] < sub_categories[2][:id]).to be_truthy
          expect(sub_categories[1][:id] < sub_categories[2][:id]).to be_truthy
        end
      end

      describe 'POST #create' do
        before { post :create, params: { category: { name: name } } }

        context 'invalid params' do
          let(:name) { nil }

          it_behaves_like 'invalid parameter'
        end

        context 'valid params' do
          let(:name) { Faker::Lorem.word }

          it 'returns created category' do
            expect(response_body[:name]).to eq name
          end

          it 'created category' do
            expect(Category.last.name).to eq name
          end
        end
      end

      describe 'PUT #update' do
        let(:categories) { create_list(:category, 5) }
        let(:category) { categories.sample }

        before { put :update, params: { id: id, category: params } }

        context 'with not existence id' do
          let(:id) { -1 }
          let(:params) { {} }

          it_behaves_like 'not found record'
        end

        context 'with existence id' do
          let(:id) { category.id }
          let(:params) { { name: name } }

          context 'with invalid params' do
            let(:name) { nil }

            it_behaves_like 'invalid parameter'
          end

          context 'with valid params' do
            let(:name) { Faker::Lorem.word }

            it 'returns updated category' do
              expect(response_body[:name]).to eq name
            end

            it 'updated category' do
              expect(Category.find(category.id).name).to eq name
            end
          end
        end
      end
    end
  end
end
