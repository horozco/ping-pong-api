class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :auth_token, :email
end
