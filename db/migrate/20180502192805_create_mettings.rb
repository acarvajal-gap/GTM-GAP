class CreateMettings < ActiveRecord::Migration[5.2]
  def change
    create_table :mettings do |t|
      t.string :name
      t.datetime :date

      t.timestamps
    end
  end
end
