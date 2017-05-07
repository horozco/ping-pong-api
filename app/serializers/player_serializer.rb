# frozen_string_literal: true

class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :auth_token, :email,
             :played_matches, :won_matches, :lost_matches
end
