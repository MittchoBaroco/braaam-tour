# include ActionDispatch::TestProcess

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
    artist_country{ [Faker::Address.country, Faker::Address.country_code].sample }
    tour_caption { Faker::Seinfeld.quote }
    # cover_image  { Rack::Test::UploadedFile.new(
    #                   Rails.root.join('spec', 'photos', 'AgilityDefined.png'),
    #                   'image/png') }
    # video_uri    { video_samples.sample }
    tech_help    { ['true', 'false'].sample }
    housing      { Faker::Boolean.boolean }
    catering     { Faker::Boolean.boolean }
    transport    { Faker::Boolean.boolean }
    currency     = Tour::CURRENCIES.sample
    base_cents   = Faker::Number.between(500, 10000)
    discount     = (base_cents * Faker::Number.between(75,90) / 100).round(2)
    braaam_amt   = base_cents - discount
    # rails money format changed - must use string - how to add currency now?
    price_normal { base_cents.to_s }
    price_braaam { braaam_amt.to_s }
    # price_normal { Money.new(base_cents, currency) }
    # price_braaam { Money.new(braaam_amt, currency) }
  end

  factory :tour_w_image, parent: :tour do
    cover_image{ Rack::Test::UploadedFile.new(
                      Rails.root.join('spec', 'photos', 'AgilityDefined.png'),
                      'image/png') }
  end

  trait :with_video do
    after :create do |tour|
      video_uri    { video_samples.sample }
    end
  end

  trait :with_awards do
    after :create do |tour|
      create_list :award, 3, tour: tour   # has_many
    end
  end
end
