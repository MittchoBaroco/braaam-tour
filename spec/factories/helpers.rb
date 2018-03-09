module FactoryHelpers
  extend self

  def get_tour
    # make a new toor if less than 3 organizers in db
    return FactoryBot.create :tour if Tour.count <= 15

    # Generate a random number between 1 and 100
    random_number = Faker::Number.between(1, 100)

    # 25% of the time just make a n new tour anyway
    return FactoryBot.create :tour if random_number <= 25

    # 75 percent of the time return an existing tour (not CMB4)
    # return Tour.find( rand(1..Tour.count) )
    # return Tour.limit(1).order("RAND()")   # mysql (but also works with psql)
    return Tour.limit(1).order("RANDOM()")   # postgresql
  end


  def get_company
    # make a new artist if less than 3 artists in db
    return FactoryBot.create :company    if Company.count <= 15
    # Generate a random number between 1 and 100
    random_number = Faker::Number.between(1, 100)
    # 25% of the time make a new artist even if more than 15 artists
    return FactoryBot.create :company    if random_number <= 25
    # 75% of the time return an existing artist
    # return Company.find(rand(1..Company.count))
    # return Company.limit(1).order("RAND()")   # mysql (but also works with psql)
    return Company.limit(1).order("RANDOM()")   # postgresql

    # no admin account yet - same model?
    # # BE SURE NOT to return the management company "CMB4"
    # while company.org_name == "CMB4"
    #   company = Company.find( rand(1..Company.count) )
    # end
    # return company
  end


  def get_award
    # make a new artist if less than 3 artists in db
    return FactoryBot.create :award    if Award.count <= 15
    # Generate a random number between 1 and 100
    random_number = Faker::Number.between(1, 100)
    # 25% of the time make a new artist even if more than 15 artists
    return FactoryBot.create :award    if random_number <= 25
    # 75% of the time return an existing artist
    # return Award.find(rand(1..Award.count))
    return Award.limit(1).order("RANDOM()")
  end
end
