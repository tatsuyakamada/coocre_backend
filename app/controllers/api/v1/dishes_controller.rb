module Api
  module V1
    class DishesController < ApplicationController
      before_action :find_dish, only: [:show, :update, :destroy]
      def index
        @dishes = Dish.all
        render json: @dishes
      end

      def show
        render json: @dish
      end

      def create
        @dish = Dish.new(permitted_params)
        unless @dish.save
          render status: 500, json: { status: 500, messages: @dish.errors.messages }
        end
      end

      def update
        @dish.update(permitted_params)
      end

      def destroy
        @dish.destroy
      end

      private

      def find_dish
        @dish = Dish.find(params[:id])
      end

      def permitted_params
        params.fetch(:dish).permit(:name, :genre)
      end
    end
  end
end
