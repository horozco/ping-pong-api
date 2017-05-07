FactoryGirl.define do
  rand_score = rand(21..30)
  factory :match do
    winner { association :player }
    loser { association :player }
    winner_score { rand_score }
    loser_score { rand_score - [2, 5, 6].sample }
  end
end
