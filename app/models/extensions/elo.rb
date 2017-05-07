# frozen_string_literal: true

module Extensions
  module Elo
    def update_elo_ratings
      EloRating.k_factor = ENV['ELO_K_FACTOR'].to_i
      elo_match = EloRating::Match.new
      elo_match.add_player(rating: winner.rating, winner: true)
      elo_match.add_player(rating: loser.rating)
      update_players_info(elo_match.updated_ratings)
    end

    private

    def update_players_info(new_ratings)
      winner.update(rating: new_ratings.first, wins: winner.wins += 1)
      loser.update(rating: new_ratings.last, loses: loser.loses += 1)
    end
  end
end
