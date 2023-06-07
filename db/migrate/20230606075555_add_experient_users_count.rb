class AddExperientUsersCount < ActiveRecord::Migration[7.0]
  def change
    add_column :experiments, :experient_users_count, :integer, default: 0
  end
end
