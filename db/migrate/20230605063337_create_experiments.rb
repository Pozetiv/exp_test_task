class CreateExperiments < ActiveRecord::Migration[7.0]
  def change
    create_table :experiments do |t|
      t.string :name, null: false, uniq: true
      t.json :conditions, null: false

      t.timestamps
    end
  end
end
