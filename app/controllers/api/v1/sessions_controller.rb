# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      before_action :authenticate_request!, only: [:destroy]

      def create
        player = session_params[:email].present? && Player.find_by(email: session_params[:email])

        if player && player.valid_password?(session_params[:password])
          player.reset_auth_token! save: true
          sign_in player, store: false
          render json: player, status: 200
        else
          render_error(
            title: 'Wrong credentials',
            detail: 'Wrong email or password'
          )
        end
      end

      def destroy
        current_player.reset_auth_token! save: true
        sign_out current_player
        render json: {
          message: 'Signed out correctly'
        }, status: 200
      end

      private

      def session_params
        params.require(:session).permit(:email, :password)
      end
    end
  end
end
