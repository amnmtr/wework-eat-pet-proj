class CreateOrders < ActiveRecord::Migration[5.1]
  def up
    create_table :orders do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.string :order_id, unique: true, index: true
      t.string :customer_name
      t.datetime :time
      t.datetime :publish_time
      t.string :status
      t.json :info, default: {}
      #Ex:- :default =>''

      t.timestamps
    end
  end

  def down 
    drop_table :orders
  end
end
