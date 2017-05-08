# frozen_string_literal: true

class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :auth_token, :email, :wins, :loses,
             :rating, :played_matches, :won_matches, :lost_matches
end
