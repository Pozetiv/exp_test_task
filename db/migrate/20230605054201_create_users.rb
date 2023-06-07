class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :device_token, null: false

      t.timestamps
    end

    add_index :users, :device_token, unique: true
  end
end
