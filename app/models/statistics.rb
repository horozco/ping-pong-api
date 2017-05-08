# frozen_string_literal: true

class Statistics
  class << self
    def leaders
      Player.order(rating: :desc, wins: :desc, loses: :asc).limit(10)
    end
  end
end
