class AddEmailAndRecentToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_column :users, :recent, :boolean

    add_index :users, :email
  end
end
