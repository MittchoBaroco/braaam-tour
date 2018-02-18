FactoryBot.define do
  factory :tour_date do
    day     { Faker::Date.between(Date.today, 1.year.from_now) }
    tour    { FactoryHelpers.get_tour() }
  end

  trait :booked do
    company { FactoryHelpers.get_company() }
  end

  factory  :invalid_tour_date, parent: :tour_date do
    day     { nil }
    tour    { nil }
    company { nil }
  end

  factory  :no_past_tour_date, parent: :tour_date do
    day     { Faker::Date.backward(14) }
  end
end
