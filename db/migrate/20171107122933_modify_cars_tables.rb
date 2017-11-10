class ModifyCarsTables < ActiveRecord::Migration
  def change
    change_table :cars do |t|
      t.rename :model, :car_model
    end
  end
end
