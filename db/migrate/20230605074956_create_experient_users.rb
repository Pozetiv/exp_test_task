class CreateExperientUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :experient_users do |t|
      t.belongs_to :user, index: true, uniq: true
      t.belongs_to :experiment, foreign_key: true
      t.jsonb :current_value, null: false

      t.timestamps
    end
  end
end
