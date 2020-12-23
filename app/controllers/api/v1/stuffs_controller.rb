module Api
  module V1
    class StuffsController < Api::V1::ApplicationController
      def create
        @stuff = Stuff.create!(permitted_params)
        render json: @stuff
      end

      def update
        @stuff = Stuff.find(params[:id])
        @stuff.update!(permitted_params)
        render json: @stuff
      end

      private

      def permitted_params
        params.require(:stuff).permit(:name, :sub_category_id)
      end
    end
  end
end
