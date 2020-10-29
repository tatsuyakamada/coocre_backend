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
          schedule: [:date, :category, :image],
          menus:[]
        )
        @schedule_create_params = params.require(:scheduledMenu).permit(schedule: [:date, :category, :image])[:schedule]
        menus_request = params.require(:scheduledMenu).permit(menus: [])[:menus]
        menus_params = menus_request.map { |menu| JSON.parse(menu) }
        @menus_create_params = ActionController::Parameters.new(menus: menus_params).permit(menus: [:dish_id, :category])[:menus]
      end
    end
  end
end
