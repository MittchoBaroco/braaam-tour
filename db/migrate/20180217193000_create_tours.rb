class CreateTours < ActiveRecord::Migration[5.2]

  # https://robots.thoughtbot.com/how-to-create-postgres-indexes-concurrently-in
  disable_ddl_transaction!

  def change
    create_table :tours do |t|
      t.string   :title,        null: false
      t.text     :description,  null: false
      # t.file    :cover_image
      t.string   :video_uri
      t.boolean  :tech_help,    null: false
      t.boolean  :housing,      null: false
      t.boolean  :catering,     null: false
      t.boolean  :transport,    null: false
      t.monetize :price_braaam
      t.monetize :price_normal

      t.timestamps
    end
    add_index :tours, :title, algorithm: :concurrently
  end
end
