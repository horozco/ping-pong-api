# frozen_string_literal: true

module Api
  module V1
    class MatchesController < ApplicationController
      before_action :authenticate_request!

      def index
        render json: Match.all, status: 200
      end

      def create
        match = Match.new(match_params)
        if match.save
          render json: match, status: 200
        else
          render_error(
            title: 'Match creation error',
            detail: match.errors.messages.to_json
          )
        end
      end

      private

      def match_params
        params.require(:match).permit(:winner_id, :loser_id, :winner_score,
                                      :loser_score)
      end
    end
  end
end
