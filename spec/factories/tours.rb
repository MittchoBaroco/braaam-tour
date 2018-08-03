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
    tour_artist_name { Faker::Company.name }
    description  { Faker::ChuckNorris.fact }
    tour_caption { Faker::Seinfeld.quote }
    housing      { Faker::Boolean.boolean }
    catering     { Faker::Boolean.boolean }
    currency     = Tour::CURRENCIES.sample
    base_cents   = Faker::Number.between(500, 10000)
    discount     = (base_cents * Faker::Number.between(75,90) / 100).round(2)
    braaam_amt   = base_cents - discount
    price_normal { base_cents.to_s }
    price_braaam { braaam_amt.to_s }
    tour_artist_email { Faker::Internet.email }
    tour_artist_phone { Faker::PhoneNumber.cell_phone }
    tour_staff_number { Faker::Number.between(1, 10) }
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
