class AddCompanyIdToTours < ActiveRecord::Migration[5.2]
  def change
    add_reference :tours, :company, foreign_key: true, index: true
  end
end
