module Api
  module V1
    class ApplicationController < ApplicationController
      rescue_from ActiveModel::UnknownAttributeError, with: :handle_unknown_attribute
      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

      private

      def handle_unknown_attribute
        render status: 500, json: { status: 500, message: 'Unknow Attributes!' }
      end

      def handle_not_found
        render status: 404, json: { status: 404, message: 'Record Not Found!' }
      end
    end
  end
end
