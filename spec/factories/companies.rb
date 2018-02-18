FactoryBot.define do
  factory :company do
    email { Faker::Internet.email }
    name  { Faker::Company.name }
  end
end
