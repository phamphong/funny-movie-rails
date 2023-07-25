class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :code
      t.string :url
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.string :user_email

      t.timestamps
    end
  end
end
