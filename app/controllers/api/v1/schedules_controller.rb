module Api
  module V1
    class SchedulesController < Api::V1::ApplicationController
      before_action :permitted_create_params, only: :create
      before_action :permitted_update_params, only: :update

      def index
        @schedules = Schedule.all.includes(menus: :dish).order(:date, :category)
      end

      def create
        Schedule.transaction do
          @schedule = Schedule.create!(@create_params[:schedule])
          @schedule.menus.create!(@menus_create_params) if @menus_create_params
        end
      end

      def update
        @schedule = Schedule.find(@schedule_update_params[:id])
        Schedule.transaction do
          @schedule.update!(@schedule_update_params.slice(*Schedule.attribute_names))
          @schedule_update_params[:delete_images]&.each { |image| @schedule.images.delete(image) }
          @schedule_update_params[:images]&.each { |image| @schedule.images.attach(image) }

          menus_update
        end
      end

      private

      def permitted_create_params
        @create_params = params.require(:scheduledMenu).permit(
          schedule: [:date, :category, :memo, images: []],
          menus: %i[dish_id category memo image]
        )
        @menus_create_params = @create_params[:menus]&.values
      end

      def permitted_update_params
        update_params = params.require(:scheduledMenu).permit(
          schedule: [:id, :date, :category, :memo, images: [], delete_images: []],
          menus: %i[id dish_id category memo image delete_image]
        )

        @schedule_update_params = update_params[:schedule]
        @menus_create_params, @menus_update_params = update_params[:menus].values.partition { |menu| menu[:id].blank? }
      end

      def menus_update
        @menus_update_params.each { |param| menu_upate(param) }

        delete_ids = @schedule.menus.ids - @menus_update_params.map { |menu| menu[:id].to_i }
        @schedule.menus.where(id: delete_ids).delete_all if delete_ids
        @schedule.menus.create!(@menus_create_params) if @menus_create_params
      end

      def menu_upate(params)
        menu = @schedule.menus.find(params[:id])
        menu.update!(params.slice(*Menu.attribute_names))
        menu.image.delete if params[:delete_image]
        menu.image.attach params[:image] if params[:image]
      end
    end
  end
end
