FactoryBot.define do
  factory :award do
    caption     { Faker::Robin.quote }
    institution { "#{Faker::Address.city} - #{Faker::Address.country}" }
    this_year   = Time.now.strftime("%Y").to_i
    award_year  { Faker::Number.between(2015, this_year) }
    tour        { FactoryHelpers.get_tour() }
  end
end
