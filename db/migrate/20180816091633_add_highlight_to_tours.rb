class AddHighlightToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :highlighted_at, :datetime
  end
end
