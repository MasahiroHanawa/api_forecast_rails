class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.integer :city_id
      t.string :name
      t.string :country
      t.float :lon
      t.float :lat
      t.timestamps
    end
  end
end
