# frozen_string_literal: true

class MatchSerializer < ActiveModel::Serializer
  attributes :id, :winner, :loser, :winner_score, :loser_score,
             :created_at
end
