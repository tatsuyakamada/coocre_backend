module Api
  module V1
    class SchedulesController < ApplicationController
      before_action :permitted_create_params, only: :create
      def index
        @schedules = Schedule.all.includes(menus: :dish).order(:date, :category)
      end

      def create
        Schedule.transaction do
          @schedule = Schedule.create!(@schedule_create_params)
          @schedule.menus.create!(@menus_create_params)
        end
      end

      private

      def permitted_create_params
        params.require(:scheduledMenu).permit(
          schedule: [:date, :category, images: []],
          menus: [:dish_id, :category, :image]
        )
        @schedule_create_params = params.require(:scheduledMenu).permit(schedule: [:date, :category, images: []])[:schedule]
        @menus_create_params = params.require(:scheduledMenu).permit(menus: [:dish_id, :category, :image])[:menus].values
      end
    end
  end
end
