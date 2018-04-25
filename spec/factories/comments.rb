FactoryBot.define do
  factory :comment do
    author_name  { Faker::Name.name }
    comment_body { Faker::Lorem.sentences.join("\n") }

    tour         { FactoryHelpers.get_tour() }
  end
end
