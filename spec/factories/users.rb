require 'faker'

FactoryBot.define do
  factory :user do |u|
    password = '123456789'

    u.email { Faker::Internet.email }
    u.password password
    u.password_confirmation password
  end
end
