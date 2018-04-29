class RemoveTransportNeededFromTours < ActiveRecord::Migration[5.2]
  def change
    remove_column :tours, :transport, :boolean
  end
end
