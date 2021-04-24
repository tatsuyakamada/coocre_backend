require 'rails_helper'

module Api
  module V1
    describe SubCategoriesController do
      describe 'POST #create' do
        let(:params) do
          {
            sub_category: {
              category_id: category.id,
              name: name
            }
          }
        end
        let(:category) { create(:category) }

        before { post :create, params: params }

        context 'invalid params' do
          let(:name) { nil }

          it_behaves_like 'invalid parameter'
        end

        context 'valid params' do
          let(:name) { Faker::Lorem.word }

          it 'returns created sub_category' do
            expect(response_body[:name]).to eq name
          end

          it 'created sub_category' do
            expect(SubCategory.last.name).to eq name
          end
        end
      end

      describe 'PUT #update' do
        let(:category) { create(:category) }
        let(:sub_category) { create_list(:sub_category, 5).sample }

        before do
          put(
            :update,
            params: {
              id: id,
              sub_category: {
                category_id: category.id,
                name: name
              }
            }
          )
        end

        context 'with not existence id' do
          let(:id) { -1 }
          let(:name) { Faker::Lorem.word }

          it_behaves_like 'not found record'
        end

        context 'with existence id' do
          let(:id) { sub_category.id }

          context 'with invalid params' do
            let(:name) { nil }

            it_behaves_like 'invalid parameter'
          end

          context 'with valid params' do
            let(:name) { Faker::Lorem.word }

            it 'returns updated sub_category' do
              expect(response_body[:category_id]).to eq category.id
              expect(response_body[:name]).to eq name
            end

            it 'updated sub_category' do
              expect(SubCategory.find(id).category_id).to eq category.id
              expect(SubCategory.find(id).name).to eq name
            end
          end
        end
      end
    end
  end
end
