module Api
  module V1
    class StuffsController < Api::V1::ApplicationController
      before_action :find_stuff, only: %i[update destroy]

      def create
        stuff = Stuff.create!(permitted_params)
        render json: stuff
      end

      def update
        @stuff.update!(permitted_params)
        render json: @stuff
      end

      def destroy
        @stuff.destroy!
        render json: @stuff
      end

      def stuff_list_for_selector
        @stuffs = Stuff.all
      end

      private

      def find_stuff
        @stuff = Stuff.find(params[:id])
      end

      def permitted_params
        params.require(:stuff).permit(:name, :sub_category_id)
      end
    end
  end
end
