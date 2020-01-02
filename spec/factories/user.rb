# spec/factories/user.rb
FactoryGirl.define do
  factory :user do
    name    { Faker::Name.first_name }
    username    { Faker::Name.last_name }
    email    { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end