class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :city
      t.string :state
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
