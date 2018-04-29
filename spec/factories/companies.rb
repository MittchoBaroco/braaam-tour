FactoryBot.define do
  factory :company do
    email { Faker::Internet.email }
    name  { Faker::Company.name }
    company_address_line1 { Faker::Address.street_address }
    company_address_line2 { Faker::Address.secondary_address }
    company_country { Faker::Address.country }
    company_npa { Faker::Address.zip_code }
    company_city { Faker::Address.city }
    reference_person_full_name { Faker::Name.name }
    manager_password       = Faker::Internet.password
    password               { manager_password }
    password_confirmation  { manager_password }
  end
end
