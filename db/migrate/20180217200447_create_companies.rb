class CreateCompanies < ActiveRecord::Migration[5.2]

  # https://robots.thoughtbot.com/how-to-create-postgres-indexes-concurrently-in
  disable_ddl_transaction!

  def change
    create_table :companies do |t|
      t.citext :email, null: false
      t.string :name,  null: false

      t.timestamps
    end
    add_index :companies, :email, unique: true, algorithm: :concurrently
  end
end
