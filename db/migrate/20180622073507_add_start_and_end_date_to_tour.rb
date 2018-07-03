class AddStartAndEndDateToTour < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :tour_start_date, :date
    add_column :tours, :tour_end_date, :date
  end
end
