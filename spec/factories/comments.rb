require 'faker'

FactoryBot.define do
  factory :comment do |u|
    u.message { Faker::Book.title }
  end
end
