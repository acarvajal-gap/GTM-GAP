class CreateMettingUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :metting_users do |t|
      t.integer :metting_id
      t.integer :user_id

      t.timestamps
    end
  end
end
