# frozen_string_literal: true

module Api
  module V1
    class DishesController < Api::V1::ApplicationController
      before_action :find_dish, only: %i[show update destroy]

      def index
        @dishes = Dish.includes(dish_stuffs: :stuff)
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
        @dish = Dish.create!(permitted_params.slice(*Dish.attribute_names))

        permitted_params[:dish_stuffs].each { |parameter| create_stuff(parameter) }
        render json: @dish
      end

      def update
        Dish.transaction do
          @dish.update!(permitted_params.slice(*Dish.attribute_names))
          dish_stuffs_update
        end

        render json: @dish
      end

      def destroy
        @dish.destroy!
        render json: @dish
      end

      def dish_list_for_selector
        @dishes = Dish.all
      end

      private

      def find_dish
        @dish = Dish.find(params[:id])
      end

      def dish_stuffs_update
        dish_stuff_params = permitted_params[:dish_stuffs]
        request_ids = dish_stuff_params&.pluck(:id)
        current_ids = @dish.dish_stuffs.present? ? @dish.dish_stuffs.pluck(:id) : []
        delete_ids = current_ids - request_ids
        @dish.dish_stuffs.where(id: delete_ids).delete_all if delete_ids.present?
        dish_stuff_params.each do |parameter|
          parameter[:id].present? ? update_stuff(parameter) : create_stuff(parameter)
        end
      end

      def update_stuff(parameter)
        @dish.dish_stuffs.find(parameter[:id]).update!(parameter)
      end

      def create_stuff(parameter)
        @dish.dish_stuffs.create!(parameter)
      end

      def permitted_params
        params.deep_transform_keys!(&:underscore).fetch(:dish).permit(
          :name, :genre, :category, dish_stuffs: %i[id stuff_id category]
        )
      end
    end
  end
end
