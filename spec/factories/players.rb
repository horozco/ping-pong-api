FactoryGirl.define do
  factory :player do
    name                  { FFaker::Name.name }
    rating                { rand(1000) }
    wins                  { rand(100) }
    loses                 { rand(100) }
    email                 { FFaker::Internet.email }
    password              { 'password1234' }
    password_confirmation { 'password1234' }
  end
end
