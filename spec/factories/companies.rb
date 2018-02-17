FactoryBot.define do
  factory :company do
    email { Faker::Internet.email }
    name  { Faker::Company.name }
  end
  factory :invalid_company, parent: :company do
    email { nil }
    name  { nil }
  end
end
