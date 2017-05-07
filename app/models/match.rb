# frozen_string_literal: true

class Match < ApplicationRecord
  include Extensions::Elo
  MINIMUM_WINNER_SCORE = ENV['GAME_POINTS_TYPE'].to_i
  MINIMUM_MARGIN = 2
  attr_accessor :margin

  belongs_to :winner, class_name: 'Player', foreign_key: 'winner_id'
  belongs_to :loser, class_name: 'Player', foreign_key: 'loser_id'

  validates :winner_id, presence: true
  validates :loser_id, presence: true
  validates :winner_score, presence: true, numericality: { only_integer: true }
  validates :loser_score, presence: true, numericality: { only_integer: true }
  validate :minimum_margin, if: :scores_exists?
  validate :minimum_winner_score, if: :winner_score_exists?

  before_save :update_elo_ratings

  private

  def minimum_margin
    errors.add(:margin, :invalid_minimum_margin) unless
      (winner_score - loser_score) >= MINIMUM_MARGIN
  end

  def minimum_winner_score
    errors.add(:winner_score, :invalid_minimum_winner_score) unless
      winner_score >= MINIMUM_WINNER_SCORE
  end

  def scores_exists?
    winner_score.present? && loser_score.present?
  end

  def winner_score_exists?
    winner_score.present?
  end
end
