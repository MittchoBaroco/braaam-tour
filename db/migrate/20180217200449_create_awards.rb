class CreateAwards < ActiveRecord::Migration[5.2]

  # https://robots.thoughtbot.com/how-to-create-postgres-indexes-concurrently-in
  disable_ddl_transaction!

  def change
    create_table :awards do |t|
      t.string  :caption,     null: false
      t.string  :institution, null: false
      # t.string  :city,        null: false
      t.string  :country,     null: false
      t.string  :award_year,  null: false
      t.references :tour,     foreign_key: true

      t.timestamps
    end
    add_index :awards, :award_year, algorithm: :concurrently
    add_index :awards, [:caption, :institution, :award_year],
                        unique: true, algorithm: :concurrently
  end
end
