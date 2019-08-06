class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|

      t.string :name
      t.text :address
      t.boolean :accepts_10bis
      t.integer :max_delivery_time
      t.json :coordinates
      t.references :cuisine, index: true, foreign_key: true
      t.timestamps
    end
  end
end
