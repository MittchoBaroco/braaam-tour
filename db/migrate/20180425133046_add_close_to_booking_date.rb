class AddCloseToBookingDate < ActiveRecord::Migration[5.2]
  def change
    add_column :booking_dates, :close, :boolean
  end
end
