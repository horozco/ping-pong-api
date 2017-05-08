# frozen_string_literal: true

module Api
  module V1
    class LeaderboardsController < ApplicationController
      before_action :authenticate_request!, only: [:index]

      def index
        leaders = Statistics.leaders
        render json: leaders, status: 200
      end
    end
  end
end
