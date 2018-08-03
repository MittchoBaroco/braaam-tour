class AddFieldsToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :tour_staff_number, :integer
    add_column :tours, :tour_artist_name, :string
    add_column :tours, :tour_artist_email, :string
    add_column :tours, :tour_artist_phone, :string
    remove_column :tours, :artist_country, :string
  end
end
