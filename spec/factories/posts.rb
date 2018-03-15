require 'faker'

FactoryBot.define do
  factory :post do |u|
    u.title { "Just title - #{rand(1...1000)}" }
    u.body 'Hello this is just post'
  end
end
