# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Authenticable

  rescue_from TypeError, with: :render_server_error
  rescue_from NoMethodError, with: :render_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::UnknownAttributeError, with: :render_server_error
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
  rescue_from ArgumentError, with: :render_bad_request
  rescue_from ActiveRecord::RecordNotUnique, with: :render_server_error

  protected

  def render_not_found
    render json: { error: t('api.errors.not_found') }, status: :not_found
  end

  def render_parameter_missing(exception)
    response = { general: "#{exception.param} parameter is missing or empty" }
    render json: { errors: response }, status: :bad_request
  end

  def render_bad_request(exception)
    render json: { errors: exception.message }, status: :bad_request
  end

  def render_server_error(exception)
    render json: { errors: exception.message }, status: :internal_server_error
  end

  def render_error(message)
    render json: {
      errors: {
        title: message[:title],
        detail: message[:detail]
      }
    }, status: 422
  end
end
