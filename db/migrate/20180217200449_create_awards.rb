class CreateAwards < ActiveRecord::Migration[5.2]

  # https://robots.thoughtbot.com/how-to-create-postgres-indexes-concurrently-in
  disable_ddl_transaction!

  def change
    create_table :awards do |t|
      t.string  :caption
      t.string  :institution
      t.integer :award_year
      t.references :tour, foreign_key: true

      t.timestamps
    end
    add_index :awards, [:caption, :institution, :award_year], unique: true, algorithm: :concurrently
  end
end
