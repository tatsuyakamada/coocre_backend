module Api
  module V1
    class DishStuffsController < Api::V1::ApplicationController
      def create
        dish_stuff = DishStuff.create(permitted_params)
        render json: dish_stuff
      end

      def stuff_list_for_selector
        @stuffs = Stuff.all
      end

      private

      def permitted_parmas
        params.require(:dish_stuff).permit(:dish_id, :stuff_id, :category)
      end
    end
  end
end
