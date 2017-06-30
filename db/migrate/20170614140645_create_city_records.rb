class CreateCityRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :city_records do |t|
      t.string :city_id
      t.string :name
      t.string :token
      t.timestamps
    end
  end
end
