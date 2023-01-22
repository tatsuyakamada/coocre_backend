# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ApplicationController
      rescue_from ActiveModel::UnknownAttributeError, with: :handle_unknown_attribute
      rescue_from ActiveRecord::RecordNotDestroyed, with: :handle_failed_destroy
      rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid
      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

      private

      def handle_unknown_attribute
        render json: { message: 'Unknow Attributes!' }, status: :bad_request
      end

      def handle_failed_destroy(exception)
        render json: { messages: exception.record.errors.full_messages }, status: :bad_request
      end

      def handle_invalid(exception)
        render json: { messages: exception.record.errors.full_messages }, status: :bad_request
      end

      def handle_not_found
        render json: { message: 'Record Not Found!' }, status: :not_found
      end
    end
  end
end
