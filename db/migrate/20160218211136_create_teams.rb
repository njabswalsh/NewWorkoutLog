class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string   :name
      t.integer  :salt
      t.string   :password_digest

      t.timestamps
    end
  end
end
