class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :available
      t.string :cover_photo
      t.string :car_id
      t.string :make
      t.string :module
      t.integer :overall
      t.integer :price_daily
      t.integer :price_hourly
      t.integer :price_weekly
      t.string :region
      t.string :street
      t.integer :year

      t.timestamps
    end
  end
end
