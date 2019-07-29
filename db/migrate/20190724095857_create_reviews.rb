class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.string :name
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
