class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|

      t.string :name
      t.text :address
      t.boolean :ten_bis
      t.integer :max_delivery_time
      t.decimal :longitude
      t.decimal :latitude
      t.timestamps
    end
  end
end
