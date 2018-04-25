class CreateComments < ActiveRecord::Migration[5.2]

  # https://robots.thoughtbot.com/how-to-create-postgres-indexes-concurrently-in
  disable_ddl_transaction!

  def change
    create_table :comments do |t|
      t.string :author_name,   null: false
      t.text   :comment_body,  null: false
      t.references :tour,      foreign_key: true

      t.timestamps
    end
    add_index :comments, [:author_name, :comment_body, :tour_id],
                          name: "index_unique_comments",
                          unique: true, algorithm: :concurrently

  end
end
