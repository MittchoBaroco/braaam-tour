class RemoveTechHelpNeeded < ActiveRecord::Migration[5.2]
  def change
    remove_column :tours, :tech_help, :boolean, null: false
  end
end
