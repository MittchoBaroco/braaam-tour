video_samples = [
  # nil,
  'https://player.vimeo.com/video/228352232',
  'https://www.youtube.com/embed/1QyEzKKMEOw',
  'https://www.youtube.com/embed/J13GI4Xik1o',
  'https://www.youtube.com/embed/hcQyFtHMfbs',
  'https://www.youtube.com/embed/LtQUJMBH8uE',
  'http://www.dailymotion.com/embed/video/x5vlb6v',
  'http://www.dailymotion.com/embed/video/x5vi8zm',
  'http://techslides.com/demos/sample-videos/small.webm',
  'https://static.videezy.com/system/resources/previews/000/002/446/original/teck_vlog--c100_in_c-log_on_calm_the_storm.mp4',
]

FactoryBot.define do
  factory :tour do
    title        { Faker::Book.title }
    description  { Faker::ChuckNorris.fact }
    # image        { nil }
    video_uri   { video_samples.sample }
    tech_help    { ['true', 'false'].sample }
    housing      { Faker::Boolean.boolean }
    catering     { Faker::Boolean.boolean }
    transport    { Faker::Boolean.boolean }
    currency     = Tour::CURRENCIES.sample
    base_cents   = Faker::Number.between(500, 10000)
    discount     = (base_cents * Faker::Number.between(75,90) / 100).round(2)
    braaam_amt   = base_cents - discount
    price_normal { Money.new(base_cents, currency) }
    price_braaam { Money.new(braaam_amt, currency) }
  end
  factory :invalid_tour, parent: :tour do
    title        { nil }
    description  { nil }
    video_uri   { nil }
    tech_help    { nil }
    housing      { nil }
    catering     { nil }
    transport    { nil }
    price_normal { nil }
    price_braaam { nil }
  end
  factory :negative_tour, parent: :tour do
    currency     = Tour::CURRENCIES.sample
    base_cents   = -1 * Faker::Number.between(500, 10000)
    discount     = (base_cents * Faker::Number.between(75,90) / 100).round(2)
    braaam_amt   = base_cents - discount
    price_normal { Money.new(base_cents, currency) }
    price_braaam { Money.new(braaam_amt, currency) }
  end

end
