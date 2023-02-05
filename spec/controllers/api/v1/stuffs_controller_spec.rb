require 'rails_helper'

module Api
  module V1
    describe StuffsController do
      describe 'POST #create' do
        let(:params) { { stuff: { sub_category_id: sub_category.id, name: } } }
        let(:sub_category) { create(:sub_category) }

        before { post :create, params: }

        context 'with ivalid params' do
          let(:name) { nil }

          it_behaves_like 'invalid parameter'
        end

        context 'with valid params' do
          let(:name) { Faker::Lorem.word }

          it 'returns created stuff' do
            expect(response_body[:sub_category_id]).to eq sub_category.id
            expect(response_body[:name]).to eq name
          end

          it 'created stuff' do
            expect(Stuff.last.sub_category_id).to eq sub_category.id
            expect(Stuff.last.name).to eq name
          end
        end
      end

      describe 'PUT #update' do
        let(:stuff) { create_list(:stuff, 5).sample }
        let(:params) do
          {
            stuff: {
              id: stuff.id,
              sub_category_id: sub_category.id,
              name:
            }
          }
        end
        let(:sub_category) { create(:sub_category) }

        before { put :update, params: { id:, **params } }

        context 'with not existence id' do
          let(:id) { -1 }
          let(:name) { Faker::Lorem.word }

          it_behaves_like 'not found record'
        end

        context 'with existence id' do
          let(:id) { stuff.id }

          context 'with invalid params' do
            let(:name) { nil }

            it_behaves_like 'invalid parameter'
          end

          context 'with valid params' do
            let(:name) { Faker::Lorem.word }

            it 'returns updated stuff' do
              expect(response_body[:sub_category_id]).to eq sub_category.id
              expect(response_body[:name]).to eq name
            end

            it 'updated stuff' do
              expect(Stuff.find(id).sub_category_id).to eq sub_category.id
              expect(Stuff.find(id).name).to eq name
            end
          end
        end
      end

      describe 'DELETE #destroy' do
        let(:stuff) { create_list(:stuff, 5).sample }

        before { delete :destroy, params: { id: } }

        context 'with not existence id' do
          let(:id) { -1 }

          it_behaves_like 'not found record'
        end

        context 'with existence id' do
          let(:id) { stuff.id }

          it 'returns deleted stuff' do
            expect(response_body[:id]).to eq stuff.id
          end

          it 'deleted stuff' do
            expect(Stuff.find_by(id:)).to be_nil
          end
        end
      end

      describe 'GET #stuff_list_for_selector' do
        let!(:stuffs) { create_list(:stuff, 5) }

        before { get :stuff_list_for_selector, format: :json }

        it 'returns stuffs' do
          expect(response_body.length).to eq stuffs.length
        end
      end
    end
  end
end
