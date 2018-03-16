require 'faker'

FactoryBot.define do
  factory :profile do |u|
    u.email { Faker::Internet.email }
    u.first_name { Faker::Name.first_name }
    u.last_name { Faker::Name.last_name }
    u.title { Faker::Name.title }
  end
end
