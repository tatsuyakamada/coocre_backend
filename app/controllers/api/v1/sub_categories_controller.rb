module Api
  module V1
    class SubCategoriesController < Api::V1::ApplicationController
      def create
        sub_cateogry = SubCategory.new(permitted_params)
        sub_cateogry.save!
        render json: sub_cateogry
      end

      def update
        sub_cateogry = SubCategory.find(params[:id])
        sub_cateogry.update!(permitted_params)
      end

      private

      def permitted_params
        params.require(:sub_category).permit(:name, :category_id)
      end
    end
  end
end
