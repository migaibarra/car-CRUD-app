class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.belongs_to :user

      t.string :make, null: false
      t.string :model, null: false
      t.string :engine
      t.string :transmission
      t.integer :horsepower, null: false
      t.integer :top_speed, null: false

      t.timestamps null: false
    end
  end
end
