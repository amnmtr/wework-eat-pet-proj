# frozen_string_literal: true

class ApplicationController < ActionController::API
  def index
  end

  rescue_from StandardError do |exception|
    response_payload = {
      error_type: exception.class.name,
      error_message: exception.message
    }
  
    render status: :internal_server_error,
            json: response_payload
  end

  rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound do |exception|
    render status: :not_found,
            json: {
              error_message: 'Resource not found'
            }
  end
end
