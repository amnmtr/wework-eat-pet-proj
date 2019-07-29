class AddCuisineRef < ActiveRecord::Migration[5.1]
  def change
    add_reference :restaurants, :cuisine, index: true, foreign_key: true
    add_foreign_key :restaurants, :cuisine, column: :cuisine_id
  end
end
