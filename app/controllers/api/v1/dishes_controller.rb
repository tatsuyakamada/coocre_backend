module Api
  module V1
    class DishesController < ApplicationController
      before_action :find_dish, only: %i[show update destroy]
      def index
        @dishes = Dish.all
      end

      def show
        menus = Menu.includes(:schedule).where(dish_id: params[:id]).order('schedules.date', 'schedules.category')
        @images = []
        @schedules = []

        menus.each do |menu|
          @images << menu.image
          @schedules << menu.schedule
        end
      end

      def create
        @dish = Dish.new(permitted_params)
        render status: 500, json: { status: 500, messages: @dish.errors.messages } unless @dish.save
      end

      def update
        @dish.update(permitted_params)
      end

      def destroy
        @dish.destroy
      end

      def dish_list_for_selector
        @dishes = Dish.all
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
