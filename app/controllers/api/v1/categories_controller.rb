module Api
  module V1
    class CategoriesController < Api::V1::ApplicationController
      def index
        @categories = Category.includes(sub_categories: :stuffs).all.order(:id)
      end

      def create
        category = Category.new(permitted_params)
        category.save!
        render json: category
      end

      def update
        category = Category.find(params[:id])
        category.update!(permitted_params)
      end

      private

      def permitted_params
        params.require(:category).permit(:name)
      end
    end
  end
end
