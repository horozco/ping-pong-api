# frozen_string_literal: true

class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :name, presence: true
  validates :auth_token, presence: true, uniqueness: { case_sensitive: true }
  validates :password_confirmation, presence: true, on: :create
  validates :rating, numericality: { only_integer: true }
  validates :wins, numericality: { only_integer: true }
  validates :loses, numericality: { only_integer: true }

  before_validation :reset_auth_token!, on: :create

  def played_matches
    Match.where('winner_id= ? OR loser_id= ?', id, id)
  end

  def won_matches
    Match.where('winner_id= ?', id)
  end

  def lost_matches
    Match.where('loser_id= ?', id)
  end

  def reset_auth_token!(options = {})
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
    save if options[:save]
  end
end
