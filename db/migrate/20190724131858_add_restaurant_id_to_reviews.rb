class AddRestaurantIdToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :restaurant_id, :integer
    add_index :reviews, :restaurant_id
    add_column :restaurants, :coordinates, :json
  end
end
