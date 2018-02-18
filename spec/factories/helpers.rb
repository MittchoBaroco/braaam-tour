module FactoryHelpers
  extend self

  def get_tour
    # make a new organizer if less than 3 organizers in db
    return FactoryBot.create :tour if Tour.count <= 3

    # Generate a random number between 1 and 100
    random_number = Faker::Number.between(1, 100)

    # 25% of the time just make a n new organizer anyway
    return FactoryBot.create :tour if random_number <= 25

    # 75 percent of the time return an existing organizer (not CMB4)
    return Tour.find( rand(1..Tour.count) )
  end


  def get_company
    # make a new artist if less than 3 artists in db
    return FactoryBot.create :company    if Company.count <= 3
    # Generate a random number between 1 and 100
    random_number = Faker::Number.between(1, 100)
    # 25% of the time make a new artist even if more than 3 artists
    return FactoryBot.create :company    if random_number <= 25
    # 75% of the time return an existing artist
    return Company.find(rand(1..Company.count))

    # no admin account yet - same model?
    # # BE SURE NOT to return the management company "CMB4"
    # while company.org_name == "CMB4"
    #   company = Company.find( rand(1..Company.count) )
    # end
    # return company
  end


  def get_award
    # make a new artist if less than 3 artists in db
    return FactoryBot.create :award    if Award.count <= 3
    # Generate a random number between 1 and 100
    random_number = Faker::Number.between(1, 100)
    # 25% of the time make a new artist even if more than 3 artists
    return FactoryBot.create :award    if random_number <= 25
    # 75% of the time return an existing artist
    return Award.find(rand(1..Award.count))
  end
end
