class AddCaptionAndCountryToTour < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :tour_caption, :string, null: false, default: ""
    add_column :tours, :artist_country, :string, null: false, default: ""
  end
end
