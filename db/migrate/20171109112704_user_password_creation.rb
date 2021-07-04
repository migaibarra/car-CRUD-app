class UserPasswordCreation < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :email, null: false
      t.string :password_hash, null: false
    end
  end
end
