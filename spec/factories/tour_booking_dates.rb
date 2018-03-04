FactoryBot.define do
  factory :tour_booking_date do
    day     { Faker::Date.between(Date.today, 1.year.from_now) }
    tour    { FactoryHelpers.get_tour() }
  end

  trait :booked do
    company { FactoryHelpers.get_company() }
  end

  factory  :invalid_tour_booking_date, parent: :tour_booking_date do
    day     { nil }
    tour    { nil }
    company { nil }
  end

  factory  :no_past_tour_booking_date, parent: :tour_booking_date do
    day     { Faker::Date.backward(14) }
  end
end
