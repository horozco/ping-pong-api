# frozen_string_literal: true

module Authenticable
  def authenticate_request!
    if current_player.blank?
      render json: {
        errors: {
          title: 'Not authorized',
          detail: 'Not authorized'
        }
      }, status: :unauthorized
    end
  end

  # Devise methods overwrite
  def current_player
    @current_player ||= Player.find_by(auth_token: request.headers['Authorization'])
  end
end
