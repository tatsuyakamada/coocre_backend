module Api
  module V1
    class SchedulesController < ApplicationController
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
        @schedule = Schedule.find(@update_params[:schedule][:id])
        Schedule.transaction do
          @schedule.update!(@update_params[:schedule])
          @menus_update_params.each do |params|
            menu = @schedule.menus.find(params[:id])
            menu.update!(params)
          end
          delete_ids = @schedule.menus.ids - @menus_update_params.map{ |menu| menu[:id].to_i }
          @schedule.menus.where(id: delete_ids).delete_all if delete_ids
          @schedule.menus.create!(@menus_create_params) if @menus_create_params
        end
      end

      private

      def permitted_create_params
        @create_params = params.require(:scheduledMenu).permit(
          schedule: [:date, :category, :memo, images: []],
          menus: [:dish_id, :category, :memo, :image]
        )
        @menus_create_params = @create_params[:menus].values
      end

      def permitted_update_params
        @update_params = params.require(:scheduledMenu).permit(
          schedule: [:id, :date, :category, :memo, images: []],
          menus: [:id, :dish_id, :category, :memo, :image]
        )
        @menus_create_params, @menus_update_params = @update_params[:menus].values.partition { |menu| menu[:id].blank? }
      end
    end
  end
end
