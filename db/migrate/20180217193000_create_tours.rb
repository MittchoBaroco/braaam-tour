class CreateTours < ActiveRecord::Migration[5.2]

  # https://robots.thoughtbot.com/how-to-create-postgres-indexes-concurrently-in
  disable_ddl_transaction!

  def change
    create_table :tours do |t|
      t.string   :title
      t.text     :description
      # t.file    :image
      t.string   :video_uri
      t.boolean  :tech_help
      t.boolean  :housing
      t.boolean  :catering
      t.boolean  :transport
      t.monetize :price_braaam
      t.monetize :price_normal

      t.timestamps
    end
    add_index :tours, :title, algorithm: :concurrently
  end
end
