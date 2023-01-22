# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < Api::V1::ApplicationController
      before_action :find_category, only: [:update]

      def index
        @categories = Category.includes(sub_categories: :stuffs).order(:id)
      end

      def create
        category = Category.create!(permitted_params)
        render json: category
      end

      def update
        @category.update!(permitted_params)
        render json: @category
      end

      private

      def find_category
        @category = Category.find(params[:id])
      end

      def permitted_params
        params.require(:category).permit(:name)
      end
    end
  end
end
