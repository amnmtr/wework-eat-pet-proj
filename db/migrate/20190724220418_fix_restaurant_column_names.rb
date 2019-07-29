class FixRestaurantColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :restaurants, :ten_bis,:accepts_10bis
  end
end
