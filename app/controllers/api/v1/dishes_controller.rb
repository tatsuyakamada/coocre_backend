module Api
  module V1
    class DishesController < ApplicationController
      def index
        @dishes = Dish.all
        render json: @dishes
      end
    end
  end
end
