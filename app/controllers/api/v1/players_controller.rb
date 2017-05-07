# frozen_string_literal: true

module Api
  module V1
    class PlayersController < ApplicationController
      before_action :authenticate_request!, except: [:create]
      before_action :load_player, only: [:show, :update]

      def index
        render json: Player.all, status: 200
      end
      
      def create
        player = Player.new(player_params)
        if player.save
          render json: player, status: 200
        else
          render_error(
            title: 'Player creation error',
            detail: player.errors.messages.to_json
          )
        end
      end

      def update
        if @player.update(player_params)
          render json: @player, status: 200
        else
          render_error(
            title: 'Player creation error',
            detail: @player.errors.messages.to_json
          )
        end
      end

      def show
        if @player.present?
          render json: @player, status: 200
        else
          render_error(
            title: 'Player not found error',
            detail: 'Requested player was not found'
          )
        end        
      end

      private

      def player_params
        params.require(:player).permit(:name, :email, :password,
                                       :password_confirmation)
      end

      def load_player
        @player = Player.find(params[:id])
      end
    end
  end
end
