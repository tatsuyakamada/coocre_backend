module Api
  module V1
    class SubCategoriesController < Api::V1::ApplicationController
      before_action :find_sub_category, only: [:update]

      def create
        sub_category = SubCategory.create!(permitted_params)
        render json: sub_category
      end

      def update
        @sub_category.update!(permitted_params)
        render json: @sub_category
      end

      private

      def find_sub_category
        @sub_category = SubCategory.find(params[:id])
      end

      def permitted_params
        params.require(:sub_category).permit(:name, :category_id)
      end
    end
  end
end
