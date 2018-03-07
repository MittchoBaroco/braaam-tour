FactoryBot.define do
  factory :manager do
    email                  { Faker::Internet.email }
    full_name              { Faker::Internet.name }
    manager_password       = Faker::Internet.password
    password               { manager_password }
    password_confirmation  { manager_password }
  end
end
