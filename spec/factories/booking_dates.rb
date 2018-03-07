FactoryBot.define do
  factory :booking_date do
    day     { Faker::Date.between(Date.today, 1.year.from_now) }
    tour    { FactoryHelpers.get_tour() }
  end

  factory  :booked_date, parent: :booking_date do
    company { FactoryHelpers.get_company() }
  end

  trait :booked do
    company { FactoryHelpers.get_company() }
  end

  factory  :invalid_booking_date, parent: :booking_date do
    day     { nil }
    tour    { nil }
    company { nil }
  end

  factory  :no_past_booking_date, parent: :booking_date do
    day     { Faker::Date.backward(14) }
  end
end
