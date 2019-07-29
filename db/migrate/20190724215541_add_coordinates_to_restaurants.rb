class AddCoordinatesToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :coordinates, :json
    remove_column :restaurants, :latitude, :decimal
    remove_column :restaurants, :longitude, :decimal

  end
end
