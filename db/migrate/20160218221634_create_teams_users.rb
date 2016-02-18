class CreateTeamsUsers < ActiveRecord::Migration
  def change
    create_table :teams_users, :id => false do |t|
      t.integer :team_id
      t.integer :user_id
    end
    add_index :teams_users, [:team_id, :user_id]
  end
end

